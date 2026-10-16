-- Tests de las reglas de oro en la base de datos. Cada bloque lanza una excepción si la regla no se cumple.
\set ON_ERROR_STOP on
set client_min_messages = notice;

create or replace function pg_temp.debe_fallar(p_sql text, p_contiene text) returns void language plpgsql as $$
begin
  begin
    execute p_sql;
  exception when others then
    if position(p_contiene in sqlerrm) = 0 and position(p_contiene in sqlstate) = 0 then
      raise exception 'FALLO: se esperaba «%» y llegó «%» (%)', p_contiene, sqlerrm, sqlstate;
    end if;
    return;
  end;
  raise exception 'FALLO: «%» debía fallar con «%» y no falló', p_sql, p_contiene;
end; $$;

create or replace function pg_temp.como(p_rol text, p_usuario uuid default null) returns void language plpgsql as $$
begin
  perform set_config('request.jwt.claim.sub', coalesce(p_usuario::text, ''), false);
  execute format('set role %I', p_rol);
end; $$;

create or replace function pg_temp.ok(p_cond boolean, p_que text) returns void language plpgsql as $$
begin
  if not coalesce(p_cond, false) then raise exception 'FALLO: %', p_que; end if;
  raise notice 'ok · %', p_que;
end; $$;

-- Datos de prueba ------------------------------------------------------------
insert into public.clients (id, name, province, website, email, send_account, stage) values
  ('10000000-0000-0000-0000-000000000001', 'Mesón Valderrey', 'Valladolid', 'http://www.mesonvalderrey.com', 'info@mesonvalderrey.com', 'guzmangonzalezperez@gmail.com', 'contactado'),
  ('10000000-0000-0000-0000-000000000002', 'Trufas Bertolín', 'Teruel', 'https://www.trufasbertolin.com', 'isabel@trufasbertolin.com', 'guzmangonzalez.twati@gmail.com', 'contactado'),
  ('10000000-0000-0000-0000-000000000003', 'Casa Pepe', 'Valencia', 'https://casapepe.es', 'pepe@gmail.com', 'guzmangonzalezperez@gmail.com', 'lead');

insert into hunter.leads (client_id, email, dominio, provincia, socio, cuenta_email, origen) values
  ('10000000-0000-0000-0000-000000000001', 'info@mesonvalderrey.com', 'mesonvalderrey.com', 'Valladolid', 'guzman', 'guzmangonzalezperez@gmail.com', 'seed'),
  ('10000000-0000-0000-0000-000000000002', 'isabel@trufasbertolin.com', 'trufasbertolin.com', 'Teruel', 'guzman', 'guzmangonzalez.twati@gmail.com', 'seed'),
  ('10000000-0000-0000-0000-000000000003', 'pepe@gmail.com', 'casapepe.es', 'Valencia', 'guzman', 'guzmangonzalezperez@gmail.com', 'rastreo');

insert into agents.agent_runs (id, department, turno) values ('20000000-0000-0000-0000-000000000001', 'hunter', 'redaccion');

-- ============================================================================
-- Regla 1 · Hunter no puede enviar
-- ============================================================================
select pg_temp.como('hunter_agent');
insert into agents.approvals (id, department, tipo, client_id, run_id, cuenta_email, para_email, asunto, cuerpo)
values ('30000000-0000-0000-0000-000000000001', 'hunter', 'nuevo', '10000000-0000-0000-0000-000000000003',
        '20000000-0000-0000-0000-000000000001', 'guzmangonzalezperez@gmail.com', 'pepe@gmail.com',
        'Vuestra web', 'Hola, equipo de Casa Pepe: …');
select pg_temp.debe_fallar($$insert into agents.outbox (approval_id, department, client_id, tipo, cuenta_email, para_email, asunto, cuerpo, aprobado_por)
  select '30000000-0000-0000-0000-000000000001', 'hunter', '10000000-0000-0000-0000-000000000003', 'nuevo',
         'guzmangonzalezperez@gmail.com', 'pepe@gmail.com', 'x', 'y', id from public.members limit 1$$, 'permission denied');
