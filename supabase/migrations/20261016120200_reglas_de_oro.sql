-- Reglas de oro impuestas en la base de datos (no solo en la interfaz ni en el prompt).
--   1. Hunter no puede enviar: la outbox solo se llena con agents.aprobar(), que exige un miembro autenticado.
--   2. «No contactar» es irreversible y alimenta la lista de supresión global, que nunca se borra.
--   3. Nada entra en la outbox (ni en la mesa) para un lead suprimido, desde otra cuenta o con la pausa activa.
--   4. Territorio y duplicados por email y dominio normalizado en hunter.leads.

-- ===========================================================================
-- 2. «No contactar» irreversible (tabla del ERP, cambio aditivo)
-- ===========================================================================
-- Nota para el ERP: su trigger enforce_client_rules permitía quitar la marca. A partir de aquí no se puede:
-- un «no» es para siempre (es la promesa de la PD).
create or replace function agents.no_contactar_irreversible() returns trigger
language plpgsql set search_path to '' as $$
begin
  if old.do_not_contact and not new.do_not_contact then
    raise exception 'NO_CONTACTAR_IRREVERSIBLE: «%» está marcado como «No contactar» y no se puede desmarcar', old.name
      using errcode = 'P0001',
            hint = 'Un «no» es para siempre: su email y su dominio están en la lista de supresión global.';
  end if;
  return new;
end; $$;

-- El nombre empieza por «clients_dnc» para dispararse antes que el clients_enforce_rules del ERP.
create trigger clients_dnc_irreversible before update of do_not_contact on public.clients
  for each row execute function agents.no_contactar_irreversible();

create or replace function agents.al_marcar_no_contactar() returns trigger
language plpgsql security definer set search_path to '' as $$
begin
  if new.do_not_contact and (tg_op = 'INSERT' or not old.do_not_contact) then
    perform agents.suprimir_cliente(new.id, coalesce(nullif(new.do_not_contact_reason, ''), 'No contactar'), 'no_contactar');
    update agents.outbox set estado = 'cancelado', error = 'Marcado como «No contactar»'
      where client_id = new.id and estado = 'en_cola';
    update agents.approvals set estado = 'caducado', motivo = 'Marcado como «No contactar»'
      where client_id = new.id and estado in ('pendiente', 'rehacer');
  end if;
  return null;
end; $$;

create trigger clients_dnc_suprimir after insert or update of do_not_contact on public.clients
  for each row execute function agents.al_marcar_no_contactar();

-- La lista de supresión no se edita ni se borra. Nunca.
create or replace function agents.supresion_inmutable() returns trigger
language plpgsql set search_path to '' as $$
begin
  raise exception 'SUPRESION_INMUTABLE: la lista de supresión no se puede modificar ni borrar' using errcode = 'P0001';
end; $$;

create trigger suppression_inmutable before update or delete on agents.suppression_list
  for each row execute function agents.supresion_inmutable();
create trigger suppression_sin_truncate before truncate on agents.suppression_list
  for each statement execute function agents.supresion_inmutable();

-- ===========================================================================
-- 1 y 3. La outbox
-- ===========================================================================
create unique index outbox_una_viva_por_aprobacion on agents.outbox (approval_id) where estado <> 'cancelado';
alter table agents.outbox drop constraint outbox_approval_id_key;

-- Barrera común: ¿se le puede escribir a este cliente desde esta cuenta?
create or replace function agents.comprobar_destinatario(p_client uuid, p_para text, p_cuenta text) returns void
language plpgsql stable security definer set search_path to '' as $$
declare
  c record;
begin
  select id, name, email, website, do_not_contact, send_account into c from public.clients where id = p_client;
  if not found then
    raise exception 'CLIENTE_INEXISTENTE' using errcode = 'P0001';
  end if;
  if c.do_not_contact then
    raise exception 'NO_CONTACTAR: «%» está marcado como «No contactar»', c.name using errcode = 'P0001';
  end if;
  if agents.esta_suprimido(p_para, c.website) or agents.esta_suprimido(c.email, c.website) then
    raise exception 'SUPRIMIDO: % está en la lista de supresión', p_para using errcode = 'P0001';
  end if;
  if lower(btrim(p_para)) <> lower(btrim(c.email)) then
    raise exception 'DESTINATARIO_DISTINTO: el correo va a % pero el email de «%» es %', p_para, c.name, c.email
      using errcode = 'P0001';
  end if;
  if btrim(c.send_account) = '' then
    raise exception 'CUENTA_SIN_ASIGNAR: «%» no tiene cuenta de envío', c.name using errcode = 'P0001';
  end if;
  if lower(btrim(p_cuenta)) <> lower(btrim(c.send_account)) then
    raise exception 'CUENTA_DISTINTA: «%» se escribe desde %, no desde %', c.name, c.send_account, p_cuenta
      using errcode = 'P0001';
  end if;
