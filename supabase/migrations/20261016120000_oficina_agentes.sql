-- Oficina de agentes de SONDIA · capa común a todos los departamentos.
-- Departamentos, ejecuciones, el rastro, la mesa de aprobación, la outbox, la lista de supresión y los ajustes.
-- Vive en el proyecto `sondia-erp` y se apoya en public.members / public.clients del ERP.

create schema if not exists agents;
comment on schema agents is 'Oficina de agentes de SONDIA: capa común a todos los departamentos.';

-- Roles de los procesos (sin login: la contraseña se pone a mano en el panel, nunca en una migración).
do $$ begin
  if not exists (select 1 from pg_roles where rolname = 'hunter_agent') then
    create role hunter_agent nologin;
  end if;
  if not exists (select 1 from pg_roles where rolname = 'hunter_outbox') then
    create role hunter_outbox nologin;
  end if;
end $$;
comment on role hunter_agent is 'Worker de Hunter (el agente). Puede proponer, nunca enviar.';
comment on role hunter_outbox is 'Worker de la outbox. El único que envía, y solo lo aprobado.';

-- ---------------------------------------------------------------------------
-- Departamentos
-- ---------------------------------------------------------------------------
create table agents.departments (
  slug text primary key check (slug ~ '^[a-z][a-z0-9_]{1,30}$'),
  numero smallint not null unique check (numero between 1 and 99),
  nombre text not null,
  descripcion text not null default '',
  estado text not null default 'libre' check (estado in ('activo', 'libre')),
  -- Estado vivo que enseña el vestíbulo («Rastreando Valencia · 12/20»).
  estado_vivo text,
  estado_vivo_at timestamptz,
  created_at timestamptz not null default now()
);

-- ---------------------------------------------------------------------------
-- Ejecuciones (cada turno es una ejecución)
-- ---------------------------------------------------------------------------
create table agents.agent_runs (
  id uuid primary key default gen_random_uuid(),
  department text not null references agents.departments(slug),
  turno text not null,
  disparador text not null default 'cron' check (disparador in ('cron', 'manual', 'comando')),
  estado text not null default 'en_curso'
    check (estado in ('en_curso', 'ok', 'error', 'parado_presupuesto', 'parado_pausa')),
  iniciado_at timestamptz not null default now(),
  terminado_at timestamptz,
  duracion_ms integer generated always as (
    case when terminado_at is null then null
      else (extract(epoch from (terminado_at - iniciado_at)) * 1000)::integer end
  ) stored,
  tokens_entrada bigint not null default 0 check (tokens_entrada >= 0),
  tokens_salida bigint not null default 0 check (tokens_salida >= 0),
  tokens_cache bigint not null default 0 check (tokens_cache >= 0),
  coste_ia_centimos numeric(12, 4) not null default 0 check (coste_ia_centimos >= 0),
  llamadas_places integer not null default 0 check (llamadas_places >= 0),
  coste_places_centimos numeric(12, 4) not null default 0 check (coste_places_centimos >= 0),
  progreso jsonb not null default '{}'::jsonb,
  resumen text not null default '',
  error text
);
create index agent_runs_dep_inicio on agents.agent_runs (department, iniciado_at desc);

-- ---------------------------------------------------------------------------
-- El rastro: cada acción del agente con su objetivo, su evidencia y su porqué
-- ---------------------------------------------------------------------------
create table agents.agent_actions (
  id uuid primary key default gen_random_uuid(),
  run_id uuid not null references agents.agent_runs(id) on delete cascade,
  department text not null references agents.departments(slug),
  at timestamptz not null default now(),
  herramienta text not null,
  objetivo_tipo text,
  objetivo_id text,
  objetivo_etiqueta text,
  client_id uuid references public.clients(id),
  porque text not null check (char_length(porque) between 1 and 160),
  evidencia jsonb not null default '{}'::jsonb,
  resultado text not null default 'ok' check (resultado in ('ok', 'descartado', 'error', 'alerta')),
  tokens integer not null default 0,
  coste_centimos numeric(12, 4) not null default 0
);
create index agent_actions_run on agents.agent_actions (run_id, at);
create index agent_actions_dep_at on agents.agent_actions (department, at desc);
create index agent_actions_client on agents.agent_actions (client_id) where client_id is not null;