select pg_temp.debe_fallar($$select count(*) from agents.outbox$$, 'permission denied');
select pg_temp.debe_fallar($$select agents.aprobar('30000000-0000-0000-0000-000000000001')$$, 'permission denied');
select pg_temp.debe_fallar($$update agents.approvals set estado = 'aprobado' where id = '30000000-0000-0000-0000-000000000001'$$, 'row-level security');
select pg_temp.debe_fallar($$update agents.approvals set decidido_por = (select id from public.members limit 1) where id = '30000000-0000-0000-0000-000000000001'$$, 'permission denied');
select pg_temp.debe_fallar($$select hunter.token_envio('guzmangonzalezperez@gmail.com')$$, 'permission denied');
select pg_temp.debe_fallar($$insert into agents.approvals (department, tipo, client_id, cuenta_email, para_email, asunto, cuerpo, estado)
  values ('hunter', 'nuevo', '10000000-0000-0000-0000-000000000003', 'guzmangonzalezperez@gmail.com', 'pepe@gmail.com', 'x', 'y', 'aprobado')$$, 'row-level security');
reset role;
select pg_temp.ok(true, 'hunter_agent no puede tocar la outbox, aprobar ni leer tokens de envío');

-- Un usuario autenticado que no es socio tampoco aprueba.
select pg_temp.como('authenticated', '00000000-0000-0000-0000-0000000000ff');
select pg_temp.debe_fallar($$select agents.aprobar('30000000-0000-0000-0000-000000000001')$$, 'NO_AUTORIZADO');
reset role;

-- Guzmán aprueba con una edición: entra en la outbox y queda un ejemplo de estilo.
select pg_temp.como('authenticated', '00000000-0000-0000-0000-00000000000a');
select pg_temp.ok(agents.aprobar('30000000-0000-0000-0000-000000000001', null, 'Hola, equipo de Casa Pepe: (editado)', '[{"op":"cambio"}]') is not null,
  'un socio autenticado aprueba y el correo entra en la outbox');
select pg_temp.debe_fallar($$select agents.aprobar('30000000-0000-0000-0000-000000000001')$$, 'APROBACION_NO_PENDIENTE');
reset role;
select pg_temp.ok((select cuerpo from agents.outbox where approval_id = '30000000-0000-0000-0000-000000000001') = 'Hola, equipo de Casa Pepe: (editado)',
  'la outbox lleva la versión editada');
select pg_temp.ok((select count(*) = 1 from hunter.style_examples where approval_id = '30000000-0000-0000-0000-000000000001'),
  'Hunter guarda la corrección como ejemplo de estilo');

-- La outbox es inmutable y solo sigue transiciones válidas.
select pg_temp.como('hunter_outbox');
select pg_temp.debe_fallar($$update agents.outbox set cuerpo = 'otro' where approval_id = '30000000-0000-0000-0000-000000000001'$$, 'permission denied');
select pg_temp.debe_fallar($$update agents.outbox set estado = 'enviado' where approval_id = '30000000-0000-0000-0000-000000000001'$$, 'OUTBOX_TRANSICION');
update agents.outbox set estado = 'enviando' where approval_id = '30000000-0000-0000-0000-000000000001';
update agents.outbox set estado = 'enviado', enviado_at = now(), gmail_message_id = 'm1' where approval_id = '30000000-0000-0000-0000-000000000001';
reset role;
select pg_temp.ok(true, 'la outbox envía lo aprobado siguiendo en_cola → enviando → enviado');

-- Aprobar el lote exige confirmación explícita.
select pg_temp.como('hunter_agent');
insert into agents.approvals (id, department, tipo, client_id, cuenta_email, para_email, asunto, cuerpo)
values ('30000000-0000-0000-0000-000000000002', 'hunter', 'seguimiento', '10000000-0000-0000-0000-000000000001',
        'guzmangonzalezperez@gmail.com', 'info@mesonvalderrey.com', 'Re: Vuestra web', 'Os dejo la maqueta…');