end; $$;

create or replace function agents.outbox_guardia() returns trigger
language plpgsql security definer set search_path to '' as $$
begin
  if tg_op = 'INSERT' then
    if agents.en_pausa(new.department) then
      raise exception 'PAUSA: el departamento % está en pausa', new.department using errcode = 'P0001';
    end if;
    perform agents.comprobar_destinatario(new.client_id, new.para_email, new.cuenta_email);
    if new.estado <> 'en_cola' then
      raise exception 'OUTBOX_ESTADO_INICIAL: una fila nueva entra siempre «en_cola»' using errcode = 'P0001';
    end if;
    return new;
  end if;

  -- Lo aprobado no se toca: el contenido de la outbox es inmutable.
  if (new.approval_id, new.department, new.client_id, new.tipo, new.cuenta_email, new.para_email, new.asunto,
      new.cuerpo, new.gmail_thread_id, new.en_respuesta_a, new.adjuntos, new.aprobado_por)
     is distinct from
     (old.approval_id, old.department, old.client_id, old.tipo, old.cuenta_email, old.para_email, old.asunto,
      old.cuerpo, old.gmail_thread_id, old.en_respuesta_a, old.adjuntos, old.aprobado_por) then
    raise exception 'OUTBOX_INMUTABLE: el contenido aprobado no se puede cambiar' using errcode = 'P0001';
  end if;

  if new.estado is distinct from old.estado then
    if not (
      (old.estado = 'en_cola' and new.estado in ('enviando', 'cancelado')) or
      (old.estado = 'enviando' and new.estado in ('enviado', 'fallido', 'en_cola')) or
      (old.estado = 'fallido' and new.estado in ('en_cola', 'cancelado'))
    ) then
      raise exception 'OUTBOX_TRANSICION: de % a % no está permitido', old.estado, new.estado using errcode = 'P0001';
    end if;
    -- Justo antes de enviar se vuelve a comprobar todo (pudo llegar un «no» o la pausa mientras esperaba).
    if new.estado = 'enviando' then
      if agents.en_pausa(new.department) then
        raise exception 'PAUSA: el departamento % está en pausa', new.department using errcode = 'P0001';
      end if;
      perform agents.comprobar_destinatario(new.client_id, new.para_email, new.cuenta_email);
    end if;
  end if;
  return new;
end; $$;

create trigger outbox_guardia before insert or update on agents.outbox
  for each row execute function agents.outbox_guardia();

-- La mesa tampoco acepta borradores para quien no se puede contactar.
create or replace function agents.approvals_guardia() returns trigger
language plpgsql security definer set search_path to '' as $$
declare
  c record;
begin
  select name, email, website, do_not_contact into c from public.clients where id = new.client_id;
  if c.do_not_contact then
    raise exception 'NO_CONTACTAR: «%» está marcado como «No contactar»', c.name using errcode = 'P0001';
  end if;
  if agents.esta_suprimido(coalesce(new.para_email, c.email), c.website) then
    raise exception 'SUPRIMIDO: «%» está en la lista de supresión', c.name using errcode = 'P0001';
  end if;
  return new;
end; $$;

create trigger approvals_guardia before insert on agents.approvals
  for each row execute function agents.approvals_guardia();

-- ---------------------------------------------------------------------------
-- RPC: aprobar, aprobar el lote, rechazar y pausar. Solo miembros autenticados.
-- ---------------------------------------------------------------------------
create or replace function agents.aprobar(
  p_approval uuid,
  p_asunto text default null,
  p_cuerpo text default null,
  p_diff jsonb default null
) returns uuid
language plpgsql security definer set search_path to '' as $$
declare
  yo uuid := public.current_member_id();
  a agents.approvals;
  editado boolean;
  outbox_id uuid;
