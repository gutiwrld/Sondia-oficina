-- Vistas de lectura para la sala de Hunter. security_invoker: respetan la RLS de quien consulta.

-- Radar: cada lead con sus datos del ERP, su última auditoría y su último envío.
create view hunter.v_radar with (security_invoker = on) as
select
  l.client_id,
  c.name as nombre,
  c.sector,
  c.city as ciudad,
  l.provincia,
  c.website as web,
  l.email,
  l.dominio,
  c.phone as telefono,
  c.stage as etapa,
  c.do_not_contact as no_contactar,
  c.email_bounced as rebotado,
  coalesce(nullif(l.cuenta_email, ''), nullif(c.send_account, '')) as cuenta,
  l.senal,
  l.prioridad,
  l.sin_hilo,
  l.origen,
  l.primer_envio_at,
  l.ultimo_envio_at,
  l.ultima_respuesta_at,
  c.email_subject as asunto,
  l.created_at
from hunter.leads l
join public.clients c on c.id = l.client_id;

-- Bandeja: mensajes entrantes clasificados con el lead y la acción que propone Hunter.
create view hunter.v_bandeja with (security_invoker = on) as
select
  m.id, m.cuenta_email, m.gmail_thread_id, m.de, m.asunto, m.fragmento, m.recibido_at,
  m.clasificacion, m.confianza, m.resumen, m.procesado,
  m.client_id, c.name as nombre, c.stage as etapa, c.do_not_contact as no_contactar,
  a.id as approval_id, a.tipo as accion_tipo, a.estado as accion_estado, a.asunto as accion_asunto
from hunter.messages m
left join public.clients c on c.id = m.client_id
left join agents.approvals a on a.id = m.approval_id
where m.direccion = 'entrante';

-- Agenda: próximas llamadas y visitas.
create view hunter.v_agenda with (security_invoker = on) as
select mt.id, mt.client_id, c.name as nombre, c.city as ciudad, c.phone as telefono, mt.tipo, mt.empieza_at,
       mt.termina_at, mt.estado, mt.ficha_md is not null as tiene_ficha, mt.ficha_md
from hunter.meetings mt
join public.clients c on c.id = mt.client_id;

-- Mesa: borradores con el nombre del lead y su Señal.
create view agents.v_mesa with (security_invoker = on) as
select a.*, c.name as nombre, c.city as ciudad, c.province as provincia, c.website as web, c.sector
from agents.approvals a
join public.clients c on c.id = a.client_id;

grant select on hunter.v_radar, hunter.v_bandeja, hunter.v_agenda, agents.v_mesa to authenticated, service_role;
