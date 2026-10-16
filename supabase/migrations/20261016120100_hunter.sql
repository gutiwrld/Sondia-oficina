-- Hunter · Departamento 01. Tablas propias; los leads son filas de public.clients (ERP) con su ficha aquí.

create schema if not exists hunter;
comment on schema hunter is 'SondiaHunter (Departamento 01): captación comercial con aprobación humana.';

-- Territorio: cada provincia tiene un único dueño.
create table hunter.territories (
  provincia text primary key,
  socio text not null check (socio in ('guzman', 'hugo', 'dani')),
  member_id uuid references public.members(id),
  rastreo boolean not null default false,
  updated_at timestamptz not null default now()
);

-- Cuentas de Gmail. Los tokens viven cifrados en Vault: aquí solo sus ids.
create table hunter.mail_accounts (
  email text primary key check (email = lower(btrim(email))),
  socio text not null check (socio in ('guzman', 'hugo', 'dani')),
  member_id uuid references public.members(id),
  firma_nombre text not null default '',
  firma_telefono text not null default '',
  vault_lectura_id uuid,
  vault_envio_id uuid,
  conectada_lectura_at timestamptz,
  conectada_envio_at timestamptz,
  calentamiento_desde date,
  limite_diario smallint check (limite_diario is null or limite_diario between 0 and 500),
  -- Último envío + espera aleatoria sorteada (la outbox no envía antes).
  no_antes_de timestamptz,
  activa boolean not null default true,
  created_at timestamptz not null default now()
);

-- Ficha de Hunter de cada lead (1:1 con public.clients).
create table hunter.leads (
  client_id uuid primary key references public.clients(id) on delete restrict,
  email text check (email is null or (email = lower(btrim(email)) and email like '%@%')),
  dominio text check (dominio is null or dominio = lower(dominio)),
  -- De dónde sale su email: la URL pública de su propia web (LSSI/RGPD).
  email_fuente_url text,
  place_id text unique,
  provincia text not null references hunter.territories(provincia),
  socio text not null check (socio in ('guzman', 'hugo', 'dani')),
  cuenta_email text references hunter.mail_accounts(email),
  gancho text not null default '',
  prioridad text check (prioridad in ('alta', 'media', 'baja')),
  senal smallint check (senal between 0 and 100),
  -- Sin hilo localizado en ninguna cuenta: no recibe seguimiento hasta que decida un socio.
  sin_hilo boolean not null default false,
  origen text not null default 'rastreo' check (origen in ('seed', 'rastreo', 'manual')),
  seed_id text unique,
  run_id uuid references agents.agent_runs(id),
  primer_envio_at timestamptz,
  ultimo_envio_at timestamptz,
  ultima_respuesta_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create unique index leads_email_unico on hunter.leads (email) where email is not null;
create unique index leads_dominio_unico on hunter.leads (dominio) where dominio is not null;
create index leads_provincia on hunter.leads (provincia);

-- Auditoría automática (sin IA) de cada web.
create table hunter.lead_audits (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references hunter.leads(client_id) on delete cascade,
  run_id uuid references agents.agent_runs(id),
  auditado_at timestamptz not null default now(),
  url_final text not null,
  http_status smallint,
  https boolean not null,
  certificado_valido boolean,
  viewport boolean not null,
  tablas boolean not null default false,
  frames boolean not null default false,
  flash boolean not null default false,
  anio_copyright smallint,
  textos_plantilla text[] not null default '{}',
  fechas_viejas text[] not null default '{}',
  enlaces_rotos jsonb not null default '[]'::jsonb,
  widgets_muertos text[] not null default '{}',
  emails_gratuitos text[] not null default '{}',
  -- HTML descargado (Storage) y su huella: el verificador de citas compara contra este archivo.
  html_path text,
  html_sha256 text,
  captura_movil_path text,
  senal smallint not null check (senal between 0 and 100),
  senal_desglose jsonb not null default '[]'::jsonb
);
create index lead_audits_client on hunter.lead_audits (client_id, auditado_at desc);

-- Mensajes de Gmail vistos por la bandeja (entrantes) o enviados por la outbox (salientes).
create table hunter.messages (
  id uuid primary key default gen_random_uuid(),
  cuenta_email text not null references hunter.mail_accounts(email),
  gmail_message_id text not null unique,
  gmail_thread_id text not null,
  direccion text not null check (direccion in ('entrante', 'saliente')),
  client_id uuid references public.clients(id),
  de text not null default '',
  para text not null default '',
  asunto text not null default '',
  fragmento text not null default '',
  recibido_at timestamptz not null,
  clasificacion text check (clasificacion in ('no', 'interes', 'precio', 'llamada_visita', 'fuera_oficina', 'rebote')),
  confianza real,
  resumen text,
  approval_id uuid references agents.approvals(id),
  procesado boolean not null default false,
  created_at timestamptz not null default now()
);
create index messages_thread on hunter.messages (gmail_thread_id);
create index messages_client on hunter.messages (client_id, recibido_at desc);

-- Llamadas y visitas, con su ficha.
create table hunter.meetings (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references public.clients(id),
  tipo text not null check (tipo in ('llamada', 'visita')),
  empieza_at timestamptz not null,
  termina_at timestamptz,
  calendar_event_id text,
  ficha_md text,
  estado text not null default 'prevista' check (estado in ('prevista', 'hecha', 'cancelada')),
  created_at timestamptz not null default now()
);
create index meetings_empieza on hunter.meetings (empieza_at);

-- Hunter aprende de las correcciones: cada edición aprobada es un ejemplo de estilo.
create table hunter.style_examples (
  id uuid primary key default gen_random_uuid(),
  approval_id uuid not null unique references agents.approvals(id),
  tipo text not null,
  antes text not null,
  despues text not null,
  diff jsonb not null default '[]'::jsonb,
  created_at timestamptz not null default now()
);

-- Parte de caza diario e informe semanal.
create table hunter.reports (
  id uuid primary key default gen_random_uuid(),
  tipo text not null check (tipo in ('parte', 'semanal')),
  fecha date not null,
  titular text not null,
  contenido jsonb not null default '{}'::jsonb,
  run_id uuid references agents.agent_runs(id),
  created_at timestamptz not null default now(),
  unique (tipo, fecha)
);

create trigger leads_updated_at before update on hunter.leads for each row execute function agents.set_updated_at();
create trigger territories_updated_at before update on hunter.territories for each row execute function agents.set_updated_at();