begin
  if yo is null then
    raise exception 'NO_AUTORIZADO: solo un socio autenticado puede aprobar' using errcode = '42501';
  end if;

  select * into a from agents.approvals where id = p_approval for update;
  if not found then
    raise exception 'APROBACION_INEXISTENTE' using errcode = 'P0001';
  end if;
  if a.estado <> 'pendiente' then
    raise exception 'APROBACION_NO_PENDIENTE: está «%»', a.estado using errcode = 'P0001';
  end if;

  editado := (p_asunto is not null and p_asunto is distinct from a.asunto)
          or (p_cuerpo is not null and p_cuerpo is distinct from a.cuerpo);

  update agents.approvals set
    estado = 'aprobado',
    decidido_por = yo,
    decidido_at = now(),
    asunto_original = case when editado then a.asunto end,
    cuerpo_original = case when editado then a.cuerpo end,
    asunto = coalesce(p_asunto, a.asunto),
    cuerpo = coalesce(p_cuerpo, a.cuerpo),
    diff = case when editado then p_diff end
  where id = a.id
  returning * into a;

  if a.tipo = 'llamada' then
    return null;
  end if;

  insert into agents.outbox (approval_id, department, client_id, tipo, cuenta_email, para_email, asunto, cuerpo,
                             gmail_thread_id, en_respuesta_a, adjuntos, aprobado_por)
  values (a.id, a.department, a.client_id, a.tipo, a.cuenta_email, a.para_email, a.asunto, a.cuerpo,
          a.gmail_thread_id, a.en_respuesta_a, a.adjuntos, yo)
  returning id into outbox_id;
  return outbox_id;
end; $$;

-- Aprobar el lote exige confirmarlo de forma explícita.
create or replace function agents.aprobar_lote(p_ids uuid[], p_confirmado boolean) returns integer
language plpgsql security definer set search_path to '' as $$
declare
  i uuid;
  n integer := 0;
begin
  if public.current_member_id() is null then
    raise exception 'NO_AUTORIZADO' using errcode = '42501';
  end if;
  if p_confirmado is not true then
    raise exception 'LOTE_SIN_CONFIRMAR: confirma el envío del lote de forma explícita' using errcode = 'P0001';
  end if;
  foreach i in array coalesce(p_ids, '{}') loop
    perform agents.aprobar(i);
    n := n + 1;
  end loop;
  return n;
end; $$;

create or replace function agents.rechazar(p_approval uuid, p_motivo text default '', p_rehacer boolean default false)
returns void
language plpgsql security definer set search_path to '' as $$
declare
  yo uuid := public.current_member_id();
begin
  if yo is null then
    raise exception 'NO_AUTORIZADO' using errcode = '42501';
  end if;
  update agents.approvals set
    estado = case when p_rehacer then 'rehacer' else 'rechazado' end,
    decidido_por = yo, decidido_at = now(), motivo = nullif(btrim(p_motivo), '')
  where id = p_approval and estado = 'pendiente';
  if not found then
    raise exception 'APROBACION_NO_PENDIENTE' using errcode = 'P0001';
  end if;
end; $$;

-- Botón de pausa: detiene al departamento y vacía la cola al instante.
-- Lo que estaba en cola vuelve a la mesa (no se pierde nada; hay que aprobarlo otra vez).
create or replace function agents.pausar(p_department text, p_activa boolean) returns integer
language plpgsql security definer set search_path to '' as $$
declare
  yo uuid := public.current_member_id();
  n integer := 0;
begin
  if yo is null then
    raise exception 'NO_AUTORIZADO' using errcode = '42501';
  end if;
  insert into agents.settings (department, clave, valor, updated_by, updated_at)
  values (p_department, 'pausa', jsonb_build_object('activa', p_activa, 'por', yo, 'desde', now()), yo, now())
  on conflict (department, clave) do update set valor = excluded.valor, updated_by = yo, updated_at = now();

  if p_activa then
    with canceladas as (
      update agents.outbox set estado = 'cancelado', error = 'Pausa'
      where department = p_department and estado = 'en_cola'
      returning approval_id, client_id
    )
    update agents.approvals a set
      estado = case when cl.do_not_contact then 'caducado' else 'pendiente' end,
      motivo = case when cl.do_not_contact then 'Marcado como «No contactar»' else 'Devuelto a la mesa por la pausa' end,
      decidido_por = null, decidido_at = null
    from canceladas c join public.clients cl on cl.id = c.client_id
    where a.id = c.approval_id;
    get diagnostics n = row_count;
  end if;
  return n;