reset role;
select pg_temp.como('authenticated', '00000000-0000-0000-0000-00000000000a');
select pg_temp.debe_fallar($$select agents.aprobar_lote(array['30000000-0000-0000-0000-000000000002']::uuid[], false)$$, 'LOTE_SIN_CONFIRMAR');
reset role;
select pg_temp.ok(true, 'el lote no se aprueba sin confirmación');

-- ============================================================================
-- Regla 3 · Cuenta del lead
-- ============================================================================
select pg_temp.como('hunter_agent');
insert into agents.approvals (id, department, tipo, client_id, cuenta_email, para_email, asunto, cuerpo)
values ('30000000-0000-0000-0000-000000000003', 'hunter', 'seguimiento', '10000000-0000-0000-0000-000000000001',
        'guzmangonzalez.twati@gmail.com', 'info@mesonvalderrey.com', 'Re: Vuestra web', 'Desde la otra cuenta');
insert into agents.approvals (id, department, tipo, client_id, cuenta_email, para_email, asunto, cuerpo)
values ('30000000-0000-0000-0000-000000000004', 'hunter', 'seguimiento', '10000000-0000-0000-0000-000000000001',
        'guzmangonzalezperez@gmail.com', 'otro@malo.com', 'Re: Vuestra web', 'A otra dirección');
reset role;
select pg_temp.como('authenticated', '00000000-0000-0000-0000-00000000000a');
select pg_temp.debe_fallar($$select agents.aprobar('30000000-0000-0000-0000-000000000003')$$, 'CUENTA_DISTINTA');
select pg_temp.debe_fallar($$select agents.aprobar('30000000-0000-0000-0000-000000000004')$$, 'DESTINATARIO_DISTINTO');
reset role;
select pg_temp.ok(true, 'nunca se envía desde la cuenta de otro ni a una dirección que no es la del lead');

-- ============================================================================
-- Regla 2 · «No contactar» es irreversible y la supresión manda en los seguimientos
-- ============================================================================
-- Hay un seguimiento de Trufas en cola cuando contestan «no».
select pg_temp.como('hunter_agent');
insert into agents.approvals (id, department, tipo, client_id, cuenta_email, para_email, asunto, cuerpo)
values ('30000000-0000-0000-0000-000000000005', 'hunter', 'seguimiento', '10000000-0000-0000-0000-000000000002',
        'guzmangonzalez.twati@gmail.com', 'isabel@trufasbertolin.com', 'Re: Vuestras trufas', 'La maqueta…'),
       ('30000000-0000-0000-0000-000000000006', 'hunter', 'seguimiento', '10000000-0000-0000-0000-000000000002',
        'guzmangonzalez.twati@gmail.com', 'isabel@trufasbertolin.com', 'Re: Vuestras trufas', 'Otra'),
       ('30000000-0000-0000-0000-000000000009', 'hunter', 'seguimiento', '10000000-0000-0000-0000-000000000002',
        'guzmangonzalez.twati@gmail.com', 'isabel@trufasbertolin.com', 'Re: Vuestras trufas', 'Una tercera');
reset role;
select pg_temp.como('authenticated', '00000000-0000-0000-0000-00000000000a');
select agents.aprobar('30000000-0000-0000-0000-000000000005');
select agents.aprobar('30000000-0000-0000-0000-000000000009');
reset role;
-- La outbox lo coge para enviar justo antes de que llegue el «no».
select pg_temp.como('hunter_outbox');
update agents.outbox set estado = 'enviando' where approval_id = '30000000-0000-0000-0000-000000000009';
reset role;

-- La bandeja clasifica el «no» (lo hace el worker del agente).
select pg_temp.como('hunter_agent');
update public.clients set do_not_contact = true, do_not_contact_reason = 'Contestó «no»' where id = '10000000-0000-0000-0000-000000000002';
reset role;

