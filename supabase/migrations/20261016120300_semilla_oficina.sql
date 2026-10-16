-- Datos de arranque: departamentos, territorio (manual, sección 3), cuentas de Gmail de Guzmán y ajustes por defecto.

insert into agents.departments (slug, numero, nombre, descripcion, estado) values
  ('hunter', 1, 'Hunter', 'Encuentra negocios con webs anticuadas, los audita, escribe, lee respuestas y prepara las llamadas.', 'activo'),
  ('cierre', 2, 'Cierre', 'Propuestas, presupuestos y seguimiento hasta el «sí».', 'libre'),
  ('entrega', 3, 'Entrega', 'Del «sí» a la web publicada: maqueta, contenidos, dominio y entrega.', 'libre'),
  ('finanzas', 4, 'Finanzas', 'Cobros, facturas y caja de SONDIA.', 'libre')
on conflict (slug) do nothing;

with socios as (
  select
    (select id from public.members where short_name = 'Guzmán' limit 1) as guzman,
    (select id from public.members where short_name = 'Hugo' limit 1) as hugo
)
insert into hunter.territories (provincia, socio, member_id, rastreo)
select p.provincia, p.socio, case p.socio when 'guzman' then s.guzman when 'hugo' then s.hugo end, p.rastreo
from socios s, (values
  ('Alicante', 'guzman', true), ('Castellón', 'guzman', true), ('Valencia', 'guzman', true),
  ('Barcelona', 'guzman', true), ('Girona', 'guzman', true), ('Lleida', 'guzman', true),
  ('Tarragona', 'guzman', true), ('Álava', 'guzman', true), ('Bizkaia', 'guzman', true),
  ('Gipuzkoa', 'guzman', true), ('Illes Balears', 'guzman', true), ('Madrid', 'guzman', true),
  ('Murcia', 'guzman', false), ('León', 'guzman', false), ('Albacete', 'guzman', false),
  ('Ciudad Real', 'guzman', false), ('Jaén', 'guzman', false), ('Badajoz', 'guzman', false),
  ('Cáceres', 'guzman', false), ('Zamora', 'guzman', false), ('Palencia', 'guzman', false),
  ('Soria', 'guzman', false), ('Teruel', 'guzman', false), ('Cuenca', 'guzman', false),
  ('Ourense', 'guzman', false), ('Lugo', 'guzman', false), ('Huesca', 'guzman', false),
  ('Burgos', 'guzman', false), ('Ávila', 'guzman', false), ('Segovia', 'guzman', false),
  ('Toledo', 'guzman', false), ('Guadalajara', 'guzman', false), ('Salamanca', 'guzman', false),
  ('Valladolid', 'guzman', false), ('La Rioja', 'guzman', false), ('Navarra', 'guzman', false),
  ('Asturias', 'guzman', false), ('Cantabria', 'guzman', false),
  ('Almería', 'hugo', false), ('Cádiz', 'hugo', false), ('Córdoba', 'hugo', false),
  ('Granada', 'hugo', false), ('Huelva', 'hugo', false), ('Málaga', 'hugo', false),
  ('Sevilla', 'hugo', false), ('A Coruña', 'hugo', false), ('Pontevedra', 'hugo', false),
  ('Zaragoza', 'hugo', false), ('Las Palmas', 'hugo', false), ('Santa Cruz de Tenerife', 'hugo', false)
) as p(provincia, socio, rastreo)
on conflict (provincia) do nothing;

insert into hunter.mail_accounts (email, socio, member_id, firma_nombre)
select e, 'guzman', (select id from public.members where short_name = 'Guzmán' limit 1), 'Guzmán'
from unnest(array['guzmangonzalezperez@gmail.com', 'guzmangonzalez.twati@gmail.com']) as e
on conflict (email) do nothing;

insert into agents.settings (department, clave, valor) values
  ('hunter', 'pausa', '{"activa": false}'),
  ('hunter', 'envio', '{
     "limiteDiario": 50, "esperaMinMinutos": 2, "esperaMaxMinutos": 6,
     "franjas": {
       "nuevo":       {"dias": [1,2,3,4],   "desde": "09:00", "hasta": "11:00"},
       "seguimiento": {"dias": [1,2,3,4],   "desde": "11:00", "hasta": "13:00"},
       "respuesta":   {"dias": [1,2,3,4,5], "desde": "09:00", "hasta": "19:00"},
       "reunion":     {"dias": [1,2,3,4,5], "desde": "09:00", "hasta": "19:00"}
     },
     "rampa": [{"desdeDia":1,"limite":10},{"desdeDia":4,"limite":20},{"desdeDia":8,"limite":30},{"desdeDia":15,"limite":40},{"desdeDia":22,"limite":50}]
   }'),
  ('hunter', 'seguimiento', '{"diasSeguimiento": 3, "diasLlamada": 7}'),
  ('hunter', 'agenda', '{"zona": "Europe/Madrid", "desde": "10:00", "hasta": "19:00", "huecosPropuestos": 2, "duracionMinutos": 30}'),
  ('hunter', 'presupuesto', '{
     "anthropicPorEjecucionEur": 2, "anthropicPorDiaEur": 8,
     "placesPorEjecucionEur": 1, "placesPorDiaEur": 3
   }'),
  ('hunter', 'modelos', '{"redactar": "claude-opus-5-5", "clasificar": "claude-haiku-5-5"}'),
  ('hunter', 'rastreo', '{"negociosPorEjecucion": 20, "provinciaActual": null}')
on conflict (department, clave) do nothing;