end; $$;

-- ===========================================================================
-- 4. Hunter: territorio, duplicados y supresión en los leads
-- ===========================================================================
create or replace function hunter.leads_guardia() returns trigger
language plpgsql security definer set search_path to '' as $$
declare
  t record;
  c record;
begin
  select socio into t from hunter.territories where provincia = new.provincia;
  if not found then
    raise exception 'PROVINCIA_DESCONOCIDA: %', new.provincia using errcode = 'P0001';
  end if;
  if t.socio <> new.socio then
    raise exception 'TERRITORIO: % es de %, no de %', new.provincia, t.socio, new.socio using errcode = 'P0001';
  end if;
  select do_not_contact, website into c from public.clients where id = new.client_id;
  if not c.do_not_contact and new.email is not null
     and agents.esta_suprimido(new.email, coalesce(c.website, '')) then
    raise exception 'SUPRIMIDO: % está en la lista de supresión', new.email using errcode = 'P0001';
  end if;
  if not c.do_not_contact and new.dominio is not null and exists (
    select 1 from agents.suppression_list s where s.tipo = 'dominio' and s.valor = new.dominio
  ) then
    raise exception 'SUPRIMIDO: el dominio % está en la lista de supresión', new.dominio using errcode = 'P0001';
  end if;
  return new;
end; $$;

create trigger leads_guardia before insert or update of email, dominio, provincia, socio on hunter.leads
  for each row execute function hunter.leads_guardia();

-- Hunter aprende de las correcciones: cada aprobación editada se guarda como ejemplo de estilo.
create or replace function hunter.guardar_ejemplo_estilo() returns trigger
language plpgsql security definer set search_path to '' as $$
begin
  if new.department = 'hunter' and new.estado = 'aprobado' and old.estado = 'pendiente'
     and new.cuerpo_original is not null then
    insert into hunter.style_examples (approval_id, tipo, antes, despues, diff)
    values (new.id, new.tipo, coalesce(new.asunto_original, new.asunto) || E'\n\n' || new.cuerpo_original,
            new.asunto || E'\n\n' || new.cuerpo, coalesce(new.diff, '[]'::jsonb))
    on conflict (approval_id) do nothing;
  end if;
  return null;
end; $$;

create trigger approvals_ejemplo_estilo after update on agents.approvals
  for each row execute function hunter.guardar_ejemplo_estilo();

-- ===========================================================================
-- Tokens de Google en Vault. Dos autorizaciones por cuenta: «lectura» (agente) y «envío» (outbox).
-- ===========================================================================
create or replace function hunter.guardar_token(p_cuenta text, p_tipo text, p_token text) returns void
language plpgsql security definer set search_path to '' as $$
declare
  cuenta hunter.mail_accounts;
  secreto uuid;
  nombre text;
begin
  if public.current_member_id() is null then
    raise exception 'NO_AUTORIZADO' using errcode = '42501';
  end if;
  if p_tipo not in ('lectura', 'envio') then
    raise exception 'TIPO_TOKEN: lectura o envio' using errcode = 'P0001';
  end if;
  select * into cuenta from hunter.mail_accounts where email = lower(btrim(p_cuenta)) for update;
  if not found then
    raise exception 'CUENTA_DESCONOCIDA: %', p_cuenta using errcode = 'P0001';
  end if;
  nombre := 'hunter_google_' || p_tipo || '_' || cuenta.email;
  secreto := case p_tipo when 'lectura' then cuenta.vault_lectura_id else cuenta.vault_envio_id end;
  if secreto is null then
    secreto := vault.create_secret(p_token, nombre, 'Refresh token de Google (' || p_tipo || ') de ' || cuenta.email);
  else
    perform vault.update_secret(secreto, p_token);
  end if;
  if p_tipo = 'lectura' then
    update hunter.mail_accounts set vault_lectura_id = secreto, conectada_lectura_at = now() where email = cuenta.email;
  else
    update hunter.mail_accounts set vault_envio_id = secreto, conectada_envio_at = now() where email = cuenta.email;
  end if;