select pg_temp.ok((select stage = 'perdido' from public.clients where id = '10000000-0000-0000-0000-000000000002'), 'un «no» pasa el lead a Perdido');
select pg_temp.ok((select count(*) = 2 from agents.suppression_list where client_id = '10000000-0000-0000-0000-000000000002'),
  'su email y su dominio entran en la lista de supresión');
select pg_temp.ok((select estado = 'cancelado' from agents.outbox where approval_id = '30000000-0000-0000-0000-000000000005'),
  'el seguimiento que estaba en cola se cancela');
select pg_temp.ok((select estado = 'caducado' from agents.approvals where id = '30000000-0000-0000-0000-000000000006'),
  'los borradores pendientes caducan');

-- Si la outbox ya lo tenía en «enviando», no puede terminar de enviarlo… salvo que ya hubiera salido; reintentar falla.
select pg_temp.como('hunter_outbox');
update agents.outbox set estado = 'en_cola' where approval_id = '30000000-0000-0000-0000-000000000009';
select pg_temp.debe_fallar($$update agents.outbox set estado = 'enviando' where approval_id = '30000000-0000-0000-0000-000000000009'$$, 'NO_CONTACTAR');
reset role;
select pg_temp.ok(true, 'la outbox vuelve a comprobar la supresión justo antes de enviar');

-- Irreversible: nadie lo desmarca, ni un socio, ni el agente, ni service_role.
select pg_temp.como('authenticated', '00000000-0000-0000-0000-00000000000a');
select pg_temp.debe_fallar($$update public.clients set do_not_contact = false where id = '10000000-0000-0000-0000-000000000002'$$, 'NO_CONTACTAR_IRREVERSIBLE');
select pg_temp.debe_fallar($$update public.clients set stage = 'contactado' where id = '10000000-0000-0000-0000-000000000002'$$, 'NO_CONTACTAR');
select pg_temp.debe_fallar($$delete from agents.suppression_list where client_id = '10000000-0000-0000-0000-000000000002'$$, 'permission denied');
reset role;
select pg_temp.como('hunter_agent');
select pg_temp.debe_fallar($$update public.clients set do_not_contact = false, stage = 'contactado' where id = '10000000-0000-0000-0000-000000000002'$$, 'NO_CONTACTAR_IRREVERSIBLE');
reset role;
select pg_temp.como('service_role');
select pg_temp.debe_fallar($$update public.clients set do_not_contact = false where id = '10000000-0000-0000-0000-000000000002'$$, 'NO_CONTACTAR_IRREVERSIBLE');
select pg_temp.debe_fallar($$delete from agents.suppression_list where client_id = '10000000-0000-0000-0000-000000000002'$$, 'SUPRESION_INMUTABLE');
select pg_temp.debe_fallar($$update agents.suppression_list set valor = 'x@y.z' where client_id = '10000000-0000-0000-0000-000000000002'$$, 'SUPRESION_INMUTABLE');
select pg_temp.debe_fallar($$truncate agents.suppression_list$$, 'SUPRESION_INMUTABLE');
reset role;
select pg_temp.ok(true, '«No contactar» es irreversible y la supresión no se borra ni con service_role');

-- Los seguimientos respetan la supresión: Hunter ni siquiera puede proponerlo.
select pg_temp.como('hunter_agent');
select pg_temp.debe_fallar($$insert into agents.approvals (department, tipo, client_id, cuenta_email, para_email, asunto, cuerpo)
  values ('hunter', 'seguimiento', '10000000-0000-0000-0000-000000000002', 'guzmangonzalez.twati@gmail.com',
          'isabel@trufasbertolin.com', 'Re: trufas', 'Otra vez')$$, 'NO_CONTACTAR');
reset role;