-- ---------------------------------------------------------------------------
-- Mesa de aprobación
-- ---------------------------------------------------------------------------
create table agents.approvals (
  id uuid primary key default gen_random_uuid(),
  department text not null references agents.departments(slug),
  tipo text not null check (tipo in ('nuevo', 'seguimiento', 'respuesta', 'reunion', 'llamada')),
  client_id uuid not null references public.clients(id),
  run_id uuid references agents.agent_runs(id),
  cuenta_email text,
  para_email text,
  asunto text not null default '',
  cuerpo text not null default '',
  gmail_thread_id text,
  en_respuesta_a text,
  adjuntos jsonb not null default '[]'::jsonb,
  huecos jsonb not null default '[]'::jsonb,
  -- Punteros a la evidencia (auditoría, mensaje…) y resultado del verificador de citas.
  evidencia jsonb not null default '{}'::jsonb,
  verificacion jsonb not null default '{}'::jsonb,
  estado text not null default 'pendiente' check (estado in ('pendiente', 'aprobado', 'rechazado', 'rehacer', 'caducado')),
  asunto_original text,
  cuerpo_original text,
  diff jsonb,
  decidido_por uuid references public.members(id),
  decidido_at timestamptz,
  motivo text,
  intento smallint not null default 1,
  rehace_a uuid references agents.approvals(id),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint approvals_correo_completo check (
    tipo = 'llamada' or (cuenta_email is not null and para_email is not null and asunto <> '' and cuerpo <> '')
  )
);
create index approvals_pendientes on agents.approvals (department, created_at) where estado = 'pendiente';
create index approvals_client on agents.approvals (client_id);