end; $$;

create or replace function hunter.token_lectura(p_cuenta text) returns text
language sql stable security definer set search_path to '' as $$
  select s.decrypted_secret from hunter.mail_accounts m
  join vault.decrypted_secrets s on s.id = m.vault_lectura_id
  where m.email = lower(btrim(p_cuenta)) and m.activa
$$;

create or replace function hunter.token_envio(p_cuenta text) returns text
language sql stable security definer set search_path to '' as $$
  select s.decrypted_secret from hunter.mail_accounts m
  join vault.decrypted_secrets s on s.id = m.vault_envio_id
  where m.email = lower(btrim(p_cuenta)) and m.activa
$$;

-- ===========================================================================
-- Permisos. Por defecto nadie puede nada; se concede lo justo a cada rol.
-- ===========================================================================
revoke all on all functions in schema agents from public;
revoke all on all functions in schema hunter from public;
revoke all on all tables in schema agents from public, anon, authenticated;
revoke all on all tables in schema hunter from public, anon, authenticated;
alter default privileges in schema agents revoke execute on functions from public;
alter default privileges in schema hunter revoke execute on functions from public;

grant usage on schema agents, hunter to authenticated, service_role, hunter_agent, hunter_outbox;
grant usage on schema public to hunter_agent, hunter_outbox;

-- service_role (administración y la importación del seed)
grant all on all tables in schema agents, hunter to service_role;
grant execute on all functions in schema agents, hunter to service_role;

-- Socios autenticados: leen todo y deciden por RPC.
grant select on all tables in schema agents, hunter to authenticated;
grant insert, update on agents.settings to authenticated;
grant insert on agents.suppression_list to authenticated;
grant update (rastreo, member_id) on hunter.territories to authenticated;
grant update (firma_nombre, firma_telefono, calentamiento_desde, limite_diario, activa) on hunter.mail_accounts to authenticated;
grant update (estado) on hunter.meetings to authenticated;
grant update (sin_hilo, cuenta_email, prioridad) on hunter.leads to authenticated;
grant execute on function agents.aprobar(uuid, text, text, jsonb), agents.aprobar_lote(uuid[], boolean),
  agents.rechazar(uuid, text, boolean), agents.pausar(text, boolean), hunter.guardar_token(text, text, text)
  to authenticated;
grant execute on function agents.en_pausa(text), agents.esta_suprimido(text, text), agents.dominio_registrable(text),
  agents.es_correo_gratuito(text) to authenticated, hunter_agent, hunter_outbox;

-- hunter_agent: propone. Ningún permiso sobre la outbox ni sobre los tokens de envío.
grant select on agents.departments, agents.settings, agents.suppression_list, agents.agent_runs,
  agents.agent_actions, agents.approvals to hunter_agent;
grant update (estado_vivo, estado_vivo_at) on agents.departments to hunter_agent;
grant insert, update on agents.agent_runs to hunter_agent;
grant insert on agents.agent_actions to hunter_agent;
grant insert on agents.approvals to hunter_agent;
grant update (estado, motivo, verificacion) on agents.approvals to hunter_agent;
grant select, insert, update on hunter.leads, hunter.lead_audits, hunter.messages, hunter.meetings, hunter.reports to hunter_agent;
grant select, insert on hunter.style_examples to hunter_agent;
grant select on hunter.territories, hunter.mail_accounts to hunter_agent;
grant select, insert, update on public.clients to hunter_agent;
grant select, insert on public.client_events to hunter_agent;
grant select on public.members to hunter_agent;
grant execute on function hunter.token_lectura(text), agents.ajuste(text, text) to hunter_agent;
revoke all on agents.outbox from hunter_agent;

-- hunter_outbox: envía lo aprobado y nada más.
grant select on agents.departments, agents.settings, agents.suppression_list, agents.approvals to hunter_outbox;
grant select on agents.outbox to hunter_outbox;
grant update (estado, intentos, enviado_at, gmail_message_id, gmail_thread_id_resultado, error, programado_para)
  on agents.outbox to hunter_outbox;