-- La supresión es global: otro negocio con el mismo dominio (o un subdominio) tampoco.
insert into public.clients (id, name, province, website, email, send_account)
values ('10000000-0000-0000-0000-000000000004', 'Trufas tienda', 'Teruel', 'https://tienda.trufasbertolin.com', 'ventas@tienda.trufasbertolin.com', 'guzmangonzalez.twati@gmail.com');
select pg_temp.como('hunter_agent');
select pg_temp.debe_fallar($$insert into agents.approvals (department, tipo, client_id, cuenta_email, para_email, asunto, cuerpo)
  values ('hunter', 'nuevo', '10000000-0000-0000-0000-000000000004', 'guzmangonzalez.twati@gmail.com',
          'ventas@tienda.trufasbertolin.com', 'Hola', 'Cuerpo')$$, 'SUPRIMIDO');
select pg_temp.debe_fallar($$insert into hunter.leads (client_id, email, dominio, provincia, socio)
  values ('10000000-0000-0000-0000-000000000004', 'ventas@tienda.trufasbertolin.com', 'trufasbertolin.com', 'Teruel', 'guzman')$$, 'SUPRIMIDO');
reset role;
select pg_temp.ok(true, 'la supresión por dominio alcanza a subdominios y a otros emails del negocio');

-- Un email gratuito suprimido no suprime gmail.com entero.
insert into agents.suppression_list (tipo, valor, motivo) values ('email', 'otro@gmail.com', 'prueba');
select pg_temp.ok(not agents.esta_suprimido('pepe@gmail.com', 'https://casapepe.es'), 'suprimir un @gmail.com no bloquea a todos los @gmail.com');

-- ============================================================================
-- Regla 4 · Territorio y duplicados
-- ============================================================================
insert into public.clients (id, name, province, website, email) values
  ('10000000-0000-0000-0000-000000000007', 'Bar Sevilla', 'Sevilla', 'http://barsevilla.es', 'hola@barsevilla.es'),
  ('10000000-0000-0000-0000-000000000008', 'Mesón 2', 'Valladolid', 'http://mesonvalderrey.com', 'reservas@mesonvalderrey.com'),
  ('10000000-0000-0000-0000-000000000009', 'Mesón 3', 'Valladolid', 'http://otro.es', 'info@mesonvalderrey.com');
select pg_temp.como('hunter_agent');
select pg_temp.debe_fallar($$insert into hunter.leads (client_id, email, dominio, provincia, socio)
  values ('10000000-0000-0000-0000-000000000007', 'hola@barsevilla.es', 'barsevilla.es', 'Sevilla', 'guzman')$$, 'TERRITORIO');
select pg_temp.debe_fallar($$insert into hunter.leads (client_id, email, dominio, provincia, socio)
  values ('10000000-0000-0000-0000-000000000008', 'reservas@mesonvalderrey.com', 'mesonvalderrey.com', 'Valladolid', 'guzman')$$, 'leads_dominio_unico');
select pg_temp.debe_fallar($$insert into hunter.leads (client_id, email, dominio, provincia, socio)
  values ('10000000-0000-0000-0000-000000000009', 'info@mesonvalderrey.com', 'otro.es', 'Valladolid', 'guzman')$$, 'leads_email_unico');
select pg_temp.debe_fallar($$insert into hunter.leads (client_id, email, dominio, provincia, socio)
  values ('10000000-0000-0000-0000-000000000009', 'INFO@mesonvalderrey.com', 'otro.es', 'Valladolid', 'guzman')$$, 'leads_email_check');
reset role;
select pg_temp.ok(true, 'territorio y duplicados por email y dominio normalizado se imponen en la base de datos');

-- Dominio registrable en SQL (coincide con el del worker en los casos habituales).
select pg_temp.ok(agents.dominio_registrable('https://WWW.Casa-Pepe.com.es/contacto?x=1') = 'casa-pepe.com.es', 'dominio .com.es');
select pg_temp.ok(agents.dominio_registrable('Info@Reservas.Mesonvalderrey.com') = 'mesonvalderrey.com', 'dominio desde email con subdominio');
select pg_temp.ok(agents.dominio_registrable('http://tienda.casapepe.es:8080/') = 'casapepe.es', 'dominio con puerto y subdominio');