-- ---------------------------------------------------------------------------
-- Outbox: copia inmutable de lo aprobado. Solo entra por agents.aprobar().
-- ---------------------------------------------------------------------------
create table agents.outbox (
  id uuid primary key default gen_random_uuid(),
  approval_id uuid not null unique references agents.approvals(id),
  department text not null references agents.departments(slug),
  client_id uuid not null references public.clients(id),
  tipo text not null check (tipo in ('nuevo', 'seguimiento', 'respuesta', 'reunion')),
  cuenta_email text not null,
  para_email text not null,
  asunto text not null,
  cuerpo text not null,
  gmail_thread_id text,
  en_respuesta_a text,
  adjuntos jsonb not null default '[]'::jsonb,
  estado text not null default 'en_cola' check (estado in ('en_cola', 'enviando', 'enviado', 'fallido', 'cancelado')),
  programado_para timestamptz not null default now(),
  intentos smallint not null default 0,
  enviado_at timestamptz,
  gmail_message_id text,
  gmail_thread_id_resultado text,
  error text,
  aprobado_por uuid not null references public.members(id),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create index outbox_cola on agents.outbox (cuenta_email, programado_para) where estado = 'en_cola';

-- ---------------------------------------------------------------------------
-- Lista de supresión global: se respeta en todos los turnos y departamentos. Nunca se borra.
-- ---------------------------------------------------------------------------
create table agents.suppression_list (
  id uuid primary key default gen_random_uuid(),
  tipo text not null check (tipo in ('email', 'dominio')),
  valor text not null check (valor = lower(btrim(valor)) and valor <> ''),
  motivo text not null default '',
  client_id uuid references public.clients(id),
  origen text not null default '',
  created_by uuid references public.members(id),
  created_at timestamptz not null default now(),
  unique (tipo, valor)
);

-- ---------------------------------------------------------------------------
-- Ajustes por departamento (límites, horarios, presupuesto, pausa…)
-- ---------------------------------------------------------------------------
create table agents.settings (
  department text not null references agents.departments(slug),
  clave text not null,
  valor jsonb not null,
  updated_at timestamptz not null default now(),
  updated_by uuid references public.members(id),
  primary key (department, clave)
);

-- ===========================================================================
-- Funciones auxiliares
-- ===========================================================================

-- Dominios de correo gratuito: nunca se suprime «gmail.com» entero.
create or replace function agents.es_correo_gratuito(p_dominio text) returns boolean
language sql immutable set search_path to '' as $$
  select lower(coalesce(p_dominio, '')) = any (array[
    'gmail.com','googlemail.com','hotmail.com','hotmail.es','outlook.com','outlook.es','live.com','live.es',
    'msn.com','yahoo.com','yahoo.es','icloud.com','me.com','aol.com','gmx.es','gmx.com','terra.es',
    'telefonica.net','ono.com'])
$$;

-- Dominio registrable aproximado (el worker guarda el exacto con la lista de sufijos públicos;
-- este sirve para las barreras de la base de datos y coincide en los dominios españoles habituales).
create or replace function agents.dominio_registrable(p_entrada text) returns text
language plpgsql immutable set search_path to '' as $$
declare
  h text := lower(btrim(coalesce(p_entrada, '')));
  partes text[];
  n int;
begin
  if h = '' then return null; end if;
  if position('@' in h) > 0 and position('/' in h) = 0 then h := split_part(h, '@', 2); end if;
  h := regexp_replace(h, '^[a-z][a-z0-9+.-]*://', '');
  h := regexp_replace(h, '[/?#].*$', '');
  h := regexp_replace(h, ':\d+$', '');
  h := regexp_replace(h, '\.$', '');
  if h = '' or position('.' in h) = 0 then return null; end if;
  partes := string_to_array(h, '.');
  n := array_length(partes, 1);
  if n >= 3 and (partes[n - 1] || '.' || partes[n]) = any (array[
      'com.es','org.es','nom.es','gob.es','edu.es','co.uk','org.uk','com.ar','com.mx','com.br','com.pt','co.es'])
  then
    return partes[n - 2] || '.' || partes[n - 1] || '.' || partes[n];
  end if;
  return partes[n - 1] || '.' || partes[n];
end; $$;

-- ¿Está suprimido este email o su dominio (o el de la web)?
create or replace function agents.esta_suprimido(p_email text, p_web text default null) returns boolean
language sql stable security definer set search_path to '' as $$
  select exists (
    select 1 from agents.suppression_list s
    where (s.tipo = 'email' and s.valor = lower(btrim(coalesce(p_email, ''))))
       or (s.tipo = 'dominio' and s.valor in (
            nullif(case when agents.es_correo_gratuito(agents.dominio_registrable(p_email)) then null
                        else agents.dominio_registrable(p_email) end, ''),
            agents.dominio_registrable(p_web)))
  )
$$;

-- Añade a la supresión el email y el dominio de un cliente (sin suprimir dominios de correo gratuito).
create or replace function agents.suprimir_cliente(p_client uuid, p_motivo text, p_origen text) returns void
language plpgsql security definer set search_path to '' as $$
declare
  c record;
  d_email text;
  d_web text;
begin
  select id, email, website into c from public.clients where id = p_client;
  if not found then return; end if;
  if btrim(c.email) <> '' then
    insert into agents.suppression_list (tipo, valor, motivo, client_id, origen, created_by)
    values ('email', lower(btrim(c.email)), p_motivo, c.id, p_origen, public.current_member_id())
    on conflict (tipo, valor) do nothing;
    d_email := agents.dominio_registrable(c.email);
    if d_email is not null and not agents.es_correo_gratuito(d_email) then
      insert into agents.suppression_list (tipo, valor, motivo, client_id, origen, created_by)
      values ('dominio', d_email, p_motivo, c.id, p_origen, public.current_member_id())
      on conflict (tipo, valor) do nothing;
    end if;
  end if;
  d_web := agents.dominio_registrable(c.website);
  if d_web is not null and not agents.es_correo_gratuito(d_web) then
    insert into agents.suppression_list (tipo, valor, motivo, client_id, origen, created_by)
    values ('dominio', d_web, p_motivo, c.id, p_origen, public.current_member_id())
    on conflict (tipo, valor) do nothing;
  end if;
end; $$;

create or replace function agents.ajuste(p_department text, p_clave text) returns jsonb
language sql stable security definer set search_path to '' as $$
  select valor from agents.settings where department = p_department and clave = p_clave
$$;

create or replace function agents.en_pausa(p_department text) returns boolean
language sql stable security definer set search_path to '' as $$
  select coalesce((agents.ajuste(p_department, 'pausa') ->> 'activa')::boolean, false)
$$;

create or replace function agents.set_updated_at() returns trigger language plpgsql as $$
begin new.updated_at := now(); return new; end; $$;

create trigger approvals_updated_at before update on agents.approvals for each row execute function agents.set_updated_at();
create trigger outbox_updated_at before update on agents.outbox for each row execute function agents.set_updated_at();