grant select on public.clients to hunter_outbox;
grant update (stage, send_account) on public.clients to hunter_outbox;
grant insert on public.client_events to hunter_outbox;
grant select on hunter.mail_accounts, hunter.leads to hunter_outbox;
grant update (no_antes_de) on hunter.mail_accounts to hunter_outbox;
grant update (primer_envio_at, ultimo_envio_at) on hunter.leads to hunter_outbox;
grant select, insert on hunter.messages to hunter_outbox;
grant execute on function hunter.token_envio(text), agents.ajuste(text, text) to hunter_outbox;

-- ===========================================================================
-- RLS
-- ===========================================================================
do $$
declare t text;
begin
  foreach t in array array[
    'agents.departments', 'agents.agent_runs', 'agents.agent_actions', 'agents.approvals', 'agents.outbox',
    'agents.suppression_list', 'agents.settings',
    'hunter.territories', 'hunter.mail_accounts', 'hunter.leads', 'hunter.lead_audits', 'hunter.messages',
    'hunter.meetings', 'hunter.style_examples', 'hunter.reports'
  ] loop
    execute format('alter table %s enable row level security', t);
    execute format('create policy "socios leen" on %s for select to authenticated using ((select public.is_member()))', t);
  end loop;

  -- Los workers: sus permisos de tabla ya acotan qué pueden hacer.
  foreach t in array array[
    'agents.departments', 'agents.agent_runs', 'agents.agent_actions', 'agents.settings', 'agents.suppression_list',
    'hunter.territories', 'hunter.mail_accounts', 'hunter.leads', 'hunter.lead_audits', 'hunter.messages',
    'hunter.meetings', 'hunter.style_examples', 'hunter.reports'
  ] loop
    execute format('create policy "worker hunter" on %s for all to hunter_agent using (true) with check (true)', t);
  end loop;
  foreach t in array array[
    'agents.departments', 'agents.settings', 'agents.suppression_list', 'agents.approvals', 'agents.outbox',
    'hunter.mail_accounts', 'hunter.leads', 'hunter.messages'
  ] loop
    execute format('create policy "worker outbox" on %s for all to hunter_outbox using (true) with check (true)', t);
  end loop;
end $$;

-- Mesa: el agente crea borradores y solo puede retirarlos (caducado) o marcarlos para rehacer; nunca aprobarlos.
create policy "worker hunter lee" on agents.approvals for select to hunter_agent using (true);
create policy "worker hunter propone" on agents.approvals for insert to hunter_agent
  with check (estado = 'pendiente' and decidido_por is null and department = 'hunter');
create policy "worker hunter retira" on agents.approvals for update to hunter_agent
  using (estado in ('pendiente', 'rehacer')) with check (estado in ('pendiente', 'caducado', 'rehacer'));

-- Socios: ajustes (la pausa solo por RPC), territorio, cuentas y supresión manual.
create policy "socios ajustan" on agents.settings for insert to authenticated
  with check ((select public.is_member()) and clave <> 'pausa');
create policy "socios ajustan (editar)" on agents.settings for update to authenticated
  using ((select public.is_member()) and clave <> 'pausa') with check ((select public.is_member()) and clave <> 'pausa');
create policy "socios suprimen" on agents.suppression_list for insert to authenticated with check ((select public.is_member()));
create policy "socios editan territorio" on hunter.territories for update to authenticated
  using ((select public.is_member())) with check ((select public.is_member()));
create policy "socios editan cuentas" on hunter.mail_accounts for update to authenticated
  using ((select public.is_member())) with check ((select public.is_member()));
create policy "socios editan reuniones" on hunter.meetings for update to authenticated
  using ((select public.is_member())) with check ((select public.is_member()));
create policy "socios editan leads" on hunter.leads for update to authenticated
  using ((select public.is_member())) with check ((select public.is_member()));

-- Tablas del ERP que usan los workers.
create policy "worker hunter" on public.clients for all to hunter_agent using (true) with check (true);
create policy "worker hunter" on public.client_events for all to hunter_agent using (true) with check (true);
create policy "worker hunter" on public.members for select to hunter_agent using (true);
create policy "worker outbox" on public.clients for all to hunter_outbox using (true) with check (true);
create policy "worker outbox" on public.client_events for insert to hunter_outbox with check (true);

-- Realtime para el estado vivo de la oficina.
alter publication supabase_realtime add table agents.departments, agents.agent_runs, agents.agent_actions,
  agents.approvals, agents.outbox, agents.settings;