-- ============================================================================
-- Botón de pausa
-- ============================================================================
select pg_temp.como('authenticated', '00000000-0000-0000-0000-00000000000a');
select agents.aprobar('30000000-0000-0000-0000-000000000002');
-- La pausa no se toca a mano (la RLS lo ignora): solo por agents.pausar(), que además vacía la cola.
update agents.settings set valor = '{"activa": true}' where department = 'hunter' and clave = 'pausa';
reset role;
select pg_temp.ok(not agents.en_pausa('hunter'), 'la pausa solo cambia por la RPC, no editando ajustes');
select pg_temp.como('authenticated', '00000000-0000-0000-0000-00000000000a');
-- En cola: el seguimiento del Mesón (…02) y el de Trufas (…09) que la outbox devolvió a la cola tras el «no».
select pg_temp.ok(agents.pausar('hunter', true) = 2, 'la pausa vacía la cola');
reset role;
select pg_temp.ok((select count(*) = 0 from agents.outbox where estado = 'en_cola'), 'no queda nada en cola');
select pg_temp.ok((select estado = 'pendiente' from agents.approvals where id = '30000000-0000-0000-0000-000000000002'), 'lo que estaba en cola vuelve a la mesa');
select pg_temp.ok((select estado = 'caducado' from agents.approvals where id = '30000000-0000-0000-0000-000000000009'), 'salvo lo de un lead en No contactar, que caduca');
select pg_temp.como('authenticated', '00000000-0000-0000-0000-00000000000a');
select pg_temp.debe_fallar($$select agents.aprobar('30000000-0000-0000-0000-000000000002')$$, 'PAUSA');
select agents.pausar('hunter', false);
select pg_temp.ok(agents.aprobar('30000000-0000-0000-0000-000000000002') is not null, 'tras quitar la pausa se puede volver a aprobar');
reset role;

-- ============================================================================
-- RLS: fuera de la lista de socios no se ve nada
-- ============================================================================
select pg_temp.como('authenticated', '00000000-0000-0000-0000-0000000000ff');
select pg_temp.ok((select count(*) = 0 from agents.approvals), 'un usuario que no es socio no ve la mesa');
select pg_temp.ok((select count(*) = 0 from hunter.leads), 'ni los leads');
reset role;
select pg_temp.como('anon');
select pg_temp.debe_fallar($$select count(*) from agents.approvals$$, 'permission denied');
reset role;
select pg_temp.como('authenticated', '00000000-0000-0000-0000-00000000000b');
select pg_temp.ok((select count(*) > 0 from agents.approvals), 'Dani (socio) sí ve la mesa');
reset role;

-- Tokens: el agente solo lee el de lectura; la outbox solo el de envío.
select pg_temp.como('authenticated', '00000000-0000-0000-0000-00000000000a');
select hunter.guardar_token('guzmangonzalezperez@gmail.com', 'lectura', 'tok-lectura');
select hunter.guardar_token('guzmangonzalezperez@gmail.com', 'envio', 'tok-envio');
reset role;
select pg_temp.como('hunter_agent');
select pg_temp.ok(hunter.token_lectura('guzmangonzalezperez@gmail.com') = 'tok-lectura', 'el agente lee su token de lectura');
reset role;
select pg_temp.como('hunter_outbox');
select pg_temp.ok(hunter.token_envio('guzmangonzalezperez@gmail.com') = 'tok-envio', 'la outbox lee su token de envío');
select pg_temp.debe_fallar($$select hunter.token_lectura('guzmangonzalezperez@gmail.com')$$, 'permission denied');
reset role;
select pg_temp.como('authenticated', '00000000-0000-0000-0000-00000000000a');
select pg_temp.debe_fallar($$select hunter.token_envio('guzmangonzalezperez@gmail.com')$$, 'permission denied');
reset role;

select pg_temp.ok(true, 'TODAS LAS REGLAS DE ORO DE LA BASE DE DATOS SE CUMPLEN');
