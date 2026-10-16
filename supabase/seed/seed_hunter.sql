-- Seed de Hunter (volcado del 13-oct-2026). Generado por workers/hunter/src/seed/importar.ts. No editar a mano.
-- Idempotente: no hace nada si el seed ya está importado.
begin;
do $$ begin if exists (select 1 from hunter.leads where origen = 'seed') then raise exception 'SEED_YA_IMPORTADO'; end if; end $$;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hostería Palacete Rural La Seda', 'Restaurante / eventos', 'Murcia (Santa Cruz)', 'Murcia', 'http://www.palacetelaseda.com', 'hosteria@palacetelaseda.com', '968 870 848', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Vuestra página de Horarios está vacía', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'hosteria@palacetelaseda.com', 'palacetelaseda.com', 'http://www.palacetelaseda.com', 'Murcia', 'guzman', null, 'Palacete histórico en la huerta que se define como ''templo gastronómico de la Región de Murcia''', 'alta', false, 'seed', 'la-seda', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra página de Horarios está vacía
Fallos: La página ''Horarios'' está vacía | No tiene HTTPS: el navegador la marca como no segura | Maquetada con tablas de ancho fijo, no se adapta al móvil | Footer ''CopyRight 2022/'' y en interiores sin año

Hola, equipo de La Seda:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Buscando restaurantes con encanto en Murcia, un palacete en plena huerta que se llama a sí mismo "templo gastronómico" me ganó en dos segundos.

Os escribo porque la web no está a la altura del sitio: la página de Horarios está vacía, en el móvil se ve diminuta y el navegador la marca como "no segura". Justo lo que ve una pareja buscando dónde celebrar su boda.

¿Os hago gratis una maqueta de cómo quedaría la portada nueva? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Formaes Centro de Estudios', 'Academia', 'Puerto de Mazarrón', 'Murcia', 'http://formaes.es', 'academia@formaes.es', '968 154 401', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', '¿Desde 2007 o 20 años? Vuestra web no se decide', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'academia@formaes.es', 'formaes.es', 'http://formaes.es', 'Murcia', 'guzman', null, '100% de aprobados en Trinity ISE I e ISE II (2023)', 'media', false, 'seed', 'formaes', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: ¿Desde 2007 o 20 años? Vuestra web no se decide
Fallos: Tablas de ancho fijo, diminuta en el móvil | ''Desde 2007'' y ''¡¡20 años en Puerto de Mazarrón!!'' a la vez | Una sola página de texto largo

Hola, equipo de Formaes:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Un 100% de aprobados en el Trinity ISE I e ISE II es para ponerlo en letras gigantes, y en vuestra web queda escondido en una página larguísima de texto.

Además, en el móvil se ve diminuta y pone a la vez "Desde 2007" y "¡¡20 años en Puerto de Mazarrón!!", así que los padres no saben qué creerse.

¿Os preparo gratis una maqueta de la portada para que la veáis? Si no os gusta, a la papelera y sin rencores.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Cuchillería Barbero', 'Cuchillería artesana', 'Albacete', 'Albacete', 'http://www.cuchilleriabarbero.es', 'tienda@cuchilleriabarbero.es', '967 99 01 77', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Vuestra web dice que sois una lavandería de Nueva York', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'tienda@cuchilleriabarbero.es', 'cuchilleriabarbero.es', 'http://www.cuchilleriabarbero.es', 'Albacete', 'guzman', null, 'Familiar desde 1945 en la Plaza de la Catedral, tres generaciones, premios de navaja', 'alta', false, 'seed', 'barbero', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web dice que sois una lavandería de Nueva York
Fallos: Plantilla de lavandería: menú en inglés, ''Dry Cleaning'', planes de $49/Mo | Contacto: ''123 Street, New York'' e info@example.com | Lorem ipsum en About y Blog | Footer © 2010; dice 78 años (son 81)

Hola, equipo de Cuchillería Barbero:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Desde 1945 en la Plaza de la Catedral, tres generaciones y premios a la mejor navaja: lo vuestro es patrimonio de Albacete.

Por eso os aviso de algo que os va a hacer gracia (o no): vuestra web está montada sobre una plantilla de lavandería. En "Contact" sale una dirección de Nueva York y un email de ejemplo, en "Services" ofrecéis "Dry Cleaning" y en "Pricing" hay planes de 49 dólares al mes. Un cliente que quiera comprar una navaja no sabe muy bien qué pensar.

¿Os hago gratis una maqueta de cómo quedaría una web a la altura de vuestras navajas? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Restaurante Tapería La Mancha', 'Restaurante', 'Albacete', 'Albacete', 'https://www.restaurantelamancha.com', 'info@restaurantelamancha.com', '967 22 16 82', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'El sobrecito de vuestra web lleva a una página de error', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@restaurantelamancha.com', 'restaurantelamancha.com', 'https://www.restaurantelamancha.com', 'Albacete', 'guzman', null, 'Familiar desde 1999 (Gerardo y Concha); atascaburras y ajo mataero; Gerardo grabó ''Hojas Rotas''', 'alta', false, 'seed', 'taperia-mancha', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: El sobrecito de vuestra web lleva a una página de error
Fallos: Icono del email mal enlazado: lleva a una página 404 | Botón a Google+ | Footer © 2016 | No hay carta en la web

Hola, Gerardo y Concha:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Atascaburras, ajo mataero y un dueño que graba una canción para dar las gracias a sus clientes: me habéis ganado.

Os escribo porque en vuestra web el icono del sobre, que es el único sitio donde aparece vuestro email, lleva a una página de error. Quien quiere reservar por correo no puede. Además, no está la carta, el pie sigue en 2016 y hay un botón a Google+, que cerró en 2019.

¿Os preparo gratis una maqueta con la carta bien visible y un botón de reserva que funcione? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Clínica Dental CIMER', 'Clínica dental', 'Almansa', 'Albacete', 'https://www.clinicacimeralmansa.com', 'info@clinicacimeralmansa.com', '967 343 626', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Un "Click edit button to change this text" en vuestra portada', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@clinicacimeralmansa.com', 'clinicacimeralmansa.com', 'https://www.clinicacimeralmansa.com', 'Albacete', 'guzman', null, '21 años, 27.000 pacientes, 38.000 implantes, planificación 3D', 'alta', false, 'seed', 'cimer', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Un "Click edit button to change this text" en vuestra portada
Fallos: Texto de relleno visible dos veces en portada: ''I am text block. Click edit button to change this text. Lorem ipsum''

Hola, equipo de CIMER:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. 27.000 pacientes y 38.000 implantes con planificación 3D son cifras para presumir, y en vuestra web las tenéis bien a la vista.

Justo encima, eso sí, se cuela dos veces el texto de relleno del maquetador: "I am text block. Click edit button to change this text. Lorem ipsum…". Es una tontería de cinco minutos, pero a un paciente que va a confiaros su boca le da que pensar.

Si queréis, os lo arreglo, y de paso os preparo gratis una maqueta con alguna mejora para captar más pacientes. Si no os gusta, la borro y aquí no ha pasado nada.

Seguimiento: 2026-10-02 maqueta + 490 €', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hostal Rural Mirador Sierra de Alcaraz', 'Hostal rural / restaurante', 'Alcaraz', 'Albacete', 'http://www.alcarazmirador.com', 'info@alcarazmirador.com', '967 380 017', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Puede que vuestro formulario de contacto no esté enviando nada', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@alcarazmirador.com', 'alcarazmirador.com', 'http://www.alcarazmirador.com', 'Albacete', 'guzman', null, 'Edificio del s. XVI, antiguo colegio de jesuitas; restaurante en bodegas abovedadas; +300 opiniones en Booking', 'alta', false, 'seed', 'mirador-alcaraz', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Puede que vuestro formulario de contacto no esté enviando nada
Fallos: Formulario con reCAPTCHA v1 (apagado en 2018): probablemente no envía | Web de 2008 con Flash | No se adapta al móvil | ''Edad Media S.XVI'', erratas

Hola, equipo del Mirador Sierra de Alcaraz:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Un colegio de jesuitas del siglo XVI con restaurante en las antiguas bodegas abovedadas y caldereta de ciervo: eso hay que enseñarlo bien.

Os aviso de algo importante: el formulario de contacto de vuestra web usa un sistema antiespam que Google apagó en 2018, así que lo más probable es que los mensajes no os estén llegando. Además, la web es de 2008, tiene un Flash que ya no se ve en ningún navegador y en el móvil sale diminuta.

¿Os preparo gratis una maqueta con reserva directa, para no depender tanto de Booking? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Talleres Camacho', 'Carpintería metálica / PVC', 'Villarrobledo', 'Albacete', 'http://www.tallerescamachoyvillarrobledo.es', 'presupuestos@tallerescamacho.net', '967 142 113', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Una cosa de vuestra web (y de los dos emails)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'presupuestos@tallerescamacho.net', 'tallerescamacho.net', 'http://www.tallerescamachoyvillarrobledo.es', 'Albacete', 'guzman', null, '+30 años fabricando ventanas y cerramientos, proyectos nacionales e internacionales', 'alta', false, 'seed', 'camacho', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Una cosa de vuestra web (y de los dos emails)
Fallos: Botones de Twitter y Facebook no llevan a ningún sitio | Sin https: ''No seguro'' | No se adapta al móvil | Dos emails de dominios distintos; ''Email: :''

Hola, equipo de Talleres Camacho:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Más de 30 años haciendo ventanas y cerramientos, con proyectos hasta fuera de España: eso no se hace en cualquier taller.

La web, en cambio, no os hace justicia. Chrome la marca como "No seguro", en el móvil no se adapta, los botones de Facebook y Twitter no llevan a ningún sitio y aparecen dos emails de dominios distintos, así que el cliente no sabe a cuál escribir.

¿Os preparo gratis una maqueta con vuestros trabajos y un formulario de presupuesto claro? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Montoya Chapa y Pintura', 'Taller de chapa y pintura', 'Villarrobledo', 'Albacete', 'http://www.tallerchapa.com/montoyachapi.html', 'montoyachapi@hotmail.com', '967 146 376', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', '¿Una web propia para Montoya Chapa y Pintura?', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'montoyachapi@hotmail.com', 'tallerchapa.com', 'http://www.tallerchapa.com/montoyachapi.html', 'Albacete', 'guzman', null, 'Trabajan con todas las aseguradoras, fotoperitación, vehículo de sustitución', 'media', false, 'seed', 'montoya', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: ¿Una web propia para Montoya Chapa y Pintura?
Fallos: Sin dominio propio (ficha en tallerchapa.com) | Email de Hotmail; fax igual que el teléfono | No se adapta al móvil | ''ISO-14004'' y ''normativa UOC''

Hola, Roberto:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Trabajar con todas las aseguradoras, hacer fotoperitación y dar coche de sustitución es justo lo que busca alguien que acaba de tener un golpe.

Te escribo porque ahora mismo no tenéis web propia: sois una ficha dentro de otro portal, con un correo de Hotmail y un fax que es el mismo número que el teléfono. Cuando alguien busca "chapa y pintura Villarrobledo" en el móvil, eso le transmite menos confianza de la que os merecéis.

¿Te preparo gratis una maqueta de una web vuestra, sencilla y con botón de llamada? Si no te convence, la borro y listo.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Haro Clínica Odontológica', 'Clínica dental', 'Villarrobledo', 'Albacete', 'https://www.clinicaharo.com', 'contacta@clinicaharo.com', '967 13 77 71', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'La última novedad de vuestra web es el COVID', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'contacta@clinicaharo.com', 'clinicaharo.com', 'https://www.clinicaharo.com', 'Albacete', 'guzman', null, 'Clínica de la Dra. Haro en la Plaza Santa María, Invisalign 3D', 'media', false, 'seed', 'haro', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: La última novedad de vuestra web es el COVID
Fallos: Última novedad de portada: medidas COVID-19 | Footer con © 2018 y © 2026 a la vez | ''Read more'' en inglés | WordPress de 2018

Hola, equipo de Clínica Haro:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Hacer Invisalign planificado en 3D en plena Plaza Santa María es un argumentazo para captar pacientes.

Pero la última "Novedad" que aparece en vuestra portada son las medidas contra el coronavirus, el pie pone a la vez © 2018 y © 2026 y los botones dicen "Read more" en inglés. Quien entra puede pensar que la web está abandonada.

¿Os preparo gratis una maqueta con vuestros tratamientos bien explicados y reserva de cita online? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Clínica Veterinaria Aralla', 'Veterinaria y tienda', 'Villamalea', 'Albacete', 'http://aralla.es', 'info@aralla.es', '967 483 738', '', 'contactado', '', null, null, '', 'No confirmado que siga abierta.', false, '', false, '', 'seed-2026-10-13', '', 'La "nueva web" de Aralla', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@aralla.es', 'aralla.es', 'http://aralla.es', 'Albacete', 'guzman', null, 'Veterinaria con tienda y transporte especializado de mascotas', 'baja', false, 'seed', 'aralla', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: La "nueva web" de Aralla
Fallos: Sin https | Portada: ''bienvenida a nuestra nueva web'' | Contacte sin email ni formulario | ''hampsters'', ''trasporte''

Hola, equipo de Aralla:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Veterinario, tienda y hasta transporte especializado para mascotas: lo tenéis todo.

Os escribo porque la web sigue dando "la bienvenida a nuestra nueva web" (y ya no es tan nueva), el navegador la marca como no segura y en "Contacte" no hay ni email ni formulario, solo el teléfono.

¿Os hago gratis una maqueta con botón de WhatsApp y cita online? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Madecar Carpintería F.B.', 'Carpintería de madera', 'Tomelloso', 'Ciudad Real', 'http://www.madecartomelloso.com', 'carpinteriafb@hotmail.com', '926 505 342', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Vuestra galería de puertas no se ve', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'carpinteriafb@hotmail.com', 'madecartomelloso.com', 'http://www.madecartomelloso.com', 'Ciudad Real', 'guzman', null, 'Desde 1990, especialistas en puertas de calle, barandas con LED', 'alta', false, 'seed', 'madecar', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra galería de puertas no se ve
Fallos: Galería y cabecera en Flash: no se ve nada | Texto de relleno ''Nombre de la Empresa'' | Footer © 2009; ''20 años'' (son 36) | Sin https, no móvil, email Hotmail

Hola, equipo de Madecar:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Puertas de calle a medida y barandas con iluminación LED: tenéis trabajos muy chulos para enseñar.

El problema es que nadie puede verlos. La galería y la cabecera de vuestra web están hechas en Flash, que dejó de funcionar en 2020, así que donde deberían salir las fotos sale un aviso de error. Además, en la cabecera pone "Nombre de la Empresa" (texto de plantilla) y dice 20 años de experiencia cuando ya lleváis 36.

¿Os preparo gratis una maqueta con vuestras puertas a pantalla completa? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Talleres Picazo', 'Taller de camiones', 'Tomelloso', 'Ciudad Real', 'http://www.tallerespicazo.com', 'taller@tallerespicazo.com', '926 034 067', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Vuestra web da un aviso de "conexión no privada"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'taller@tallerespicazo.com', 'tallerespicazo.com', 'http://www.tallerespicazo.com', 'Ciudad Real', 'guzman', null, '+30 años reparando camiones y vehículos industriales; atiende Pedro', 'alta', false, 'seed', 'picazo', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web da un aviso de "conexión no privada"
Fallos: Certificado https caducado: aviso de conexión no privada | Textos de plantilla en inglés | Una sola página sin fotos ni servicios

Hola, Pedro:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Más de 30 años reparando camiones en Tomelloso: eso es oficio de verdad.

Te escribo porque si alguien entra en vuestra web por https, el navegador le avisa de que "la conexión no es privada": el certificado es el genérico del hosting y caducó en mayo. Además, quedan textos de la plantilla en inglés ("Quick Links", "Recent Post") y toda la web es una sola página, sin fotos del taller ni lista de servicios.

Una empresa de transporte que busca taller mira eso. ¿Te preparo gratis una maqueta? Si no te convence, la borro y listo.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Chapa Rapid, S.L.', 'Taller chapa y pintura', 'Murcia (La Chimenea)', 'Murcia', 'https://www.chaparapid.es', 'chapa.rapid@chaparapid.es', '968 202 478', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Vuestros botones de Facebook no llevan a ningún sitio', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'chapa.rapid@chaparapid.es', 'chaparapid.es', 'https://www.chaparapid.es', 'Murcia', 'guzman', null, '+25 años; coche de sustitución gratis y limpieza incluida', 'alta', false, 'seed', 'chapa-rapid', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestros botones de Facebook no llevan a ningún sitio
Fallos: Footer ''© 2012'' | Ancho fijo de 960 px, no se adapta al móvil | Iconos de Facebook y Twitter no llevan a ningún sitio | Palabras cortadas: ''espe-cializada''

Hola, equipo de Chapa Rapid:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Más de 25 años y coche de sustitución gratis con limpieza incluida: eso es lo que busca cualquiera que ha tenido un golpe.

Pero la web os deja un poco mal. El pie pone © 2012, en el móvil hay que hacer zoom para leer y los botones de Facebook y Twitter no llevan a ningún sitio.

¿Os hago gratis una maqueta de una web donde pedir presupuesto sea cosa de dos clics? Si no os convence, la borro y listo.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Centro Dental Manchego', 'Clínica dental', 'Puertollano', 'Ciudad Real', 'https://www.centrodentalmanchego.es', 'info@centrodentalmanchego.es', '926 422 093', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'La cabecera de vuestra web sale en blanco', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@centrodentalmanchego.es', 'centrodentalmanchego.es', 'https://www.centrodentalmanchego.es', 'Ciudad Real', 'guzman', null, 'Sección educativa con diccionario dental y página del Ratoncito Pérez', 'media', false, 'seed', 'dental-manchego', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: La cabecera de vuestra web sale en blanco
Fallos: Cabecera en Flash: sale en blanco | ''Haga doble click en el mapa'' | Enlace a ''tools.goolel.com'' | No deja hacer zoom en móvil

Hola, equipo del Centro Dental Manchego:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Tener en la web un diccionario odontológico y hasta una página del Ratoncito Pérez dice mucho de cómo cuidáis a los pacientes.

Por eso os aviso: la cabecera de vuestra web es un Flash que hoy sale en blanco, el texto pide "haga doble click en el mapa" para contactar y en la política de cookies hay un enlace a "goolel.com" (con una errata). Son detalles que restan.

¿Os preparo gratis una maqueta que conserve todo ese contenido pero con un diseño de hoy? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Fisioterapia y Osteopatía Natura', 'Fisioterapia', 'Valdepeñas', 'Ciudad Real', 'https://osteopatianatura.webnode.es', 'clinicanaturaval@gmail.com', '652 34 25 43', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Una web propia para Natura', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'clinicanaturaval@gmail.com', 'osteopatianatura.webnode.es', 'https://osteopatianatura.webnode.es', 'Ciudad Real', 'guzman', null, 'Osteopatía estructural, visceral, craneal y pediátrica; entrevistados en El Eco de Valdepeñas', 'media', false, 'seed', 'natura', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Una web propia para Natura
Fallos: Subdominio gratuito de Webnode con anuncio | Último post: despedida de un fisio (2024) | Cita online solo para una fisio

Hola, equipo de Natura:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Osteopatía estructural, visceral, craneal y pediátrica, y entrevista en El Eco de Valdepeñas: tenéis un perfil muy completo.

Os escribo porque la web está en un subdominio gratuito de Webnode, con su anuncio en todas las páginas, y la última entrada del blog es una despedida de 2024. Quien entra por primera vez puede pensar que la clínica ya no está activa, y no es así.

¿Os preparo gratis una maqueta con dominio propio y cita online para todo el equipo? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Clínica Real', 'Clínica dental', 'Ciudad Real', 'Ciudad Real', 'https://www.clinicareal.es', 'info@clinicareal.es', '926 923 990', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Vuestra web aún os invita a seguiros en Google+', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@clinicareal.es', 'clinicareal.es', 'https://www.clinicareal.es', 'Ciudad Real', 'guzman', null, 'Escáner maxilofacial 3D propio, Invisalign, encuesta de satisfacción', 'media', false, 'seed', 'clinica-real', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web aún os invita a seguiros en Google+
Fallos: Botón a Google+ | Blog parado en julio 2023 | Diseño de 2012

Hola, equipo de Clínica Real:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Tener escáner 3D propio y hasta buzón de sugerencias para pacientes dice mucho de cómo trabajáis.

La web, en cambio, se ha quedado atrás: en "Síguenos en las redes sociales" hay un botón a Google+, que cerró en 2019, el blog se paró en 2023 y el diseño es de hace más de diez años.

¿Os preparo gratis una maqueta con reserva de cita online? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('PEMAR – Ventanas Alcázar', 'Carpintería aluminio y PVC', 'Alcázar de San Juan', 'Ciudad Real', 'https://www.ventanasalcazar.com', 'contacto@ventanasalcazar.com', '926 550 914', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Una "tarifa flotante" en vuestra web', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'contacto@ventanasalcazar.com', 'ventanasalcazar.com', 'https://www.ventanasalcazar.com', 'Ciudad Real', 'guzman', null, '+20 años, taller propio, perfiles Deceuninck, tarimas y parquets', 'media', false, 'seed', 'pemar', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Una "tarifa flotante" en vuestra web
Fallos: No se adapta al móvil | Captcha antiguo | ''tarifa flotante'' en vez de tarima | Catálogo en PDF suelto

Hola, equipo de Ventanas Alcázar:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Más de 20 años con taller propio y trabajando con perfiles Deceuninck: eso da confianza.

La web, en cambio, se ve en el móvil como la de escritorio pero en pequeño, el formulario usa un captcha de los de antes y en las palabras clave para Google pone "tarifa flotante" en vez de "tarima flotante". Ahí perdéis búsquedas.

¿Os preparo gratis una maqueta con vuestros trabajos y presupuesto online? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Talleres Arvigar', 'Vehículos de limpieza', 'Tomelloso', 'Ciudad Real', 'http://www.arvigar.es', 'arvigar@arvigar.es', '926 51 01 33', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Bienvenidos a la portada', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'arvigar@arvigar.es', 'arvigar.es', 'http://www.arvigar.es', 'Ciudad Real', 'guzman', null, 'Desde 2006, nave de 2.000 m², clientes como Aqualia, Cespa, Acciona', 'media', false, 'seed', 'arvigar', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Bienvenidos a la portada
Fallos: Portada ''Bienvenidos a la portada'' (Joomla 2008) | Bloque central en Flash | Noticias con ministerio de 2011 | No móvil

Hola, equipo de Arvigar:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Equipar vehículos de limpieza para Aqualia, Cespa o Acciona desde una nave de 2.000 m² en Tomelloso es un currículum muy potente.

Vuestra web, en cambio, se titula "Bienvenidos a la portada" (el texto por defecto de Joomla de 2008), el bloque central es un Flash que ya no se ve y las noticias citan un ministerio que dejó de existir en 2011.

Para una empresa que trabaja con grandes clientes, la web es la carta de presentación. ¿Os preparo gratis una maqueta? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Multiservicios La Mancha', 'Reformas', 'Tomelloso', 'Ciudad Real', 'http://www.multiservicioslamancha.es', 'multiserviciosmlm@hotmail.com', '926 50 29 65', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Vuestro formulario todavía pide el fax', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'multiserviciosmlm@hotmail.com', 'multiservicioslamancha.es', 'http://www.multiservicioslamancha.es', 'Ciudad Real', 'guzman', null, 'Reformas integrales, cerrajería, electricidad y fontanería, dos locales', 'media', false, 'seed', 'multiservicios', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestro formulario todavía pide el fax
Fallos: Sin https ni móvil | ''Diseñado por ®'' sin nombre | Formulario pide Fax | Calle con dos nombres

Hola, equipo de Multiservicios La Mancha:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Reformas integrales, cerrajería, electricidad y fontanería con dos locales en Tomelloso: sois el "llama y te lo arreglamos" de la zona.

La web, en cambio, se ha quedado antigua: el formulario de presupuesto sigue pidiendo el fax, el navegador la marca como no segura, en el móvil no se adapta y la calle aparece con dos nombres distintos.

¿Os preparo gratis una maqueta con botón de WhatsApp para pedir presupuesto? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Muebles Ruiz y Gallego', 'Tienda de muebles', 'Tomelloso', 'Ciudad Real', 'https://www.ruizygallego.com', 'mueblesruizygallego@ruizygallego.com', '926 50 29 77', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Una frase a medias en vuestra portada', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'mueblesruizygallego@ruizygallego.com', 'ruizygallego.com', 'https://www.ruizygallego.com', 'Ciudad Real', 'guzman', null, 'Desde 1988, montaje gratis, asesor de decoración a domicilio', 'baja', false, 'seed', 'ruizgallego', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Una frase a medias en vuestra portada
Fallos: Footer y fotos de 2018 | Frase cortada en portada | Email con espacios

Hola, equipo de Ruiz y Gallego:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Transporte y montaje gratis y un asesor de decoración que va a tu casa: eso no lo da cualquier tienda.

Os aviso de un par de cosas de la web: en la portada hay una frase que se corta a medias ("Visítanos para descubrir todo nuestro catálogo de"), el email aparece con espacios y no se puede pulsar, y las fotos y el pie siguen en 2018.

¿Os preparo gratis una maqueta con el catálogo bien enseñado? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Arévalo', 'Almazara / aceite', 'Baeza', 'Jaén', 'https://casaarevalo.com', 'info@casaarevalo.com', '953 74 01 22', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'En vuestra tienda 1 litro cuesta más que 2', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@casaarevalo.com', 'casaarevalo.com', 'https://casaarevalo.com', 'Jaén', 'guzman', null, 'Almazara más antigua en activo de Baeza; tinaja de 1826; familia desde 1945', 'alta', false, 'seed', 'casa-arevalo', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestra tienda 1 litro cuesta más que 2
Fallos: Listado: 1L a 91,50 € y 2L a 74,40 € (es una caja, no se ve) | Única noticia: ''Estrenamos nueva web'' (2022) | Iconos sociales genéricos y a Google+ | Textos de plantilla en inglés

Hola, equipo de Casa Arévalo:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. La almazara más antigua de Baeza que sigue funcionando, con una tinaja de 1826: eso es historia del aceite.

Os escribo por algo de vuestra tienda online: en el listado pone "Botella 1L — 91,50 €" y "Garrafa 2L — 74,40 €". Solo al entrar en la ficha se ve que la botella es una caja de 15. Quien navega rápido piensa que el litro cuesta 91 € y se va.

Además, la única noticia es "¡Estrenamos nueva web!" de 2022 y hay iconos que llevan a Google+. ¿Os preparo gratis una maqueta de la tienda? Si no os gusta, la borro y aquí no ha pasado nada.

Seguimiento: 2026-10-02 maqueta + 490 €', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hotel La Mirada del Santuario', 'Hotel / restaurante / camping', 'Andújar', 'Jaén', 'https://www.hotelenandujar.com', 'sandragp923@gmail.com', '669 934 389', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Google no puede leer vuestra web (y os lo explico)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'sandragp923@gmail.com', 'hotelenandujar.com', 'https://www.hotelenandujar.com', 'Jaén', 'guzman', null, 'Junto al Santuario de la Virgen de la Cabeza; bodas, cabañas y camping', 'alta', false, 'seed', 'mirada-santuario', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Google no puede leer vuestra web (y os lo explico)
Fallos: Portada = una sola imagen de 3,3 MB, sin texto: Google no lee nada | Ancho fijo, diminuta en móvil | Clic derecho bloqueado

Hola, Sandra:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Tener hotel, restaurante para bodas, cabañas y camping al lado del Santuario de la Virgen de la Cabeza es una ubicación de lujo.

Te escribo porque vuestra web es, en realidad, una sola imagen enorme (más de 3 MB) con zonas para pulsar. No tiene ni una línea de texto real, así que Google no puede leer nada y es muy difícil que os encuentren buscando "hotel Sierra de Andújar". Además, en el móvil se ve diminuta.

¿Te preparo gratis una maqueta de una web de verdad, con reservas? Si no te gusta, la borro y aquí no ha pasado nada.

Seguimiento: 2026-10-02 maqueta + 490 €', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Clínica Veterinaria Clinican', 'Veterinaria', 'Jaén / Martos', 'Jaén', 'http://www.clinicanjaen.com', 'infojaen@clinicanjaen.com', '953 87 43 74', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Vuestra web se hizo con un programa que ya no existe', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'infojaen@clinicanjaen.com', 'clinicanjaen.com', 'http://www.clinicanjaen.com', 'Jaén', 'guzman', null, 'Fundada en 2004 por el Dr. Fernando Arroyo; segunda clínica en Martos; GEVO de AVEPA', 'media', false, 'seed', 'clinican', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web se hizo con un programa que ya no existe
Fallos: Hecha con Adobe Muse (abandonado) | Ancho fijo, no se adapta al móvil | Blog con 2 entradas de 2015 | Faltan tildes

Hola, equipo de Clinican:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Dos clínicas, en Jaén y en Martos, y un fundador en el grupo de traumatología de AVEPA: tenéis mucho nivel.

La web, en cambio, está hecha con Adobe Muse, un programa que Adobe abandonó hace años. No se adapta al móvil (que es desde donde busca quien tiene una urgencia con su mascota) y el blog se quedó en 2015 con dos entradas.

¿Os preparo gratis una maqueta con botón de urgencias y cita online para las dos clínicas? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Clínica Dental del Valle', 'Clínica dental', 'Cartagena', 'Murcia', 'https://www.clinicadelvalle.es', 'contacto@clinicadelvalle.es', '968 521 241', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Vuestra web le hace publicidad a otra clínica (en Navarra)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'contacto@clinicadelvalle.es', 'clinicadelvalle.es', 'https://www.clinicadelvalle.es', 'Murcia', 'guzman', null, 'Sedación consciente, implantes y ortodoncia en el centro de Cartagena', 'alta', false, 'seed', 'dental-valle', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web le hace publicidad a otra clínica (en Navarra)
Fallos: Footer ''© 2017 CLINICADENTALDELVALLE.ES'': ese dominio es de otra clínica en Navarra | Errata ''Clínical Dental del Valle'' | WordPress de 2018

Hola, equipo de Clínica Dental del Valle:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Os escribo por algo curioso: el pie de vuestra web pone "© 2017 CLINICADENTALDELVALLE.ES", y ese dominio es de otra clínica, en Mutilva (Navarra). Un paciente que lo busque acaba en otra clínica, aunque esté a 700 km.

También hay una errata en la portada ("Clínical Dental") y la web tiene ya unos años.

Con sedación consciente, implantes y ortodoncia en pleno centro, merecéis una web que os traiga pacientes. ¿Os hago gratis una maqueta y la veis sin compromiso?

Seguimiento: 2026-10-02 maqueta + 490 €', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Mesón Asador Leandro', 'Restaurante / apartamentos', 'Cazorla', 'Jaén', 'https://www.mesonleandro.com', 'reservas@mesonleandro.com', '953 720 632', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Michelin os recomienda, pero vuestra carta no tiene precios', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'reservas@mesonleandro.com', 'mesonleandro.com', 'https://www.mesonleandro.com', 'Jaén', 'guzman', null, 'Recomendados en la Guía Michelin, junto a las Ruinas de Santa María', 'media', false, 'seed', 'leandro', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Michelin os recomienda, pero vuestra carta no tiene precios
Fallos: Carta sin precios | Erratas: ''tomate contirado'', ''sal de bechamel'' | Facebook genérico | Drupal 7 sin soporte

Hola, equipo del Mesón Leandro:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Recomendados en la Guía Michelin un año más y en pleno centro histórico de Cazorla: enhorabuena.

Os escribo porque la carta de vuestra web no tiene ni un precio, y hoy casi todo el mundo los mira antes de reservar. También hay alguna errata ("tomate contirado", "sal de bechamel") y el icono de Facebook lleva a Facebook en general, no a vuestra página.

¿Os preparo gratis una maqueta con carta clara y reservas para el mesón y los apartamentos? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Centro de Fisioterapia Karma', 'Fisioterapia', 'Andújar', 'Jaén', 'https://www.centrofisioterapiakarma.es', 'centrokarma@hotmail.com', '655 271 745', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', '"Somos Centro de Centro de Fisioterapia Karma"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'centrokarma@hotmail.com', 'centrofisioterapiakarma.es', 'https://www.centrofisioterapiakarma.es', 'Jaén', 'guzman', null, 'Dentro de la Piscina Municipal Cubierta, ideal para rehabilitación', 'media', false, 'seed', 'karma', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: "Somos Centro de Centro de Fisioterapia Karma"
Fallos: ''Somos Centro de Centro de Fisioterapia Karma'' | Página ''Gracias'' en el menú del móvil | Texto genérico sin equipo ni tarifas | Email de Hotmail

Hola, equipo de Karma:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Estar dentro de la piscina municipal cubierta es una ventaja enorme para la rehabilitación, y casi nadie la tiene.

Os escribo porque la primera frase de vuestra web dice "Somos Centro de Centro de Fisioterapia Karma", en el menú del móvil aparece una página llamada "Gracias" y el texto es genérico, sin fotos del equipo ni tarifas.

¿Os preparo gratis una maqueta que cuente quiénes sois y deje reservar cita? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Clínica Veterinaria Medea', 'Veterinaria', 'Mérida', 'Badajoz', 'https://clinicamedea.com', 'cvmedea@gmail.com', '924 371 865', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Vuestra web se ha quedado en 22 años (y ya lleváis 28)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'cvmedea@gmail.com', 'clinicamedea.com', 'https://clinicamedea.com', 'Badajoz', 'guzman', null, 'Abierta el 1 de abril de 1998; ''Sobre nosotros'' muy cercano', 'media', false, 'seed', 'medea', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web se ha quedado en 22 años (y ya lleváis 28)
Fallos: ''Odontolología'' | ''veintidós años después'' (son 28) | Botón protocolo COVID 2021 | Footer © 2020

Hola, equipo de Medea:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Me ha encantado vuestro "Sobre nosotros": lo de las canas, las hijas y dar las gracias a los clientes se nota que está escrito de verdad.

Por eso os aviso de un par de cosas: la web dice "hoy veintidós años después" cuando ya lleváis 28, hay un servicio que se llama "Odontolología", sigue el botón del protocolo COVID de 2021 y el pie está en 2020.

¿Os preparo gratis una maqueta que mantenga ese tono tan cercano? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Muebles García Morales', 'Tienda de muebles', 'Villanueva de la Serena', 'Badajoz', 'http://www.mueblesgarciamorales.com', 'mueblesgm@mueblesgarciamorales.com', '924 84 24 17', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'En vuestra web os llamáis "García Norales"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'mueblesgm@mueblesgarciamorales.com', 'mueblesgarciamorales.com', 'http://www.mueblesgarciamorales.com', 'Badajoz', 'guzman', null, 'Familiar de 2ª generación, una de las mayores exposiciones de la comarca', 'alta', false, 'seed', 'garcia-morales', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestra web os llamáis "García Norales"
Fallos: Footer: ''Muebles García Norales'' | Enlaces de email y teléfono vacíos | Outlet con 1 producto | Faltas: ''mubles'', ''increible''

Hola, equipo de Muebles García Morales:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Segunda generación y una de las exposiciones más grandes de la comarca: lo vuestro tiene mérito.

Os escribo porque en el pie de todas las páginas de vuestra web pone "Muebles García Norales". Además, en Contacto los enlaces del email y del teléfono están vacíos (al pulsarlos no pasa nada) y el outlet solo tiene un producto.

¿Os preparo gratis una maqueta con el catálogo bien enseñado? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hostal Restaurante Arias', 'Hostal / restaurante', 'Zafra', 'Badajoz', 'https://www.hostalarias.net', 'info@hostalarias.net', '924 55 48 55', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Vuestro formulario de reservas sigue "reformándose"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@hostalarias.net', 'hostalarias.net', 'https://www.hostalarias.net', 'Badajoz', 'guzman', null, 'Desde 1972 en Zafra; menú diario; salón de 300 m²; precios para peregrinos', 'alta', false, 'seed', 'hostal-arias', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestro formulario de reservas sigue "reformándose"
Fallos: ''El formulario de reserva está reformándose'': no funciona | ''Un tenedo'' | Footer 2021 | Sin reserva online

Hola, equipo del Hostal Arias:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Desde 1972 en Zafra, menú diario con diez primeros y diez segundos y precios para peregrinos: así se hace hostelería.

Os escribo porque en la web de reservas pone que "el formulario de reserva está reformándose" y pide escribir al email. Cada persona que lo lee y no tiene ganas de escribir es una reserva que se va a Booking.

¿Os preparo gratis una maqueta con reserva directa que funcione? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Ibermonesterio', 'Jamones e ibéricos', 'Monesterio', 'Badajoz', 'https://www.ibermonesterio.com', 'ibermonesterio@ibermonesterio.com', '924 149 250', '', 'perdido', '', null, null, '', 'Contestaron "no". No volver a escribir.', true, 'Contestaron "no". No volver a escribir.', false, '', 'seed-2026-10-13', '', 'Hay código roto debajo de cada jamón de vuestra tienda', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'ibermonesterio@ibermonesterio.com', 'ibermonesterio.com', 'https://www.ibermonesterio.com', 'Badajoz', 'guzman', null, 'Marca registrada, explotaciones propias de ibérico en Monesterio', 'alta', false, 'seed', 'ibermonesterio', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (no_contactar).
Asunto: Hay código roto debajo de cada jamón de vuestra tienda
Fallos: Código roto bajo cada producto: ''[yith_wcwl_add_to_wishlist] [yith_compare_button]'' | ''precedente'' por ''procedente'' | Cookies en inglés | WooCommerce de 2022 sin actualizar

Hola, equipo de Ibermonesterio:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Explotaciones propias de ibérico en Monesterio, que es tierra de jamón: el producto está más que bien.

Os escribo porque debajo de cada producto de vuestra tienda online se ve un trozo de código roto ("[yith_wcwl_add_to_wishlist] [yith_compare_button]"), veinte veces solo en la portada. Además, la tienda lleva sin actualizarse desde 2022, y eso en una web donde se paga con tarjeta da más miedo que vergüenza.

¿Os preparo gratis una maqueta de la tienda renovada? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Meseguera Restaurante Brasería', 'Restaurante', 'Trujillo', 'Cáceres', 'https://meseguera.com', 'reservas@meseguera.com', '604 90 21 12', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Vuestra web sigue en la Navidad de 2024', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'reservas@meseguera.com', 'meseguera.com', 'https://meseguera.com', 'Cáceres', 'guzman', null, 'En plena Plaza Mayor de Trujillo; rabo de toro y pulpo a la brasa', 'media', false, 'seed', 'meseguera', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web sigue en la Navidad de 2024
Fallos: Noticia más reciente: Menú Navidad 2024 | ''Nuevo restaurante'' | Texto COVID | URL ''menu-especial-mavidad''

Hola, equipo de Meseguera:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Rabo de toro y pulpo a la brasa en plena Plaza Mayor de Trujillo: eso se vende solo.

La web, en cambio, se quedó en el menú de Navidad de 2024, os sigue presentando como "nuevo restaurante" y aún habla de "las medidas sanitarias actuales". Quien entra hoy puede pensar que habéis cerrado.

¿Os preparo gratis una maqueta con la carta y reservas siempre al día? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hostal La Muralla', 'Hostal', 'Plasencia', 'Cáceres', 'https://hostallamuralla.es', 'flormuralla@hotmail.com', '927 41 38 74', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'En vuestras tarifas todo pone "a consultar"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'flormuralla@hotmail.com', 'hostallamuralla.es', 'https://hostallamuralla.es', 'Cáceres', 'guzman', null, 'Familiar en la zona monumental, junto a la Plaza Mayor y la Catedral', 'media', false, 'seed', 'muralla', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestras tarifas todo pone "a consultar"
Fallos: Tarifas: todo ''PRECIOS A CONSULTAR'' | ''Wiffi Wifi Gratuito'' | Enlace ''Login'' público | Joomla 3 sin soporte

Hola, Flor:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Un hostal familiar a dos minutos de la Plaza Mayor de Plasencia: la ubicación no puede ser mejor.

Te escribo porque en la página de tarifas todo pone "PRECIOS A CONSULTAR" y no se puede reservar online. Mucha gente, si no ve el precio, se va directamente a Booking, y Booking se lleva su comisión. Además, hay un "Wiffi Wifi Gratuito" y un enlace de "Login" visible para cualquiera.

¿Te preparo gratis una maqueta con precios y reserva directa? Si no te gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Restaurante Asador La Fusa', 'Restaurante', 'Cáceres', 'Cáceres', 'https://www.restaurantelafusa.com', 'contacto@restaurantelafusa.com', '927 21 33 51', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'La carta de vuestra web es una foto de 2018', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'contacto@restaurantelafusa.com', 'restaurantelafusa.com', 'https://www.restaurantelafusa.com', 'Cáceres', 'guzman', null, 'Familiar junto a la Plaza Mayor, terraza, sala de juegos para niños, cochinillo', 'alta', false, 'seed', 'la-fusa', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: La carta de vuestra web es una foto de 2018
Fallos: Carta = 2 fotos JPG de 2018 | Footer 2018 | ''plugin cookies'' visible | Instagram genérico

Hola, equipo de La Fusa:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Cochinillo asado, terraza y una sala de juegos para que los niños dejen comer tranquilos a los padres: eso es pensar en el cliente.

Os escribo porque la carta de vuestra web son dos fotos subidas en 2018, así que Google no puede leerla y seguramente los precios ya no coinciden. El pie también sigue en 2018 y en el aviso de cookies se lee "plugin cookies".

¿Os preparo gratis una maqueta con la carta actualizable en dos minutos? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casas Rurales La Picota del Jerte', 'Casas rurales', 'Navaconcejo', 'Cáceres', 'https://casasruraleslapicotadeljerte.es', 'info@casasruraleslapicotadeljerte.es', '927 173 609', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', '¿La Picota es para 8 o para 10 personas?', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@casasruraleslapicotadeljerte.es', 'casasruraleslapicotadeljerte.es', 'https://casasruraleslapicotadeljerte.es', 'Cáceres', 'guzman', null, 'Casas tradicionales con piscina entre cerezos del Valle del Jerte', 'alta', false, 'seed', 'picota-jerte', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: ¿La Picota es para 8 o para 10 personas?
Fallos: La misma casa aparece para 10 y para 8 personas | Dos, tres casas… no cuadra | Erratas: ''inciendios'' | Iconos a Facebook genérico y Google+

Hola, equipo de La Picota del Jerte:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Casas con piscina entre cerezos en flor: no hay mejor plan de primavera.

Os escribo porque en vuestra web la misma casa aparece para "hasta 10 personas" y más abajo para "hasta 8". Además, en un sitio habláis de tres casas y en otro de dos. Un grupo que está decidiendo dónde reservar se puede liar y acabar en otra casa.

¿Os preparo gratis una maqueta con cada casa, su capacidad y un calendario de disponibilidad? Si no os gusta, la borro y aquí no ha pasado nada.

Seguimiento: 2026-10-02 maqueta + 490 €', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Clinicanimal Veterinarios', 'Veterinaria', 'Molina de Segura', 'Murcia', 'http://www.clinicanimalvet.com', 'info@clinicanimalvet.com', '968 02 40 70', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'La "radiografía figital" de vuestra web', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@clinicanimalvet.com', 'clinicanimalvet.com', 'http://www.clinicanimalvet.com', 'Murcia', 'guzman', null, 'Urgencias 24 h y sin cerrar a mediodía; fundada en 2017 por Ana María Martínez Ferra', 'media', false, 'seed', 'clinicanimal', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: La "radiografía figital" de vuestra web
Fallos: Sin HTTPS: ''no segura'' | Errata ''Radiografía figital directa'' | Faltan tildes (''Sabados'', ''Politica'')

Hola, equipo de Clinicanimal:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Urgencias 24 h y sin cerrar a mediodía: eso vale oro para cualquiera con una mascota.

Os escribo porque la web os hace de menos. El navegador la marca como "no segura", en servicios pone "Radiografía figital directa" y faltan tildes en varios sitios. Son detalles, pero a un dueño preocupado a las 3 de la mañana le generan dudas.

¿Os preparo gratis una maqueta con un botón de urgencias bien grande? Si no os gusta, la borro.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Clínica Podológica Cardenal', 'Podología', 'Cáceres', 'Cáceres', 'https://podologocaceres.com', 'consultacardenal@gmail.com', '927 03 54 06', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', '¿Abrís los lunes o no?', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'consultacardenal@gmail.com', 'podologocaceres.com', 'https://podologocaceres.com', 'Cáceres', 'guzman', null, 'Dirigida por Pilar Cardenal, buenas opiniones, blog activo', 'media', false, 'seed', 'cardenal', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: ¿Abrís los lunes o no?
Fallos: Horario contradictorio: ''LUNES cerrado; 17:30–20:30'' | Emojis del blog salen como ''?'' | Erratas: ''callosidaes'', ''terapeútico''

Hola, Pilar:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Me ha gustado ver que seguís escribiendo en el blog: eso casi nadie lo mantiene.

Te escribo porque en Contacto el horario dice a la vez "LUNES: cerrado" y "17:30–20:30", igual que el jueves, así que un paciente no sabe si puede ir. Además, los emojis de los títulos del blog salen como interrogaciones y hay alguna errata en la portada ("callosidaes").

¿Te preparo gratis una maqueta con el horario claro y cita online? Si no te gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Quesería El Zamorral', 'Quesería artesana', 'Santa Cristina de la Polvorosa', 'Zamora', 'https://www.elzamorral.com', 'info@elzamorral.com', '605 26 00 15', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'En vuestra tienda los quesos están a 0,00 €', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@elzamorral.com', 'elzamorral.com', 'https://www.elzamorral.com', 'Zamora', 'guzman', null, 'Leche cruda de rebaño propio; Premio Artesano 2019, bronce World Cheese Awards', 'alta', false, 'seed', 'zamorral', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestra tienda los quesos están a 0,00 €
Fallos: Tienda: todos los productos a 0,00 € | Novedades de 2019 | Botón a Google+

Hola, equipo de El Zamorral:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Leche cruda de vuestro propio rebaño, Premio Artesano del Año y bronce en los World Cheese Awards: menudo currículum quesero.

Os escribo porque en la tienda online todos los productos aparecen a "0,00 €": el semicurado, el viejo, los yogures… Quien entra a comprar no sabe cuánto cuestan y se va. Además, las novedades se quedaron en 2019 y sigue el botón de Google+.

¿Os preparo gratis una maqueta de la tienda con precios y pedido online? Si no os gusta, la borro y aquí no ha pasado nada.

Seguimiento: 2026-10-02 maqueta + 490 €', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Tierra Dulce – Chocolate Ecológico', 'Obrador de chocolate', 'Moraleja del Vino', 'Zamora', 'https://www.chocolateecologico.com', 'info@chocolateecologico.com', '617 508 653', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'En octubre vuestra web sigue en San Valentín', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@chocolateecologico.com', 'chocolateecologico.com', 'https://www.chocolateecologico.com', 'Zamora', 'guzman', null, 'Taller familiar de chocolate ecológico artesanal; Premio Ecocultura; Salón Gourmets', 'alta', false, 'seed', 'tierra-dulce', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En octubre vuestra web sigue en San Valentín
Fallos: En móvil la página se sale de pantalla | En octubre destaca ''Febrero in love'' y turrón de Navidad | Primera noticia: premio de 2013 | ASP clásico

Hola, equipo de Tierra Dulce:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Chocolate ecológico hecho a mano en un taller familiar de Zamora, con premio Ecocultura y paso por el Salón Gourmets: qué bien suena.

Os escribo porque en el móvil vuestra tienda se sale de la pantalla (el menú y los productos aparecen cortados) y, en pleno octubre, la portada destaca la oferta "Febrero in love". La mayoría de la gente compra desde el móvil, así que ahí se pierden pedidos.

¿Os preparo gratis una maqueta de la tienda pensada para el móvil? Si no os gusta, la borro y aquí no ha pasado nada.

Seguimiento: 2026-10-02 maqueta + 490 €', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('El Alfar de Pereruela', 'Alfarería', 'Pereruela', 'Zamora', 'https://www.hornosdebarrodepereruela.es', 'info@elalfardepereruela.es', '980 551 122', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Un montaje de horno a 0,00 € en vuestra web', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@elalfardepereruela.es', 'elalfardepereruela.es', 'https://www.hornosdebarrodepereruela.es', 'Zamora', 'guzman', null, 'Hornos y cazuelas de barro a mano, sin plomo ni cadmio', 'media', false, 'seed', 'alfar-pereruela', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Un montaje de horno a 0,00 € en vuestra web
Fallos: Producto a 0,00 € con botón comprar | Footer © 2016 | Email de otro dominio

Hola, equipo de El Alfar de Pereruela:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Hornos y cazuelas de barro hechos a mano, sin plomo ni cadmio. Y lo de "cocinan el gusto de tus recuerdos" es de lo mejor que he leído en una web.

Os aviso de un par de cosas: en la portada aparece "Montajes de hornos de leña a domicilio" a 0,00 € con botón de comprar, el pie sigue en 2016 y el email es de un dominio distinto al de la web, lo que confunde.

¿Os preparo gratis una maqueta de la tienda renovada? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Viajes Albur', 'Agencia de viajes', 'Benavente', 'Zamora', 'https://viajesalbur.net', 'viajes@viajesalbur.net', '980 63 50 52', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Vuestra web sigue vendiendo el crucero de julio', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'viajes@viajesalbur.net', 'viajesalbur.net', 'https://viajesalbur.net', 'Zamora', 'guzman', null, 'Diseñan sus excursiones y van con los clientes; patrocinan al C.D. Benavente', 'alta', false, 'seed', 'albur', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web sigue vendiendo el crucero de julio
Fallos: Venden viajes ya pasados (julio y septiembre 2026) | Facebook lleva a ''facebook.com/pg'' | Aviso legal descarga un Word | Blog con anuncio de Kia

Hola, equipo de Viajes Albur:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Diseñar vuestras propias excursiones e ir con los clientes es lo que diferencia a una agencia de verdad de un buscador.

Os escribo porque en la web siguen a la venta viajes que ya pasaron, como el crucero del 8 de julio o Granada del 2 de septiembre. El icono de Facebook lleva a una página genérica y al pulsar "Aviso legal" se descarga un archivo de Word.

¿Os preparo gratis una maqueta donde actualizar las salidas sea cosa de un minuto? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Materiales Hermanos Galende', 'Materiales de construcción', 'Camarzana de Tera', 'Zamora', 'https://hermanosgalende.es', 'info@hermanosgalende.es', '980 649 279', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Vuestros catálogos siguen siendo los de 2024-2025', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@hermanosgalende.es', 'hermanosgalende.es', 'https://hermanosgalende.es', 'Zamora', 'guzman', null, 'Familiar desde 1983 (Jesús e Ismael), relevo en 2012, almacén en Puebla de Sanabria', 'media', false, 'seed', 'galende', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestros catálogos siguen siendo los de 2024-2025
Fallos: Catálogos 2024-2025 en octubre 2026 | ''gamma de productos'' | Tienda online lleva a otra web

Hola, equipo de Hermanos Galende:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una empresa familiar desde 1983 que ha hecho el relevo generacional y ha abierto en Puebla de Sanabria: eso es hacer bien las cosas.

Os escribo porque en la portada siguen los catálogos 2024-2025, hay una errata ("toda nuestra gamma") y el botón "Tienda Online" manda al cliente a la web de otra empresa.

¿Os preparo gratis una maqueta con vuestro catálogo y un formulario de presupuesto propio? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Rural El Cobijo de los Arribes', 'Casa rural', 'Fermoselle', 'Zamora', 'https://www.elcobijodelosarribes.com', 'info@elcobijodelosarribes.com', '679 977 268', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Reservas directas para El Cobijo', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@elcobijodelosarribes.com', 'elcobijodelosarribes.com', 'https://www.elcobijodelosarribes.com', 'Zamora', 'guzman', null, 'Desde 2017 en el casco histórico de Fermoselle, 4 habitaciones, Arribes del Duero', 'baja', false, 'seed', 'cobijo-arribes', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Reservas directas para El Cobijo
Fallos: Errata ''Asución'' | Sin disponibilidad ni reserva online | Aviso de cookies antiguo

Hola, equipo de El Cobijo de los Arribes:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una casa en pleno casco histórico de Fermoselle, al lado de la Plaza Mayor y con los Arribes a un paso: qué sitio.

La web está bien, pero no se puede ver disponibilidad ni reservar: solo llamar. Mucha gente reserva a las doce de la noche desde el sofá, y si no puede, se va a Booking. También hay una errata en la portada ("Asución").

¿Os preparo gratis una maqueta con calendario y reserva directa? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Camping Monte Royal', 'Camping / restaurante', 'Aguilar de Campoo', 'Palencia', 'http://campingmonteroyal.com', 'info@campingmonteroyal.com', '979 181 007', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'En Google salís como "Camping Alguilar de Campoo"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@campingmonteroyal.com', 'campingmonteroyal.com', 'http://campingmonteroyal.com', 'Palencia', 'guzman', null, 'Junto al embalse y la ermita de Llano; restaurante para 300 comensales', 'alta', false, 'seed', 'monteroyal', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En Google salís como "Camping Alguilar de Campoo"
Fallos: Título en Google: ''Camping Alguilar de Campoo'' | No se adapta al móvil | Aviso para instalar ''Firefox 3.5'' | Tarifas: ''IVA incluido'' y ''IVA no incluido'' | Analytics que dejó de funcionar en 2023

Hola, equipo de Monte Royal:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Cabañas junto al embalse de Aguilar y un restaurante para 300 comensales: tenéis el plan completo para bodas y escapadas.

Os escribo porque el título de vuestra web, que es lo que sale en Google, pone "Camping Alguilar de Campoo". Además, la tabla de tarifas dice a la vez "IVA incluido" y "IVA no incluido", en el móvil la web no se adapta y sigue un aviso para instalar Firefox 3.5.

¿Os preparo gratis una maqueta con reservas online? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Pagos de Negredo Viñedos', 'Bodega D.O. Arlanza', 'Palenzuela', 'Palencia', 'https://pagosdenegredo.com', 'administracion@pagosdenegredo.com', '649 190 304', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'El botón "tienda" de vuestra web no lleva a ninguna tienda', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'administracion@pagosdenegredo.com', 'pagosdenegredo.com', 'https://pagosdenegredo.com', 'Palencia', 'guzman', null, 'Desde 1997, familia Primo Cavía (11 hermanos), viñedo centenario premiado en el s. XIX', 'alta', false, 'seed', 'pagos-negredo', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: El botón "tienda" de vuestra web no lleva a ninguna tienda
Fallos: Botón ''tienda'' lleva a la portada | Últimas noticias de febrero 2020 | No responsive

Hola, equipo de Pagos de Negredo:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Once hermanos que recuperan un viñedo centenario premiado en el siglo XIX: esa historia vende vino sola.

Os escribo porque el botón "tienda" de vuestra web no lleva a ninguna tienda, solo vuelve a la portada. Quien quiere comprar una caja de Quinta Negredo se queda con las ganas. Además, las últimas noticias son de febrero de 2020 y en el móvil la web no se adapta.

¿Os preparo gratis una maqueta con tienda online de verdad? Si no os gusta, la borro y aquí no ha pasado nada.

Seguimiento: 2026-10-02 maqueta + 490 €', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hostal La Llave', 'Hostal rural / restaurante', 'Mave (Aguilar de Campoo)', 'Palencia', 'https://www.hostallallave.es', 'info@hostallallave.es', '629 341 325', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Vuestro formulario no os deja contestar a nadie', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@hostallallave.es', 'hostallallave.es', 'https://www.hostallallave.es', 'Palencia', 'guzman', null, 'Hostal familiar al inicio de la Montaña Palentina, restaurante y precios para trabajadores', 'alta', false, 'seed', 'la-llave', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestro formulario no os deja contestar a nadie
Fallos: Formulario sin campo de email ni teléfono: no pueden contestar | Iconos sociales genéricos | ''Quiénes somos'' vacía | ''Reserva Ya'' solo baja de página

Hola, equipo de La Llave:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Un hostal familiar con restaurante a la entrada de la Montaña Palentina y precios para trabajadores: muy buena idea.

Os aviso de algo importante: el formulario de contacto de vuestra web solo pide "Nombre" y "Mensaje", sin email ni teléfono. Es decir, si alguien os escribe para reservar, no tenéis forma de contestarle. Además, la página "Quiénes somos" está vacía y los iconos de redes llevan a Facebook e Instagram en general.

¿Os preparo gratis una maqueta con un botón de reserva que funcione? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Fontanería Hermanos Ruiz', 'Fontanería y calefacción', 'Santa Cruz (Murcia)', 'Murcia', 'http://fontaneriahnosruiz.com', 'contacto@fontaneriahnosruiz.com', '628 055 991', '', 'contactado', '', null, null, '', 'Web bastante decente: prioridad baja.', false, '', false, '', 'seed-2026-10-13', '', 'Hay una foto rota en vuestra portada', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'contacto@fontaneriahnosruiz.com', 'fontaneriahnosruiz.com', 'http://fontaneriahnosruiz.com', 'Murcia', 'guzman', null, 'Los hermanos Raúl y Rubén, especialistas en ósmosis inversa y suelo radiante', 'baja', false, 'seed', 'fonta-ruiz', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Hay una foto rota en vuestra portada
Fallos: Imagen rota en el carrusel (foto demo de la plantilla) | http no redirige a https | Solo 3 secciones en el menú

Hola, Raúl y Rubén:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Os escribo porque en el carrusel de vuestra portada hay una imagen que no carga (es una foto de ejemplo de la plantilla) y la web no pasa a la versión segura.

La web no está mal, pero con solo tres secciones no se lucen cosas como la ósmosis inversa o el suelo radiante, que es justo lo que la gente busca en Google.

¿Os preparo gratis una maqueta con una página por servicio y botón de WhatsApp? Si no os convence, la borro y tan amigos.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Bar Perico', 'Bar de tapas', 'Palencia', 'Palencia', 'https://barperico.es', 'info@barperico.es', '979 740 123', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Medio mililitro de Prado Rey por 10 €', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@barperico.es', 'barperico.es', 'https://barperico.es', 'Palencia', 'guzman', null, 'Familiar desde 1940 (Pedro y Rosario), junto al Teatro Colón', 'media', false, 'seed', 'bar-perico', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Medio mililitro de Prado Rey por 10 €
Fallos: ''Prado Rey 0.50ml 10,00€'' | ''Carapaccio'', ''Fuenteandino'' | Cookies con enlaces a Opera 10 e IE9 | Foursquare y Yelp en vez de Instagram

Hola, equipo del Bar Perico:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Desde 1940, tres generaciones y al lado del Teatro Colón: lo vuestro es historia de Palencia.

Os escribo por un par de cosas de la carta online que me hicieron gracia: el Prado Rey aparece como "0.50ml" por 10 € (medio mililitro sale caro), hay un "Carapaccio" y la morcilla figura como "de Fuenteandino" en vez de Fuenteandrino, que en Palencia duele.

¿Os preparo gratis una maqueta con la carta revisada y botón de reserva? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Quesería Campos Góticos', 'Quesería artesana', 'Villerías de Campos', 'Palencia', 'https://camposgoticos.com', 'paramio@camposgoticos.com', '979 768 229', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Un par de detalles de vuestra web', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'paramio@camposgoticos.com', 'camposgoticos.com', 'https://camposgoticos.com', 'Palencia', 'guzman', null, 'Moldes a mano con paño, cuajo animal, leche cruda de oveja churra propia', 'baja', false, 'seed', 'campos-goticos', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Un par de detalles de vuestra web
Fallos: Erratas: ''a realizado'', ''se la Quesería'' | Cookies antiguas | Lechazo IGP destacado y fuera de stock

Hola, equipo de Campos Góticos:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Llenar los moldes a mano con paño y usar leche cruda de vuestras ovejas churras: así se hacía el queso de verdad.

La tienda funciona bien, pero hay un par de detalles: alguna errata en la portada ("a realizado un vídeo", "el principal objetivo se la Quesería"), un aviso de cookies antiguo y el lechazo IGP destacado entre los más vendidos aparece fuera de stock.

¿Os preparo gratis una maqueta de cómo podría lucir más vuestra historia? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hostal Arévacos', 'Hostal', 'Soria', 'Soria', 'https://hostalarevacos.com', 'soria@hostalarevacos.com', '975 21 28 32', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Vuestra web recomienda usar Internet Explorer 5', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'soria@hostalarevacos.com', 'hostalarevacos.com', 'https://hostalarevacos.com', 'Soria', 'guzman', null, 'Hostal castellano a 10 minutos del centro, en la Soria de Machado', 'alta', false, 'seed', 'arevacos', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web recomienda usar Internet Explorer 5
Fallos: Icono de email roto (''mialto:'') | ''© 2002'' y ''Recomendamos Internet Explorer 5'' | No responsive | Tarifas: todo ''Consultar''

Hola, equipo del Hostal Arévacos:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Un hostal castellano en la Soria de Machado, tranquilo y a diez minutos del centro: plan perfecto para una escapada.

Os escribo porque en vuestra web el icono del email no funciona (el enlace está escrito "mialto" en vez de "mailto"), el pie pone "© 2002" y recomienda usar "Internet Explorer 5 y 800x600 de resolución". Además, en Tarifas no hay ninguna tarifa.

¿Os preparo gratis una maqueta con precios y reserva directa? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hotel Rural El Alquerque', 'Hotel rural', 'San Esteban de Gormaz', 'Soria', 'https://www.elalquerque.com', 'hotelelalquerque@gmail.com', '620 232 532', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'El botón de Reservas de vuestra web no hace nada', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'hotelelalquerque@gmail.com', 'elalquerque.com', 'https://www.elalquerque.com', 'Soria', 'guzman', null, 'Cuatro habitaciones en la villa medieval con vistas al castillo y las bodegas', 'alta', false, 'seed', 'alquerque', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: El botón de Reservas de vuestra web no hace nada
Fallos: Botones del menú (incluido Reservas) no hacen nada | Se lee ''5&euro,'' en pantalla | Reserva web vs ''contacte por teléfono'' | No se adapta al móvil

Hola, equipo de El Alquerque:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Cuatro habitaciones en una plazoleta de la villa medieval, con vistas al castillo y a las bodegas: precioso.

Os escribo porque varios botones del menú de vuestra web, incluido el de "Reservas", no hacen nada al pulsarlos. Además, en la parte de mascotas se lee "5&euro," (se ve el código) y la portada promete contestar "de inmediato" a las reservas web mientras la página de reservas pide llamar.

¿Os preparo gratis una maqueta con reserva directa que funcione de verdad? Si no os gusta, la borro y aquí no ha pasado nada.

Seguimiento: 2026-10-02 maqueta + 490 €', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hotel Rural Villa de Berlanga', 'Hotel rural / restaurante', 'Berlanga de Duero', 'Soria', 'http://hotelvilladeberlanga.com', 'hotelvilladeberlanga@gmail.com', '635 23 88 00', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Vuestra web dice a la vez 3 y 4 estrellas', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'hotelvilladeberlanga@gmail.com', 'hotelvilladeberlanga.com', 'http://hotelvilladeberlanga.com', 'Soria', 'guzman', null, 'Edificio de 1904 frente a la Colegiata; punto de sellado del Camino del Cid', 'media', false, 'seed', 'villa-berlanga', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web dice a la vez 3 y 4 estrellas
Fallos: https da aviso de no segura (certificado de otro dominio) | Sello ''Castilla y LeÛn'' y 3 vs 4 estrellas | Ancho fijo, no móvil | ''Bienvenidos al nuevo hotel''

Hola, equipo de Villa de Berlanga:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Un edificio de 1904 frente a la Colegiata, con vistas al castillo y sello del Camino del Cid: tenéis historia por todas partes.

La web, en cambio, da un aviso de "no segura" si se entra por https, el sello de ofertas habla de hoteles de tres estrellas cuando el texto dice que sois de cuatro (y pone "Castilla y LeÛn"), y en el móvil no se adapta.

¿Os preparo gratis una maqueta con reservas para el hotel y el restaurante? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Confitería Almarza', 'Confitería', 'Almazán', 'Soria', 'https://www.confiteriaalmarza.com', 'yemasalmarza@gmail.com', '975 30 01 21', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', '206 años de yemas y ninguna forma de pedirlas por internet', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'yemasalmarza@gmail.com', 'confiteriaalmarza.com', 'https://www.confiteriaalmarza.com', 'Soria', 'guzman', null, 'Desde 1820, séptima generación (Celina Almarza), reportaje de El Español en 2026', 'alta', false, 'seed', 'almarza', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: 206 años de yemas y ninguna forma de pedirlas por internet
Fallos: Texto de plantilla en inglés: ''Subscribe to our profiles…'' | Footer © 2016 | Sin tienda online | ''Sabado''

Hola, Celina:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Leí el reportaje de El Español sobre vuestras yemas y paciencias: séptima generación desde 1820 es algo que casi ninguna casa en España puede decir.

Te escribo porque con esa historia (y esa visibilidad) no tenéis tienda online: quien lee el reportaje desde Madrid o Barcelona no puede pedirlas. Además, en la web quedan textos de la plantilla en inglés ("Subscribe to our profiles…") y el pie sigue en 2016.

¿Te preparo gratis una maqueta con tienda online para enviar yemas a toda España? Si no te gusta, la borro y aquí no ha pasado nada.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hospedería El Fielato', 'Hospedería', 'El Burgo de Osma', 'Soria', 'https://www.hospederiaelfielato.es', 'info@hospederiaelfielato.es', '975 36 82 36', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Un "drisfrutarla" (y un párrafo repetido) en vuestra web', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@hospederiaelfielato.es', 'hospederiaelfielato.es', 'https://www.hospederiaelfielato.es', 'Soria', 'guzman', null, 'Antiguo edificio del Fielato, al comienzo de la Calle Mayor, 21 habitaciones', 'media', false, 'seed', 'fielato', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Un "drisfrutarla" (y un párrafo repetido) en vuestra web
Fallos: ''drisfrutarla'' | Párrafo repetido dos veces | Tarifas sin temporada | Sin reserva online

Hola, equipo de El Fielato:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Dormir en el antiguo edificio donde se cobraban los tributos, al empezar la Calle Mayor del Burgo, tiene mucho encanto.

Os escribo por un par de detalles de la web: en la portada pone "Ven a drisfrutarla", el mismo párrafo sale repetido dos veces seguidas y la tabla de tarifas tiene dos precios por habitación sin decir de qué temporada es cada uno. Además, no se puede reservar online.

¿Os preparo gratis una maqueta con tarifas claras y reserva directa? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Cánovas Carpintería', 'Carpintería / cocinas a medida', 'San José de la Vega (Murcia)', 'Murcia', 'https://canovascarpinteria.es', 'pacocanovasros@gmail.com', '', '', 'contactado', '', null, null, '', 'Web funciona en móvil; fallos pequeños. Email personal de Paco.', false, '', false, '', 'seed-2026-10-13', '', 'Una "capintería" en vuestra portada', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'pacocanovasros@gmail.com', 'canovascarpinteria.es', 'https://canovascarpinteria.es', 'Murcia', 'guzman', null, 'Familiar: cocinas, vestidores y armarios a medida', 'baja', false, 'seed', 'canovas', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Una "capintería" en vuestra portada
Fallos: Errata en portada: ''capintería'' | Footer © 2015 | Email de gmail

Hola, Paco:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Vi vuestras cocinas y vestidores a medida y me gustaron mucho. Por eso te aviso de un par de cosas de la web: en la portada pone "Los mejores diseños en capintería" (se escapó una r), el pie sigue en 2015 y el contacto es un gmail.

¿Te preparo gratis una maqueta de la portada, con vuestros trabajos a pantalla completa? Si no te gusta, la borro y aquí no ha pasado nada.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Taller Mecánico Tascón', 'Taller mecánico', 'León (La Palomera)', 'León', 'http://www.tallermecanicotascon.es', 'info@tallermecanicotascon.es', '987 232 650', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', '"Mucho amtes" (y otras cosillas de vuestra web)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@tallermecanicotascon.es', 'tallermecanicotascon.es', 'http://www.tallermecanicotascon.es', 'León', 'guzman', null, 'Abierto en 2012; presumen de explicar las reparaciones con total transparencia', 'media', false, 'seed', 'tascon', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: "Mucho amtes" (y otras cosillas de vuestra web)
Fallos: Sin HTTPS: ''no segura'' | Footer © 2019 | Erratas: ''mucho amtes'', ''total trasparencia'' | Sin cita online

Hola, equipo de Taller Tascón:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Me gusta mucho lo de "explicar las reparaciones con total transparencia". Ojalá todos los talleres fueran así.

La web, en cambio, se ha quedado atrás. El navegador la marca como "no segura", el pie sigue en 2019 y hay erratas en la portada ("mucho amtes", "total trasparencia"). Además, no se puede pedir cita online.

¿Os hago gratis una maqueta de una web donde pedir cita sea cosa de un minuto? Si no os convence, la borro y listo.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Escayolas Mateos S.L.', 'Escayola, pladur y reformas', 'León (San Mamés)', 'León', 'http://www.escayolasmateos.com', 'info@escayolasmateos.com', '987 22 46 99', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', '50 años de oficio y 3 fotos en la web', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@escayolasmateos.com', 'escayolasmateos.com', 'http://www.escayolasmateos.com', 'León', 'guzman', null, '+50 años en construcción, trabajan en León y Asturias', 'media', false, 'seed', 'escayolas', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: 50 años de oficio y 3 fotos en la web
Fallos: Footer ''Copyright 2012'' | No se adapta al móvil | Solo 3 trabajos en ''Últimos trabajos''

Hola, equipo de Escayolas Mateos:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Más de 50 años trabajando en toda la provincia y en Asturias, y en la web solo se ven tres trabajos. Con la de techos y reformas que habréis hecho, eso es como tener un Picasso y guardarlo en el trastero.

Además, el pie sigue en 2012 y en el móvil se ve diminuta, que es desde donde la gente busca a quien le haga la reforma.

¿Os preparo gratis una maqueta con una galería de antes y después? Si no os gusta, la borro sin rencores.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Confitería Asturias', 'Confitería', 'León', 'León', 'https://www.confiteriaasturias.es', 'info@confiteriaasturias.es', '987 20 71 10', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'La tienda online que promete vuestra web (y no aparece)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@confiteriaasturias.es', 'confiteriaasturias.es', 'https://www.confiteriaasturias.es', 'León', 'guzman', null, 'Familiar desde 1970; genarines y tocinillos con receta de Grado; chocolate Valrhona', 'alta', false, 'seed', 'conf-asturias', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: La tienda online que promete vuestra web (y no aparece)
Fallos: Promete ''tienda online'' y envíos a toda la península, pero no hay tienda ni carrito | No se adapta al móvil | Diseño muy antiguo

Hola, equipo de Confitería Asturias:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Genarines, tocinillos de cielo con receta de familia de Grado y chocolate Valrhona desde 1970: se me ha hecho la boca agua.

En la portada decís que en la tienda online se pueden pedir panetones y tocinillos con envío a toda la península… pero no he encontrado ni la tienda ni el carrito. Eso son pedidos que se os escapan, y más en Navidad.

¿Os preparo gratis una maqueta de la web con tienda de verdad? Si no os convence, la borro y me voy a por un tocinillo.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Agrícola González S.L.', 'Maquinaria agrícola y jardín', 'León', 'León', 'https://www.agricolagonzalez.es', 'info@agricolagonzalez.es', '987 20 51 53', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Los correos de vuestra web se están perdiendo', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@agricolagonzalez.es', 'agricolagonzalez.es', 'https://www.agricolagonzalez.es', 'León', 'guzman', null, '+50 años; distribuidor exclusivo de Husqvarna en León', 'alta', false, 'seed', 'agricola-glez', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Los correos de vuestra web se están perdiendo
Fallos: El enlace del email en Contacto abre ''info@agricolagonazlez.es'' (errata): esos correos se pierden | Footer ©2012 | No se adapta al móvil

Hola, equipo de Agrícola González:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Os aviso de algo importante: en vuestra página de contacto aparece info@agricolagonzalez.es, pero al pulsarlo se abre un correo a "info@agricolagonazlez.es" (con dos letras cambiadas). Es decir, los clientes que os escriben desde ahí no os llegan.

Además, el pie sigue en 2012 y en el móvil se ve diminuta.

Más de 50 años y la exclusiva de Husqvarna en León merecen algo mejor. Si queréis, os preparo gratis una maqueta de la web nueva. Y si no, arreglad al menos ese enlace, que os está costando clientes.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Restaurante Salzillo', 'Restaurante', 'Murcia (Santa Eulalia)', 'Murcia', 'http://restaurantesalzillo.com', 'contacto@restaurantesalzillo.com', '968 22 01 94', '', 'perdido', '', null, null, '', 'Contestaron: la web la lleva un familiar y no pueden cambiar de proveedor; le pasarán los cambios. No insistir.', true, 'Contestaron: la web la lleva un familiar y no pueden cambiar de proveedor; le pasarán los cambios. No insistir.', false, '', 'seed-2026-10-13', '', 'Os estáis quitando 13 años en la web', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'contacto@restaurantesalzillo.com', 'restaurantesalzillo.com', 'http://restaurantesalzillo.com', 'Murcia', 'guzman', null, 'Familiar desde 1988, guisos a fuego lento y salones Retablo, Los Pasos, La Gubia y El Altillo', 'alta', false, 'seed', 'salzillo', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (no_contactar).
Asunto: Os estáis quitando 13 años en la web
Fallos: Portada dice ''25 años de tradición'' pero abrieron en 1988 (38 años) | La página ''Menús'' no muestra menús, manda a Facebook | Certificado HTTPS autofirmado: aviso de seguridad | Errata ''Suíguenos en las redes''

Hola, equipo del Salzillo:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Os escribo por algo que me hizo gracia: en la portada ponéis "25 años de tradición", pero en "Nosotros" contáis que abristeis en 1988. Eso son 38 años. Os estáis quitando 13, y en hostelería la veteranía se presume.

Aparte de eso, la sección de Menús no enseña ningún menú (manda a Facebook) y, si alguien entra por https, el navegador le da un aviso de seguridad que asusta a cualquiera.

Un sitio con salones que se llaman Retablo, Los Pasos y La Gubia merece una web con el mismo mimo. ¿Os preparo gratis una maqueta de la portada? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('La Piccola', 'Obrador de pasta fresca', 'León (Burgo Nuevo)', 'León', 'http://lapiccola.es', 'lapiccola@lapiccola.es', '987 04 04 74', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'El botón de "realiza tu pedido" no funciona', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'lapiccola@lapiccola.es', 'lapiccola.es', 'http://lapiccola.es', 'León', 'guzman', null, 'Obrador artesano de pasta fresca diaria, pan ecológico y blog de recetas', 'alta', false, 'seed', 'piccola', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: El botón de "realiza tu pedido" no funciona
Fallos: Botón ''realiza tu pedido'' lleva a la web de pruebas del diseñador (error 503) | Código HTML visible en el footer | Enlace roto a la tienda | https da error 500

Hola, equipo de La Piccola:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Pasta fresca artesana cada día en Burgo Nuevo: me habéis ganado.

Os escribo porque el botón de "realiza tu pedido" lleva a una página de pruebas que da error, así que los pedidos online se quedan por el camino. También se ve código raro en el pie y el enlace a la tienda está roto.

¿Os preparo gratis una maqueta de la web con pedidos que funcionen de verdad? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('La Casa de Sebastián', 'Hostal y restaurante', 'Valderrobres', 'Teruel', 'http://www.lacasadesebastian.com/', 'info@lacasadesebastian.com', '616 49 57 88', '', 'perdido', '', null, null, '', 'Contestó: están traspasando el negocio. Respondido el 8 oct ofreciendo ayuda a los nuevos dueños.', false, '', false, 'Contestó: están traspasando el negocio. Respondido el 8 oct ofreciendo ayuda a los nuevos dueños.', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestra web en inglés da error 404', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@lacasadesebastian.com', 'lacasadesebastian.com', 'http://www.lacasadesebastian.com/', 'Teruel', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Casa del s. XV incendiada por el General Cabrera en 1839, reabierta en 2006 en el casco medieval', 'alta', false, 'seed', 'casa-sebastian', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (perdido_revisar).
Asunto: Vuestra web en inglés da error 404
Fallos: Sin HTTPS (error TLS) | No responsive, tablas, email en mapa de imagen | Versión inglés y Habitaciones dan 404 | Tarifas sin precios; ''Sientase'', ''no fué hasta,''

Hola, equipo de La Casa de Sebastián:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una casa del siglo XV que sobrevivió al incendio del General Cabrera merece una web que aguante igual de bien.

Os escribo porque he entrado en la vuestra y hay varias cosas: la versión en inglés y la página de habitaciones dan error 404, no se adapta al móvil y el navegador la marca como "no segura". En tarifas, además, no aparece ningún precio.

¿Os preparo gratis una maqueta con habitaciones, precios y reserva directa? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Mas del Aragonés', 'Casa rural / masía', 'Peñarroya de Tastavins', 'Teruel', 'http://www.masaragones.com/', 'masaragones@gmail.com', '600 26 24 33 / 678 23 11 57', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestras tarifas siguen en 2020 (y se ha colado una "moche")', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'masaragones@gmail.com', 'masaragones.com', 'http://www.masaragones.com/', 'Teruel', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Torre del s. XVI rehabilitada por Manolo y Pilar, camas de hierro forjado de la familia, pan casero', 'alta', false, 'seed', 'mas-aragones', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestras tarifas siguen en 2020 (y se ha colado una "moche")
Fallos: ''PRECIOS PARA EL AÑO 2020'' | ''65 € x moche'' | Sin HTTPS válido ni viewport | Sin reserva online

Hola, Manolo y Pilar:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una torre del siglo XVI con camas de hierro forjado de la familia y pan hecho en casa: ya me habéis ganado.

Os escribo porque en la web la página de tarifas dice "PRECIOS PARA EL AÑO 2020" y, en la misma página, "65 € x moche". Una errata muy simpática, pero errata. Además no se ve bien en el móvil y no se puede reservar online.

¿Os preparo gratis una maqueta con los precios al día y reserva directa? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Barranc de la Serra', 'Albergue rural', 'Fuentespalda', 'Teruel', 'http://www.barrancdelaserra.com/', 'info@barrancdelaserra.com', '978 856 217 / 686 641 920', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', '"Se ruega consutar precio" en vuestra portada', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@barrancdelaserra.com', 'barrancdelaserra.com', 'http://www.barrancdelaserra.com/', 'Teruel', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Falda de la Peña del Corb, junto a Els Ports; alquiler entero para grupos de hasta 30', 'alta', false, 'seed', 'barranc-serra', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: "Se ruega consutar precio" en vuestra portada
Fallos: ''se ruega consutar precio'', ''comodiad'' | Sin viewport, jQuery 2011 | Sello Toprural (ya no existe) | Sin reserva online

Hola, equipo de Barranc de la Serra:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Dormir a los pies de la Peña del Corb, con Els Ports al lado y la opción de alquilar todo el albergue para 30 personas, es un planazo para grupos.

Os escribo porque en la portada hay dos erratas ("se ruega consutar precio" y "mayor comodiad"), la web no se adapta al móvil y en el pie sigue el sello de Toprural, que ya no existe. Tampoco se puede reservar online.

¿Os preparo gratis una maqueta pensada para grupos, con precios claros y reserva directa? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Jamones El Rullo', 'Secadero / tienda online', 'Villarluengo', 'Teruel', 'http://www.jamoneselrullo.com/es/', 'contacto@jamoneselrullo.com', '978 773 006', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Comprar vuestro jamón desde el móvil es un deporte de riesgo', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'contacto@jamoneselrullo.com', 'jamoneselrullo.com', 'http://www.jamoneselrullo.com/es/', 'Teruel', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Jamón D.O. Teruel bajo en sal, secadero natural en el Maestrazgo, ya venden online', 'alta', false, 'seed', 'jamones-el-rullo', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Comprar vuestro jamón desde el móvil es un deporte de riesgo
Fallos: PrestaShop 2014 sin viewport | ''baja concetración de sal'' | Textos de plantilla: ''24/7'', ''Log in'' | Títulos cortados en portada

Hola, equipo de Jamones El Rullo:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Curar jamón D.O. Teruel en secadero natural en pleno Maestrazgo y venderlo online ya es ir por delante de mucha gente.

Por eso os escribo: la tienda no se adapta al móvil (que es desde donde compra casi todo el mundo), los nombres de producto salen cortados en la portada ("Jamón Denominación de...") y en una ficha pone "baja concetración de sal". También quedan textos de la plantilla, como el botón "Log in" en inglés.

¿Os preparo gratis una maqueta de la tienda pensada para el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Trufas Bertolin', 'Truficultura', 'Sarrión', 'Teruel', 'https://trufasbertolin.com/', 'info@trufasbertolin.com', '629 205 052 / 978 780 104', '', 'perdido', '', null, null, '', 'Isabel Bertolín contestó 5 oct: no están interesados. No volver a escribir.', true, 'Isabel Bertolín contestó 5 oct: no están interesados. No volver a escribir.', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'En vuestra web pone hola@miempresa.es', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@trufasbertolin.com', 'trufasbertolin.com', 'https://trufasbertolin.com/', 'Teruel', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Más de 50 años con trufa negra en Sarrión, capital mundial de la trufa', 'media', false, 'seed', 'trufas-bertolin', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (no_contactar).
Asunto: En vuestra web pone hola@miempresa.es
Fallos: Barra superior: ''Teléfono | hola@miempresa.es'' | Redes enlazan a portadas genéricas | ''Atención 24 Horas'', © 2018 | Sin pedidos online

Hola, equipo de Trufas Bertolin:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Más de 50 años con la trufa negra en Sarrión, la capital mundial de la trufa, es mucho currículum.

Os escribo porque la barra de arriba de vuestra web todavía tiene el texto de la plantilla, "Teléfono | hola@miempresa.es", y quien pulsa escribe a un email que no es el vuestro. Los iconos de Facebook, Twitter e Instagram llevan a la portada de cada red, no a vuestros perfiles, y no hay forma de pedir trufa ni planta desde la web.

¿Os preparo gratis una maqueta con un formulario de pedidos? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Restaurante Sierra de Javalambre', 'Restaurante de carretera / hotel', 'La Puebla de Valverde', 'Teruel', 'https://www.restaurantejavalambre.es/', 'info@restaurantejavalambre.es', '978 72 00 04', '', 'contactado', '', null, null, '', 'Negocio más grande que la media; más capacidad de pago.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Las fotos de vuestra web se llaman "DSC_0246"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@restaurantejavalambre.es', 'restaurantejavalambre.es', 'https://www.restaurantejavalambre.es/', 'Teruel', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Horno de pan propio, cocina de 7 a 23 h, ducha gratis para viajeros, Premio PYME Teruel 2019', 'alta', false, 'seed', 'rest-javalambre', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Las fotos de vuestra web se llaman "DSC_0246"
Fallos: Sin viewport, WordPress 4.9 | ''acojedor'', ''mensas'', ''intima'' | Nombres de fotos visibles ''DSC_0246...'' | Dos emails distintos

Hola, equipo del Sierra de Javalambre:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Horno de pan propio, cocina abierta de 7 a 23 h y ducha gratis para el que viene conduciendo: así se gana uno a los de la A-23.

Os escribo porque en el carrusel de fotos de la web salen los nombres de archivo ("DSC_0246 DSC_0250..."), hay erratas como "acojedor" y "mensas" y no se adapta al móvil, que es justo desde donde os busca el que va por la autovía. Además aparecen dos emails distintos.

¿Os preparo gratis una maqueta pensada para el móvil, con carta y cómo llegar? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Mieles 5 Panales', 'Miel artesana', 'Campillo de Altobuey', 'Cuenca', 'http://mieles5panales.com/', 'mieles5panales@gmail.com', '666 223 772 / 969 33 80 16', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestra tienda online esconde el botón de comprar', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'mieles5panales@gmail.com', 'mieles5panales.com', 'http://mieles5panales.com/', 'Cuenca', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Cuatro generaciones de apicultores, sello «Miel de Cuenca»', 'alta', false, 'seed', 'mieles-5-panales', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra tienda online esconde el botón de comprar
Fallos: Sin HTTPS (error TLS) | WordPress 2015, blog con 1 entrada | Tienda sin precios y botón de compra oculto | Botón Google+

Hola, equipo de Mieles 5 Panales:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Cuatro generaciones de apicultores y miel con sello «Miel de Cuenca»: eso se vende solo... si la web deja.

Y ese es el tema: en las fichas de la tienda no aparece el precio y el botón de comprar está oculto, así que nadie puede pedir. La web no se toca desde 2015 (el blog tiene una sola entrada), el navegador la marca como no segura y sigue el botón de Google+, que cerró en 2019.

¿Os preparo gratis una maqueta con una tienda que funcione de verdad? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Rural Pitu', 'Casa rural', 'Las Majadas', 'Cuenca', 'http://www.casapitu.es/', 'casaruralpitu@gmail.com', '969 230 486 / 696 375 267', '', 'perdido', '', null, null, '', 'Contestó "No, gracias". No volver a escribir.', true, 'Contestó "No, gracias". No volver a escribir.', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', '"Teféfonos" en vuestra portada', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'casaruralpitu@gmail.com', 'casapitu.es', 'http://www.casapitu.es/', 'Cuenca', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Casa de piedra junto a los Callejones de Las Majadas, admite mascotas', 'alta', false, 'seed', 'casa-pitu', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (no_contactar).
Asunto: "Teféfonos" en vuestra portada
Fallos: FrontPage, tablas, sin viewport | ''contruida'', ''Teféfonos'' | Widget del tiempo 404, enlaces muertos | Email @wanadoo.es

Hola, equipo de Casa Pitu:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una casa de piedra al lado de los Callejones de Las Majadas que encima admite mascotas: mi perro (hipotético) ya ha hecho la maleta.

Os escribo porque en la portada pone "Teféfonos" y en el título "contruida de piedra", el widget del tiempo ya no carga, no se ve bien en el móvil y todavía aparece un email de @wanadoo.es.

¿Os preparo gratis una maqueta con fotos grandes y reserva directa? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Rural Las Abuelas', 'Casa rural', 'Villalba de la Sierra', 'Cuenca', 'http://lasabuelas.es/', 'casarural_lasabuelas@yahoo.es', '659 56 41 72', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestra web dice "Update: 20/07/2008"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'casarural_lasabuelas@yahoo.es', 'lasabuelas.es', 'http://lasabuelas.es/', 'Cuenca', 'guzman', 'guzmangonzalez.twati@gmail.com', 'El nombre es un homenaje a sus mayores; barrio de Los Perales, a 20 km de Cuenca', 'alta', false, 'seed', 'las-abuelas', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web dice "Update: 20/07/2008"
Fallos: ''Update : 20/07/2008'' y contador roto | Enlace ''mailto:m@il'' | Tablas, sin viewport, sin HTTPS | ''consultar precio'', disponibilidad por teléfono

Hola, equipo de Las Abuelas:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Ponerle a la casa el nombre de vuestras abuelas para que no se olvide es de las cosas más bonitas que he visto buscando casas rurales.

Os escribo porque en la portada aún pone "Update: 20/07/2008", el contador de visitas está roto, el enlace de email de contacto apunta a "m@il" y la web no se ve bien en el móvil. Además, para saber el precio o la disponibilidad hay que llamar.

¿Os preparo gratis una maqueta con calendario y precios? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('La Tinaja - Apartamentos Rurales', 'Apartamentos rurales', 'Cardenete', 'Cuenca', 'http://www.casarurallatinaja.com/', 'info@casarurallatinaja.com', '969 348 259 / 617 857 702', '', 'perdido', '', null, null, '', 'Contestó: se jubiló el 1 de octubre. Respondido con agradecimiento el 8 oct.', false, '', false, 'Contestó: se jubiló el 1 de octubre. Respondido con agradecimiento el 8 oct.', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestras páginas se titulan "Free CSS Templates"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@casarurallatinaja.com', 'casarurallatinaja.com', 'http://www.casarurallatinaja.com/', 'Cuenca', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Apartamentos El Botijo, El Puchero, La Cántara y La Sartén; vídeo de dron', 'alta', false, 'seed', 'la-tinaja', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (perdido_revisar).
Asunto: Vuestras páginas se titulan "Free CSS Templates"
Fallos: Slider Flash (hueco vacío) | H1 ''Free CSS Templates'' | Ancho fijo, HTTPS con error | Sin reserva online

Hola, equipo de La Tinaja:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Unos apartamentos que se llaman El Botijo, El Puchero, La Cántara y La Sartén: solo por los nombres ya me quedaba.

Os escribo porque las fotos de la portada van en Flash, así que hoy se ve un hueco vacío, y Contactar, Precios y Apartamentos tienen de título "Free CSS Templates", el texto de la plantilla. Tampoco se adapta al móvil.

¿Os preparo gratis una maqueta con vuestro vídeo de dron bien a la vista? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Europlaca Suministros Industriales', 'Suministro pladur y herramienta', 'León', 'León', 'https://www.europlaca.com', 'info@europlaca.com', '987 25 60 04', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Vuestra web sigue con las tarifas de 2010', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@europlaca.com', 'europlaca.com', 'https://www.europlaca.com', 'León', 'guzman', null, 'Distribuidores de DeWalt, Metabo, Stanley; reparto por CyL y Asturias', 'alta', false, 'seed', 'europlaca', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web sigue con las tarifas de 2010
Fallos: Portada con ''TARIFAS 2010'' y catálogo 2009-2010 | No se adapta al móvil | Sin catálogo online, solo PDFs

Hola, equipo de Europlaca:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Distribuidores de DeWalt, Metabo y Stanley con reparto por toda Castilla y León y Asturias: tenéis un catálogo que da gusto.

Pero en la portada siguen las "TARIFAS 2010" y el catálogo 2009-2010. Un instalador que entra hoy puede pensar que los precios son de hace 16 años (ojalá).

¿Os preparo gratis una maqueta de la web con un catálogo actualizado y fácil de mirar desde el móvil? Si no os convence, la borro sin más.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Rural El Telar del Tío Josete', 'Casas rurales', 'Huerta del Marquesado', 'Cuenca', 'http://www.casaruraleltelar.com/', 'gloria@casaruraleltelar.com', '654 629 827', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', '"Company Name" en el pie de vuestra web', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'gloria@casaruraleltelar.com', 'casaruraleltelar.com', 'http://www.casaruraleltelar.com/', 'Cuenca', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Dos casas nuevas con terraza y barbacoa cerca de Cañete; Gloria firma la bienvenida', 'media', false, 'seed', 'telar-tio-josete', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: "Company Name" en el pie de vuestra web
Fallos: Pie ''© Copyright 2012 Company Name'' | ''manatiales'', ''nos encontraos'' | elentorno.htm da 404 | Sin precios ni reserva

Hola, Gloria:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Dos casas nuevas con terraza y barbacoa en Huerta del Marquesado, a un paso de Cañete: muy bien pensado.

Te escribo porque en el pie de la web pone "© Copyright 2012 Company Name" (el texto de la plantilla), en la portada hay erratas como "manatiales" y "nos encontraos" y el "Ver más" de El Entorno da error. Tampoco aparecen precios.

¿Te preparo gratis una maqueta con precios y reserva directa? Si no te gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Cabañas Rurales Villa de Cañete', 'Cabañas rurales', 'Cañete', 'Cuenca', 'http://www.cabanasruralesvilladecanete.es/', 'info@cabanasruralesvilladecanete.es', '969 34 63 22 / 650 22 64 51', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestras tarifas son una foto (y Google no las ve)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@cabanasruralesvilladecanete.es', 'cabanasruralesvilladecanete.es', 'http://www.cabanasruralesvilladecanete.es/', 'Cuenca', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Finca de 5 ha entre los ríos Tinte y Mayor, cerca del casco de Cañete', 'media', false, 'seed', 'cabanas-canete', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestras tarifas son una foto (y Google no las ve)
Fallos: Adobe Muse (abandonado 2018), sin viewport | Sin HTTPS | Tarifas en imagen | ''LE IMPRESIONARAN'', sin reserva

Hola, equipo de Cabañas Villa de Cañete:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Cinco hectáreas entre el Tinte y el río Mayor, a un paseo del pueblo de Álvaro de Luna: un sitio bonito de verdad.

Os escribo porque la tabla de precios de la web es una imagen, así que en el móvil apenas se lee y Google no la encuentra. Además, la web está hecha con un programa que dejó de actualizarse en 2018, no se adapta al móvil y no tiene candado de seguridad.

¿Os preparo gratis una maqueta con precios legibles y reserva directa? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Pulpería El Dorado', 'Pulpería / restaurante', 'O Barco de Valdeorras', 'Ourense', 'http://www.pulperiaeldorado.com', 'info@pulperiaeldorado.com', '988 321 728', '', 'perdido', '', null, null, '', 'Email rebotó (no existe). Llamar al 988 321 728.', false, '', true, 'Email rebotó (no existe). Llamar al 988 321 728.', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestra web es un documento de Word', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@pulperiaeldorado.com', 'pulperiaeldorado.com', 'http://www.pulperiaeldorado.com', 'Ourense', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Actualizan el menú del día casi a diario (menú 15 €)', 'alta', false, 'seed', 'pulperia-el-dorado', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (rebote).
Asunto: Vuestra web es un documento de Word
Fallos: Portada = documento Word guardado como HTML | Sin <title> ni viewport | Solo imagen + 2 PDF; sin fotos, horario ni reserva | Ficheros auxiliares 404

Hola, equipo de El Dorado:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. He visto que subís el menú del día casi a diario. Ese mimo se nota, y por eso me da pena lo que os voy a contar.

Vuestra portada es un documento de Word guardado como página web: no tiene título, en el móvil sale diminuta y todo se reduce a una imagen y dos PDF. No hay fotos de platos, horario, mapa ni botón para reservar o mandar un WhatsApp.

¿Os preparo gratis una maqueta donde el menú del día se vea a la primera, sin descargar nada? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Lagar do Meréns', 'Bodega D.O. Ribeiro', 'Castrelo de Miño', 'Ourense', 'https://www.lagardomerens.com', 'info@lagardomerens.com', '607 533 314', '', 'contactado', '', null, null, '', 'Web sin tocar desde 2011: puede que la bodega esté poco activa.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'El enlace de Contacto de vuestra web da error', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@lagardomerens.com', 'lagardomerens.com', 'https://www.lagardomerens.com', 'Ourense', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Bronce Decanter 2011 con 30 Copelos; ''reza para que no aparezca otro coche de cara''', 'baja', false, 'seed', 'lagar-do-merens', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: El enlace de Contacto de vuestra web da error
Fallos: Cabecera e intro en Flash | Contacto -> /cantactar.aspx -> error 500 | Noticias de 2011, Google Maps v2 | ''echo de piedras''

Hola, equipo de Lagar do Meréns:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Un bronce en los Decanter con el 30 Copelos y una bodega en un camino tan estrecho que hay que rezar para que no aparezca otro coche de cara: me encanta.

Os escribo porque el enlace de Contacto del menú da error, la cabecera es Flash (hoy no se ve en ningún navegador), la última noticia es de 2011 y el mapa ya no funciona.

¿Os preparo gratis una maqueta con vuestros vinos y cómo visitaros? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Ciefocal, S.L.', 'Electricidad, calefacción y fontanería', 'Celanova', 'Ourense', 'https://ciefocal-es.webnode.es', 'ciefocalsl@hotmail.com', '988 451 759', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestra web no dice que hacéis fontanería', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'ciefocalsl@hotmail.com', 'ciefocal-es.webnode.es', 'https://ciefocal-es.webnode.es', 'Ourense', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Fundada en 1990, más de 35 años en Celanova', 'alta', false, 'seed', 'ciefocal', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web no dice que hacéis fontanería
Fallos: Webnode gratis con publicidad, © 2013; ciefocal.es no carga | Texto de ejemplo de la plantilla, no dice qué hacen | Única novedad de 2013 | Sin viewport, fotos ni WhatsApp

Hola, equipo de Ciefocal:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Más de 35 años haciendo instalaciones en Celanova merecen algo mejor que lo que os voy a contar.

Vuestra web es una página gratuita de Webnode con su publicidad en el pie, el texto es el de ejemplo de la plantilla ("servicios y productos de la más alta calidad...") y en ningún sitio pone que hacéis electricidad, fontanería o calefacción. La última novedad es de 2013 y el dominio ciefocal.es no carga.

¿Os preparo gratis una maqueta con vuestros servicios, fotos de trabajos y un botón de WhatsApp? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Fisio Conde', 'Fisioterapia', 'Xinzo de Limia', 'Ourense', 'http://fisiocondexinzo.com', 'info@fisiocondexinzo.com', '988 461 415 / 649 932 911', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestro masaje deportivo lleva a "gynecology"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@fisiocondexinzo.com', 'fisiocondexinzo.com', 'http://fisiocondexinzo.com', 'Ourense', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Nacen en 2013 tras 10 años en clínicas de Barcelona, Lugo, Pontevedra y Ourense; servicio a domicilio', 'alta', false, 'seed', 'fisio-conde', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestro masaje deportivo lleva a "gynecology"
Fallos: ''Masaxe deportivo'' -> /servicios/gynecology/ (404) | ''Horario de mañana 16:30 a 20:30'' | WhatsApp sin enlace | Copyright 2017, Limia/Limia

Hola, equipo de Fisio Conde:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Montar la clínica en 2013 después de diez años en clínicas de media Galicia y Barcelona, y encima ir a domicilio, tiene mérito.

Os escribo porque en la web el servicio "Masaxe deportivo" lleva a una página llamada /gynecology/ que da error (restos de la plantilla), el horario dice "Horario de mañana 16:30 a 20:30" y el "Mandanos un Whatsapp" no se puede pulsar.

¿Os preparo gratis una maqueta con cita por WhatsApp de un toque? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Quina', 'Casa rural / restaurante', 'A Mezquita', 'Ourense', 'http://casaquina.com', 'acasaquina@gmail.com', '988 423 534 / 680 215 788', '', 'contactado', '', null, null, '', 'No citar el fallo de HTTPS: sin confirmar.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Las páginas legales de vuestra web dan error', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'acasaquina@gmail.com', 'casaquina.com', 'http://casaquina.com', 'Ourense', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Casa del s. XVII en la Puerta de Galicia, cruce de tres caminos; carne suprema gallega', 'media', false, 'seed', 'casa-quina', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Las páginas legales de vuestra web dan error
Fallos: Carga por http sin redirigir | 3 enlaces legales del pie dan 404 | ''su esperiencia'' | Pie ''2017 ®''

Hola, equipo de Casa Quina:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una casa del siglo XVII en la Puerta de Galicia, donde se cruzan tres caminos, y con carne suprema gallega: eso es jugar en casa.

Os escribo porque los tres enlaces legales del pie de la web (términos, privacidad y cookies) dan error 404, el aviso de cookies dice "mejorar su esperiencia" y el pie sigue en 2017. Lo último es menor, pero lo de los enlaces legales conviene arreglarlo.

¿Os preparo gratis una maqueta renovada con reserva directa? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Rural Pacio do Sil', 'Casa rural', 'Vilela, A Rúa', 'Ourense', 'https://paciodosil.es', 'paciodosil@gmail.com', '609 567 823', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestras tarifas no tienen ni un precio', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'paciodosil@gmail.com', 'paciodosil.es', 'https://paciodosil.es', 'Ourense', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Monedas de cobre de 1743 en un muro, horno romano en el comedor, habitaciones con nombres de uva', 'media', false, 'seed', 'pacio-do-sil', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestras tarifas no tienen ni un precio
Fallos: Tarifas: todo ''consultar'' | Cabecera apunta a dominio de pruebas caído | Sin reserva ni calendario; © 2020 | Tildes incoherentes, privacidad duplicada

Hola, equipo de Pacio do Sil:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Encontrar monedas de 1743 en un muro al restaurar la casa, tener un horno romano en el comedor y ponerle a cada habitación el nombre de una uva... ¡la historia ya la tenéis hecha!

Os escribo porque en la página de tarifas solo pone "consultar", la imagen de cabecera apunta a un dominio de pruebas que ya no existe y no hay reserva online ni calendario.

¿Os preparo gratis una maqueta que cuente todo eso y deje reservar? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Foncaldiz', 'Cocinas, baños y reformas', 'Ourense', 'Ourense', 'https://www.foncaldiz.com', 'contacto@foncaldiz.com', '988 219 403', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Diseñáis cocinas preciosas y en la web no se ve ninguna', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'contacto@foncaldiz.com', 'foncaldiz.com', 'https://www.foncaldiz.com', 'Ourense', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Más de 25 años diseñando cocinas a medida en la calle Mercado', 'media', false, 'seed', 'foncaldiz', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Diseñáis cocinas preciosas y en la web no se ve ninguna
Fallos: © 2014 y Google+ | ''Reformar integrales'' | Enlaces de fabricantes 404/500 | Sin galería de proyectos ni WhatsApp

Hola, equipo de Foncaldiz:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Más de 25 años diseñando cocinas a medida en Ourense y ni una foto de vuestros proyectos en la web: es como un restaurante sin carta.

Además, en la portada pone "Reformar integrales", el pie sigue en 2014 con un icono de Google+ (que cerró en 2019) y varios enlaces de fabricantes dan error.

¿Os preparo gratis una maqueta con galería de proyectos y presupuesto por WhatsApp? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Santalla Dental', 'Clínica dental', 'Mondoñedo', 'Lugo', 'https://www.santalladental.es', 'doctora@santalladental.es', '982 507 150', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Ningún botón de "Pedir cita" de su web funciona', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'doctora@santalladental.es', 'santalladental.es', 'https://www.santalladental.es', 'Lugo', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Dentista de Mondoñedo desde 1992', 'alta', false, 'seed', 'santalla-dental', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Ningún botón de "Pedir cita" de su web funciona
Fallos: 4 botones ''PEDIR CITA'' y ''CONTACTAR'' -> 404 | ''VER SERVICIOS'' -> 404 | ''más de 25 años'' (desde 1992) | Copyright 2019

Hola, doctora Santalla:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Llevar desde 1992 siendo la dentista de Mondoñedo es mucha confianza ganada.

Por eso le escribo: en su web, los cuatro botones de "PEDIR CITA" y el de "CONTACTAR" llevan a una página que da error 404, y "Ver servicios" también. Es decir, el paciente que quiere pedir cita desde la web no puede. Además pone "más de 25 años de experiencia", cuando ya son más de 34.

¿Le preparo gratis una maqueta con cita por WhatsApp o un formulario que funcione? Si no le gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Bladi Profesional', 'Maquinaria de limpieza y piscinas', 'Navatejera (León)', 'León', 'http://www.bladiprofesional.com', 'info@bladiprofesional.com', '987 286 919', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Vuestra web aún os deja compartir en Digg (que ya no existe)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@bladiprofesional.com', 'bladiprofesional.com', 'http://www.bladiprofesional.com', 'León', 'guzman', null, 'Fregadoras, barredoras y análisis de aguas con servicio técnico propio', 'media', false, 'seed', 'bladi', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web aún os deja compartir en Digg (que ya no existe)
Fallos: Botones para compartir en del.icio.us y Digg (ya no existen) | Errata ''Servicio profesonial'' | No se adapta al móvil | ''Carrito Vacío'' fijo en todas las páginas

Hola, equipo de Bladi Profesional:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Os escribo porque vuestra web tiene botones para compartir en del.icio.us y Digg, dos redes que ya no existen, y en la cabecera pone "Servicio profesonial".

Es una pena, porque fregadoras, barredoras y análisis de aguas con servicio técnico propio es justo lo que busca un hotel o una comunidad de vecinos.

¿Os hago gratis una maqueta de la web, pensada para el móvil? Si no os gusta, la borro y tan amigos.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa da Lembranza', 'Apartamentos rurales', 'A Fonsagrada', 'Lugo', 'http://www.casadalembranza.com', 'casadalembranza@gmail.com', '695 021 386 / 649 329 118', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestros apartamentos salen a "€0 / Night"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'casadalembranza@gmail.com', 'casadalembranza.com', 'http://www.casadalembranza.com', 'Lugo', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Apartamentos con nombres de escritores gallegos (Castelao, Rosalía, Cunqueiro...)', 'alta', false, 'seed', 'casa-lembranza', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestros apartamentos salen a "€0 / Night"
Fallos: Precios ''€0 / Night'' | ''More'', ''Details'', ''Rooms'' sin traducir | Sin reserva online; ''Que visitar'' | © 2020, solo http

Hola, equipo de Casa da Lembranza:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Apartamentos que se llaman Castelao, Rosalía, Cunqueiro o Curros Enríquez: es como dormir dentro de un libro de literatura gallega.

Os escribo porque en la página de Reservas todos los apartamentos aparecen con precio "€0 / Night" (ojalá, pero no). Quedan textos de la plantilla en inglés ("More", "Details", "Rooms") y no se puede reservar online.

¿Os preparo gratis una maqueta con precios reales y reserva directa? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Complejo O Piñeiral', 'Restaurante / pensión / albergue', 'A Fonsagrada', 'Lugo', 'https://www.opineiral.com', 'info@opineiral.com', '982 340 350 / 606 165 752', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', '"Exquisitos postes caseros" en vuestra carta', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@opineiral.com', 'opineiral.com', 'https://www.opineiral.com', 'Lugo', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Pastel de A Fonsagrada, cocido con butelo, Seimeira de Vilagocende al lado', 'alta', false, 'seed', 'o-pineiral', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: "Exquisitos postes caseros" en vuestra carta
Fallos: ''exquisitos postes caseros'' | ''O Opiñeiral'' repetido | ''Nos encontrarnos'', ''Contamos de conexión'' | Sin reserva online; © 2017

Hola, equipo de O Piñeiral:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Pastel de A Fonsagrada, cocido con butelo y la Seimeira a un paso: peregrino que pasa, peregrino que se queda.

Os escribo porque en la carta de la web pone "exquisitos postes caseros" (me imagino que son postres, aunque un poste casero también tendría su gracia), el nombre sale como "O Opiñeiral" en varios sitios y no se puede reservar la pensión ni el albergue online.

¿Os preparo gratis una maqueta con reserva directa para peregrinos? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Horacio', 'Restaurante y hospedaje', 'Ribeira de Piquín', 'Lugo', 'http://casahoracio.gal', 'info@casahoracio.gal', '982 333 685', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestra web sale como "no segura"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@casahoracio.gal', 'casahoracio.gal', 'http://casahoracio.gal', 'Lugo', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Fundado por Horacio y Oliva, 54 años abierto, salón para 60 con ventanales al valle', 'media', false, 'seed', 'casa-horacio', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web sale como "no segura"
Fallos: Certificado SSL de otro dominio | ''Riveira'' vs ''Ribeira'' | ''mientrás'', ''Visitanos'' | Sin precios, carta ni reserva

Hola, equipo de Casa Horacio:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. 54 años abiertos desde que empezaron Horacio y Oliva, con un comedor para 60 y ventanales al valle. Eso no lo tiene cualquiera.

Os escribo porque el certificado de seguridad de la web no corresponde a vuestro dominio, así que el navegador avisa de que no es segura. Además, el título dice "Riveira de Piquín" y el texto "Ribeira", y no hay precios, carta ni forma de reservar.

¿Os preparo gratis una maqueta con la carta, las habitaciones y reserva? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Pensión Restaurante Casa Goás', 'Pensión y restaurante', 'Abadín', 'Lugo', 'https://www.casagoas.com', 'reservas@casagoas.com', '982 508 005 / 647 453 696', '', 'contactado', '', null, null, '', 'Ya tienen reserva online: el argumento es contenido y erratas.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Un botiquín para "cualquier altercado" en el Camino', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'reservas@casagoas.com', 'casagoas.com', 'https://www.casagoas.com', 'Lugo', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Cuarta generación; llevan la mochila del peregrino a la siguiente etapa', 'media', false, 'seed', 'casa-goas', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Un botiquín para "cualquier altercado" en el Camino
Fallos: Botiquín ''para cualquier altercado'' | ''rustico'', ''todas su dudas'' | Textos genéricos de plantilla | © 2018

Hola, equipo de Casa Goás:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Cuatro generaciones y encima le lleváis la mochila al peregrino hasta la siguiente etapa: así da gusto hacer el Camino.

Os escribo porque en los servicios de la web pone que el botiquín es "para cualquier altercado que pueda sufrir en el Camino" (suena a que hay peleas en Abadín). También hay erratas como "todas su dudas", frases de plantilla como "La nueva era de la hospitalidad", y el pie sigue en 2018.

¿Os preparo gratis una maqueta con textos vuestros, que cuenten la historia de la casa? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Pensión Casa Manolo', 'Pensión', 'A Fonsagrada', 'Lugo', 'https://www.pension-casamanolo.es', 'pension-casamanolo@hotmail.com', '982 340 408 / 626 009 979', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'El mapa de vuestra web os pone en otra calle', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'pension-casamanolo@hotmail.com', 'pension-casamanolo.es', 'https://www.pension-casamanolo.es', 'Lugo', 'guzman', 'guzmangonzalez.twati@gmail.com', 'A 95 m del Camino Primitivo, garaje gratis para bicis', 'media', false, 'seed', 'casa-manolo', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: El mapa de vuestra web os pone en otra calle
Fallos: © 2013 y botón Google+ | Mapa en otra calle | ''Lo mas'', ''Politica'', ''France'' | Sin precios ni calendario

Hola, equipo de Casa Manolo:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. A 95 metros del Camino Primitivo y con garaje gratis para las bicis: los que van pedaleando os lo agradecen seguro.

Os escribo porque el mapa de la web marca "Rúa Rois de la Peña, 3", mientras la dirección que publicáis es la Calle Burón 35, así que algún peregrino cansado puede acabar llamando a otra puerta. En contacto sigue el botón de Google+ (que cerró en 2019) y no hay precios ni calendario.

¿Os preparo gratis una maqueta con el mapa bien puesto y reserva directa? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Café Bar Moderno', 'Café-bar, fonda y restaurante', 'San Cosme de Barreiros', 'Lugo', 'https://cafebarmoderno.hotelriadomasma.com', 'info@cafebarmoderno.org', '982 12 40 85 / 615 09 21 15', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'La carta de vuestra web se descarga como un Word', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@cafebarmoderno.org', 'cafebarmoderno.org', 'https://cafebarmoderno.hotelriadomasma.com', 'Lugo', 'guzman', 'guzmangonzalez.twati@gmail.com', '''Casa fundada en 1934''; mismos dueños que el Hotel Ría do Masma', 'baja', false, 'seed', 'cafe-bar-moderno', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: La carta de vuestra web se descarga como un Word
Fallos: Frames y FrontPage | Sin viewport, sin cambios desde 2018 | Carta en MENUS.doc | Enlace benquerencia.info muerto

Hola, equipo del Moderno:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. "Casa fundada en 1934": casi un siglo dando de comer en la Mariña, eso es oro.

Os escribo porque la web de la fonda está hecha con marcos (una técnica de los 2000), no se adapta al móvil y para ver la carta hay que descargarse un documento de Word. Además, el enlace a benquerencia.info está muerto.

He visto que la web del Hotel Ría do Masma ya está renovada. ¿Os preparo gratis una maqueta de la fonda al mismo nivel? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Bodegas La Sierra', 'Bodega D.O. Somontano', 'Bespén', 'Huesca', 'http://www.bodegaslasierra.es', 'info@bodegaslasierra.es', '974 260 365 / 652 791 187', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestra web son dos GIF', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@bodegaslasierra.es', 'bodegaslasierra.es', 'http://www.bodegaslasierra.es', 'Huesca', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Bodega familiar de 2007, vinos con el nombre del pueblo (Bespén), 7 ha, visitas con cata', 'alta', false, 'seed', 'bodegas-la-sierra', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web son dos GIF
Fallos: Web = 2 GIF + dirección | HTTPS con certificado de otro dominio | mailto mal escrito | Sin viewport

Hola, equipo de Bodegas La Sierra:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una bodega familiar que les pone a sus vinos el nombre del pueblo, Bespén, y con 7 hectáreas propias: eso me gusta mucho.

Os escribo porque vuestra web ahora mismo es una sola página con dos imágenes GIF y la dirección: no cuenta nada de los vinos, de las visitas ni de dónde comprarlos. Además, el enlace del email está mal escrito y la versión segura da error de certificado.

¿Os preparo gratis una maqueta con vuestros vinos y las visitas con cata? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Bodegas Chesa', 'Bodega D.O. Somontano', 'Barbastro', 'Huesca', 'https://www.bodegaschesa.com', 'bodegaschesa@hotmail.com', '649 870 637', '', 'contactado', '', null, null, '', 'Web hackeada: buen motivo, contarlo con tacto.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Ojo: vuestra web tiene publicidad de casinos escondida', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'bodegaschesa@hotmail.com', 'bodegaschesa.com', 'https://www.bodegaschesa.com', 'Huesca', 'guzman', 'guzmangonzalez.twati@gmail.com', '''Chesas'' = tierras de yesos; 10 ha junto al LIC Yesos de Barbastro, Gewürztraminer', 'alta', false, 'seed', 'bodegas-chesa', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Ojo: vuestra web tiene publicidad de casinos escondida
Fallos: HACKEADA: spam oculto de casinos en portada | Sin viewport, Joomla antiguo | Google Analytics UA (muerto en 2023) | Email solo vía JS, Hotmail

Hola, equipo de Bodegas Chesa:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Llamar a la bodega como las tierras de yesos del Somontano y tener las viñas al lado de los Yesos de Barbastro es tener el nombre bien puesto.

Os escribo por algo que creo que no sabéis: la portada de vuestra web tiene texto escondido de casinos online, con enlaces a páginas de apuestas. Los visitantes no lo ven, pero Google sí, y eso perjudica a vuestra marca. Suele pasar cuando una web lleva tiempo sin actualizarse, que es el caso: tampoco se adapta al móvil.

Aunque no queráis nada más, os recomiendo arreglarlo. Y si os apetece, os preparo gratis una maqueta nueva y limpia. Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Bodegas Sers', 'Bodega + casa rural', 'Cofita', 'Huesca', 'https://bodegassers.es', 'info@bodegassers.es', '652 979 718 / 974 412 110', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Se ve "[honeypot your-hnp]" en vuestro formulario', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@bodegassers.es', 'bodegassers.es', 'https://bodegassers.es', 'Huesca', 'guzman', 'guzmangonzalez.twati@gmail.com', '''Sers'' = cierzo; Casa Canales junto a ermita románica s. XIII; Parraleta y Moristel', 'alta', false, 'seed', 'bodegas-sers', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Se ve "[honeypot your-hnp]" en vuestro formulario
Fallos: WordPress 4.3 (2015) | ''[honeypot your-hnp]'' visible en formulario | ''rocio de lamañana'', ''quese acentua'' | Casa rural sin reserva: ''consultar precios''

Hola, equipo de Bodegas Sers:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una bodega que se llama como el cierzo, con Parraleta y Moristel y la casa de labranza de la familia pegada a una ermita románica: hay historia para rato.

Os escribo porque en mitad del formulario de contacto de la web se ve el código "[honeypot your-hnp]", hay erratas en las fichas de cata ("rocio de lamañana") y la casa rural no se puede reservar online: solo pone "consultar precios".

¿Os preparo gratis una maqueta con la bodega y Casa Canales juntas, con reserva directa? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Rufas', 'Casa rural', 'Bierge', 'Huesca', 'https://www.casarufas.es', 'info@casarufas.es', '974 318 373 / 646 598 961', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', '"¿Por qué motivo desea una cita?" en vuestras reservas', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@casarufas.es', 'casarufas.es', 'https://www.casarufas.es', 'Huesca', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Casa de labradores de 1717; los niños ven los animales del establo', 'alta', false, 'seed', 'casa-rufas', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: "¿Por qué motivo desea una cita?" en vuestras reservas
Fallos: IONOS MyWebsite 2010, sin viewport | Reservas: ''¿Por qué motivo desea una cita?'' | ''adap-/-tada'' partido, ''rustico'' | Reserva solo por teléfono

Hola, equipo de Casa Rufas:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una casa de labradores de 1717 donde los niños pueden ver los animales del establo: muchas familias de Madrid pagarían por eso.

Os escribo porque el formulario de "Reservas online" pregunta "¿Por qué motivo desea una cita?", como si fuera una consulta médica (es un campo de la plantilla). Además, la web no se adapta al móvil, la palabra "adaptada" sale partida en dos y al final hay que confirmar la reserva por teléfono.

¿Os preparo gratis una maqueta con reserva directa de verdad? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Metálicas Pérez / Seccionales Altobar', 'Carpintería metálica / puertas', 'Altobar de la Encomienda', 'León', 'http://www.metalicasperez.es', 'metalicasperez@metalicasperez.es', '987 667 418', '', 'contactado', '', null, null, '', 'No está confirmado fuera de su web que siga abierto.', false, '', false, '', 'seed-2026-10-13', '', 'Una cosa de la web de las puertas', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'metalicasperez@metalicasperez.es', 'metalicasperez.es', 'http://www.metalicasperez.es', 'León', 'guzman', null, 'Fabrican sus propias puertas seccionales; web firmada por Rubén Pérez García', 'baja', false, 'seed', 'metalicas-perez', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Una cosa de la web de las puertas
Fallos: Sin HTTPS | No se adapta al móvil | Erratas: ''A1:20011'', ''apertura latera'' | Presupuesto solo por email, sin fotos en portada

Hola, Rubén:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Me parece muy top que fabriquéis vuestras propias puertas seccionales desde Altobar.

Te escribo porque la web no os ayuda a vender: el navegador la marca como "no segura", en el móvil se ve diminuta, en la portada no hay fotos de las puertas y para pedir presupuesto solo se puede mandar un correo. También hay un par de erratas en las normas ("A1:20011").

¿Te preparo gratis una maqueta con fotos de vuestros trabajos y un formulario de presupuesto? Si no te convence, la borro.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Vertientes Aventura', 'Turismo activo', 'Alquézar', 'Huesca', 'https://www.vertientesaventura.com', 'vertientes@vertientesaventura.com', '974 318 354 / 635 501 073', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestra portada sigue en el "Verano 2025"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'vertientes@vertientesaventura.com', 'vertientesaventura.com', 'https://www.vertientesaventura.com', 'Huesca', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Actividad ''Susurra a los Buitres'' y astronomía en Guara', 'media', false, 'seed', 'vertientes-aventura', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra portada sigue en el "Verano 2025"
Fallos: Titular ''Verano 2025'' | WordPress 4.1 (2014) | ''se realizara'', ''todos los dias'' | Aviso COVID en el pie

Hola, equipo de Vertientes:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. "Susurra a los Buitres" es el mejor nombre de actividad que he leído este año.

Os escribo porque el titular de la portada dice "os espera este Verano 2025", en el pie sigue el aviso de la ayuda COVID y hay erratas como "se realizara" y "todos los dias". Además, la web va sobre una versión de WordPress de 2014, que aparte de vieja es un riesgo de seguridad.

¿Os preparo gratis una maqueta con las actividades y reserva online? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Clínica Dental Santos', 'Clínica dental', 'Barbastro', 'Huesca', 'https://www.clinicadentalsantosbarbastro.com', 'clinicadentalsantos@gmail.com', '974 31 32 91', '', 'contactado', '', null, null, '', 'El diseño Wix no es viejo: el gancho es el mailto roto.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'El email de vuestra web va a info@mysite.com', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'clinicadentalsantos@gmail.com', 'clinicadentalsantosbarbastro.com', 'https://www.clinicadentalsantosbarbastro.com', 'Huesca', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Más de 25 años en el centro de Barbastro', 'media', false, 'seed', 'dental-santos', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: El email de vuestra web va a info@mysite.com
Fallos: Email de cabecera -> mailto:info@mysite.com | ''intalaciones'' | ''Quiero una pedir una consulta'' | ''©2022... Creado con Wix'', sin WhatsApp

Hola, equipo de Clínica Dental Santos:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Más de 25 años en el centro de Barbastro: eso es tener pacientes de toda la vida.

Os escribo por algo que os puede estar haciendo perder citas: en la cabecera de la web, el email lleva a info@mysite.com, la dirección de ejemplo de Wix, así que quien lo pulsa no os escribe a vosotros. También hay una errata en "Explora nuestras intalaciones" y el asunto para pedir cita sale como "Quiero una pedir una consulta".

¿Os preparo gratis una maqueta con cita por WhatsApp y todo esto corregido? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hostal-Restaurante El Chocolatero', 'Hostal y restaurante', 'Castildelgado', 'Burgos', 'http://www.hostalelchocolatero.com', 'chococastil@gmail.com', '947 588 063', '', 'contactado', '', null, null, '', 'Servidor intermitente.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestra página del chocolate está en latín', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'chococastil@gmail.com', 'hostalelchocolatero.com', 'http://www.hostalelchocolatero.com', 'Burgos', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Página dedicada al Chocolate Merino en cazuela ''de San Martín a Santa Águeda''; 37 hab. en el Camino', 'alta', false, 'seed', 'el-chocolatero', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra página del chocolate está en latín
Fallos: Sin HTTPS | Página Chocolate Merino con pseudolatín | © 2015, jQuery 1.8 | ''WiFigratuita'', reserva -> Booking

Hola, equipo de El Chocolatero:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una página entera dedicada al Chocolate Merino y a hacerlo en cazuela de San Martín a Santa Águeda: con eso ya me tenéis.

Pero en esa misma página hay texto de relleno en pseudolatín ("Nec ornare non sit ullamcorper..."), el pie sigue en 2015, la web no tiene candado de seguridad y el botón de RESERVA os manda a Booking, que se queda su comisión.

¿Os preparo gratis una maqueta con reserva directa, sin comisiones? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hotel Belorado', 'Hotel, bar y restaurante', 'Belorado', 'Burgos', 'http://www.hotelbelorado.com', 'informacion@hotelbelorado.com', '947 58 06 84', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Los botones de vuestra portada no llevan a ningún sitio', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'informacion@hotelbelorado.com', 'hotelbelorado.com', 'http://www.hotelbelorado.com', 'Burgos', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Bienvenida: ''alivio para el viajero... dando posada al maltrecho cuerpo tras largo caminar''', 'alta', false, 'seed', 'hotel-belorado', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Los botones de vuestra portada no llevan a ningún sitio
Fallos: Tarjetas de portada -> ''http://bar'', ''http://hotel''... | HTTPS con certificado de otro dominio | ''nuestro ancestros'', ''compañia'' | Reservas = formulario genérico

Hola, equipo del Hotel Belorado:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. "Alivio para el viajero... dando posada al maltrecho cuerpo tras largo caminar": vuestro texto de bienvenida es de lo mejor que he leído en la web de un hotel.

Os escribo porque las tres tarjetas de la portada (bar, hotel y restaurante) llevan a direcciones rotas, la versión segura da error de certificado y la sección de Reservas es un formulario genérico. También hay erratas como "nuestro ancestros".

¿Os preparo gratis una maqueta con reserva directa para peregrinos? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Las de Villadiego', 'Casas rurales', 'Villalibado', 'Burgos', 'https://lasdevilladiego.com', 'info@lasdevilladiego.com', '699 76 36 38 / 616 88 53 08', '', 'contactado', '', null, null, '', 'Ya tienen motor de reservas.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Lo último de vuestro blog es de 2018', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@lasdevilladiego.com', 'lasdevilladiego.com', 'https://lasdevilladiego.com', 'Burgos', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Rehabilitaron un pueblo casi abandonado 30 años; torre medieval (1725); iglesia románica', 'media', false, 'seed', 'las-de-villadiego', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Lo último de vuestro blog es de 2018
Fallos: Pie © 2013, WordPress 4.7 | Última entrada del blog: julio 2018 | ''0 Comment'', ''Find Out More'' | Contenido mixto http

Hola, equipo de Las de Villadiego:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Devolverle la vida a un pueblo que llevaba 30 años casi vacío, y que se pueda dormir en una torre medieval, es de película.

Os escribo porque la entrada más reciente que sale en la portada es de julio de 2018, el pie dice "Copyright © 2013", quedan textos en inglés de la plantilla ("Find Out More", "0 Comment") y algunas imágenes cargan sin seguridad. El motor de reservas funciona, pero la web no le hace justicia al sitio.

¿Os preparo gratis una maqueta renovada, manteniendo vuestro sistema de reservas? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Bodegas Hemar', 'Bodega D.O. Ribera del Duero', 'Fuentecén', 'Burgos', 'https://bodegashemar.com', 'info@bodegashemar.com', '947 532 718', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', '"Tradicción" en el lema de vuestra web', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@bodegashemar.com', 'bodegashemar.com', 'https://bodegashemar.com', 'Burgos', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Acrónimo de las Heras Martín; Carlos fundó en 2003 sobre viñas de los abuelos; reserva Llanum', 'media', false, 'seed', 'bodegas-hemar', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: "Tradicción" en el lema de vuestra web
Fallos: ''tradicción vinícola'' en el lema | ''caracter'', ''Bodegas hemar'' | © 2022, WordPress 5.8 | WooCommerce instalado sin tienda ni enoturismo

Hola, equipo de Bodegas Hemar:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Que el nombre salga de las Heras Martín y que la bodega se levantara sobre las viñas de los abuelos le da mucho sentido al Llanum.

Os escribo porque en el lema de la portada pone "tradicción vinícola" (con dos ces), la web sigue en 2022 y, aunque tiene instalado lo necesario para una tienda, no se pueden comprar vinos ni reservar visitas.

¿Os preparo gratis una maqueta con tienda y enoturismo? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Desgrufesa', 'Desguace y grúa 24 h', 'Aranda de Duero', 'Burgos', 'https://www.desgrufesa.com', 'info@desgrufesa.com', '947 51 09 90 / 680 53 80 42', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Quien busca una grúa desde el móvil no ve bien vuestra web', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@desgrufesa.com', 'desgrufesa.com', 'https://www.desgrufesa.com', 'Burgos', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Más de 30 años, centro autorizado, recogida gratis', 'media', false, 'seed', 'desgrufesa', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Quien busca una grúa desde el móvil no ve bien vuestra web
Fallos: Sin viewport (grúa 24h buscada en móvil) | Joomla 3.6.5 (2016) | ''Grua'', ''Vehiculos'' | S.L. vs S.A.

Hola, equipo de Desgrufesa:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Más de 30 años en el sector y centro autorizado: eso da confianza.

Os escribo porque vuestra web no se adapta al móvil, y quien necesita una grúa 24 horas os busca desde el móvil y con prisa. Además va sobre una versión de Joomla de 2016 sin soporte, hay erratas como "Servicio Grua 24h" y el encabezado dice S.L. mientras el pie dice S.A.

¿Os preparo gratis una maqueta con un botón bien grande de "Llamar ahora"? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('dp Abogados – David Pomar', 'Abogados y mediación', 'Aranda de Duero', 'Burgos', 'https://www.abogadomediadoraranda.es', 'davidpomar@icaburgos.com', '947 67 99 90 / 608 009 096', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Su email de la web lleva a Johndoe@gmail.com', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'davidpomar@icaburgos.com', 'icaburgos.com', 'https://www.abogadomediadoraranda.es', 'Burgos', 'guzman', 'guzmangonzalez.twati@gmail.com', '30 años de experiencia, despacho en Aranda y Madrid, derecho cinegético y agrario', 'media', false, 'seed', 'dp-abogados', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Su email de la web lleva a Johndoe@gmail.com
Fallos: Email visible -> mailto:Johndoe@gmail.com | Pie en inglés ''Copyright 2022'' | ''Áreas que estamos especializados'' | Menú ''Derecho-civil''

Hola, David:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. El derecho cinegético y agrario no lo ve uno en cualquier despacho, y menos con oficina en Aranda y en Madrid.

Le escribo porque en su web el email que aparece (davidpomar@icaburgos.com) en realidad abre un correo a Johndoe@gmail.com, la dirección de ejemplo de la plantilla. Es decir, a quien le escribe desde ahí no le llega el mensaje. Además, el pie está en inglés y sigue en 2022, y hay frases como "Áreas que estamos especializados".

¿Le preparo gratis una maqueta con todo esto corregido? Si no le gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hostal Restaurante de Goya', 'Hostal y restaurante', 'Piedrahíta', 'Ávila', 'https://hostaldegoya.com/', 'info@hostaldegoya.com', '920 360 720', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', '"Lorem ipsum" en vuestra portada', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@hostaldegoya.com', 'hostaldegoya.com', 'https://hostaldegoya.com/', 'Ávila', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Centro de Piedrahíta, Palacio de los Duques de Alba, carne avileña a la brasa', 'alta', false, 'seed', 'hostal-goya', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: "Lorem ipsum" en vuestra portada
Fallos: Lorem ipsum en las 4 tarjetas de portada | ''Siguenos'', ''Instragram'', ''interes'' | ''bacalo bras'', ''bizcaína'' | Sin reserva ni WhatsApp

Hola, equipo del Hostal de Goya:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Carne avileña a la brasa en el centro de Piedrahíta, con el Palacio de los Duques de Alba al lado: plan de fin de semana resuelto.

Os escribo porque las cuatro tarjetas de la portada (Habitaciones, Restaurante, Entorno y Blog) todavía dicen "Lorem ipsum dolor sit amet", el texto de relleno de la plantilla. En el pie pone "Instragram" y en la carta "bacalo bras". Tampoco se puede reservar online.

¿Os preparo gratis una maqueta con vuestros textos y reserva directa? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Jamones y Embutidos La Cañada', 'Jamones y embutidos', 'La Cañada', 'Ávila', 'http://grupojufersa.com/', 'info@grupojufersa.com', '920 272 002', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestra web pone "LA CA??ADA"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@grupojufersa.com', 'grupojufersa.com', 'http://grupojufersa.com/', 'Ávila', 'guzman', 'guzmangonzalez.twati@gmail.com', '80 años elaborando jamón en la C/ Mayor 1 de La Cañada', 'alta', false, 'seed', 'jamones-la-canada', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web pone "LA CA??ADA"
Fallos: ''LA CA??ADA'', ''INTRODUCCI??N'' | Aviso ''Se necesita plugin de Flash MX'' | Word 2011, tablas, sin viewport | Catálogo error 500, sin HTTPS

Hola, equipo de Jamones La Cañada:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. 80 años haciendo jamón en la calle Mayor de La Cañada: eso es una institución.

Os escribo porque en vuestra web la eñe se ha roto y el título dice "LA CA??ADA" (y el menú, "INTRODUCCI??N"). Además, aparece un aviso de que hace falta Flash, el enlace al catálogo da error y no se ve bien en el móvil.

¿Os preparo gratis una maqueta con vuestros productos y un catálogo que funcione? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Embutidos Agustín', 'Embutidos y cecina IGP', 'Villanueva de Carrizo', 'León', 'https://www.embutidosagustin.es', 'fabrica@embutidosagustin.es', '987 357 172', '', 'perdido', '', null, null, '', 'Rebote del email. Llamar al 987 357 172', false, '', true, 'Rebote del email. Llamar al 987 357 172', 'seed-2026-10-13', '', 'Cecina ahumada con roble y nadie fuera de León puede comprarla', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'fabrica@embutidosagustin.es', 'embutidosagustin.es', 'https://www.embutidosagustin.es', 'León', 'guzman', null, 'Receta de padres a hijos; ahumado con leña de roble; IGP Cecina de León', 'media', false, 'seed', 'emb-agustin', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (rebote).
Asunto: Cecina ahumada con roble y nadie fuera de León puede comprarla
Fallos: Sin tienda online, solo puntos de venta | No se adapta al móvil | Footer © 2018, librerías de 2010

Hola, equipo de Embutidos Agustín:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Receta de padres a hijos y ahumado con leña de roble: eso se vende solo… si se puede comprar.

Vuestra web no tiene tienda online (solo puntos de venta), en el móvil se ve diminuta y el pie sigue en 2018. Hay mucha gente fuera de León con ganas de cecina IGP y ningún sitio donde pedírosla.

¿Os preparo gratis una maqueta de la web con tienda? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Restaurante El Descanso', 'Asador castellano', 'El Barraco (Burguillo)', 'Ávila', 'http://restauranteeldescanso.es/', 'info@restauranteeldescanso.es', '920 281 657', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Un letrero que se mueve en vuestra web (y un reloj Flash)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@restauranteeldescanso.es', 'restauranteeldescanso.es', 'http://restauranteeldescanso.es/', 'Ávila', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Desde 1963 junto al Burguillo; cabrito, cordero y judías; reportaje en RTVCyL', 'alta', false, 'seed', 'el-descanso', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Un letrero que se mueve en vuestra web (y un reloj Flash)
Fallos: FrontPage 12, tablas, sin viewport | Aviso de cierre en <marquee> | Enlaces 404 y reloj Flash muerto | Solo http, reserva por teléfono

Hola, equipo de El Descanso:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Desde 1963 junto al Burguillo y famosos por el cabrito y las judías: lo raro es que no haya cola hasta el pantano.

Os escribo porque vuestra web está hecha con FrontPage (un programa de hace casi 20 años) y no se adapta al móvil. El aviso de que cerráis los jueves pasa como un letrero luminoso, y hay enlaces rotos, incluido un reloj Flash que ya no existe. Además, para reservar solo hay teléfono.

¿Os preparo gratis una maqueta con la carta, el horario claro y reserva? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('La Posada del Tiétar', 'Posada rural', 'Santa María del Tiétar', 'Ávila', 'https://posadadeltietar.com/', 'info@posadadeltietar.com', '647 290 864', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestra web todavía tiene una pestaña de Covid-19', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@posadadeltietar.com', 'posadadeltietar.com', 'https://posadadeltietar.com/', 'Ávila', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Dintel de piedra del s. XVIII y puertas de cedro de Costa Rica; 7 habitaciones junto a la plaza', 'alta', false, 'seed', 'posada-tietar', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web todavía tiene una pestaña de Covid-19
Fallos: ''disfrutar una un agradable hospedaje'', ''datado el siglo'' | Pestaña ''Covid-19'' en el menú | Tablas de ancho fijo, sin viewport | Script de Google+

Hola, equipo de La Posada del Tiétar:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Un dintel de piedra del siglo XVIII y puertas de cedro de Costa Rica junto a la plaza: qué bien recuperado está.

Os escribo porque en el menú de la web sigue la pestaña "Covid-19", en la portada pone "disfrutar una un agradable hospedaje", no se adapta al móvil y aún carga el botón de Google+, que cerró en 2019.

¿Os preparo gratis una maqueta con las 7 habitaciones y reserva directa? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Legumbres La Gallareta', 'Tienda gourmet / legumbres', 'El Barco de Ávila', 'Ávila', 'https://www.gallareta.com/', 'comercial@gallareta.com', '920 34 03 16', 'José Manuel Mena', 'negociacion', 'Webs + ventas online (fijo + comisión)', null, 'fijo_comision', 'Propuesta escrita del piloto de Navidad', 'José Manuel Mena escribió por WhatsApp (móvil personal +34 679 93 75 70) el 2/10. Lead caliente. · Reunión el 5 oct. Quiere solo comisión: pendiente de negociar.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestra tienda pone "EcolÃ³gica"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'comercial@gallareta.com', 'gallareta.com', 'https://www.gallareta.com/', 'Ávila', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Desde 2001 junto al Consejo Regulador de las Judías de El Barco', 'media', false, 'seed', 'la-gallareta', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (pipeline).
Asunto: Vuestra tienda pone "EcolÃ³gica"
Fallos: Tildes rotas: ''EcolÃ³gica'', ''CafÃ©'' | osCommerce sin traducir (''My Account | Cart Contents'') | Sin viewport, 28 tablas | ?osCsid en URLs

Hola, equipo de La Gallareta:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Llevar desde 2001 defendiendo la judía de El Barco, con Consejo Regulador y todo, es mucho compromiso.

Os escribo porque en la tienda las tildes salen rotas ("Agricultura EcolÃ³gica", "CafÃ©"), la pestaña del navegador se llama "osCommerce", hay partes en inglés ("My Account | Cart Contents | Checkout") y no se adapta al móvil.

¿Os preparo gratis una maqueta de tienda moderna para vender judías desde el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Alojamiento Rural Cruz del Gallo', 'Casa rural para grupos', 'Navalperal de Tormes', 'Ávila', 'http://cruzdelgallo.com/', 'cruzdelgallocasarural@gmail.com', '646 630 557', '', 'perdido', '', null, null, '', 'Raquel contestó: la casa se vendió a finales de septiembre; quizá los nuevos dueños. Guzmán ya le respondió.', false, '', false, 'Raquel contestó: la casa se vendió a finales de septiembre; quizá los nuevos dueños. Guzmán ya le respondió.', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestra web está hecha con marcos (como en el año 2000)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'cruzdelgallocasarural@gmail.com', 'cruzdelgallo.com', 'http://cruzdelgallo.com/', 'Ávila', 'guzman', 'guzmangonzalez.twati@gmail.com', '1.350 m en la cara norte de Gredos; ''leer, caminar, observar el cielo o simplemente estar''', 'media', false, 'seed', 'cruz-del-gallo', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (perdido_revisar).
Asunto: Vuestra web está hecha con marcos (como en el año 2000)
Fallos: Frameset (menu/banner/bienvenido) | HTML 4.01 sin viewport, sin HTTPS | Script de idioma de la era IE | Enlace empresasenred.es 404

Hola, equipo de Cruz del Gallo:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. "Leer, caminar, observar el cielo o simplemente estar", a 1.350 metros en la cara norte de Gredos. Me lo apunto.

Os escribo porque vuestra web está montada con marcos, una técnica del año 2000 que impide compartir cada página e indexarla bien en Google. Tampoco se adapta al móvil, uno de los enlaces del menú da error y para reservar solo hay teléfono y email.

¿Os preparo gratis una maqueta con fotos grandes de Gredos y reserva directa? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Cárnicas Ceferino', 'Matadero y distribución cárnica', 'La Lastrilla', 'Segovia', 'http://carnicasceferino.es/', 'matadero@carnicasceferino.es', '921 42 47 91', '', 'contactado', '', null, null, '', 'B2B: probablemente conteste un comercial.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'La cabecera de vuestra web es Flash', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'matadero@carnicasceferino.es', 'carnicasceferino.es', 'http://carnicasceferino.es/', 'Segovia', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Desde 1988 invirtiendo en tecnología, venden en toda España y fuera', 'media', false, 'seed', 'carnicas-ceferino', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: La cabecera de vuestra web es Flash
Fallos: Cabecera Flash | Sin viewport, imágenes troceadas | Solo http | Portada de 1 párrafo, catálogo externo

Hola, equipo de Cárnicas Ceferino:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una empresa que lleva desde 1988 invirtiendo en tecnología y vendiendo por toda España merece una web a la altura.

Os escribo porque la cabecera de la web es una animación Flash que ya no se ve en ningún navegador, la página no se adapta al móvil ni tiene candado de seguridad y el catálogo está en un folleto externo. Para un cliente que os busca por primera vez, la web dice muy poco de lo que sois.

¿Os preparo gratis una maqueta con el catálogo dentro y un formulario para pedidos? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Onzas de Sabor', 'Alimentación a granel / producto local', 'Segovia', 'Segovia', 'https://www.onzasdesabor.com/', 'segovia@onzasdesabor.com', '674 993 197', '', 'contactado', '', null, null, '', 'Otro email visible: onzasdesabor@gmail.com', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'El email de vuestra web pone "gmial"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'segovia@onzasdesabor.com', 'onzasdesabor.com', 'https://www.onzasdesabor.com/', 'Segovia', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Merchandising con juegos de palabras: CastleBirra, Birraducto, DiaBlirra', 'alta', false, 'seed', 'onzas-de-sabor', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: El email de vuestra web pone "gmial"
Fallos: Mailto a ''gmial.com'' y ''onzasdesbor'' | Destacados a ''€0'' | © 2015 | Categoría ''Especial PAPÁ'' en octubre

Hola, equipo de Onzas de Sabor:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. CastleBirra, Birraducto y DiaBlirra: el que os pone los nombres se merece un aumento.

Os escribo porque los botones de email de la web llevan a "onzasdesabor@gmial.com" y "onzasdesbor@gmail.com" (con erratas), así que esos mensajes se pierden. Además, en Productos Destacados todo sale a "€0" y el pie sigue en 2015.

¿Os preparo gratis una maqueta con todo corregido? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Pastelería Limón y Menta', 'Pastelería / ponche segoviano', 'Segovia', 'Segovia', 'https://www.pastelerialimonymenta.com/', 'pastelerialimonymenta@gmail.com', '921 462 141', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'El mapa de vuestra web no carga', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'pastelerialimonymenta@gmail.com', 'pastelerialimonymenta.com', 'https://www.pastelerialimonymenta.com/', 'Segovia', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Porción de ponche a 3 € con café en la Plaza Mayor; rombos marcados con hierro al rojo', 'alta', false, 'seed', 'limon-y-menta', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: El mapa de vuestra web no carga
Fallos: Mapa roto: ''This page can''t load Google Maps correctly'' | ''EXQUSITECES'', ''Tryp Advisor'', ''Piñon'' | Blog en 2015 y en inglés | WordPress 4.3, sin pedidos online

Hola, equipo de Limón y Menta:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una porción de ponche con café en la Plaza Mayor por 3 € es de los mejores planes que se pueden hacer en Segovia.

Os escribo porque el mapa de contacto de la web da error ("This page can''t load Google Maps correctly"), en la portada pone "EXQUSITECES" y "Tryp Advisor", y el blog se quedó en 2015. Tampoco se pueden hacer pedidos online.

¿Os preparo gratis una maqueta con encargos de ponche online? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('El Portón de Javier', 'Restaurante, catering y hotel rural', 'Marugán', 'Segovia', 'http://elportondejavier.com/', 'restaurante@elportondejavier.com', '921 19 61 41', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestra "nueva web" es de 2015', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'restaurante@elportondejavier.com', 'elportondejavier.com', 'http://elportondejavier.com/', 'Segovia', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Quince ediciones de jornadas gastronómicas de setas; catering', 'alta', false, 'seed', 'porton-de-javier', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra "nueva web" es de 2015
Fallos: Blog parado en 2015 (''Inauguración Nueva Web'') | ''ofreros'', ''puedan de gustar'' | Enlace a Google+ | Solo http

Hola, equipo de El Portón de Javier:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Quince ediciones de jornadas de setas no las aguanta cualquiera.

Os escribo porque lo último del blog de la web es "Inauguración Nueva Web 15.09.2015", junto con las jornadas de ese año. Hay erratas como "para ofreros" y "puedan de gustar", sigue el enlace a Google+ y no tiene candado de seguridad.

¿Os preparo gratis una maqueta con el restaurante, el catering y el hotel bien separados? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('El Convento de Ayllón', 'Hospedería', 'Ayllón', 'Segovia', 'http://www.elconventodeayllon.com/', 'reservas@elconventodeayllon.com', '670 393 533', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', '"El Covento de Ayllón" en el pie de vuestra web', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'reservas@elconventodeayllon.com', 'elconventodeayllon.com', 'http://www.elconventodeayllon.com/', 'Segovia', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Convento de la Concepción Franciscana fundado el 6 de junio de 1528', 'alta', false, 'seed', 'convento-ayllon', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: "El Covento de Ayllón" en el pie de vuestra web
Fallos: ''El Covento de Ayllón'' en el pie | Certificado de otro dominio | Sin viewport, dos jQuery | CSS y scripts 404

Hola, equipo de El Convento de Ayllón:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Dormir en un convento franciscano fundado en 1528 ya es un argumento de venta por sí solo.

Os escribo porque en el pie de todas las páginas pone "El Covento de Ayllón" (le falta una ene), el certificado de seguridad no corresponde a vuestro dominio, la web no se adapta al móvil y algunos archivos dan error.

¿Os preparo gratis una maqueta que luzca el convento y deje reservar? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('La Cruz de Hierro', 'Garbanzo de Labajos / tienda online', 'Labajos', 'Segovia', 'https://lacruzdehierro.es/', 'contact@lacruzdehierro.es', '699 890 018', '', 'contactado', '', null, null, '', 'Web de 2024 responsive: argumento = fallos. Otro email: hola@lacruzdehierro.es', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Una camiseta azul en el carrito de vuestra tienda de garbanzos', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'contact@lacruzdehierro.es', 'lacruzdehierro.es', 'https://lacruzdehierro.es/', 'Segovia', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Proyecto familiar ''de más de 400 años''; garbanzo que ''no se despelleja''', 'media', false, 'seed', 'cruz-de-hierro', '2026-10-02T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Una camiseta azul en el carrito de vuestra tienda de garbanzos
Fallos: ''Privaciodad'', ''Subscribete'', ''beneficiate'' | Enlaces del pie 404, dominio que no resuelve | ''Garbanzos Gourmet, Calidad'' x8 | Productos de ejemplo en el carrito

Hola, equipo de La Cruz de Hierro:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Un garbanzo que "no se despelleja" y más de 400 años de familia detrás: eso hay que contarlo bien.

Os escribo porque vuestra web, aunque es nueva, tiene unos cuantos fallos: en el carrito aparecen productos de ejemplo de la plantilla ("Blue Round-Neck Tshirt with a Button"), en el pie pone "Política de Privaciodad", dos enlaces del pie dan error y en la portada "Garbanzos Gourmet, Calidad" sale repetido ocho veces.

¿Os preparo gratis una maqueta con todo corregido? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-02T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Peñín Selección', 'Obrador de repostería', 'Valderrey (La Bañeza / Astorga)', 'León', 'http://www.peninseleccion.com', 'ttitopenin@yahoo.es', '987 632 400', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Las Trufas de San Isidoro merecen algo mejor que un Yahoo', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'ttitopenin@yahoo.es', 'peninseleccion.com', 'http://www.peninseleccion.com', 'León', 'guzman', null, 'Empezó de aprendiz en Casa Baudilio (1970) y estudió en París; yemas tostadas, imperiales y Trufas de San Isidoro', 'media', false, 'seed', 'penin', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Las Trufas de San Isidoro merecen algo mejor que un Yahoo
Fallos: Footer © 2014 | No se adapta al móvil | Certificado https de otro dominio | Pedidos solo por teléfono o Yahoo; errata ''colorantesm''

Hola, equipo de Peñín:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. De aprendiz en Casa Baudilio a estudiar pastelería en París: vaya historia. Y las yemas tostadas y los imperiales bañezanos ya me han abierto el apetito.

La web, en cambio, se quedó en 2014. En el móvil se ve diminuta, el navegador avisa de que no es segura y los pedidos son solo por teléfono o por un correo de Yahoo.

¿Os preparo gratis una maqueta con tienda online para vender vuestros dulces fuera de León? Si no os convence, la borro sin rencores.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Embutidos Cauria', 'Cecina y embutidos', 'La Robla (León)', 'León', 'http://www.embutidoscauria.es', 'cauria@embutidoscauria.es', '630 424 748', '', 'perdido', '', null, null, '', 'El correo rebotó: la dirección no existe. Si interesa, llamar al 630 424 748.', false, '', true, 'El correo rebotó: la dirección no existe. Si interesa, llamar al 630 424 748.', 'seed-2026-10-13', '', 'Casi un siglo de cecina y un trozo de código en vuestra web', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'cauria@embutidoscauria.es', 'embutidoscauria.es', 'http://www.embutidoscauria.es', 'León', 'guzman', null, 'Familiar desde 1921; venden en los mercados de Carrizo, Astorga, Benavides, Veguellina y La Bañeza', 'media', false, 'seed', 'cauria', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (rebote).
Asunto: Casi un siglo de cecina y un trozo de código en vuestra web
Fallos: Código roto visible en la ficha de la cecina (''Grasas: <5gr de="" las=""…'') | No se adapta al móvil | Constructor de webs antiguo | Venta solo por teléfono/email

Hola, equipo de Embutidos Cauria:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Desde 1921 y de mercado en mercado por Carrizo, Astorga o La Bañeza: eso es tradición de verdad.

Os aviso de que en la ficha de la cecina se ve un trozo de código roto en la información nutricional ("Grasas: <5gr de="" las=""…"), en el móvil la web se ve diminuta y para comprar hay que llamar o escribir.

¿Os hago gratis una maqueta de la web con tienda online? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Pérez Alonso Consultores', 'Asesoría / gestoría', 'Ponferrada', 'León', 'https://www.perezalonsoconsultores.com', 'asesoria@perezalonsoconsultores.com', '987 40 56 64', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Vuestra web dice que estamos en el año 126', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'asesoria@perezalonsoconsultores.com', 'perezalonsoconsultores.com', 'https://www.perezalonsoconsultores.com', 'León', 'guzman', null, 'Despacho cercano que presume de trato personal ''sin la burocracia de los grandes''', 'alta', false, 'seed', 'perez-alonso', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web dice que estamos en el año 126
Fallos: La fecha de la cabecera muestra el año ''126'' | Footer ''Copyright ©2005'' | Maquetada con tablas, no se adapta al móvil | ''Más de diez años de experiencia'' escrito en 2005

Hola, equipo de Pérez Alonso:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Os escribo por algo que me hizo mucha gracia: la fecha de la cabecera de vuestra web pone algo como "jueves, 1 de Octubre de 126". Es un fallo de programación antiguo, pero una asesoría que controla plazos no debería parecer que vive en el Imperio romano.

El pie también sigue en 2005 y en el móvil la web se ve diminuta.

Lo del trato cercano "sin la burocracia de los grandes" es un argumentazo. ¿Os preparo gratis una maqueta de la web nueva? Si no os gusta, la borro sin más.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Musical Belenda', 'Tienda de instrumentos', 'Ponferrada', 'León', 'https://www.musicalbelenda.com', 'belenda@musicalbelenda.com', '987 416 117', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Desde 1978 en Ponferrada y una tienda online de 2012', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'belenda@musicalbelenda.com', 'musicalbelenda.com', 'https://www.musicalbelenda.com', 'León', 'guzman', null, 'Abierta en 1978 por Daniel Belenda, fundador de la Discoteca Strada; hoy la llevan sus hijos Daniel y Raúl', 'media', false, 'seed', 'belenda', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Desde 1978 en Ponferrada y una tienda online de 2012
Fallos: Tienda PrestaShop antigua (2012) | No se adapta al móvil | Diseño muy anticuado para tienda online

Hola, Daniel y Raúl:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Leí en El Bierzo Noticias la historia de vuestro padre, la Discoteca Strada y el anuncio en el Cine Morán. Muy grande.

Os escribo porque la tienda online se ha quedado antigua: no se adapta al móvil, que es desde donde hoy se compra casi todo, y tiene un diseño de hace más de diez años.

¿Os preparo gratis una maqueta de cómo quedaría la tienda nueva? Si no os convence, la borro y seguimos tan amigos.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Los Calderones de Piedrasecha', 'Casa rural', 'Piedrasecha (León)', 'León', 'https://www.loscalderones.com', 'info@loscalderones.com', '652 350 984', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Leña gratis, chimenea… y reservas por teléfono', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@loscalderones.com', 'loscalderones.com', 'https://www.loscalderones.com', 'León', 'guzman', null, 'Casa para 2-12 con chimenea y leña gratis, porche con barbacoa junto al río; los huéspedes adoran a Toño', 'media', false, 'seed', 'calderones', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Leña gratis, chimenea… y reservas por teléfono
Fallos: Sin reserva online: hay que ''solicitar disponibilidad'' | Ancho fijo, no se adapta al móvil | Mapa de Google en formato antiguo

Hola, equipo de Los Calderones:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Chimenea con leña gratis, porche con barbacoa junto al río y a 35 km de León: justo lo que busca un grupo de amigos para un finde (y por las opiniones, Toño es media experiencia).

Pero en vuestra web no se puede reservar: hay que pedir disponibilidad y esperar. Mucha gente, si no puede reservar al momento, se va a Booking, y Booking se lleva su comisión. Además, en el móvil se ve diminuta.

¿Os preparo gratis una maqueta con calendario y reserva directa? Si no os gusta, la borro sin rencores.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Fisioterapia Meseguer', 'Fisioterapia', 'Murcia', 'Murcia', 'http://www.fisioterapiameseguer.com', 'contacto@fisioterapiameseguer.com', '968 909 212', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Hay un "Lorem ipsum" escondido en vuestra web', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'contacto@fisioterapiameseguer.com', 'fisioterapiameseguer.com', 'http://www.fisioterapiameseguer.com', 'Murcia', 'guzman', null, 'Primera consulta gratis; especialistas en suelo pélvico e hipopresivos', 'alta', false, 'seed', 'meseguer', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Hay un "Lorem ipsum" escondido en vuestra web
Fallos: Texto de relleno visible: ''Collapsible Group Item #5 Lorem ipsum…'' | Redirige de https a http | Plantilla genérica de Mobirise

Hola, equipo de Fisioterapia Meseguer:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Os aviso de algo que seguramente no sabéis: en la sección de tratamientos sigue apareciendo el texto de relleno de la plantilla ("Collapsible Group Item #5 Lorem ipsum dolor sit amet…"). Es latín de mentira, y un paciente que lo lee no sabe muy bien qué pensar.

Es una pena, porque ofrecéis primera consulta gratis y os especializáis en suelo pélvico e hipopresivos, que es justo lo que mucha gente busca en Google.

¿Os hago gratis una maqueta de cómo quedaría la web, con reserva de cita incluida? Si no os convence, la borro y tan amigos.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hotel Presa y Apartamentos Pico Llerenes', 'Hotel / apartamentos', 'Riaño', 'León', 'https://www.hotelpresa.com', 'info@hotelpresa.com', '987 740 637', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Riaño merece una web que no sea de la época de Internet Explorer 6', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@hotelpresa.com', 'hotelpresa.com', 'https://www.hotelpresa.com', 'León', 'guzman', null, '33 habitaciones, comedor para 200 y 14 apartamentos con vistas en Riaño', 'media', false, 'seed', 'hotel-presa', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Riaño merece una web que no sea de la época de Internet Explorer 6
Fallos: Carga un estilo para Internet Explorer 6 | No se adapta al móvil | Sin motor de reservas ni precios

Hola, equipo del Hotel Presa:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. 33 habitaciones y 14 apartamentos con vistas en pleno Riaño: tenéis uno de los paisajes más bonitos de España para enseñar.

La web, en cambio, todavía carga un archivo pensado para Internet Explorer 6 (sí, el de 2001), en el móvil se ve diminuta y no tiene reservas ni precios, solo un formulario.

¿Os preparo gratis una maqueta con reserva directa, para no depender tanto de Booking? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Uva de Vida', 'Bodega familiar (vinos biodinámicos)', 'Santa Olalla', 'Toledo', 'https://www.uvadevida.com/', 'uvadevida@uvadevida.com', '667 252 158', '', 'contactado', '', null, null, '', 'Programado lun 5 oct 9:00', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'En vuestra web pone "info@email.com" (y un teléfono de Estados Unidos)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'uvadevida@uvadevida.com', 'uvadevida.com', 'https://www.uvadevida.com/', 'Toledo', 'guzman', 'guzmangonzalezperez@gmail.com', 'Bodega familiar biodinámica que presume de ser "una de las cinco bodegas españolas del selecto club de La Renaissance des Appellations"; organizan visitas al viñedo y catas.', 'alta', false, 'seed', 'uva-de-vida', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestra web pone "info@email.com" (y un teléfono de Estados Unidos)
Fallos: Pie de página con los datos de ejemplo de la plantilla en todas las páginas: "+1 840 841 25 69" e "info@email.com" (el email real solo aparece en /contacto/) | Errata en el botón de la página Sobre Nosotros: "Descure Nuestros Vinos" | Widget de WhatsApp sin configurar ni traducir: "Hello! Click one of our contacts below to chat on WhatsApp" y "Social Chat is free, download and try it now here!" | Errata en contacto: "Santa Olalla, Castilla La-Mancha"

Hola, equipo de Uva de Vida:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Ser una de las cinco bodegas españolas de La Renaissance des Appellations, y hacerlo desde Santa Olalla, tiene muchísimo mérito (y muchas lunas de biodinámica detrás).

Os escribo porque en el pie de todas las páginas aparecen "+1 840 841 25 69" e "info@email.com", que son los datos de ejemplo de la plantilla; el botón de Sobre Nosotros invita a "Descure Nuestros Vinos", y el chat de WhatsApp saluda en inglés con "Hello! Click one of our contacts below to chat on WhatsApp" y "Social Chat is free, download and try it now".

¿Os preparo gratis una maqueta con la tienda y la reserva de visitas y catas bien resueltas en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Vinagres Parras', 'Elaborador de vinagres (empresa familiar desde 1947)', 'Torrijos', 'Toledo', 'https://vinagresparras.com/es/', 'vp@vinagres-parras.com', '925 761 100', '', 'contactado', '', null, null, '', 'Programado lun 5 oct 9:00. Es una S.A., algo más grande que la media.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'En vuestra web hay una empresa en "42 Puffin street, Puffinville"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'vp@vinagres-parras.com', 'vinagres-parras.com', 'https://vinagresparras.com/es/', 'Toledo', 'guzman', 'guzmangonzalezperez@gmail.com', 'Fundada en 1947 en Torrijos; en 1957 fue "la primera empresa nacional" en embotellar vinagre.', 'alta', false, 'seed', 'vinagres-parras', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestra web hay una empresa en "42 Puffin street, Puffinville"
Fallos: Bloque de la plantilla sin rellenar en el pie: "My Company", "42 Puffin street 12345 Puffinville France", "0123-456-789", "sales@yourcompany.com" | Textos del tema a la vista: "Premium Prestashop Template", "Copyright info generate from smart admin panel" y "© Copyright 2015. All Rights Reserved by Legenda Responsive Theme." | Módulo roto visible: "You Need To Configure twitter API in SmartBlockTwitter Module." | Erratas en las fichas de producto: "grado acética de 6º" y "Zumo de limón NO procendente de concentrados"; últimas entradas del blog de julio y septiembre de 2020

Hola, equipo de Vinagres Parras:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Llevar desde 1947 en Torrijos y haber sido, en 1957, la primera empresa nacional en embotellar vinagre es un currículum que ya quisieran muchas marcas de Módena.

Os escribo porque en el pie de la web conviven vuestros datos con los de la plantilla ("My Company", "42 Puffin street 12345 Puffinville France", "sales@yourcompany.com"), también se ven "Premium Prestashop Template" y "You Need To Configure twitter API in SmartBlockTwitter Module", y en las fichas se ha colado un "grado acética de 6º".

¿Os preparo gratis una maqueta con el catálogo y las fichas logísticas ordenadas y fáciles de consultar desde el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Rural Las Herencias', 'Casa rural', 'Las Herencias (cerca de Talavera de la Reina)', 'Toledo', 'https://casarurallasherencias.es/', 'reservas@casarurallasherencias.es', '652 693 075', '', 'contactado', '', null, null, '', 'Programado lun 5 oct 9:00', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'El botón de compartir de vuestra web escribe a "enteryour@addresshere.com"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'reservas@casarurallasherencias.es', 'casarurallasherencias.es', 'https://casarurallasherencias.es/', 'Toledo', 'guzman', 'guzmangonzalezperez@gmail.com', 'Junto al Cerro de los Castillos, "un antiguo emplazamiento de una fortaleza árabe" en la ribera del Tajo, en la Comarca de la Jara.', 'media', false, 'seed', 'las-herencias', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: El botón de compartir de vuestra web escribe a "enteryour@addresshere.com"
Fallos: El botón de compartir por email de la portada abre un correo a la dirección de ejemplo de la plantilla: "enteryour@addresshere.com" | Pie sin actualizar: "Copyright 2018. Designed by LOVE Studios" | Página de error en inglés sin traducir: "Oops! Page not found" / "Sorry, but the page you are looking for is not found" | Errata en Precios: "Las plazas adicionales se alquilaran"; la disponibilidad se manda a EscapadaRural.com en vez de a una reserva propia

Hola, equipo de Casa Rural Las Herencias:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Tener al lado el Cerro de los Castillos, una antigua fortaleza árabe asomada al Tajo, es un argumento que pocas casas de la Jara pueden poner encima de la mesa.

Os escribo porque el botón de compartir por email de la portada abre un correo a "enteryour@addresshere.com" (el texto de ejemplo de la plantilla), el pie sigue en "Copyright 2018", en Precios pone "se alquilaran" sin tilde y, si alguien cae en una página que no existe, le sale en inglés: "Oops! Page not found".

¿Os preparo gratis una maqueta con calendario y reserva directa, para no tener que mandar a la gente a EscapadaRural? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Rural Las Adelfas de Olveite', 'Casa rural (5 estrellas verdes)', 'Novés', 'Toledo', 'https://www.lasadelfasdeolveite.com/', 'david@lasadelfasdeolveite.com', '650 84 53 92', '', 'contactado', '', null, null, '', 'El email es david@...; posiblemente el dueño se llame David, pero la web no lo dice.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra web da como contacto "contact@bellevue.com" y un 1-800', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'david@lasadelfasdeolveite.com', 'lasadelfasdeolveite.com', 'https://www.lasadelfasdeolveite.com/', 'Toledo', 'guzman', 'guzmangonzalezperez@gmail.com', 'Catalogada con 5 estrellas verdes, junto al Campo de Golf Pablo Hernández, con billar francés y suites llamadas Augusta, St. Andrews, Valderrama o Sotogrande.', 'alta', false, 'seed', 'adelfas-olveite', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web da como contacto "contact@bellevue.com" y un 1-800
Fallos: Bloque de contacto del pie con datos de ejemplo de la plantilla: "contact@bellevue.com" y "1-800-222-4545" (más un "Location" en inglés) | Botón en inglés sin traducir: "Read More" | Erratas: "En un salón de 100 metros cuadros" y, en Tarifas, "el chek-out antes de las 12:00 horas" | Coordenadas GPS incompletas: "4º 15′ 41.2»" sin indicar Oeste

Hola, equipo de Las Adelfas de Olveite:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una casa de cinco estrellas verdes con billar francés, a los pies de un campo de golf y con suites llamadas Augusta, St. Andrews o Valderrama, es para enmarcarla en la casa club.

Os escribo porque en el bloque de contacto del pie aparecen "contact@bellevue.com" y "1-800-222-4545", que son los datos de ejemplo del tema; además se cuela un "Read More" en inglés, el salón mide "100 metros cuadros" y en las normas pone "chek-out".

¿Os preparo gratis una maqueta con las cinco suites, las tarifas y la reserva directa bien visibles en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Rural El Cantueso', 'Casa rural', 'Hontanar', 'Toledo', 'http://www.elcantueso.com/', 'info@elcantueso.com', '620 861 883', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Lo último del tablón de vuestra web es de diciembre de 2017', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@elcantueso.com', 'elcantueso.com', 'http://www.elcantueso.com/', 'Toledo', 'guzman', 'guzmangonzalezperez@gmail.com', 'Tienen una sección "Apadrina un Cerdo" con cerdos ibéricos, y están al lado de Cabañeros (publicaron sobre la berrea).', 'alta', false, 'seed', 'el-cantueso', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Lo último del tablón de vuestra web es de diciembre de 2017
Fallos: No adaptada al móvil: no tiene <meta name="viewport"> | Sin HTTPS: https://www.elcantueso.com no carga (la conexión se corta); solo funciona por http | Tablón de anuncios abandonado: la noticia más reciente es del "18.12.2017" (las demás de 2015 y 2016) | Faltan tildes por toda la web: "minimo 2 noches", "La reserva sera del 30 %", "En estos precios esta incluido el IVA", "Lugares de Interes"

Hola, equipo de El Cantueso:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Lo de "Apadrina un Cerdo" con ibéricos en Hontanar es de las mejores ideas que he visto en una casa rural, y encima tenéis Cabañeros a tiro de piedra para la berrea.

Os escribo porque la noticia más reciente del tablón es del 18.12.2017, la web no está adaptada al móvil ni abre por https, y en Tarifas faltan tildes por todas partes: "minimo 2 noches", "La reserva sera del 30 %", "En estos precios esta incluido el IVA".

¿Os preparo gratis una maqueta con reserva directa y el apadrinamiento de cerdos bien explicado, que se vea bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Rural La Tahona', 'Casa rural', 'Navahermosa', 'Toledo', 'https://www.casarurallatahona.com/', 'casarurallatahona@gmail.com', '656 60 62 48', '', 'perdido', '', null, null, '', 'Rebote: la dirección no existe. Llamar al 656 60 62 48', false, '', true, 'Rebote: la dirección no existe. Llamar al 656 60 62 48', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'La pestaña de vuestra web dice "Just another WordPress site"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'casarurallatahona@gmail.com', 'casarurallatahona.com', 'https://www.casarurallatahona.com/', 'Toledo', 'guzman', 'guzmangonzalezperez@gmail.com', 'Casa para 10 personas en Navahermosa con piscina y barbacoa; proponen rutas a caballo, golf, senderismo y rutas ciclistas, y colaboran con Natur Explora.', 'media', false, 'seed', 'la-tahona-navahermosa', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (rebote).
Asunto: La pestaña de vuestra web dice "Just another WordPress site"
Fallos: Título de la web sin cambiar, el texto por defecto de WordPress: "CR La Tahona – Just another WordPress site" (es lo que sale en la pestaña y en Google) | Errata en servicios: "Mascotas consultar ante al propietario" | Etiqueta en inglés sin traducir: "Main Menu" | Email de empresa en Gmail y sin precios ni calendario: todo se deriva a teléfono/WhatsApp

Hola, equipo de Casa Rural La Tahona:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una casa para diez en Navahermosa, con piscina, barbacoa y rutas a caballo y en bici a mano, es justo lo que busca un grupo que quiere escaparse sin pasarse el día en el coche.

Os escribo porque el título que sale en la pestaña del navegador (y en Google) es "CR La Tahona – Just another WordPress site", el texto que WordPress trae de serie; en servicios pone "Mascotas consultar ante al propietario" y hay un "Main Menu" en inglés.

¿Os preparo gratis una maqueta con precios, calendario y reserva directa, en lugar de tener que preguntarlo todo por WhatsApp? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Rural Dos Hermanas', 'Casa rural (grupos)', 'Navahermosa', 'Toledo', 'http://casaruraldoshermanas.com/', 'casaruraldoshermanas@gmail.com', '655 946 438 / 615 380 473', '', 'contactado', '', null, null, '', 'Está en el mismo pueblo que Casa Rural La Tahona.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', '¿Vuestra casa tiene dos bañeras grandes o tres? La web dice las dos cosas', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'casaruraldoshermanas@gmail.com', 'casaruraldoshermanas.com', 'http://casaruraldoshermanas.com/', 'Toledo', 'guzman', 'guzmangonzalezperez@gmail.com', 'Casa de 420 m² en tres plantas, 7 dormitorios para 16 personas y gran salón para fiestas, a 5 km del Parque Nacional de Cabañeros.', 'media', false, 'seed', 'dos-hermanas-navahermosa', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: ¿Vuestra casa tiene dos bañeras grandes o tres? La web dice las dos cosas
Fallos: Datos contradictorios en la portada: primero "cinco baños, dos con bañera grande, y un aseo" y después "Cinco cuartos de baños equipados: 3 con bañera grande, 2 con ducha y 1 aseo" | Erratas: "la tranquilidad del la zona", "desconectaras" y ".Sus instalaciones son amplias" | HTTPS roto: https://casaruraldoshermanas.com da error de certificado autofirmado (la web solo funciona por http) | WordPress desactualizado (6.1) y email de empresa en Gmail

Hola, equipo de Casa Rural Dos Hermanas:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. 420 metros en tres plantas, siete dormitorios y un salón para banquetes a cinco kilómetros de Cabañeros: lo vuestro no es una casa rural, es casi un pueblo.

Os escribo porque en la portada se dice que hay "cinco baños, dos con bañera grande" y unas líneas más abajo "3 con bañera grande, 2 con ducha y 1 aseo"; también se han colado un "la tranquilidad del la zona" y un ".Sus instalaciones", y la versión https da aviso de certificado no válido.

¿Os preparo gratis una maqueta con la visita 360º, el calendario y la reserva directa bien integrados y cómodos en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Rural Sobre Fábulas', 'Casa rural', 'Prádena de Atienza', 'Guadalajara', 'https://www.sobrefabulas.com/', 'info@sobrefabulas.com', '696 90 19 57', '', 'contactado', '', null, null, '', 'El email está protegido con JavaScript (cloaking de Joomla): se ve en la web con JS activado.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra web sigue en 2019 (y sigue presumiendo de DVD)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@sobrefabulas.com', 'sobrefabulas.com', 'https://www.sobrefabulas.com/', 'Guadalajara', 'guzman', 'guzmangonzalezperez@gmail.com', 'Asados de cordero y cabrito en horno de leña, migas de pastor y truchas; baño y pesca en el río Pelagallinas; kit de bienvenida con café e infusiones.', 'media', false, 'seed', 'sobre-fabulas', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web sigue en 2019 (y sigue presumiendo de DVD)
Fallos: Pie sin actualizar: "Copyright © 2019 Sobre Fábulas" | Crédito de plugin visible bajo el formulario del boletín: "Constructor de formularios de Joomla by JoomlaShine" | Servicio anticuado destacado como reclamo: "TELEVISIÓN Y DVD" | Título de la pestaña empieza con un guion suelto: "- Casa Rural Sobre Fábulas | Prádena de Atienza"; errata "baño en el rio Pelagallinas"

Hola, equipo de Sobre Fábulas:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Asados de cordero y cabrito en horno de leña, migas de pastor y un baño en el Pelagallinas: con ese menú la Sierra Norte se vende sola.

Os escribo porque el pie de la web sigue en "Copyright © 2019", bajo el formulario del boletín aparece "Constructor de formularios de Joomla by JoomlaShine", entre los servicios destacáis "TELEVISIÓN Y DVD" y la pestaña del navegador empieza con un guion suelto: "- Casa Rural Sobre Fábulas".

¿Os preparo gratis una maqueta con los precios claros y el calendario de AvaiBook bien integrado, pensada para el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hostal Rural Santa Bárbara', 'Hostal rural con bar-restaurante', 'Solanillos del Extremo', 'Guadalajara', 'http://www.hostalruralsantabarbara.com/', 'santabarbarahostalrural@gmail.com', '949 810 172', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'El "Blog" y "Actividades" de vuestra web dan error 404', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'santabarbarahostalrural@gmail.com', 'hostalruralsantabarbara.com', 'http://www.hostalruralsantabarbara.com/', 'Guadalajara', 'guzman', 'guzmangonzalezperez@gmail.com', 'Diez habitaciones que "poseen nombres de lugares característicos de nuestra zona", torreznos en el bar, y un testimonio de un grupo de moteros que vuelve siempre a comer.', 'alta', false, 'seed', 'hostal-santa-barbara', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: El "Blog" y "Actividades" de vuestra web dan error 404
Fallos: Enlaces del menú rotos: "Blog" (/blog) y "Actividades" (/actividades-hostal-rural-santa-barbara/) dan error 404 | Certificado HTTPS que no es del dominio: https://www.hostalruralsantabarbara.com muestra el certificado de "dns74209.phdns13.es" y el navegador avisa | Pie sin actualizar: "© 2018 Hostal Rural Santa Barbara" y los enlaces "Aviso Legal" y "Mapa Web" apuntan a "#" | Erratas en El Hostal: "nuestro bar par que vayas cogiendo fuerzas" y "degustar nuestra especialidades"

Hola, equipo del Hostal Rural Santa Bárbara:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Que un grupo de moteros vuelva a comer cada vez que pasa por Solanillos dice mucho de vuestros torreznos, y lo de bautizar las diez habitaciones con lugares de la zona tiene mucho encanto.

Os escribo porque en el menú, "Blog" y "Actividades" llevan a páginas de error 404, si alguien entra por https el navegador avisa de que el certificado no es de vuestro dominio, el pie sigue en "© 2018" y en El Hostal pone "nuestro bar par que vayas cogiendo fuerzas".

¿Os preparo gratis una maqueta con la carta, las habitaciones y cómo llegar, todo fácil de ver desde el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Rural Molino de Castilpelayo', 'Casa rural (molino rehabilitado)', 'Hiendelaencina', 'Guadalajara', 'https://www.molinocastilpelayo.com/', 'molino@molinocastilpelayo.com', '676 48 98 08 / 949 82 41 17', '', 'contactado', '', null, null, '', 'El dueño aparece como "José, propietario" en Precios y Reservas; trato de tú.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Tu web se llama "Molino de Castilpelayo en blanco"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'molino@molinocastilpelayo.com', 'molinocastilpelayo.com', 'https://www.molinocastilpelayo.com/', 'Guadalajara', 'guzman', 'guzmangonzalezperez@gmail.com', 'Molino harinero del siglo XVII asentado sobre el desaparecido poblado de Castilpelayo, junto al río Bornova, con huerto ecológico, mini granja y excursión a la antigua fundición "La Constante".', 'media', false, 'seed', 'molino-castilpelayo', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Tu web se llama "Molino de Castilpelayo en blanco"
Fallos: Nombre del sitio sin terminar en cabecera y pestaña: "Casa Rural Molino de Castilpelayo en blanco" | Erratas en la portada: "EL Molino de Castilpelayo es un Casa Rural ÚNICA, ESPECIAL" | Web hecha con Google Sites con los enlaces del sistema a la vista ("Report abuse", "Page details", "Embedded Files") y sin reserva online: solo teléfono y WhatsApp

Hola, José:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Un molino harinero del siglo XVII levantado sobre el desaparecido poblado de Castilpelayo, junto al Bornova y con huerto ecológico y mini granja, es de esos sitios que la gente fotografía antes de bajarse del coche.

Te escribo porque la cabecera y la pestaña de la web dicen "Casa Rural Molino de Castilpelayo en blanco", en la portada pone "EL Molino de Castilpelayo es un Casa Rural ÚNICA" y, al ser un Google Sites, se ven abajo los enlaces de "Report abuse" y "Page details".

¿Te preparo gratis una maqueta con precios, calendario y reserva directa, para que no todo dependa del teléfono? Si no te gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Centro de Turismo Rural El Caminante', 'Albergue, hotel rural y restaurante', 'Santa Catalina de Somoza (Astorga)', 'León', 'http://www.elcaminante.es', 'elcaminante.ctr@gmail.com', '987 69 10 98', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Para entrar en vuestra web hay que "pulsar para entrar"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'elcaminante.ctr@gmail.com', 'elcaminante.es', 'http://www.elcaminante.es', 'León', 'guzman', null, '''El Balcón de la Maragatería'', en pleno Camino de Santiago; cocido maragato', 'media', false, 'seed', 'caminante', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Para entrar en vuestra web hay que "pulsar para entrar"
Fallos: Portada ''Pulsa para entrar'' y web con frames | No se adapta al móvil | Certificado https de otro dominio | Botón de Facebook en francés

Hola, equipo de El Caminante:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. "El Balcón de la Maragatería", en pleno Camino y con cocido maragato: si pasara por ahí, paraba seguro.

Pero la web tiene una portada de las de antes con "Pulsa para entrar", en el móvil se ve diminuta, el navegador avisa de que no es segura y el botón de Facebook está en francés ("Aimez-nous sur Facebook").

Con la de peregrinos que buscan albergue desde el móvil, ¿os preparo gratis una maqueta de la web nueva, en español e inglés? Si no os gusta, la borro sin más.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('La Casita de Leire', 'Casa rural', 'Muriel', 'Guadalajara', 'https://www.lacasitadeleire.es/', 'info@lacasitadeleire.com', '636 47 57 39', '', 'contactado', '', null, null, '', 'El dueño firma como Luis Olmeda; trato de tú. También aparece luisolmeda.g@gmail.com en el pie.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Tu web dice "Sierrra Norte" con tres erres', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@lacasitadeleire.com', 'lacasitadeleire.com', 'https://www.lacasitadeleire.es/', 'Guadalajara', 'guzman', 'guzmangonzalezperez@gmail.com', 'Casa de pizarra y piedra de más de 100 años en Muriel, restaurada en 2006, con el río Sorbe pegado a la casa y la ruta GR-10 pasando por la puerta.', 'alta', false, 'seed', 'casita-de-leire', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Tu web dice "Sierrra Norte" con tres erres
Fallos: No adaptada al móvil: no tiene <meta name="viewport"> | Erratas literales: "En la Sierrra Norte de Guadalajara", "3 habiaciones dobles", "avistamieto de aves", "la antigua escalera que da acesso" | Datos contradictorios: arriba hay "3 habiaciones dobles" y en Características "Ya en la segunda planta hay cuatro habitaciones" | Enlaces muertos en "Webs amigas": www.turismoguadalajara.es acaba en la página de un servidor de hosting ("Hosting Housing VPS Server") y www.fincarionegro.es no carga

Hola, Luis:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una casa de pizarra y piedra de más de cien años en Muriel, con el Sorbe pegado a la puerta y el GR-10 pasando por delante, es un plan redondo en cualquier estación.

Te escribo porque la web no está adaptada al móvil, en la descripción se lee "En la Sierrra Norte", "3 habiaciones dobles" (y más abajo "cuatro habitaciones" en la planta de arriba) y "avistamieto de aves", y en Webs amigas el enlace a www.turismoguadalajara.es acaba en la página de una empresa de hosting.

¿Te preparo gratis una maqueta con fotos grandes, calendario y reserva directa que se vea bien en el móvil? Si no te gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Recodo del Tajo', 'Casa rural', 'Driebes', 'Guadalajara', 'https://www.casarecododeltajo.com/', 'casarecododeltajo@gmail.com', '653 186 003 / 949 310 015', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'La pestaña de vuestra web se llama "http://www.casarecododeltajo.com"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'casarecododeltajo@gmail.com', 'casarecododeltajo.com', 'https://www.casarecododeltajo.com/', 'Guadalajara', 'guzman', 'guzmangonzalezperez@gmail.com', 'La casa fue "la casa del Guarda" de la vega Alóciga, rehabilitada a lo largo de tres generaciones, con parra, piscina y el Tajo ("el más castellano de todos", como dijo Cela) al lado.', 'media', false, 'seed', 'recodo-del-tajo', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: La pestaña de vuestra web se llama "http://www.casarecododeltajo.com"
Fallos: Título de la web sin poner: la pestaña y Google muestran literalmente "http://www.casarecododeltajo.com" | Erratas en la portada: "Casa Recodo del Tajo esta ubicada" y "relajaras tu vista bajo la parra y dejar que se pierda" | Errata en Precios: "Alquiler Integro de casa completa"; sin calendario ni reserva online, solo formulario | Email de empresa en Gmail

Hola, equipo de Casa Recodo del Tajo:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Que la antigua casa del guarda de la vega Alóciga siga en la familia tres generaciones después, ahora con parra, piscina y el Tajo de Cela al lado, es una historia preciosa.

Os escribo porque el título de la web, el que sale en Google y en la pestaña, es literalmente "http://www.casarecododeltajo.com"; en la portada pone "esta ubicada" y "relajaras tu vista bajo la parra y dejar que se pierda", y en Precios "Alquiler Integro".

¿Os preparo gratis una maqueta con fotos, precios, reserva directa y un buen cómo llegar por el camino de la vega? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Rural El Cebadal', 'Casa rural (turismo accesible)', 'Torremocha de Jadraque', 'Guadalajara', 'http://www.elcebadal.es/', 'cassanpa3@hotmail.com', '626 471 993', '', 'contactado', '', null, null, '', 'El pie dice "Creado con IONOS Editor Web by Esther Moreno Castilla"; puede ser la dueña, pero no está confirmado, así que uso "equipo".', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestras normas de la casa llevan "2014" en el nombre', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'cassanpa3@hotmail.com', 'elcebadal.es', 'http://www.elcebadal.es/', 'Guadalajara', 'guzman', 'guzmangonzalezperez@gmail.com', 'En tarifas dicen con total franqueza: "Si quieres pagar menos, te cierro alguna habitación." Y apuestan por el turismo rural familiar, senior y accesible.', 'media', false, 'seed', 'el-cebadal', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestras normas de la casa llevan "2014" en el nombre
Fallos: Documento de normas con nombre roto y fecha vieja visible como enlace: "normas$2Bregimen$2Binterno$2B2014.pdf" | Sin HTTPS: https://www.elcebadal.es da error de conexión segura; solo funciona por http | Email de empresa en Hotmail: "cassanpa3@hotmail.com" | Espacio antes de la coma en el lema de portada: "Turismo Familiar , Senior y Accesible"

Hola, equipo de El Cebadal:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Lo de "Si quieres pagar menos, te cierro alguna habitación" es la política de precios más honesta que he leído en una casa rural, y apostar por el turismo accesible en Torremocha de Jadraque tiene mucho mérito.

Os escribo porque el documento de normas aparece enlazado como "normas$2Bregimen$2Binterno$2B2014.pdf", la web no carga por https, el correo de contacto es "cassanpa3@hotmail.com" y en la portada se ha colado un "Turismo Familiar , Senior y Accesible".

¿Os preparo gratis una maqueta con las tarifas por temporada, el calendario y la reserva directa en una sola página? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Productos Silvestres Florencio Ramos', 'Setas y frutos silvestres (recolección y venta)', 'Navasfrías', 'Salamanca', 'http://productossilvestres.freetzi.com', 'productossilvestres@hotmail.com', '652 91 55 74 / 923 47 51 80', '', 'perdido', '', null, null, '', 'Rebote: la dirección no existe. Llamar al 652 91 55 74 / 923 47 51 80', false, '', true, 'Rebote: la dirección no existe. Llamar al 652 91 55 74 / 923 47 51 80', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Tu web sigue "En construcción" (y se ha colado una "colabororación")', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'productossilvestres@hotmail.com', 'freetzi.com', 'http://productossilvestres.freetzi.com', 'Salamanca', 'guzman', 'guzmangonzalezperez@gmail.com', 'Llevan desde 1986 vendiendo boletus, níscalos, zarzamoras y endrinas recogidos por lugareños de El Rebollar, "directamente del campo a su mesa".', 'alta', false, 'seed', 'florencio-ramos-navasfrias', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (rebote).
Asunto: Tu web sigue "En construcción" (y se ha colado una "colabororación")
Fallos: Alojada en hosting gratuito (freetzi / freewebhostingarea) que inyecta su script de anuncios pop.js | Sin HTTPS válido: el certificado es de *.eu5.org y no coincide con el dominio | Sin <meta name="viewport">, maquetada con tablas (plantilla Macromedia 2005) | Secciones Instalaciones y Recortes de prensa: "En construcción Disculpen las molestias" | Erratas literales: "colabororación", "relizada", "zonay así" | Contador de visitas tusestadisticas.com y email @hotmail

Hola, Florencio:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Llevar desde 1986 bajando boletus, níscalos y zarzamoras de El Rebollar "directamente del campo a su mesa" es de las mejores cartas de presentación que he leído en mucho tiempo.

Te escribo porque la web está en un hosting gratuito que mete su propio script de anuncios, no tiene HTTPS, no se adapta al móvil, Instalaciones y Recortes de prensa siguen con "En construcción Disculpen las molestias" y se han colado erratas como "colabororación" y "relizada".

¿Te preparo gratis una maqueta con el catálogo de setas por temporada y un botón para hacer el pedido desde el móvil? Si no te gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Obleas Pan de Ángel', 'Obrador de obleas artesanas', 'Cipérez', 'Salamanca', 'https://www.pandeangel.com', 'info@pandeangel.com', '923 518 079', '', 'contactado', '', null, null, '', 'Empresa familiar de unas 15 personas que ya vende en grandes superficies; la web no tiene tienda propia.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', '¿17.000 o 10.000 obleas por hora? (y se ha colado una "obrea")', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@pandeangel.com', 'pandeangel.com', 'https://www.pandeangel.com', 'Salamanca', 'guzman', 'guzmangonzalezperez@gmail.com', 'Cuatro generaciones de la familia Martín haciendo obleas desde hace 160 años; un médico del lugar decía: "El que un vaso de leche y una oblea toma al día, llega a los 100 sin pasar por la enfermería".', 'media', false, 'seed', 'pan-de-angel-ciperez', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: ¿17.000 o 10.000 obleas por hora? (y se ha colado una "obrea")
Fallos: Sin <meta name="viewport">: no adaptada al móvil | Errata en Empresa: "17.000 obreas por hora" | Contradicción: Empresa dice 17.000 obleas/hora y el pie "10.000 obleas cada hora", con errata "en los cúltimos años" | Portada: "Huevos pasteu- rizados" (palabra partida) | Premios citados de hace más de 20 años: "Master de Popularidad" 2000 y 2001, Premio Nacional de Empresas 1999

Hola, equipo de Pan de Ángel:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Lo del médico de Cipérez que decía que "el que un vaso de leche y una oblea toma al día, llega a los 100 sin pasar por la enfermería" debería ir impreso en cada caja.

Os escribo porque la web no está adaptada al móvil, en Empresa pone "17.000 obreas por hora" mientras el pie dice "10.000 obleas cada hora" y "en los cúltimos años", y en la portada los huevos salen "pasteu- rizados".

¿Os preparo gratis una maqueta con una tienda que funcione en el móvil para vender las obleas directamente? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Embutidos Pérez Malmierca', 'Chacinas / ibéricos y farinato', 'Ciudad Rodrigo', 'Salamanca', 'https://embutidosperezmalmierca.com', 'ind.car.perezmalmierca@hotmail.com', '923 480 992 / 636 223 671', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra portada se llama "pagina-ejemplo" (y hay un jamón "IBÉRICIO")', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'ind.car.perezmalmierca@hotmail.com', 'embutidosperezmalmierca.com', 'https://embutidosperezmalmierca.com', 'Salamanca', 'guzman', 'guzmangonzalezperez@gmail.com', 'Elaboran ibérico desde 1927, tres generaciones, con secaderos naturales y tienda en el Mercado de Abastos de Ciudad Rodrigo; tienen farinato ibérico.', 'alta', false, 'seed', 'perez-malmierca-ciudad-rodrigo', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra portada se llama "pagina-ejemplo" (y hay un jamón "IBÉRICIO")
Fallos: La portada es la "pagina-ejemplo" que crea WordPress por defecto (/pagina-ejemplo/) | Errata en la lista de precios: "JAMÓN BELLOTA IBÉRICIO" | Erratas en portada: "AGRANDES OFERTAS DE PRODUCTOS ESTE VERANO 2026", "Pude realizar su pedido", "desde del productor al consumidor" | "COMPRAR AQUÍ" es solo un formulario de contacto: no hay tienda | Email de empresa @hotmail

Hola, equipo de Embutidos Pérez Malmierca:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Casi cien años haciendo ibérico desde 1927, tres generaciones y puesto en el Mercado de Abastos de Ciudad Rodrigo: eso es farinato con pedigrí.

Os escribo porque la portada sigue siendo la "pagina-ejemplo" que crea WordPress por defecto, en la lista de precios aparece "JAMÓN BELLOTA IBÉRICIO", arriba pone "AGRANDES OFERTAS" y "Pude realizar su pedido", y "COMPRAR AQUÍ" es un formulario que acaba en un correo de @hotmail.

¿Os preparo gratis una maqueta con una tienda que funcione en el móvil para pedir jamón y farinato sin tener que escribir un email? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Posada Puerta Grande y Restaurante El Ruedo', 'Posada rural y restaurante', 'Candelario', 'Salamanca', 'http://www.posadapuertagrande.com', 'info@posadapuertagrande.com', '923 41 32 45 / 610 627 459', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra web pide instalar Flash para ver las fotos', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@posadapuertagrande.com', 'posadapuertagrande.com', 'http://www.posadapuertagrande.com', 'Salamanca', 'guzman', 'guzmangonzalezperez@gmail.com', 'Edificio del siglo XVIII que fue casa de chacinas; las cinco habitaciones se llaman "Tendidos", el restaurante El Ruedo y la tienda El Tentadero.', 'alta', false, 'seed', 'posada-puerta-grande-candelario', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web pide instalar Flash para ver las fotos
Fallos: Carrusel de fotos en Flash: en su lugar sale "Get the Flash Player to see this rotator" | "tARIFAS Y RESERVAS" (errata de mayúsculas) y no es un enlace; tampoco lo son ENTORNO, COMERCIO EL TENTADERO, OPINIONES ni Contacto | Sin <meta name="viewport">, maquetada con 8 tablas | https://www.posadapuertagrande.com da error de certificado (no cubre www) | Pie: "Todos los derechos reservados 2011"

Hola, equipo de la Posada Puerta Grande:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Dormir en una antigua casa de chacinas del siglo XVIII, en habitaciones que se llaman "Tendidos", y cenar en El Ruedo es salir por la puerta grande, sí.

Os escribo porque en la portada, en lugar del carrusel de fotos, sale "Get the Flash Player to see this rotator", el apartado "tARIFAS Y RESERVAS" no lleva a ninguna parte (igual que Entorno o El Tentadero), la web no se adapta al móvil y el pie sigue en "Todos los derechos reservados 2011".

¿Os preparo gratis una maqueta con reserva directa de los cinco Tendidos y la carta de El Ruedo, que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Clínica Dental Béjar', 'Clínica dental', 'Béjar', 'Salamanca', 'https://clinicadentalbejar.es', 'info@clinicadentalbejar.es', '923 40 30 44', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra web dice "más de 30 años" pero ya lleváis 44', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@clinicadentalbejar.es', 'clinicadentalbejar.es', 'https://clinicadentalbejar.es', 'Salamanca', 'guzman', 'guzmangonzalezperez@gmail.com', 'Abierta desde marzo de 1982 y dirigida por el Dr. Francisco Hernández Herrero; su filosofía: "El rigor científico y la calidad humana".', 'alta', false, 'seed', 'clinica-dental-bejar', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web dice "más de 30 años" pero ya lleváis 44
Fallos: Sin <meta name="viewport">: no adaptada al móvil | Pie: "Copyright © 2012 Clínica Dental Béjar" | Portada: "Más de 30 años de experiencia" cuando abrió en marzo de 1982 (ya son 44) | Erratas: "micoorganismos" (Preguntas frecuentes) y "Dos esterilizador por calor" (Clínica) | URLs con tildes (/clínica/, /información/) y jQuery UI 1.8.16

Hola, equipo de Clínica Dental Béjar:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Abrir en marzo de 1982 y seguir en la calle Colón con "el rigor científico y la calidad humana" por bandera tiene más mérito que una ortodoncia bien hecha.

Os escribo porque la web no se adapta al móvil, el pie sigue en "Copyright © 2012", en la portada pone "Más de 30 años de experiencia" cuando ya van 44, y por dentro se han colado "micoorganismos" y "Dos esterilizador por calor".

¿Os preparo gratis una maqueta con un botón para pedir cita desde el móvil y cómo llegar a la consulta? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Quesos García Calvo', 'Quesería artesana (oveja, leche cruda)', 'Vilvestre', 'Salamanca', 'https://www.quesosgarciacalvo.es', 'quesosgarciacalvo@hotmail.com', '923 52 46 82', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestro queso en aceite sale "embasado" con b', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'quesosgarciacalvo@hotmail.com', 'quesosgarciacalvo.es', 'https://www.quesosgarciacalvo.es', 'Salamanca', 'guzman', 'guzmangonzalezperez@gmail.com', 'El maestro quesero Juan García Gorjón aprendió el oficio en el País Vasco y volvió a Vilvestre a fundar la quesería en 1992; tienen queso curado en aceite de oliva y requesón.', 'alta', false, 'seed', 'quesos-garcia-calvo-vilvestre', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestro queso en aceite sale "embasado" con b
Fallos: Sin <meta name="viewport">: no adaptada al móvil | Erratas: "curado embasado en aceite de oliva", "zona no con poca tradicón quesera", "ebulliciónaparece", "eletrónicos", "corazon" | Las fotos de la galería son capturas llamadas "imagen 2014-01-30 a la(s) 10.18.15.png" | Datos caducados: "Ocho años bajo la Marca de Garantía", "desde 2009" | Email de empresa @hotmail (solo aparece en Nuestra Empresa)

Hola, equipo de Quesos García Calvo:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Que Juan aprendiera el oficio en el País Vasco y volviera a Vilvestre a fundar la quesería en 1992 es de esas historias que hacen que el queso sepa todavía mejor.

Os escribo porque la web no se adapta al móvil, el curado aparece "embasado en aceite de oliva", se han colado "tradicón quesera" y "ebulliciónaparece", las fotos de la galería se llaman "imagen 2014-01-30 a la(s) 10.18.15.png" y el contacto es un @hotmail.

¿Os preparo gratis una maqueta con una tienda que funcione en el móvil para pedir queso y requesón directamente? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Joyería Méndez Vieira', 'Taller de joyería y filigrana charra', 'La Alberca', 'Salamanca', 'https://www.artesaniamendezlaalberca.es', 'joyeria@artesaniamendezlaalberca.es', '923 415 387 / 687 723 547', '', 'contactado', '', null, null, '', 'Ya tiene tienda online y viewport; el gancho son las erratas, no el diseño.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'En vuestra web el fundador se apellida "Méndes"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'joyeria@artesaniamendezlaalberca.es', 'artesaniamendezlaalberca.es', 'https://www.artesaniamendezlaalberca.es', 'Salamanca', 'guzman', 'guzmangonzalezperez@gmail.com', 'En 1928 José María Méndez abrió su primer obrador en Tamames; hoy sus nietos siguen con la filigrana charra y alquilan trajes albercanos. Tienen hasta un "Dedómetro" recortable en PDF para medirse el anillo.', 'media', false, 'seed', 'joyeria-mendez-la-alberca', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestra web el fundador se apellida "Méndes"
Fallos: Título de la página Legado: "Joyería artasana Méndez Vieira" | En Legado: "José María Méndes" (el fundador es Méndez), "Relicarios antiguosz", "mateniendo la tradición" | Portada: "la más arragida tradición joyera" | Aviso de cookies: "mostrale publicidad" y "Puede obtener más informació leyendo" | Textos alternativos con "Joyas tradiconales" y "Joyas tradionales"

Hola, equipo de Joyería Méndez:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Que todo empezara en 1928 con José María Méndez abriendo obrador en Tamames y que hoy sus nietos sigan con la filigrana charra en La Alberca es oro de ley, nunca mejor dicho.

Os escribo porque en la página Legado pone "Joyería artasana", "José María Méndes", "Relicarios antiguosz" y "mateniendo la tradición", en la portada habla de "la más arragida tradición joyera" y el aviso de cookies dice "mostrale publicidad".

¿Os preparo gratis una maqueta de la tienda online, más limpia y cómoda de usar desde el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Mesón Asador Valderrey', 'Restaurante asador', 'Tordesillas', 'Valladolid', 'http://www.mesonvalderrey.com', 'mesonvalderrey@gmail.com', '983 771 172 / 609 039 188', 'Carlos Deza', 'maqueta_enviada', 'Web completa', 490, 'fijo', 'Pedir el enlace de su carta', 'Carlos Deza (dueño) contestó: quiere que la web use su carta de Gourmeats (gourmeatsapp.com). Le pedimos el enlace el 6 oct, sin respuesta. Maqueta hecha el 7 oct con contenido de su web y carta.pdf. · Maqueta hecha el 7 oct.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra web sigue anunciando el Día de la Madre de 2018', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'mesonvalderrey@gmail.com', 'mesonvalderrey.com', 'http://www.mesonvalderrey.com', 'Valladolid', 'guzman', 'guzmangonzalezperez@gmail.com', 'Abierto el 8 de junio de 1984 por la familia Valderrey Pérez; en la web citan a Rocío Jurado ("Me encantan los cangrejos de Rio del Valderrey") y a Bertín Osborne ("Yo quiero un par de huevos fritos").', 'alta', false, 'seed', 'meson-valderrey-tordesillas', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (pipeline).
Asunto: Vuestra web sigue anunciando el Día de la Madre de 2018
Fallos: Sin <meta name="viewport">: no adaptada al móvil | Eventos desfasados: lo último es "MENU DIA DE LA MADRE 06/05/2018"; también "Menú San Valentín 14/02/2014" | Sello "Recomendado en Salir.com - MAY 2013" | Errata y dato viejo: "En en el trayecto de casi 30 años" (abrieron en 1984) y "Exmo. Sr. Alcalde" | Mapa con la API antigua de Google Maps (maps/api/js?sensor=false, sin clave) y Google Analytics Universal (UA-), ya retirado

Hola, equipo del Mesón Valderrey:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Cualquier asador presume de lechazo, pero tener a Rocío Jurado diciendo "Me encantan los cangrejos de Rio del Valderrey" y a Bertín Osborne pidiendo "un par de huevos fritos" es jugar en otra liga.

Os escribo porque en Eventos lo más reciente es el "MENU DIA DE LA MADRE 06/05/2018" (y el San Valentín de 2014), la web no se adapta al móvil, sigue el sello "Recomendado en Salir.com - MAY 2013" y en la historia se lee "En en el trayecto de casi 30 años", cuando ya vais por 42.

¿Os preparo gratis una maqueta con la carta, reserva de mesa desde el móvil y cómo llegar? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Bodegas Rueda Pérez S.A.T.', 'Bodega familiar (D.O. Rueda)', 'Pozaldez', 'Valladolid', 'http://www.bodegasruedaperez.es', 'satruedaperez@terra.com', '983 822 049', '', 'perdido', '', null, null, '', 'Email rebotó (el dominio terra.com ya no recibe correo).', false, '', true, 'Email rebotó (el dominio terra.com ya no recibe correo).', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra web es de 2003 y lo dice ella misma', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'satruedaperez@terra.com', 'terra.com', 'http://www.bodegasruedaperez.es', 'Valladolid', 'guzman', 'guzmangonzalezperez@gmail.com', 'Bodega familiar en Pozaldez con viñedo propio de verdejo y tempranillo en Pozaldez y Rueda; su Jose Galo verdejo tiene "una gran frescura y fructuosidad difícil de olvidar".', 'alta', false, 'seed', 'bodegas-rueda-perez-pozaldez', '2026-10-09T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (rebote).
Asunto: Vuestra web es de 2003 y lo dice ella misma
Fallos: Al hacer clic derecho salta un alert: "Bienvenidos a Bodegas Rueda Pérez S.A.T. Versión 1.1 © S.A.T. Rueda Pérez 2003" | Web con frames (frameset) y tablas, sin <meta name="viewport"> | Erratas en la ficha del Jose Galo: "presentandoo", "Grado Alcolóhico" y un "quesos./p>" visible | Inconsistencia: la página se llama pagos_valdecobo pero el vino aparece como "VALDELCOBO" | Email de empresa @terra.com

Hola, equipo de Bodegas Rueda Pérez:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una bodega familiar en Pozaldez, con viñedo propio de verdejo y un Jose Galo de "una gran frescura y fructuosidad difícil de olvidar": así da gusto leer una ficha de cata.

Os escribo porque al hacer clic derecho salta un aviso de "Versión 1.1 © S.A.T. Rueda Pérez 2003", la web va con marcos y no se adapta al móvil, en la ficha del Jose Galo se han colado "presentandoo", "Grado Alcolóhico" y un "/p>" suelto, y el contacto es un correo de @terra.com.

¿Os preparo gratis una maqueta con vuestros vinos y un botón para pedirlos desde el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-09T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Rural Las Ducas', 'Casa rural', 'Villavieja del Cerro (Tordesillas)', 'Valladolid', 'http://www.casarurallasducas.es', 'lasducas@casarurallasducas.es', '665 40 21 67 / 983 79 23 18', '', 'contactado', '', null, null, '', 'Aristónico Silvano Negro Diez figura como autor de la web; probablemente el dueño o un familiar. Hay otro email (arisnegro@gmail.com) en Opiniones.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'El calendario de Las Ducas se quedó en junio de 2019', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'lasducas@casarurallasducas.es', 'casarurallasducas.es', 'http://www.casarurallasducas.es', 'Valladolid', 'guzman', 'guzmangonzalezperez@gmail.com', 'Casa a los pies del Cerro de San Juan con bodega-merendero con fuego bajo; la web y el calendario los programó el propio Aristónico (script fechado el 13-03-2009).', 'alta', false, 'seed', 'casa-rural-las-ducas', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: El calendario de Las Ducas se quedó en junio de 2019
Fallos: El calendario de días ocupados (reservas.xml) termina el 30/06/2019 | "Cómo llegar" carga la API v2 de Google Maps (maps?file=api&v=2), retirada hace años | Sin <meta name="viewport">, maquetada con tablas | Erratas: "las ultimas estivaciones" (estribaciones) y "Painball" | Texto caducado: "muy pronto se podrá practicar esquí en ''Meseta del Ski''"; Opiniones depende de Toprural

Hola, Aristónico:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una casa a los pies del Cerro de San Juan con bodega-merendero y fuego bajo, y encima con la web y el calendario programados por ti mismo: eso tiene mucho mérito.

Te escribo porque el calendario de días ocupados no se actualiza desde el 30/06/2019, el mapa de Cómo llegar usa una versión de Google Maps que ya no funciona, la web no se adapta al móvil y se han colado "las ultimas estivaciones" y "Painball" (y el esquí en Meseta Ski sigue "muy pronto").

¿Te preparo gratis una maqueta con reserva directa y un calendario fácil de actualizar, que funcione en el móvil? Si no te gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Restaurante Bodegón El Ciervo', 'Restaurante (lechazo y carne a la piedra)', 'Cabezón de Pisuerga', 'Valladolid', 'https://bodegonelciervo.com', 'restaurantebodegonelciervo@hotmail.com', '983 50 01 56 / 687 46 19 59', '', 'contactado', '', null, null, '', 'La web parece montada en junio de 2026 (uploads/2026/06), pero está rota: solo funciona la portada.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'En vuestra web pone "Just another WordPress site"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'restaurantebodegonelciervo@hotmail.com', 'bodegonelciervo.com', 'https://bodegonelciervo.com', 'Valladolid', 'guzman', 'guzmangonzalezperez@gmail.com', 'Lechazo asado en horno de leña con "piel dorada y crujiente" y carne a la piedra volcánica que cada comensal termina a su gusto.', 'alta', false, 'seed', 'bodegon-el-ciervo-cabezon', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestra web pone "Just another WordPress site"
Fallos: Título de la web: "Bodegonelciervo | Just another WordPress site" | Todos los enlaces interiores (/about-us/, /our-menu/, /contact-us/, /aviso-legal/) dan 404 con una página de aparcamiento de IONOS | Carta en PDF con el nombre por defecto de Canva: "Diseno-sin-titulo-1-1.pdf" | Email de empresa @hotmail

Hola, equipo del Bodegón El Ciervo:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Lechazo en horno de leña y carne a la piedra volcánica en Cabezón de Pisuerga: con eso ya tenéis media reserva hecha.

Os escribo porque el título de la web sigue siendo "Just another WordPress site", los enlaces del menú (Sobre nosotros, Carta, Contacto y hasta el Aviso legal) dan error 404 y acaban en una página de aparcamiento de IONOS, la carta es un PDF llamado "Diseno-sin-titulo-1-1.pdf" y el correo es de @hotmail.

¿Os preparo gratis una maqueta con la carta visible en el móvil, reserva de mesa y cómo llegar? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Carlos Jimeno · Cerámica y Patrimonio', 'Artesano ceramista', 'Cabezón de Pisuerga', 'Valladolid', 'https://carlosjimeno.es', 'carjimeno@hotmail.com', '696 582 402', '', 'perdido', '', null, null, '', 'Contestó 5 oct: no le interesa, se está jubilando. No volver a escribir.', true, 'Contestó 5 oct: no le interesa, se está jubilando. No volver a escribir.', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Tu web mide 1.152 píxeles de ancho y el móvil no llega a 400', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'carjimeno@hotmail.com', 'carlosjimeno.es', 'https://carlosjimeno.es', 'Valladolid', 'guzman', 'guzmangonzalezperez@gmail.com', 'Reproduce cerámica vaccea y ha recreado una ''Trompa de guerra celtibérica'' con bocina en forma de cabeza de lobo para el Centro de Interpretación del Lobo Ibérico de Robledo de Sanabria; de niño veía el obrador de su padre hacer rosquillas de palo.', 'media', false, 'seed', 'carlos-jimeno-ceramica', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (no_contactar).
Asunto: Tu web mide 1.152 píxeles de ancho y el móvil no llega a 400
Fallos: Sin <meta name="viewport">: no adaptada al móvil | Maquetada en una tabla de ancho fijo width="1152" | Los textos del menú (Reproducciones, Paneles, Serigrafía, Usos, Cursos, Contacto) son imágenes .jpg en lugar de texto | Único contacto: enlace mailto a @hotmail, sin formulario

Hola, Carlos:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Recrear en cerámica una trompa de guerra celtibérica con cabeza de lobo para el Centro del Lobo Ibérico es de esos encargos que no le salen a cualquiera.

Te escribo porque la web está maquetada en una tabla de 1.152 píxeles de ancho fijo y no se adapta al móvil, los textos del menú (Reproducciones, Paneles, Serigrafía, Cursos...) son imágenes en vez de texto y el único contacto es un enlace a un correo de @hotmail.

¿Te preparo gratis una maqueta con tus últimos trabajos y un formulario para reservar visitas y cursos en el taller? Si no te gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Librería Alcaraván', 'Librería (Villa del Libro)', 'Urueña', 'Valladolid', 'http://www.alcaravan.com', 'libros@alcaravan.com', '983 717 018', 'Jesús Martínez', 'ganado', 'Web informativa de una página', 290, 'fijo', 'Confirmar horario y dominio y publicar la web', 'CERRADO: web informativa sin venta por 290 €. Factura F260046 del primer pago; Jesús envió el 8 oct el justificante de la transferencia (175,45 €). No tiene fotos: vale la maqueta. El 9 oct le pedimos confirmar el horario y quién gestiona el dominio alcaravan.com. · Primer pago cobrado. Dos versiones de web enviadas para elegir.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra web entera cabe en una tarjeta de visita', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'libros@alcaravan.com', 'alcaravan.com', 'http://www.alcaravan.com', 'Valladolid', 'guzman', 'guzmangonzalezperez@gmail.com', 'Librería en el Corro de San Andrés nº 13 de Urueña; la web solo tiene nombre, logo y dirección.', 'media', false, 'seed', 'libreria-alcaravan-uruena', '2026-10-09T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (pipeline).
Asunto: Vuestra web entera cabe en una tarjeta de visita
Fallos: Toda la web es una sola tabla de width="740" con logo, dirección y teléfono | Sin <meta name="viewport"> y sin etiquetas <html> ni <body> | Sin catálogo, horario ni cómo llegar | Logo cargado por http:// (logo2.gif)

Hola, equipo de la Librería Alcaraván:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Tener la librería en el Corro de San Andrés de Urueña y llamarla como un pájaro de páramo tiene mucha poesía.

Os escribo porque la web es solo una tabla de 740 píxeles con el logo, la dirección y el teléfono: no se adapta al móvil y no hay forma de ver qué libros tenéis ni cuándo abrís.

¿Os preparo gratis una maqueta con un catálogo sencillo, el horario y cómo llegar? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-09T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Rural de La Condesa', 'Casa rural', 'El Redal (Valle de Ocón)', 'La Rioja', 'https://www.casaruraldelacondesa.com/', 'reservas@casaruraldelacondesa.com', '609 466 509 / 941 438 041', '', 'contactado', '', null, null, '', 'Los posts del blog los firma María Solano; la web no deja claro si es la dueña, por eso el saludo va al equipo.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'En vuestra web pone hello@youremail.com (y "Welcome to Resort")', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'reservas@casaruraldelacondesa.com', 'casaruraldelacondesa.com', 'https://www.casaruraldelacondesa.com/', 'La Rioja', 'guzman', 'guzmangonzalezperez@gmail.com', 'Casa rural de 5 estrellas en la casa familiar de El Redal; cada habitación lleva el nombre de un personaje (I Marqués del Socorro, I Condesa del Carpio, General Solano...).', 'alta', false, 'seed', 'casa-condesa-elredal', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestra web pone hello@youremail.com (y "Welcome to Resort")
Fallos: Datos de plantilla sin cambiar en la cabecera: "hello@youremail.com" y "+1234567890" | Texto de relleno de la plantilla en portada: "Welcome to Resort" y "Edolor sit amet, consectetur, adipis civelit..." | Botones en inglés de la plantilla: "details" en cada habitación y "Read All News" en el blog | Errata: "Reglamento Gereral de Turismo de La Rioja"

Hola, equipo de Casa de la Condesa:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Lo de poner a cada habitación el nombre de un personaje, del Marqués del Socorro a la Condesa del Carpio, es un detalle precioso: dormir en El Redal con título nobiliario incluido.

Os escribo porque en la cabecera de vuestra web siguen los datos de la plantilla, "hello@youremail.com" y "+1234567890", justo encima de "Welcome to Resort" y de un texto de relleno ("Edolor sit amet, consectetur..."). Además, los botones de las habitaciones dicen "details", el del blog "Read All News" y en la presentación se ha colado un "Reglamento Gereral de Turismo".

¿Os preparo gratis una maqueta con vuestros textos de verdad y reserva directa que funcione bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('El Pajar de Javi', 'Casa rural', 'Camprovín (cerca de Nájera)', 'La Rioja', 'http://www.elpajardejavi.es/', 'elpajardejavi@gmail.com', '629 946 131 / 941 363 285', '', 'contactado', '', null, null, '', 'Mismo dueño que el apartamento El Rincón de Inma (web caída).', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'En vuestra web la casa tiene "dorma" y una "chimea barbacoa"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'elpajardejavi@gmail.com', 'elpajardejavi.es', 'http://www.elpajardejavi.es/', 'La Rioja', 'guzman', 'guzmangonzalezperez@gmail.com', 'Edificio levantado sobre antiguos pajares con muros de piedra, junto a la iglesia, con un salón-comedor de más de 60 m2 con asador de parrilla; ofrecen visita guiada a una bodega.', 'alta', false, 'seed', 'pajar-javi-camprovin', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestra web la casa tiene "dorma" y una "chimea barbacoa"
Fallos: Erratas en la página de la casa: "dan dorma a un edificio", "chimea barbacoa", "esplendidas vistas" | Los botones "Más información" de la portada llevan a room.html y rooms-list.html, que dan error 404 (nombres de la plantilla) | El enlace a su apartamento "El Rincón de Inma" apunta a elrincondeinma.es, dominio que ya no resuelve | Sin HTTPS (la versión https no conecta) y pie "Copyright 2018"

Hola, equipo de El Pajar de Javi:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Un salón-comedor de más de 60 m2 con asador de parrilla dentro de unos antiguos pajares de piedra es, básicamente, el sueño de cualquier cuadrilla con hambre.

Os escribo porque en la página de la casa pone que los muros "dan dorma" al edificio y que el patio tiene "chimea barbacoa". Además, los botones "Más información" de la portada llevan a páginas que no existen (error 404), el enlace a El Rincón de Inma apunta a un dominio que ya no funciona y el pie sigue en "Copyright 2018".

¿Os preparo gratis una maqueta con reserva directa, fotos grandes y que se vea bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Bodega Beleluin', 'Bodega familiar', 'Alcanadre', 'La Rioja', 'https://www.beleluin.com/', 'bodega@beleluin.com', '601 350 347', '', 'contactado', '', null, null, '', 'El spam de casinos no se ve a simple vista (está oculto), pero está en el HTML; conviene decirlo con tacto.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra web esconde anuncios de tragaperras (y no son vuestros)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'bodega@beleluin.com', 'beleluin.com', 'https://www.beleluin.com/', 'La Rioja', 'guzman', 'guzmangonzalezperez@gmail.com', 'BELELUIN es el acrónimo de cuatro hermanas (Belinda, Elena, Luisa e Inmaculada), unidas desde 2009; 35 hectáreas de viñedo propio en Alcanadre.', 'alta', false, 'seed', 'bodega-beleluin-alcanadre', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web esconde anuncios de tragaperras (y no son vuestros)
Fallos: Web hackeada: bloque oculto (display:none) en la portada con enlaces de casinos: "Juegos nuevos de tragamonedas gratis sin descargar.", "Slots Bono Sin Deposito España 2026 Únete Hoy" | WordPress 4.6.29 y WooCommerce 2.5.5 (versiones de 2016) y pie "Copyright 2016 BELELUIN" | Erratas: "barricas 100% de roble frances" y "vinos aromáticos, Bien estructurados"

Hola, Belinda, Elena, Luisa e Inmaculada:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Que el nombre de la bodega sea el acrónimo de cuatro hermanas me parece de lo más bonito que he visto en Rioja: es difícil meter más familia en una etiqueta.

Os escribo porque en el código de vuestra portada hay un bloque oculto con enlaces a casinos ("Juegos nuevos de tragamonedas gratis sin descargar.", "Slots Bono Sin Deposito España 2026"...), algo típico cuando una web lleva años sin actualizar y la han hackeado: vosotras no lo veis, pero Google sí. La web va con WordPress 4.6, el pie sigue en "Copyright 2016" y en los vinos se cuelan un "roble frances" y un "Bien estructurados" con mayúscula.

¿Os preparo gratis una maqueta limpia, con tienda que funcione en el móvil y reserva de visitas a la bodega? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Embutidos Don Hilarión', 'Embutidos / tienda de producto local', 'Haro', 'La Rioja', 'https://www.donhilarion.com/', 'info@donhilarion.com', '941 31 08 38', '', 'contactado', '', null, null, '', 'Ojo al citar el pie: el texto real lleva llaves, {current_year}; en el email lo he descrito sin llaves para que no choque con los marcadores de la plantilla de envío.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'En vuestra web el año todavía es "current_year"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@donhilarion.com', 'donhilarion.com', 'https://www.donhilarion.com/', 'La Rioja', 'guzman', 'guzmangonzalezperez@gmail.com', 'Empresa familiar: Hilario Calvo Martínez abrió en 1968 una pequeña fábrica artesanal donde se hacía todo, desde la matanza al curado tradicional.', 'media', false, 'seed', 'don-hilarion-haro', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestra web el año todavía es "current_year"
Fallos: En el pie de todas las páginas aparece el código de la plantilla en vez del año: "Embutidos Don Hilarión © {current_year}" | La portada solo dice "¡Bienvenido! ¿Quieres conocer nuestros productos? Vamos", sin más contenido | El catálogo ofrece "Ordenar por precio: bajo a alto" pero ningún producto muestra precio | Contadores duplicados en el catálogo: "Chorizos 4 4 productos"

Hola, equipo de Embutidos Don Hilarión:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Que Hilario Calvo abriera en 1968 una pequeña fábrica donde se hacía todo, de la matanza al curado, explica muy bien por qué uno sale de Haro con la mochila oliendo a chorizo.

Os escribo porque en el pie de todas las páginas, donde debería ir el año, aparece el código de la plantilla ("Embutidos Don Hilarión ©" seguido de "current_year" entre llaves). La portada se queda en un "¡Bienvenido! ¿Quieres conocer nuestros productos? Vamos" sin nada más, y en el catálogo se puede "Ordenar por precio: bajo a alto" aunque ningún producto tiene precio.

¿Os preparo gratis una maqueta con una tienda sencilla que funcione en el móvil para pedir chorizo desde cualquier sitio? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Despensa Pisón', 'Tienda de producto local / asados y embutidos', 'Ezcaray', 'La Rioja', 'https://despensapison.com/', 'info@despensapison.com', '941 354 332', '', 'contactado', '', null, null, '', 'Web relativamente cuidada (WooCommerce con envíos); el gancho principal es el móvil.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestras ovejas tienen hotel de lujo, pero la tienda no está adaptada al móvil', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@despensapison.com', 'despensapison.com', 'https://despensapison.com/', 'La Rioja', 'guzman', 'guzmangonzalezperez@gmail.com', 'Desde 1979 en Ezcaray; su granja está "convertida en un hotel rural de lujo" para el ganado y crían los corderos en el Valle de Oja; venden la morcilla de Ezcaray.', 'media', false, 'seed', 'despensa-pison-ezcaray', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestras ovejas tienen hotel de lujo, pero la tienda no está adaptada al móvil
Fallos: La tienda online no tiene la etiqueta <meta name="viewport">: en el móvil se carga como la versión de ordenador | Texto en inglés de la plantilla en portada: "Best sellers, best recommended" | Erratas: "llevamos desde 1979 recibiendote" y "un hotel rural de lujo para nuestros ganado" | Las tres opiniones destacadas son de la misma "Almudena G." con la etiqueta "Propietario verificado"

Hola, equipo de Despensa Pisón:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Llevar desde 1979 en Ezcaray y tener una granja "convertida en un hotel rural de lujo" para el ganado es el tipo de detalle que hace que uno quiera probar la morcilla sin pensarlo.

Os escribo porque la tienda online no lleva la etiqueta que la adapta al móvil (meta viewport), así que en el teléfono se carga como la versión de ordenador. Además, en la portada aparece en inglés "Best sellers, best recommended" y la frase de la granja dice "para nuestros ganado".

¿Os preparo gratis una maqueta de la tienda pensada para comprar desde el móvil en dos toques? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Rural La Cigüeña (y La Alameda Riojana)', 'Casa rural', 'Uruñuela (cerca de Nájera)', 'La Rioja', 'http://www.casarurallaciguena.com/', 'info@casarurallaciguena.com', '616 16 45 51', '', 'contactado', '', null, null, '', 'La web carga de forma intermitente (alguna subpágina dio timeout y a la segunda cargó). El email es el mismo para las dos casas.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestro logo sigue en Flash (y Flash murió en 2020)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@casarurallaciguena.com', 'casarurallaciguena.com', 'http://www.casarurallaciguena.com/', 'La Rioja', 'guzman', 'guzmangonzalezperez@gmail.com', 'Casa de labranza de piedra y madera de alrededor de 1800, reformada en 2008; los mismos dueños tienen La Alameda Riojana, casa grande para 20 personas en Uruñuela.', 'alta', false, 'seed', 'la-ciguena-urunuela', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestro logo sigue en Flash (y Flash murió en 2020)
Fallos: Sin <meta name="viewport"> (no adaptada al móvil) y maquetada con tablas (6 en la portada) | El logo es un archivo Flash: "images/logo_animado.swf" | Erratas: "Sus 250 metros están distribuidos entres plantas", "Desde el se accede a un hermoso patio" y en tarifas "TODOS LOS PRECIOS TIENE INCLUIDO EL I.V.A." | Imagen de cabecera llamada "header2 - copia.jpg"; su otra casa (alamedariojana.com) va con WordPress 4.9.26

Hola, equipo de La Cigüeña y La Alameda Riojana:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una casa de labranza de piedra y madera de alrededor de 1800, en Uruñuela y rodeada de viñas, tiene más historia que muchas bodegas de la zona.

Os escribo porque la web de La Cigüeña sigue montada con tablas, no se adapta al móvil y el logo es un archivo Flash ("logo_animado.swf") que ningún navegador actual muestra. En los textos se cuelan un "distribuidos entres plantas", un "Desde el se accede" y, en tarifas, "TODOS LOS PRECIOS TIENE INCLUIDO EL I.V.A."; hasta una imagen de cabecera se llama "header2 - copia.jpg".

¿Os preparo gratis una maqueta con las dos casas juntas, reserva directa y que funcione bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Rural Mirizabal', 'Casa rural', 'Echagüe, Valdorba (entre Tafalla y Pamplona)', 'Navarra', 'http://www.casamirizabal.com/', 'info@casamirizabal.com', '948 312 988 / 686 207 365', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra casa tiene "patrimonionio" románico (y wifi desde 2013)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@casamirizabal.com', 'casamirizabal.com', 'http://www.casamirizabal.com/', 'Navarra', 'guzman', 'guzmangonzalezperez@gmail.com', 'Casa de piedra restaurada en 2004 en Echagüe; ofrecen un embotellado especial de vino para los clientes de la casa.', 'alta', false, 'seed', 'casa-mirizabal-echague', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra casa tiene "patrimonionio" románico (y wifi desde 2013)
Fallos: Sin HTTPS (la versión https da error de certificado/conexión) y sin <meta name="viewport"> | Los tres botones "Ver más" de la portada (/equipamiento/, /entorno/, /actividades/) dan 404: "Disculpa, lo que estás buscando no está aquí." | Erratas: "un valioso patrimonionio románico", "planta baja y primero piso", "Tambien atractivos culturales" | Contenido desfasado: "TV , DVD , Video" y "Desde el verano de 2013 disponemos de conexión Wi-Fi gratuita"; WordPress 4.7 (2017)

Hola, equipo de Casa Mirizabal:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Lo del embotellado especial de vino para los clientes de la casa me parece un detalle de diez: pocas casas rurales mandan a sus huéspedes de vuelta con su propia botella.

Os escribo porque en la portada se habla de "un valioso patrimonionio románico" y los tres botones "Ver más" llevan a una página que dice "Disculpa, lo que estás buscando no está aquí.". Además, la web no tiene versión segura (https), no se adapta al móvil y en el equipamiento todavía se presume de "TV, DVD, Video" y de que "Desde el verano de 2013 disponemos de conexión Wi-Fi".

¿Os preparo gratis una maqueta con disponibilidad, reserva directa y cómo llegar a Echagüe desde Olite o Pamplona? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Nueces de Navarra', 'Productor agrícola / venta directa', 'Riezu, Valle de Yerri (cerca de Estella)', 'Navarra', 'http://www.nuecesdenavarra.com/', 'nuecesdenavarra@hotmail.es', '636 379 261 (WhatsApp)', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra web "se compremete" con las nueces (y le falta un teléfono)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'nuecesdenavarra@hotmail.es', 'nuecesdenavarra.com', 'http://www.nuecesdenavarra.com/', 'Navarra', 'guzman', 'guzmangonzalezperez@gmail.com', '10 hectáreas de nogales en Riezu plantados sucesivamente desde 1996; envasan las nueces en la propia explotación y dicen ser el mayor productor de la zona.', 'alta', false, 'seed', 'nueces-navarra-riezu', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web "se compremete" con las nueces (y le falta un teléfono)
Fallos: Sin HTTPS (la versión https no conecta) y sin <meta name="viewport"> (IONOS MyWebsite antiguo) | Erratas: "NUECES DE NAVARRA se compremete a ofrecer" y "aninoácidos esenciales" | En contacto pone "llamándonos al teléfono" y el número no aparece (solo el de WhatsApp) | Contador antiguo en el pie: "Ud. es el visitante:"; email de empresa en @hotmail.es

Hola, equipo de Nueces de Navarra:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Diez hectáreas de nogales en Riezu plantados poco a poco desde 1996 y envasados en la propia finca: eso sí es kilómetro cero, y además con cáscara.

Os escribo porque en la portada pone que la empresa "se compremete" a ofrecer una nuez de alta calidad, en los beneficios para la salud se ha colado "aninoácidos" y en contacto dice "llamándonos al teléfono" pero el número no aparece. Además, la web no tiene versión segura (https), no está adaptada al móvil y en el pie sigue un contador de "Ud. es el visitante:".

¿Os preparo gratis una maqueta con una tienda sencilla para pedir nueces desde el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hostal Trinkete Antxitonea', 'Hostal / alojamiento', 'Elizondo (Valle de Baztán)', 'Navarra', 'https://www.antxitonea.com/', 'hostal@antxitonea.com', '948 581 807', '', 'contactado', '', null, null, '', 'Comparte propiedad con el Hotel Trinkete (hoteltrinkete.com, web más nueva).', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'En vuestras tarifas hay "Tempora alta" (y un "checking")', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'hostal@antxitonea.com', 'antxitonea.com', 'https://www.antxitonea.com/', 'Navarra', 'guzman', 'guzmangonzalezperez@gmail.com', 'Antigua casona del siglo XIX rehabilitada, a orillas del río Baztan, en el barrio de Txokoto; 12% de descuento reservando en su web.', 'media', false, 'seed', 'antxitonea-elizondo', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestras tarifas hay "Tempora alta" (y un "checking")
Fallos: Erratas en tarifas: "Tempora alta: 1 de julio – 15 de septiembre" y "en el momento de hacer el checking" | Errata en portada: "Hotel Trinkete.... ¿quiéres conocerlo?" | En la cabecera hay enlaces de la plantilla en inglés, "Registration" y "Log In", que llevan a wp-login.php | WordPress 3.9 (2014) con swfobject (script de Flash) cargado

Hola, equipo del Hostal Trinkete Antxitonea:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Dormir en una casona del siglo XIX a orillas del río Baztan, en pleno Txokoto, es de esas cosas que convencen antes de ver las fotos.

Os escribo porque en la página de tarifas pone "Tempora alta" y que el pago se hace "en el momento de hacer el checking", y en la portada aparece un "¿quiéres conocerlo?". Además, en la cabecera hay dos enlaces en inglés, "Registration" y "Log In", que llevan al acceso de administración, y la web sigue con una versión de WordPress de 2014.

¿Os preparo gratis una maqueta con reserva directa desde el móvil y el descuento del 12% bien a la vista? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hotel Rural Camino de las Bardenas', 'Hotel rural con restaurante', 'Arguedas (cerca de Tudela)', 'Navarra', 'http://www.caminodelasbardenas.com/', 'hotel1@caminodelasbardenas.com', '657 948 971 / 948 830 517', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'La doble cuesta 65 € en la portada y 60 € en tarifas', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'hotel1@caminodelasbardenas.com', 'caminodelasbardenas.com', 'http://www.caminodelasbardenas.com/', 'Navarra', 'guzman', 'guzmangonzalezperez@gmail.com', 'Habitaciones dedicadas a antiguas cabañas de pastores de las Bardenas Reales; Arguedas es la puerta de las Bardenas.', 'alta', false, 'seed', 'camino-bardenas-arguedas', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: La doble cuesta 65 € en la portada y 60 € en tarifas
Fallos: Precios contradictorios: la portada muestra "65.00€" y la página de tarifas "Habitación doble 60 euros"; además "Desayuno desde…" sin precio | La carta es un "Menú de Otoño 2025" en galería con botones en inglés: "◄ Back", "Next ►", "Picture 1 of 2" | Incoherencia: "8 Habitaciones dobles ... dedicadas a siete antiguas cabañas de pastores" | Sin HTTPS (la versión https no conecta), botón de Google+ (plus.google.com) y WordPress 4.9.10; "Que comer en el Restaurante" y "Como llegar a Arguedas" sin tilde

Hola, equipo del Hotel Rural Camino de las Bardenas:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Que cada habitación esté dedicada a una antigua cabaña de pastores de las Bardenas es un detalle precioso para un hotel que hace de puerta del desierto.

Os escribo porque en la portada la habitación aparece a "65.00€" y en tarifas pone "Habitación doble 60 euros" y un "Desayuno desde…" sin precio. La carta del restaurante es un "Menú de Otoño 2025" con botones en inglés ("Back", "Next", "Picture 1 of 2"), se habla de "8 Habitaciones" dedicadas a "siete antiguas cabañas" y la web no tiene versión segura (https) y aún enseña el botón de Google+.

¿Os preparo gratis una maqueta con reserva directa, la carta actualizada y cómo llegar desde Tudela? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Cinesia Fisioterapia y Osteopatía', 'Clínica de fisioterapia', 'Tafalla', 'Navarra', 'https://www.cinesia.es/', 'cinesiatafalla@hotmail.com', '948 755 080', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra web promete "Servicio 24 horas" (¿de verdad abrís a las 4 de la mañana?)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'cinesiatafalla@hotmail.com', 'cinesia.es', 'https://www.cinesia.es/', 'Navarra', 'guzman', 'guzmangonzalezperez@gmail.com', 'Centro de fisioterapia y osteopatía en Tafalla desde 2003, homologado por Sanidad y referente en la zona media (colegiado nº 183).', 'media', false, 'seed', 'cinesia-tafalla', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web promete "Servicio 24 horas" (¿de verdad abrís a las 4 de la mañana?)
Fallos: Textos de plantilla que no encajan: "Servicio 24 horas", "Agendar una Cita", "Disfrutar tu Terapia" | El título de la pestaña lleva comillas sueltas: "''CINESIA – FISIOTERAPIA TAFALLA''" | Dirección con número de relleno: "Calle Benegorri, 0"; coma mal puesta: "técnicas que ,mediante la aplicación" | Email de empresa en @hotmail.com

Hola, equipo de Cinesia:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Llevar desde 2003 arreglando espaldas y rodillas en Tafalla y ser referencia en toda la zona media tiene mucho mérito, sobre todo en una zona donde todo se sabe por el boca a boca.

Os escribo porque la portada conserva textos de la plantilla que no encajan con una clínica, como "Servicio 24 horas" o los pasos "Agendar una Cita" y "Disfrutar tu Terapia". Además, el título de la pestaña del navegador lleva comillas sueltas ("''CINESIA – FISIOTERAPIA TAFALLA''"), la dirección aparece como "Calle Benegorri, 0" y en la definición de fisioterapia hay un "técnicas que ,mediante".

¿Os preparo gratis una maqueta con cita online desde el móvil y las mutuas con las que trabajáis bien a la vista? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('A.M. Tellechea González, Clínica Dental', 'Clínica dental', 'Estella-Lizarra', 'Navarra', 'https://www.clinicadentaltellechea.com/', 'crownd@hotmail.com', '948 551 981', '', 'contactado', '', null, null, '', 'Dueño: Dr. Antonio Manuel Tellechea; equipo de 4 personas, por eso trato de vosotros. Web hecha por BeeDIGITAL.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra clínica tiene 200 m2 que "dan cavidad" (y no es una caries)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'crownd@hotmail.com', 'clinicadentaltellechea.com', 'https://www.clinicadentaltellechea.com/', 'Navarra', 'guzman', 'guzmangonzalezperez@gmail.com', 'Clínica de 200 m2 con 3 gabinetes y sala de radiodiagnóstico; ofrecen Orthoapnea, un dispositivo para el ronquido y la apnea.', 'media', false, 'seed', 'dental-tellechea-estella', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra clínica tiene 200 m2 que "dan cavidad" (y no es una caries)
Fallos: Email de contacto de la clínica en una cuenta personal: "crownd@hotmail.com" | Erratas: "una superficie de 200m2 que dan cavidad a instalaciones" (cabida), "necesitan de una delicado cuidado", "teleradiografía" | La página "Gracias" (la de después de enviar el formulario) aparece en el menú principal | Paréntesis suelto en la portada: "CPS 00752 C/1-07-NA)"

Hola, equipo de la Clínica Dental Tellechea:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Que en Estella tengáis Orthoapnea para el ronquido me parece un servicio que más de una pareja os agradecería por escrito.

Os escribo porque en "Nuestra clínica" pone que los 200 m2 "dan cavidad" a las instalaciones (en vez de cabida), en servicios aparece "necesitan de una delicado cuidado" y "teleradiografía", y en el menú principal sale la página "Gracias", que solo debería verse después de enviar el formulario. Además, el email de contacto de la web es una cuenta de Hotmail, "crownd@hotmail.com".

¿Os preparo gratis una maqueta con cita online desde el móvil y vuestros tratamientos bien explicados? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa de Aldea Ofelia', 'Casa de aldea', 'San Martín de Luiña (Cudillero)', 'Asturias', 'http://www.casaruralofelia.com', 'info@casaruralofelia.com', '985 59 70 07 / 608 47 25 69', '', 'contactado', '', null, null, '', 'La firma del copyright es "Rosa Mª Riesgo Rubio", por eso trato de tú. Web aparentemente abandonada: conviene confirmar por teléfono que la casa sigue abierta.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Tu web de Casa Ofelia ahora anuncia un casino indonesio', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@casaruralofelia.com', 'casaruralofelia.com', 'http://www.casaruralofelia.com', 'Asturias', 'guzman', 'guzmangonzalezperez@gmail.com', 'En su web recomiendan ir al puerto de Cudillero entre las 3 y las 8 de la tarde para ver volver los barcos y descargar en la rula.', 'alta', false, 'seed', 'casa-ofelia', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Tu web de Casa Ofelia ahora anuncia un casino indonesio
Fallos: Web hackeada: el botón "Entrar >>" de la portada lleva a paginas/portada.html, que ahora muestra un casino online indonesio con el título "CICAKWIN > Bandar Platform Arena CICAK WIN Peluang Nyepin Hoki Seru Terbesar" | La portada es una animación Flash (files/casaofelia.swf), que ningún navegador actual reproduce | Sin <meta name="viewport">: no adaptada al móvil | Fechas antiguas: "© Rosa Mª Riesgo Rubio 2009", mapa con "Map data ©2009 Tele Atlas" y descarga de POI "si dispones de una pda" | Erratas: "A parte de la de la tranquilidad", "Imagén obtenida a través de SigPac", "pues descargar los POI" | La página de galería está vacía y el formulario de contacto usa action="mailto:info@casaruralofelia.com" (no envía nada en la mayoría de navegadores)

Hola, Rosa:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Me encantó que en la web de Casa Ofelia recomiendes bajar al puerto de Cudillero entre las 3 y las 8 de la tarde para ver llegar los barcos a la rula: es el tipo de consejo que no sale en ninguna guía.

Te escribo porque al pulsar "Entrar >>" la web lleva a una página hackeada que anuncia un casino indonesio ("CICAKWIN > Bandar Platform Arena..."). Además, la portada es una animación Flash que ya no se ve en ningún navegador, la galería está vacía y en el mapa sigue poniendo "Map data ©2009 Tele Atlas", junto a la opción de descargar los puntos GPS para la "pda".

¿Te preparo gratis una maqueta con fotos de la casa, cómo llegar y reserva directa desde el móvil? Si no te gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa de Aldea Los Glayus', 'Casa de aldea con museo etnográfico', 'San Martín (Luarca, Valdés)', 'Asturias', 'http://losglayus.com', 'reservas@losglayus.com', '607 114 445', '', 'contactado', '', null, null, '', 'El texto está en primera persona ("Donde Yo nací") pero no figura el nombre del dueño; si lo averiguas, pasar a trato de tú.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra web se titula "Pagina nueva 2" (y el museo merece más)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'reservas@losglayus.com', 'losglayus.com', 'http://losglayus.com', 'Asturias', 'guzman', 'guzmangonzalezperez@gmail.com', 'Junto a la casa tienen el llagar donde se elabora la sidra y su propio Museo Rural Etnográfico de Luarca, con más de 5.000 piezas en 12 espacios.', 'alta', false, 'seed', 'los-glayus', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web se titula "Pagina nueva 2" (y el museo merece más)
Fallos: Maquetada con marcos (frameset en marco.htm) y tablas, generada con "Microsoft FrontPage 4.0"; sin <meta name="viewport"> | Títulos de plantilla sin cambiar: "Pagina nueva 1", "Pagina nueva 2", "Pagina nueva 3"; la página del mapa se titula "Película2" | Formulario de reserva roto: action="--WEBBOT-SELF--" (extensión de FrontPage ya inexistente) y otro con action="losglayus.com/solicitd.htm" (ruta mal escrita); además pide "Fax" | Texto "SELECCIONADA" animado con <marquee> en la portada | Erratas: "a tan solo 1.800M de su capital", "Desayuno 6mas IVA", "Casa de Aldea LosGlayus"

Hola, equipo de Los Glayus:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. No conozco muchas casas de aldea que tengan su propio llagar y, al lado, un museo etnográfico con más de 5.000 piezas; eso, a un paseo de Luarca, debería ser la primera foto de la web.

Os escribo porque la web sigue hecha con marcos de FrontPage: la pestaña del navegador dice "Pagina nueva 2", el mapa se titula "Película2" y el "SELECCIONADA" de la portada va dando botes en un marquee. Lo más serio es el formulario de reserva, que apunta a "--WEBBOT-SELF--", una función de FrontPage que ya no existe, así que es probable que esas solicitudes no os estén llegando.

¿Os preparo gratis una maqueta con la casa, el museo y un formulario de reserva que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Aldea de Con (El Texu, El Acebu, El Fresnu)', 'Casa rural y apartamentos rurales', 'Mestas de Con (Cangas de Onís)', 'Asturias', 'https://aldeadecon.com', 'noecamangu20@hotmail.es', '625 90 11 65', '', 'contactado', '', null, null, '', 'Web en WordPress con viewport; fallos de detalle pero muy visibles. Responsable de datos en la web: María Teresa García Álvarez.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestro botón de email intenta abrir hotmail como si fuera una web', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'noecamangu20@hotmail.es', 'aldeadecon.com', 'https://aldeadecon.com', 'Asturias', 'guzman', 'guzmangonzalezperez@gmail.com', 'Sus tres alojamientos llevan nombre de árbol asturiano: El Texu, El Acebu y El Fresnu, a pocos minutos de Cangas de Onís y Covadonga.', 'media', false, 'seed', 'aldea-de-con', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestro botón de email intenta abrir hotmail como si fuera una web
Fallos: El botón "Correo electrónico" enlaza a "http://noecamangu20@hotmail.es" (como si fuera una web, sin mailto:), así que no abre el correo | Email de empresa en @hotmail.es | Aviso de cookies sin traducir: "Privacy Overview This website uses cookies to improve your experience while you navigate through the website" | Erratas en el pie de todas las páginas: "Habeis estado en la casa rural y quereis compartir vuestra estancia?" (sin tildes ni ¿); en portada "Alquilar casas de forma integra" | Página de ofertas vacía: "Actualmente no tenemos ninguna oferta en vigor"

Hola, equipo de Aldea de Con:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Me gustó mucho que vuestros tres alojamientos se llamen El Texu, El Acebu y El Fresnu: es Asturias pura antes incluso de ver las fotos.

Os escribo porque el botón "Correo electrónico" enlaza a "http://noecamangu20@hotmail.es", como si fuera una página web, así que no abre el correo de nadie. Además, el aviso de cookies sale en inglés ("Privacy Overview This website uses cookies...") y en el pie de todas las páginas se cuela un "Habeis estado en la casa rural y quereis compartir vuestra estancia?" sin tildes ni signo de apertura.

¿Os preparo gratis una maqueta con reserva directa de los tres alojamientos y un contacto que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Mario', 'Casa de aldea (ecoturismo)', 'Posada de Rengos (Cangas del Narcea)', 'Asturias', 'https://casamario.net', 'info@casamario.net', '985 911 198 / 637 867 566', '', 'contactado', '', null, null, '', 'Joomla con viewport; el gancho de ecoturismo da mucho juego para la maqueta.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestro menú dice "Chck-in online" (y el covid sigue en portada)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@casamario.net', 'casamario.net', 'https://casamario.net', 'Asturias', 'guzman', 'guzmangonzalezperez@gmail.com', 'Las habitaciones no tienen televisión a propósito, "por nuestro deseo de velar por la ausencia de ruidos", en la antigua casa familiar junto a Muniellos.', 'media', false, 'seed', 'casa-mario', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestro menú dice "Chck-in online" (y el covid sigue en portada)
Fallos: Erratas en el menú y en el pie: "Chck-in online", y la propia página se titula "Chack-in online"; el enlace de cookies dice "Cookes" | Sigue el banner "Protocolo Covid19" enlazado a /images/covid19.pdf y las condiciones de cancelación citan "las condiciones sanitarias por COVID19" | Pie con "Todos los derechos reservados © 2017" | Datos contradictorios: el título dice "A 6km. del Bosque de Muniellos" y la portada "a 5kms de Muniellos" | Errata: "hemos rehabilitado tratado de mantener su estructura original"

Hola, equipo de Casa Mario:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Me encantó leer que las habitaciones no tienen tele a propósito, para que lo único que se oiga al lado de Muniellos sea el silencio; poca gente se atreve a venderlo así de bien.

Os escribo porque en el menú del pie pone "Chck-in online", la propia página se titula "Chack-in online" y el enlace de cookies dice "Cookes". Además sigue el banner de "Protocolo Covid19" enlazado al PDF, el pie marca "© 2017" y el título dice que estáis "A 6km. del Bosque de Muniellos" mientras la portada habla de "5kms".

¿Os preparo gratis una maqueta con reserva directa, las rutas por Fuentes del Narcea y todo bien visible en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hotel La Casona de Pío', 'Hotel pequeño (11 habitaciones)', 'Cudillero', 'Asturias', 'http://www.lacasonadepio.com', 'lacasonadepio@lacasonadepio.com', '985 591 512', '', 'contactado', '', null, null, '', 'El formulario roto significa reservas perdidas: buen argumento de urgencia.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestro formulario dice a la vez que ha fallado y que ha funcionado', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'lacasonadepio@lacasonadepio.com', 'lacasonadepio.com', 'http://www.lacasonadepio.com', 'Asturias', 'guzman', 'guzmangonzalezperez@gmail.com', 'Desayunos caseros con muslitos de monja, galletas de mantequilla, huevos de aldea y mermeladas de fruta de temporada.', 'alta', false, 'seed', 'casona-de-pio', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestro formulario dice a la vez que ha fallado y que ha funcionado
Fallos: Formulario de reserva roto: el código PHP sale tal cual en contacto.php y la página muestra a la vez "No se ha podido enviar el formulario. Lo sentimos, inténtelo de nuevo." y "Su petición ha sido enviada correctamente", con trozos de código ("} else if($correcto == 1) { print") | La web es una copia estática hecha con HTTrack: en el código pone "Mirrored from lacasonadepio.com/ by HTTrack Website Copier/3.x [XR&CO''2014], Fri, 19 Aug 2022" | Portada con animación Flash (imagenes/casona.swf) y sin <meta name="viewport"> | Erratas: "Equipamento de las habitaciones", "mirador del Espítitu Santo", "Visitas a diferente playas"

Hola, equipo de La Casona de Pío:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Un desayuno con muslitos de monja, galletas de mantequilla y mermelada casera de temporada ya es motivo suficiente para dormir en Cudillero, y así lo contáis en la web.

Os escribo porque en la página de contacto el formulario muestra a la vez "No se ha podido enviar el formulario. Lo sentimos, inténtelo de nuevo." y "Su petición ha sido enviada correctamente", con trozos de código en medio. Además, la web es una copia estática hecha con HTTrack en 2022, la portada es una animación Flash que ya no se ve y se cuelan erratas como "Equipamento de las habitaciones" o "mirador del Espítitu Santo".

¿Os preparo gratis una maqueta con reserva directa que funcione de verdad en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Apartamentos La Casona de Vidiago', 'Apartamentos turísticos rurales', 'Vidiago (Llanes)', 'Asturias', 'https://www.lacasonadevidiago.com', 'info@lacasonadevidiago.com', '985 41 10 69 / 647 62 57 05', '', 'contactado', '', null, null, '', 'Tarifas 2026 al día; 18 apartamentos, negocio algo más grande que el resto. El asunto «Villa Sofía» está en el código de la portada (bloque para navegadores sin marcos).', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'En el código de vuestra web se ha colado una tal "Villa Sofía"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@lacasonadevidiago.com', 'lacasonadevidiago.com', 'https://www.lacasonadevidiago.com', 'Asturias', 'guzman', 'guzmangonzalezperez@gmail.com', 'Complejo rehabilitado en 1989 sobre una casona asturiana del siglo XIX, con piscina excavada en roca, a 8 km de Llanes.', 'media', false, 'seed', 'casona-de-vidiago', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En el código de vuestra web se ha colado una tal "Villa Sofía"
Fallos: Web de escritorio montada con marcos (frameset con cabecera.htm y presentacion.htm) y sin <meta name="viewport">; versión móvil aparte en /mobile/ con "Copyright © 2022" | Restos de la web de otro cliente: el enlace del webmaster de la portada lleva el asunto "Villa Sofía" (mailto:sat@e-magnetron.com?subject=Villa Sofía) | Texto de plantilla: "Esta página utiliza marcos, pero su explorador no las admite." | Erratas: "Estancia mínima 2 noche", "El servicio de limpieza de los apartamentos., será", "cambio de sabanas" | Fechas contradictorias: temporada baja "Del 21 de Septiembre al 18 de Diciembre" pero cierre "Del 13 de Noviembre al 3 de Diciembre"

Hola, equipo de La Casona de Vidiago:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una casona del siglo XIX con piscina excavada en la roca a 8 km de Llanes es de esas cosas que se venden solas con una buena foto.

Os escribo porque la web de escritorio sigue montada con marcos y no se adapta al móvil (la versión aparte de /mobile/ marca "Copyright © 2022"), y en el código de la portada el enlace del webmaster lleva como asunto "Villa Sofía", que no sé quién es, pero no sois vosotros. También hay detalles como "Estancia mínima 2 noche" o una temporada baja "al 18 de Diciembre" que choca con el cierre "Del 13 de Noviembre al 3 de Diciembre".

¿Os preparo gratis una maqueta única para móvil y ordenador, con tarifas claras y reserva directa? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Wences', 'Tienda de productos de Liébana (orujos, quesos, embutidos) con tienda online', 'Potes', 'Cantabria', 'http://www.casawences.es', 'info@casawences.es', '942 73 00 33', '', 'contactado', '', null, null, '', 'No citar el número de DNI en ningún mensaje; solo avisar de que está publicado.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'En vuestra web, Lastres se ha mudado a los Picos de Europa', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@casawences.es', 'casawences.es', 'http://www.casawences.es', 'Cantabria', 'guzman', 'guzmangonzalezperez@gmail.com', 'En los años 40 el abuelo Nicolás recorría Liébana a caballo comprando pieles; en 1954 Wences y Milagros abrieron la tienda en Potes.', 'alta', false, 'seed', 'casa-wences', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestra web, Lastres se ha mudado a los Picos de Europa
Fallos: Tienda online (PrestaShop con jQuery 1.7.2) sin <meta name="viewport">: no adaptada al móvil | Pie con "© 2013 Casa wences."; en "Enlaces de interés" sigue "Camino Lebaniego 2017" | Erratas: "Libros y Música Flok" (menú), "Información metereológica", "mostrate publicidad" (aviso de cookies) | En "Quiénes somos": "ala vez", "esos producto" y "Lastres ofrecen una rica y variada gastronomía" (por "Las tres") | La página "Quiénes somos" publica el DNI completo del titular

Hola, equipo de Casa Wences:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. La historia del abuelo Nicolás recorriendo Liébana a caballo para comprar pieles, y de Wences y Milagros abriendo la tienda en Potes en 1954, es mejor que cualquier eslogan.

Os escribo porque la tienda online no se adapta al móvil y tiene erratas a la vista: en el menú pone "Libros y Música Flok", en la portada "Información metereológica" y en "Quiénes somos" se lee "Lastres ofrecen una rica y variada gastronomía" (Lastres es un pueblo asturiano, supongo que queríais decir "Las tres"). El pie sigue en "© 2013" y esa misma página muestra el DNI completo del titular, que convendría quitar.

¿Os preparo gratis una maqueta de la tienda que funcione bien en el móvil, con los orujos y los quesos a dos toques? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Posada Máximo', 'Posada rural con restaurante y rutas 4x4', 'Espinama (Camaleño, Liébana)', 'Cantabria', 'http://posadamaximo.com', 'info@posadamaximo.com', '942 736 603 / 666 528 881', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestras tarifas siguen en 2024 (y el contacto es un "Documento sin título")', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@posadamaximo.com', 'posadamaximo.com', 'http://posadamaximo.com', 'Cantabria', 'guzman', 'guzmangonzalezperez@gmail.com', 'Es el último pueblo antes del teleférico de Fuente Dé (3 km) y ofrecen taxi de montaña 4x4 para quien baja del Cable por la pista de Aliva.', 'alta', false, 'seed', 'posada-maximo', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestras tarifas siguen en 2024 (y el contacto es un "Documento sin título")
Fallos: Tarifas caducadas: "TARIFAS 2024" (y mismo precio de 65 € en temporada alta y baja) | La página de contacto tiene el título de plantilla "Documento sin título" | Teléfonos que no coinciden: "942 736 604" en tarifas; "942 736 603" y "942 736 732" en contacto | Maquetada con tablas (8 <table> en portada) y sin <meta name="viewport">; el HTTPS da error de certificado | Erratas: "Lignun Crucis", "la practica de actividades", "alojandose"

Hola, equipo de Posada Máximo:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Estar en el último pueblo antes del teleférico de Fuente Dé y, encima, recoger en 4x4 a quien baja del Cable por Aliva es un servicio que vale oro, y en la web apenas se ve.

Os escribo porque la página de tarifas sigue diciendo "TARIFAS 2024", la de contacto se titula "Documento sin título" y los teléfonos no coinciden (942 736 604 en una, 942 736 603 en otra). Además, la web está hecha con tablas, no se adapta al móvil y en la página de Liébana se cuela un "Lignun Crucis".

¿Os preparo gratis una maqueta con tarifas al día, reserva directa y las rutas 4x4 bien a la vista en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Mesón La Vega', 'Restaurante y pensión', 'La Vega (Vega de Liébana)', 'Cantabria', 'http://mesonlavega.com', 'meson_la_vega@mesonlavega.com', '942 736 132', '', 'contactado', '', null, null, '', 'Email tomado de la versión inglesa de su propia web.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra web pide a la gente que se descargue una letra gótica', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'meson_la_vega@mesonlavega.com', 'mesonlavega.com', 'http://mesonlavega.com', 'Cantabria', 'guzman', 'guzmangonzalezperez@gmail.com', 'El mesón está en la plaza de La Vega, junto a la bolera y al río Quiviesa, con aperitivo junto a la chimenea y menús para llevar.', 'alta', false, 'seed', 'meson-la-vega', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web pide a la gente que se descargue una letra gótica
Fallos: La portada pide descargar una tipografía: "Para que pueda ver bien nuestra página Web, deberá descargar este archivo (BLACKLETTER686BT.TTF)" | Hecha con "Microsoft FrontPage 6.0", sin <meta name="viewport"> | Widget muerto: globo de visitas en Flash de revolvermaps (g.swf, "Large Visitor Globe") | Títulos de pestaña: "Localizacin Page" (situación) y "Pagina nueva 1" (fotos) | El email solo aparece en la versión inglesa ("index ingles.htm"); en español solo hay teléfono | Erratas: puerto "San glorío", "esta situado", "calido rustico"

Hola, equipo de Mesón La Vega:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Un mesón en la plaza, al lado de la bolera y del Quiviesa, con aperitivo junto a la chimenea y menú para llevar: así da gusto parar camino de San Glorio.

Os escribo porque lo primero que ve un visitante es "Para que pueda ver bien nuestra página Web, deberá descargar este archivo (BLACKLETTER686BT.TTF)", algo que desde un móvil es directamente imposible. Además, la web está hecha con FrontPage, tiene un globo de visitas en Flash que ya no carga, la pestaña de las fotos dice "Pagina nueva 1" y la de situación "Localizacin Page".

¿Os preparo gratis una maqueta con la carta, el menú del día y cómo llegar, que se vea bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Apartamentos Cantabria Infinita', 'Apartamentos rurales con spa', 'Ojedo (Potes)', 'Cantabria', 'http://www.apartamentoscantabriainfinita.com', 'info@apartamentoscantabriainfinita.com', '942 73 07 50 / 676 27 56 67', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra web anuncia "download putty" a escondidas (y pone "Inifnita")', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@apartamentoscantabriainfinita.com', 'apartamentoscantabriainfinita.com', 'http://www.apartamentoscantabriainfinita.com', 'Cantabria', 'guzman', 'guzmangonzalezperez@gmail.com', 'Seis apartamentos con spa común propio: piscina climatizada, jacuzzi para unas 6 personas y sauna, con "circuito completo" recomendado.', 'alta', false, 'seed', 'cantabria-infinita', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web anuncia "download putty" a escondidas (y pone "Inifnita")
Fallos: Enlace de spam oculto en el código: <b style="display:none;"><a href="http://surmedia.net/putty/">download putty</a></b> | Pie con errata y año viejo: "Copyright 2008 Apartamentos Cantabria Inifnita" | Sin <meta name="viewport"> y con Google Analytics antiguo (ga.js, UA-24465825-1) | El HTTPS da error de certificado (no coincide con www.apartamentoscantabriainfinita.com) | Erratas: "Despuésde una sesion de sauna", "Alejate de todo", "a traves de chorros"

Hola, equipo de Cantabria Infinita:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Seis apartamentos en Ojedo con piscina climatizada, jacuzzi y sauna propios, y además con el circuito recomendado paso a paso: eso en Liébana no lo tiene cualquiera.

Os escribo porque en el código de vuestras páginas hay un enlace oculto de spam ("download putty", hacia surmedia.net), algo que Google penaliza. Además, el pie dice "Copyright 2008 Apartamentos Cantabria Inifnita", la web no se adapta al móvil, el HTTPS da error de certificado y en servicios se lee "Despuésde una sesion de sauna".

¿Os preparo gratis una maqueta con reserva directa y el spa bien lucido en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Apartamentos La Braña de Potes', 'Apartamentos turísticos', 'Potes', 'Cantabria', 'http://labranadepotes.es', 'labranadepotes@gmail.com', '942 730 004 / 689 856 932', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'La Fiesta del Orujo es temporada alta (pero vuestra tabla de precios es una foto de 2014)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'labranadepotes@gmail.com', 'labranadepotes.es', 'http://labranadepotes.es', 'Cantabria', 'guzman', 'guzmangonzalezperez@gmail.com', 'En su tabla de precios la Fiesta del Orujo cuenta como temporada alta, igual que agosto y Semana Santa; los apartamentos se llaman Deva, Quiviesa y Bullón, como los ríos.', 'alta', false, 'seed', 'la-brana-de-potes', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: La Fiesta del Orujo es temporada alta (pero vuestra tabla de precios es una foto de 2014)
Fallos: Tarifas publicadas como imagen (imagenes/tarifas.jpg), creada con Photoshop CS6 el 25/05/2014 según sus metadatos; ilegible en el móvil y sin año | Texto caducado en reservas: "Somos una empresa joven y de reciente creación. Estamos trabajando en incorporar un panel de reservas" | El botón "Enlaces" del menú no lleva a ningún sitio (href="#") y la portada se titula "Index" | Sin <meta name="viewport">, con SpryMenuBar y swfobject (Flash) de Dreamweaver; el HTTPS da error de certificado | Email de empresa en @gmail.com

Hola, equipo de La Braña de Potes:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Que en vuestra tabla de precios la Fiesta del Orujo cuente como temporada alta, al nivel de agosto y Semana Santa, dice mucho de Potes y me hizo bastante gracia.

Os escribo porque esas tarifas son una imagen JPG guardada en mayo de 2014, que no se lee bien en el móvil ni se puede actualizar sin Photoshop. La sección de reservas sigue diciendo "Somos una empresa joven y de reciente creación. Estamos trabajando en incorporar un panel de reservas", el botón "Enlaces" no lleva a ningún sitio y la portada se titula simplemente "Index".

¿Os preparo gratis una maqueta con ese panel de reservas por fin hecho y Deva, Quiviesa y Bullón bien a la vista en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hotel Noray', 'Hotel familiar (20 habitaciones)', 'San Vicente de la Barquera', 'Cantabria', 'http://www.hotelnoray.com', 'norayhotel@gmail.com', '942 712 141', '', 'contactado', '', null, null, '', 'Uso norayhotel@gmail.com porque es el que figura en portada y reservas.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'He pulsado vuestro "No pulse aquí" (y la oferta sigue en 2025)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'norayhotel@gmail.com', 'hotelnoray.com', 'http://www.hotelnoray.com', 'Cantabria', 'guzman', 'guzmangonzalezperez@gmail.com', 'Tienen un botón "No pulse aquí" que abre una viñeta de humor sobre el propio hotel; además regalan una entrada a Cabárceno, Fuente Dé o El Soplao en estancias de 7 noches.', 'alta', false, 'seed', 'hotel-noray', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: He pulsado vuestro "No pulse aquí" (y la oferta sigue en 2025)
Fallos: Oferta caducada en tarifas: "*Oferta fin de semana* Del 18 de Abril al 30 de mayo del 2.025" | Maquetada con 23 tablas, generada con "Microsoft FrontPage 5.0" y sin <meta name="viewport"> | El HTTPS da error de certificado (no coincide con www.hotelnoray.com) | Erratas: "individuales,dobles y suittes", "guia Campsa" | Tres emails distintos en la web (noray@hotelnoray.com, norayhotel@gmail.com, reservas@hotelnoray.com) y el principal es @gmail.com

Hola, equipo del Hotel Noray:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Confieso que pulsé el botón de "No pulse aquí" y la viñeta me sacó una carcajada; pocos hoteles se ríen así de sí mismos.

Os escribo porque la oferta de fin de semana sigue anunciada "Del 18 de Abril al 30 de mayo del 2.025", la web está hecha con FrontPage y tablas sin adaptar al móvil, el HTTPS da error de certificado y en la portada aparecen unas "suittes"; además, entre unas páginas y otras repartís tres emails distintos.

¿Os preparo gratis una maqueta con reserva directa, ofertas que no caduquen a la vista y, por supuesto, el botón prohibido incluido? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Posada El Labrador', 'Posada rural', 'San Vicente de la Barquera', 'Cantabria', 'http://www.posadaellabrador.com', 'posadaellabrador@yahoo.es', '942 71 23 05 / 660 524 422', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestras tarifas viven en una página llamada "aboutus"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'posadaellabrador@yahoo.es', 'posadaellabrador.com', 'http://www.posadaellabrador.com', 'Cantabria', 'guzman', 'guzmangonzalezperez@gmail.com', 'Desde su porche se ven la playa, el Puente de la Maza y los Picos de Europa; seis habitaciones, cada una con decoración distinta.', 'alta', false, 'seed', 'posada-el-labrador', '2026-10-05T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestras tarifas viven en una página llamada "aboutus"
Fallos: Páginas con los nombres de la plantilla sin cambiar: las tarifas están en "aboutus.html", las habitaciones en "blog.html", la situación en "gallery.html" y las reservas en "contact.html" | Títulos de pestaña cruzados: la página de reservas se titula "Tarifas" y la de tarifas "Habitaciones" | Email de empresa en @yahoo.es | Sin <meta name="viewport"> y el HTTPS no carga (fallo de handshake SSL) | Erratas: "vistas a la bahia", "podra disfrutar", "decoracion exclusiva", "piedra.En nuestra Posada"

Hola, equipo de Posada El Labrador:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Un porche desde el que se ven a la vez la playa, el Puente de la Maza y los Picos de Europa es difícil de superar en San Vicente, y que cada una de las seis habitaciones tenga su propia decoración le da mucha personalidad.

Os escribo porque la web conserva los nombres de la plantilla: las tarifas están en una página llamada "aboutus.html", las habitaciones en "blog.html" y la situación en "gallery.html", y encima la pestaña de reservas se titula "Tarifas". Además, no se adapta al móvil, el HTTPS no carga y se repiten erratas como "vistas a la bahia" o "podra disfrutar".

¿Os preparo gratis una maqueta con reserva directa y cómo llegar por la carretera del Faro, que se vea bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-05T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Cervantes College', 'Academia de español', 'Murcia', 'Murcia', 'https://cervantescollege.com', 'hola@cervantescollege.com', '+34 968 937 708', '', 'respondio', '', null, null, '', 'Respondió Raquel Mtz. Vera-Meseguer (directora): ya son Guay Spanish School y tienen web nueva (guayspanishschool.com). Oportunidad: redirigir el dominio viejo.', false, '', false, '', 'seed-2026-10-13', '', 'Vuestra web sigue enlazando a Google+ (que cerró en 2019)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'hola@cervantescollege.com', 'cervantescollege.com', 'https://cervantescollege.com', 'Murcia', 'guzman', null, 'Quieren que el alumno sea ''un murciano más''; decoración con materiales reciclados', 'media', false, 'seed', 'cervantes', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (respondio).
Asunto: Vuestra web sigue enlazando a Google+ (que cerró en 2019)
Fallos: Footer ''Copyright 2013'' | No se adapta al móvil | Joomla antiguo con tablas | Enlaza a Google+ (cerró en 2019)

Hola, equipo de Cervantes College:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Me encanta vuestra idea de que el alumno acabe siendo "un murciano más", y lo de decorar con materiales reciclados. Reutilizar muebles, genial. Reutilizar la web de 2013, ya no tanto.

El pie pone Copyright 2013, en el móvil se ve diminuta (y vuestros alumnos buscan desde el móvil) y seguís enlazando a Google+, que cerró hace siete años.

¿Os preparo gratis una maqueta de la portada nueva, en español e inglés? Si no os gusta, la borro sin rencores.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Cal Correu de Fredes', 'Casa rural', 'Fredes (La Pobla de Benifassà)', 'Castellón', 'https://www.calcorreudefredes.com', 'calcorreudefredes@gmail.com', '687 42 71 93', '', 'contactado', '', null, null, '', 'Web en valenciano con versión en castellano; los textos citados están tal cual.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestra web en castellano dice que estáis en Frías', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'calcorreudefredes@gmail.com', 'calcorreudefredes.com', 'https://www.calcorreudefredes.com', 'Castellón', 'guzman', 'guzmangonzalez.twati@gmail.com', 'El sótano, excavado bajo la montaña, es una bodega con botas de vermut y vinos del Priorat, Montsant y Terra Alta, en pleno parque natural de la Tinença de Benifassà', 'alta', false, 'seed', 'cal-correu-fredes', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web en castellano dice que estáis en Frías
Fallos: La versión en castellano dice que la casa está "situada en Frías" (el traductor automático ha convertido Fredes en Frías) | El teléfono que se ve es "(+34) 687 42 71 93", pero el enlace para llamar marca tel:+34687427194 (acaba en 94): quien pulsa desde el móvil llama a otro número | Errata en la descripción: "una guitarra a punto ser para ser tocada" (en valenciano: "a punt ser per ser tocada") | Sin <meta name="viewport">: no está adaptada al móvil aunque carga Bootstrap 3.3.7

Hola, equipo de Cal Correu:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una casa con bodega excavada bajo la montaña y botas de vermut en pleno Fredes lo tiene muy difícil para no gustar.

Os escribo porque la versión en castellano de la web dice que la casa está "situada en Frías" (el traductor se ha llevado Fredes por delante), el teléfono que se ve es el "687 42 71 93" pero el botón de llamar marca uno que acaba en 94, y en la tercera planta hay "una guitarra a punto ser para ser tocada". Además, la web no se adapta al móvil.

¿Os preparo gratis una maqueta con reserva directa que se vea bien en el móvil y llame al número correcto? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa de Banys L''Avellà', 'Hostal, restaurante y balneario', 'Catí (L''Avellà)', 'Castellón', 'https://casadebanyslavella.com', 'casabanyscati@gmail.com', '964 76 50 51', '', 'contactado', '', null, null, '', 'El email aparece en la web como Casabanyscati@gmail.com.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestra agenda sigue en enero de 2019 (con María Jesús y su acordeón)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'casabanyscati@gmail.com', 'casadebanyslavella.com', 'https://casadebanyslavella.com', 'Castellón', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Han recuperado la antigua denominación y función de la Casa de Banys de L''Avellà, y en su web cuentan una velada con "María Jesús y su acordeón"', 'alta', false, 'seed', 'casa-banys-lavella', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra agenda sigue en enero de 2019 (con María Jesús y su acordeón)
Fallos: La sección "NUESTROS EVENTOS" sigue anunciando actos del "5 de enero de 2019", "10 de enero de 2019" y "15 de enero de 2019" | Los "Leer mas." de los eventos enlazan a direcciones de plantilla en latín: /event/suscipit-tellus-mauris/, /event/purus-semper-eget/ y /event/proin-gravida-hendrerit/ | Erratas literales en la portada: "Mas infornación", "Rerservas", "Te encantara" y "Bienvenido a Casa de Banys Lávella" | El selector de hora de la reserva de mesa ofrece "12:am" y "7:pm"; pie "Copyright 2021."

Hola, equipo de Casa de Banys L''Avellà:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Recuperar la antigua casa de baños de L''Avellà y encima traer a María Jesús con su acordeón es de lo más bonito que he visto en una web del Maestrat.

Os escribo porque en "Nuestros eventos" esa velada sigue anunciada para el "5 de enero de 2019", los "Leer mas" llevan a páginas de plantilla con nombres en latín como "suscipit-tellus-mauris" y se han colado un "Mas infornación" y un "Rerservas". El reservador de mesa, además, ofrece las "12:am" y las "7:pm".

¿Os preparo gratis una maqueta con reserva de mesa y de habitación que funcione bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hotel El Prat', 'Hotel rural con restaurante', 'Lucena del Cid (Llucena)', 'Castellón', 'https://www.hotelelpratdelucena.com', 'hoteldelprat@gmail.com', '964 38 02 03', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'La historia detrás que hay detrás de vuestra web', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'hoteldelprat@gmail.com', 'hotelelpratdelucena.com', 'https://www.hotelelpratdelucena.com', 'Castellón', 'guzman', 'guzmangonzalez.twati@gmail.com', 'La Fuente del Prat brotó de un barreno: Francisco Mezquita Pastor usó dinamita para convertir un prado en huerta a principios del siglo XX; Cavanilles ya escribió que allí "todo verdea y ríe"', 'alta', false, 'seed', 'hotel-el-prat-lucena', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: La historia detrás que hay detrás de vuestra web
Fallos: En la portada: "Descubre toda la historia detrás que hay detrás de los más de 80 años de vida del hotel" | Botones que se quedaron en inglés de la plantilla: "Go to RESTAURANTE" y "Go to HISTORIA" | Errata en la página Otros: "El complejo cuanta además con otros edificios incluida una capilla" | Pie "Copyright 2017. HotelElPratdeLucena.com" y WordPress 4.7 (versión de finales de 2016) en el código

Hola, equipo del Hotel El Prat:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Que la Fuente del Prat naciera de un barreno de dinamita para hacer huerta, y que Cavanilles ya escribiera que allí "todo verdea y ríe", es una historia que pide ser contada a lo grande.

Os escribo porque en la portada pone "Descubre toda la historia detrás que hay detrás", los botones siguen en el inglés de la plantilla ("Go to RESTAURANTE", "Go to HISTORIA"), en la página Otros "el complejo cuanta además con otros edificios" y el pie sigue en "Copyright 2017".

¿Os preparo gratis una maqueta con reserva directa de habitaciones y la carta del restaurante, pensada para el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hostal Rural La Piedra del Mediodía (Restaurante Sorni)', 'Hostal rural y restaurante', 'Cirat', 'Castellón', 'http://www.piedramediodia.com', 'info@piedramediodia.com', '964 14 30 25', '', 'perdido', '', null, null, '', 'Contestó 7 oct: cierran el 15 de noviembre por jubilación. Respondido con agradecimiento el 8 oct.', false, '', false, 'Contestó 7 oct: cierran el 15 de noviembre por jubilación. Respondido con agradecimiento el 8 oct.', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestro email tiene una tilde que se come los correos', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@piedramediodia.com', 'piedramediodia.com', 'http://www.piedramediodia.com', 'Castellón', 'guzman', 'guzmangonzalez.twati@gmail.com', 'El Restaurante Sorni está en la planta baja del hostal, con terraza y "impresionantes vistas"; la doble con desayuno cuesta 50 euros', 'alta', false, 'seed', 'piedra-mediodia-cirat', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (perdido_revisar).
Asunto: Vuestro email tiene una tilde que se come los correos
Fallos: En la página de Reservas el email aparece con tilde en el dominio: "info@piedramediodía.com", así que quien lo copia escribe a un dominio que no es el suyo | La sección "Noticias" sale vacía y el servidor devuelve error 500 | Errata en Habitaciones: "disfrutar del la tranquilidad y el descanso" | Sin <meta name="viewport"> (no adaptada al móvil) y botón "News" en inglés en un menú en castellano

Hola, equipo de La Piedra del Mediodía:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Un hostal en Cirat con el Restaurante Sorni abajo, terraza con vistas y la doble con desayuno a 50 euros es casi un servicio público.

Os escribo porque en la página de reservas el email aparece como "info@piedramediodía.com", con tilde, y escrito así no os llega nada; además la sección "Noticias" sale vacía por un error del servidor, se ha colado un "disfrutar del la tranquilidad" y la web no se adapta al móvil.

¿Os preparo gratis una maqueta con reserva directa, la carta del Sorni y cómo llegar, que se vea bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hostal Restaurante Aguilar', 'Hostal y restaurante', 'Forcall', 'Castellón', 'https://www.hostal-aguilar.com/es/', 'informacion@hostal-aguilar.com', '964 171 106', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Se os han colado unos menu''s en la web', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'informacion@hostal-aguilar.com', 'hostal-aguilar.com', 'https://www.hostal-aguilar.com/es/', 'Castellón', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Forcall debe su nombre a la forma de horca que hacen los ríos Caldes, Cantavieja y Morella; el restaurante tiene una carta de más de 50 platos', 'media', false, 'seed', 'hostal-aguilar-forcall', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Se os han colado unos menu''s en la web
Fallos: En la página Restaurante: "menu’s para empresas o grupos" y "menu’s cerrados" (apóstrofo inglés) | La noticia "Restaurant guru" está vacía: solo título y botón de compartir; la portada no tiene ni una línea de texto, solo el menú | Faltan tildes en textos visibles: "¿ Que podemos visitar ?", "podra encontrar el numero de telefono, correo electronico", "Peñiscola" | La dirección raíz hostal-aguilar.com es una página sin viewport que redirige a /es al cabo de 1 segundo; WordPress 4.7 en el código

Hola, equipo del Hostal Aguilar:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una carta de más de 50 platos en un pueblo que debe su nombre a la horca que forman tres ríos merece bastante más protagonismo del que le da la web.

Os escribo porque la portada no tiene ni una línea de texto, la noticia "Restaurant guru" está vacía, en la página del restaurante aparecen dos "menu’s" con apóstrofo inglés y faltan tildes en sitios muy visibles como "¿ Que podemos visitar ?" o "Peñiscola".

¿Os preparo gratis una maqueta con la carta, el menú del día y cómo llegar, pensada para el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('La Caseta del Forn', 'Casa rural', 'Vistabella del Maestrat', 'Castellón', 'http://lacasetadelforn.blogspot.com', 'lacasetadelforn@gmail.com', '655 185 291', '', 'perdido', '', null, null, '', 'Contestó 7 oct (Jose Manuel Edo): ese blog no lo usan, su web es lacasetadelforn.com y no necesitan nada. No volver a escribir.', true, 'Contestó 7 oct (Jose Manuel Edo): ese blog no lo usan, su web es lacasetadelforn.com y no necesitan nada. No volver a escribir.', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Una cama de 1,50 cm en Vistabella (y unas cuentas que no salen)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'lacasetadelforn@gmail.com', 'lacasetadelforn.blogspot.com', 'http://lacasetadelforn.blogspot.com', 'Castellón', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Ofrecen "visites guiades i eixides a per trufa" en el Parque Natural de Penyagolosa', 'alta', false, 'seed', 'caseta-del-forn-vistabella', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (no_contactar).
Asunto: Una cama de 1,50 cm en Vistabella (y unas cuentas que no salen)
Fallos: Camas medidas en centímetros: "llit doble (1,50 cm)", "llit doble (1,35 cm)" y "sofà-llit (1,20 cm)" | Cuentas que no cuadran en la tabla de precios: "2 persones en 2 llits (50€/persona)........110 €" (serían 100) y "3 persones en 2 llits (36,66€/persona)........100 €" (serían 110) | La web es un blog de Blogger sin dominio propio y sin <meta name="viewport">: no adaptada al móvil | Formulario con etiquetas en castellano ("Nombre", "Correo electrónico") en una web en valenciano y enlace a "Mesures per fer front a la COVID-19"

Hola, equipo de La Caseta del Forn:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Ofrecer salidas "a per trufa" a los pies del Penyagolosa es de esos planes que se venden solos.

Os escribo porque en la ficha la cama doble mide "1,50 cm" y el sofá cama "1,20 cm" (comodísimos para un gnomo), en la tabla de precios "2 persones en 2 llits (50€/persona)" suman 110 € en lugar de 100, y la web es un blog de Blogger sin dominio propio que no se adapta al móvil.

¿Os preparo gratis una maqueta con calendario de disponibilidad y reserva directa que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Villa de Ayora', 'Casas rurales y hotel rural', 'Ayora', 'Valencia', 'https://www.villadeayora.es', 'info@villadeayora.es', '962 191 068', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestras tarifas en inglés siguen en 2010 (con el 7% de IVA)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@villadeayora.es', 'villadeayora.es', 'https://www.villadeayora.es', 'Valencia', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Están en la calle Empedrá, "enclave de castilla en valencia", con habitaciones decoradas con cuadros de pintores locales', 'alta', false, 'seed', 'villa-de-ayora', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestras tarifas en inglés siguen en 2010 (con el 7% de IVA)
Fallos: En Precios: "Los precios están actualizados para todo el año 2023" | En la versión inglesa (villadeayora.com): "Prices are updated for the year 2010" y "These prices do not carry the 7% I.V.A."; el título de la web es "Rurals houses, Holiday Rentals Spain..." | Frase duplicada en Precios: "están muy bien acondicionadas para poder vivir en ellas, están muy bien acondicionadas para poder vivir en ellas" | El blog se quedó en mayo de 2012 (el de la versión .com muestra "Error 404 - Not Found"); sin <meta name="viewport"> y pie "Copyright © 2003"

Hola, equipo de Villa de Ayora:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Habitaciones con cuadros de pintores locales en plena calle Empedrá y más de veinte años con web propia es tener los deberes hechos antes que nadie.

Os escribo porque en la página de precios pone "actualizados para todo el año 2023", en la versión inglesa "Prices are updated for the year 2010" con el "7% I.V.A.", el título de la web es "Rurals houses" y una frase sale dos veces seguidas: "están muy bien acondicionadas para poder vivir en ellas". El blog se quedó en mayo de 2012 y la web no se adapta al móvil.

¿Os preparo gratis una maqueta con reserva directa y precios al día que se vea bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Rural Monmossen', 'Casa rural (casa cueva)', 'Bocairent', 'Valencia', 'http://www.monmossen.com', 'monmossen@yahoo.es', '654 113 225', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestra página de Contacto no tiene contacto', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'monmossen@yahoo.es', 'monmossen.com', 'http://www.monmossen.com', 'Valencia', 'guzman', 'guzmangonzalez.twati@gmail.com', 'La casa está en la antigua parte judía del casco antiguo, con cuevas habilitadas como habitaciones y balcón con vistas a Les Covetes dels Moros', 'alta', false, 'seed', 'monmossen-bocairent', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra página de Contacto no tiene contacto
Fallos: La página "Contacto" no tiene ningún dato de contacto: solo "Enlaces a webs de turismo | Tourist Info Bocairent" | Sin HTTPS (la versión https no responde), sin <meta name="viewport"> y maquetada con tablas | Email de contacto en @yahoo.es | Contenido desfasado y erratas: "Cuentan con televisión con canal plus", "tras pasar por Ontiyent", "la Comunidad de Valenciana"

Hola, equipo de Monmossen:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Dormir en una cueva de la antigua judería de Bocairent mirando a Les Covetes dels Moros es un argumento que no necesita ayuda.

Os escribo porque la página "Contacto" no tiene ni teléfono ni email, solo un enlace a "Tourist Info Bocairent", la casa todavía presume de "televisión con canal plus", hay un "Ontiyent" al que le falta una n y la web no tiene HTTPS ni se adapta al móvil.

¿Os preparo gratis una maqueta con fotos de las cuevas, tarifas y reserva directa pensada para el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Habitacions Casa Roberto', 'Pensión y restaurante', 'Ontinyent', 'Valencia', 'http://www.habitacionscasaroberto.com', 'contacte@habitacionscasaroberto.com', '96 238 35 18', '', 'contactado', '', null, null, '', 'El email se muestra en la página Contacto mediante el script antispam de Joomla.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Una estrella con comodidades de dos y una cabecera en Flash', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'contacte@habitacionscasaroberto.com', 'habitacionscasaroberto.com', 'http://www.habitacionscasaroberto.com', 'Valencia', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Se presentan como "Alojamiento de 1 estrella con las comodidades de uno de 2 estrellas"; en el restaurante, all i pebre de anguilas, coca de fira y "todo el futbol en directo"', 'alta', false, 'seed', 'casa-roberto-ontinyent', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Una estrella con comodidades de dos y una cabecera en Flash
Fallos: La cabecera es una animación Flash ("/templates/mx_joofree8/header/header.swf") que ningún navegador actual reproduce | Sin <meta name="viewport"> y sin HTTPS (la versión https no responde) | El formulario de contacto pregunta "¿Cuanto son tres mas 2?" y el email solo se ve con JavaScript (aviso "Esta dirección de correo electrónico está protegida contra spambots") | Plantilla gratuita sin personalizar: pie "Designed by mixwebtemplates.com"

Hola, equipo de Casa Roberto:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Lo de "alojamiento de 1 estrella con las comodidades de uno de 2 estrellas" es de los mejores eslóganes que he leído, y si encima hay all i pebre y todo el fútbol en directo, poco más se puede pedir.

Os escribo porque la cabecera de la web es una animación Flash ("header.swf") que ya no se ve en ningún navegador, el formulario pregunta "¿Cuanto son tres mas 2?", el pie sigue diciendo "Designed by mixwebtemplates.com" y la web no tiene HTTPS ni se adapta al móvil.

¿Os preparo gratis una maqueta con habitaciones, carta y cómo llegar que funcione bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Embutidos Pimar', 'Obrador de embutidos artesanos', 'Agullent (Ontinyent)', 'Valencia', 'https://www.embutidospimar.com', 'pimar@embutidospimar.com', '962 907 707', '', 'propuesta_enviada', 'Web completa', 490, 'fijo', 'Llamada para cerrar', 'Contestaron el 9 oct: "Me parece buena idea. Ya me dice." Maqueta (3 imágenes) y propuesta de 490 € enviadas el 9 oct desde twati, proponiendo llamada de 10 min la semana que viene. · Maqueta y propuesta enviadas el 9 oct.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestros curados dan error 403 (y la potrota habla del blanquet)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'pimar@embutidospimar.com', 'embutidospimar.com', 'https://www.embutidospimar.com', 'Valencia', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Se presentan como de Ontinyent, "ciudad cuna de la morcilla de cebolla", que elaboran siguiendo las recetas de sus antecesores; también hacen longaniza de Pascua', 'alta', false, 'seed', 'embutidos-pimar', '2026-10-09T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (pipeline).
Asunto: Vuestros curados dan error 403 (y la potrota habla del blanquet)
Fallos: En el menú, "Productos curados" y "Bandejas y Envases" llevan a una página "403 Forbidden" (la primera, con la dirección de plantilla "portfolio-4-columns-2") | Errata en la portada: "satisfacer todas la demanda de mercando" | La ficha de "Potrota o Morcón" tiene texto copiado de otro producto: "El blanquet se presenta en cuelgos por unidades atadas" | Enlace "Login" público en el menú y otras erratas: "Envasado bajo atmosfera protectora", "(entre 0ª-4ºC)"

Hola, equipo de Embutidos Pimar:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Hacer morcilla de cebolla con las recetas de siempre en la tierra que presume de ser su cuna, y además longaniza de Pascua, es jugar en casa.

Os escribo porque en el menú "Productos curados" y "Bandejas y Envases" llevan a una página de "403 Forbidden", en la portada pone "satisfacer todas la demanda de mercando" y la ficha de la potrota explica que "el blanquet se presenta en cuelgos". Además sigue a la vista un botón de "Login" que el cliente no necesita.

¿Os preparo gratis una maqueta con el catálogo completo y una tienda que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-09T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Rural Molino del Agua', 'Casa rural', 'Banyeres de Mariola', 'Alicante', 'http://molinodelagua.com', 'molinodelagua@hotmail.com', '699 712 532', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestro molino "a conseguido" algo, pero sin h', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'molinodelagua@hotmail.com', 'molinodelagua.com', 'http://molinodelagua.com', 'Alicante', 'guzman', 'guzmangonzalez.twati@gmail.com', 'El agua suena en todas las estancias gracias a una canalización "hecha por los moros", y fueron pioneros en España en climatizar una casa rural restaurada con geotermia', 'alta', false, 'seed', 'molino-del-agua-banyeres', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestro molino "a conseguido" algo, pero sin h
Fallos: Sin HTTPS (la conexión segura falla) y sin <meta name="viewport">: no adaptada al móvil | Maquetada con tablas y con el aviso "Click = Ampliar" en las fotos | Email de contacto @hotmail.com | Erratas: "Molino del Conde, a conseguido dar un ambiente auténtico" (Nosotros), "lenceria de cama y baño" y "No se admiten animales de compañia" (Precios)

Hola, equipo del Molino del Agua:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una casa donde se oye el agua desde todas las estancias por un canal que hicieron los moros, y encima climatizada con geotermia, es de las que se recuerdan.

Os escribo porque la web no tiene HTTPS ni se adapta al móvil (está maquetada con tablas), el email de contacto es un @hotmail, en "Nosotros" pone que el propietario "a conseguido dar un ambiente auténtico", sin h, y en precios se han quedado sin tilde "lenceria" y "compañia".

¿Os preparo gratis una maqueta con fotos grandes, precios y reserva directa que se vea bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Rural La Llar d''Aitana', 'Casa rural', 'Alcoleja', 'Alicante', 'https://www.lallardaitana.com', 'casarural@lallardaitana.com', '965 171 253', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Innovadoras desde el pueblo, pero con el aviso Covid todavía puesto', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'casarural@lallardaitana.com', 'lallardaitana.com', 'https://www.lallardaitana.com', 'Alicante', 'guzman', 'guzmangonzalez.twati@gmail.com', 'El diario Información las consideró "modelo de innovación en el mundo rural" (entrada "INNOVADORAS DESDE EL PUEBLO"); la casa es anterior al siglo XIX y tiene 370 m2', 'alta', false, 'seed', 'llar-daitana-alcoleja', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Innovadoras desde el pueblo, pero con el aviso Covid todavía puesto
Fallos: La portada sigue anunciando "Establecimiento con protocolo Covid-19" | Pie "©2009-2020 La Llar d''Aitana" y la última entrada del blog es del "18 Agosto 2019" | Errata en la descripción de la casa: "más un lotf (buhardilla de lujo...)"; en el blog, "El periodico Información" | La casa presume de "TV y DVD en habitaciones" y "videoteca"

Hola, equipo de La Llar d''Aitana:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Que el diario Información os pusiera como modelo de innovación en el mundo rural, con una casa anterior al siglo XIX en plena Serra d''Aitana, dice mucho de cómo trabajáis.

Os escribo porque la portada sigue anunciando "Establecimiento con protocolo Covid-19", el pie dice "©2009-2020", la última entrada del blog es de agosto de 2019 y en la descripción de la casa se ha colado "un lotf" en lugar de un loft.

¿Os preparo gratis una maqueta con disponibilidad y reserva directa que esté a la altura de lo de innovadoras? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Venta El Borrego', 'Hotel, restaurante y eventos', 'Banyeres de Mariola', 'Alicante', 'https://ventaelborrego.com', 'info@ventaelborrego.com', '966 56 74 57', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestro botón de reservar no reserva', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@ventaelborrego.com', 'ventaelborrego.com', 'https://ventaelborrego.com', 'Alicante', 'guzman', 'guzmangonzalez.twati@gmail.com', '"Más de 100 años" dando servicio en la carretera Villena-Onteniente, km 18', 'media', false, 'seed', 'venta-el-borrego-banyeres', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestro botón de reservar no reserva
Fallos: El botón "RESERVAR AHORA" lleva a la página Restaurante, que no tiene ni texto ni formulario de reserva | Los enlaces "Hotel" y "Eventos" del pie apuntan a "#" y no llevan a ningún sitio | Pie "© 2019 Venta El Borrego" | Errata en el enlace de accesibilidad: "Saltear al contenido principal"

Hola, equipo de Venta El Borrego:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Más de cien años dando de comer en el kilómetro 18 de la carretera de Villena a Ontinyent es una marca que ya quisieran muchas cadenas.

Os escribo porque el botón "RESERVAR AHORA" lleva a la página del restaurante, que está vacía y no deja reservar, los enlaces "Hotel" y "Eventos" del pie no llevan a ningún sitio, el pie sigue en "© 2019" y el enlace de accesibilidad dice "Saltear al contenido principal".

¿Os preparo gratis una maqueta con reserva de mesa, bodas y habitaciones que funcione bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hostal Restaurant Vertisol', 'Hostal, restaurante y bar', 'Les Preses (Garrotxa)', 'Girona', 'http://www.hostalvertisol.com', 'info@hostalvertisol.com', '972 69 21 48', '', 'contactado', '', null, null, '', 'Web solo en catalán.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestro menú del día cuesta "10,90ï¿½"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@hostalvertisol.com', 'hostalvertisol.com', 'http://www.hostalvertisol.com', 'Girona', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Nace en 1940 a partir de la botiga de poble "Can Central", parada de traginers y pagesos; el hostal se construyó en 1960 y lo lleva la tercera generación.', 'alta', false, 'seed', 'hostal-vertisol', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestro menú del día cuesta "10,90ï¿½"
Fallos: Sin <meta name="viewport">: no adaptada al móvil; maquetada con tablas | Codificación rota en el menú: "PREU: 10,90ï¿½ IVA INCLï¿½S" y "19ï¿½ IVA INCLï¿½S" (restaurant1.html) | Erratas: "per tercera gerenació" (historia.html) y "pots gauidir de les prestigioses vistes" (hostal2.html) | Contador de visitas de contadorgratis.com con el enlace "visites" en portada | Sigue anunciando fax ("Fax. 972 69 31 55") en el pie de todas las páginas

Hola, equipo del Hostal Vertisol:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Que el hostal venga de "Can Central", la tienda donde paraban traginers y payeses en 1940, y que vayáis ya por la tercera generación, es de esas historias que ya casi no quedan.

Os escribo porque en la web el menú diario sale como "PREU: 10,90ï¿½ IVA INCLï¿½S", la historia dice "per tercera gerenació" y en el hostal pone "pots gauidir de les prestigioses vistes". Además sigue con un contador de visitas de contadorgratis.com y no se adapta al móvil.

¿Os preparo gratis una maqueta con la carta, las habitaciones y reserva directa que se vea bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Mas La Casica', 'Masía de turismo rural con granja', 'Argelaguer (Garrotxa)', 'Girona', 'http://www.maslacasica.com', 'info@maslacasica.com', '972 68 70 13 / 608 26 07 99', '', 'contactado', '', null, null, '', 'Hay versión en castellano (/es).', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'En vuestra web, en vez del mapa, sale "FitxersWeb/1374/mapa casica.gif"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@maslacasica.com', 'maslacasica.com', 'http://www.maslacasica.com', 'Girona', 'guzman', 'guzmangonzalez.twati@gmail.com', 'En 2007 recibieron el diploma turístico de la Generalitat, entregado por Jordi Pujol; tienen granja con caballos, ponis, vacas, ovejas y pavos.', 'media', false, 'seed', 'mas-la-casica', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestra web, en vez del mapa, sale "FitxersWeb/1374/mapa casica.gif"
Fallos: Sin <meta name="viewport"> y maquetada con tablas (6-9 <table> por página) | En "El entorno", en lugar del mapa aparece el texto "FitxersWeb/1374/mapa casica.gif" | Erratas: "obejas", "una belleza extraodinaria", "hay unos quarenta", "Pla de espacios de Intrés natural" | "En el año 2007 en el Mas La Casica estuvimos galardonados" y "entre Besalú i Olot" en la versión en castellano | El formulario de reserva todavía pide "Fax"

Hola, equipo de Mas La Casica:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Un diploma turístico de la Generalitat y una granja con caballos, ponis y vacas: pocas masías pueden presumir de las dos cosas.

Os escribo porque en "El entorno", donde debería estar el mapa, aparece el texto "FitxersWeb/1374/mapa casica.gif", hay erratas como "obejas", "extraodinaria" o "unos quarenta" volcanes, y el formulario de reserva todavía pide el "Fax". Además está maquetada con tablas y no se adapta al móvil.

¿Os preparo gratis una maqueta con reserva directa y cómo llegar que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Can Galló', 'Casa de pagès con agricultura ecológica', 'Llanars (Vall de Camprodon, Ripollès)', 'Girona', 'https://www.cangallo.es', 'can.gallo@hotmail.com', '639 878 691', '', 'contactado', '', null, null, '', 'Hay versión en castellano (/es/), traducida automáticamente.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Google os llama "Puede Gallo"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'can.gallo@hotmail.com', 'cangallo.es', 'https://www.cangallo.es', 'Girona', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Son "fills de pagès" con explotación ecológica inscrita en el CCPAE; los niños pueden dar de comer a gallinas y ovejas y acompañar al pastor.', 'alta', false, 'seed', 'can-gallo', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Google os llama "Puede Gallo"
Fallos: La versión en castellano se titula "Puede Gallo - Turismo Rural Camprodon - Llanars" (traducción automática de "Can"), también en el título que sale en Google y al compartir | La portada sigue con el aviso de la pandemia: "debido a la situación actual, me hecho una serie de cambios" (en catalán: "em fet una sèrie de canvis") | El enlace del correo apunta a "http://can.gallo@hotmail.com" (no abre el correo) y el email es @hotmail | "Com Arribar a Can Galló" solo muestra "EST: 2,33722 NORD: 42,31358", sin mapa | Menú mezclado: "Video y Galeria", "Llocs d''ínterès"

Hola, equipo de Can Galló:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una casa de payés ecológica donde los niños dan de comer a las gallinas y acompañan al pastor con las ovejas es justo lo que muchas familias buscan y no encuentran.

Os escribo porque la versión en castellano se titula "Puede Gallo - Turismo Rural Camprodon" (el traductor se tomó el "Can" al pie de la letra), la portada sigue con el aviso de la pandemia ("debido a la situación actual, me hecho una serie de cambios"), el enlace del correo apunta a "http://can.gallo@hotmail.com" y la página de cómo llegar son solo unas coordenadas sin mapa.

¿Os preparo gratis una maqueta con disponibilidad, reserva directa y un mapa para llegar? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Snack Bar Torrent', 'Bar-restaurante familiar', 'Amer (La Selva)', 'Girona', 'http://snackbartorrent.com', 'info@snackbartorrent.com', '972 43 00 73', '', 'contactado', '', null, null, '', 'Web solo en catalán.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Lleváis 58 años abiertos y la web dice "més de 40"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@snackbartorrent.com', 'snackbartorrent.com', 'http://snackbartorrent.com', 'Girona', 'guzman', 'guzmangonzalez.twati@gmail.com', 'La familia Torrent-Lanchas lo inauguró el 21 de junio de 1968; segunda generación y pan artesano cocido en horno de leña.', 'media', false, 'seed', 'snack-bar-torrent', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Lleváis 58 años abiertos y la web dice "més de 40"
Fallos: Sin <meta name="viewport">: no adaptada al móvil | Portada: "MÉS DE 40 ANYS AL SERVEI DEL CLIENT" cuando abrieron en 1968 (58 años) | El párrafo de la historia ("El 21 de juny de 1968...") aparece repetido dos veces seguidas en la página L''Snack | URL con errata: /els-nosrtes-plats/ | Pie con "Copyright 2014" y WordPress de 2014 (ver=3.9.27)

Hola, equipo del Snack Bar Torrent:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Abrir un 21 de junio de 1968 y seguir, ya en segunda generación, cociendo el pan en horno de leña tiene mucho mérito.

Os escribo porque la portada dice "MÉS DE 40 ANYS AL SERVEI DEL CLIENT" cuando ya vais por 58, el párrafo de la historia sale repetido dos veces seguidas, la dirección de la carta es "els-nosrtes-plats" y el pie sigue en "Copyright 2014". Además no se adapta al móvil.

¿Os preparo gratis una maqueta con la carta, el menú del día y cómo llegar que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Apartaments Cal Rafeló', 'Apartamentos rurales y casa rural (Cal Culí)', 'Organyà (Alt Urgell)', 'Lleida', 'http://calrafelo.es', 'calrafelo@calrafelo.es', '650 963 890 / 659 582 381', '', 'contactado', '', null, null, '', 'Hay versión en castellano (es/index.php).', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestras noticias siguen en la liga de parapente de 2013', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'calrafelo@calrafelo.es', 'calrafelo.es', 'http://calrafelo.es', 'Lleida', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Organyà, "el pueblo gancho", villa de las Homilies d''Organyà y cuna de la lengua catalana; parapente y el Segre al lado.', 'alta', false, 'seed', 'cal-rafelo', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestras noticias siguen en la liga de parapente de 2013
Fallos: Sin <meta name="viewport"> y maquetada con tablas | Cabecera en Flash (flash.swf de 810x270 y enfasi.swf), que ya no se ve en ningún navegador | Noticias caducadas: "Liga de parapente del 2 al 5 de mayo del 2013" y "Feria y fiesta del libro del Pirineo 2 y 3 de septiembre del 2011" | Erratas en castellano: "Museuo de los Dinosaurios", "os podéis refrescaren la piscina", "a la época plegar setas", "Orgaña (Lerida)" | Tarifa confusa: "1 noche, persona 15 €/casa"

Hola, equipo de Cal Rafeló:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Dormir en Organyà, el pueblo de las Homilies y cuna de la lengua catalana, con parapente y el Segre al lado, se vende casi solo.

Os escribo porque la última noticia es la "Liga de parapente del 2 al 5 de mayo del 2013", la cabecera es un banner en Flash que ya ningún navegador muestra y en castellano hay frases como "os podéis refrescaren la piscina" o "Museuo de los Dinosaurios". Además las tarifas dicen "1 noche, persona 15 €/casa", y no queda claro si es por persona o por casa.

¿Os preparo gratis una maqueta con tarifas claras y reserva directa que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Besolí', 'Casa rural y apartamento (La Perxada)', 'Àreu, Alins (Pallars Sobirà)', 'Lleida', 'https://casabesoli.es', 'info@casabesoli.es', '692 244 878 / 973 624 415', '', 'contactado', '', null, null, '', 'Solo la portada tiene versión en castellano (index_es.html); el resto está en catalán. Teléfono a nombre de Dolors Torrent.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestra página de contacto responde "Access denied."', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@casabesoli.es', 'casabesoli.es', 'https://casabesoli.es', 'Lleida', 'guzman', 'guzmangonzalez.twati@gmail.com', 'La lleva la familia Bringué Torrent en Àreu (1.220 m), al pie de la Pica d''Estats, con esmorzar de pagès y cenas caseras con producto de la tierra.', 'media', false, 'seed', 'casa-besoli', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra página de contacto responde "Access denied."
Fallos: Sin <meta name="viewport">: no adaptada al móvil | La página "Contactar" (contactar.php) devuelve "Access denied." (403) | Selector de idiomas: "Català Català | Español | Francaise" | Erratas en catalán: "unes vistes fascinats", "el punt de partiria", "Aquesta apartament", "bany complert"

Hola, familia Bringué Torrent:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Tener la Pica d''Estats a tiro desde casa y servir desayuno de payés con producto de la tierra es un plan difícil de mejorar.

Os escribo porque al entrar en "Contactar" la web devuelve "Access denied.", el selector de idiomas pone "Català Català | Español | Francaise" y en catalán se han colado "unes vistes fascinats" y "el punt de partiria". Además no se adapta al móvil.

¿Os preparo gratis una maqueta con reserva directa para la casa y La Perxada que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Xicot', 'Alojamiento turístico rural', 'Alins (Pallars Sobirà)', 'Lleida', 'https://www.casaxicot.com', 'consolpicartmillat@hotmail.com', '973 624 348 / 676 556 217', '', 'contactado', '', null, null, '', 'Hay un segundo email en la web: monicapicart@hotmail.com.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestro botón "Reservar" lleva a ejemplo.web10plus.com', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'consolpicartmillat@hotmail.com', 'casaxicot.com', 'https://www.casaxicot.com', 'Lleida', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Está a 100 metros de Alins, rodeada de naturaleza y silencio, "en dirección a la famosa población de Tor"; habitación doble a 50 euros todo el año.', 'alta', false, 'seed', 'casa-xicot', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestro botón "Reservar" lleva a ejemplo.web10plus.com
Fallos: El botón "Reservar" de la tabla de precios enlaza a "http://ejemplo.web10plus.com/contactar/" (dirección de plantilla) | Los iconos de Facebook, Twitter e Instagram llevan a las cuentas "vegueries", no a las de la casa | Dos emails @hotmail distintos: consolpicartmillat@hotmail.com en la cabecera y monicapicart@hotmail.com en contacto | Iconos de plantilla muertos (Delicious, Forrst, Lastfm... con href="#") | Erratas: "situada en 100 metros del pueblo de Alins", "Esta páginas web utiliza cookies", "Acceptar"

Hola, equipo de Casa Xicot:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una casa a cien metros de Alins, rodeada de silencio y camino de "la famosa población de Tor", tiene todo para enganchar a quien busca Pirineo de verdad.

Os escribo porque el botón "Reservar" de la tabla de precios apunta a "ejemplo.web10plus.com/contactar/", los iconos de Facebook, Twitter e Instagram llevan a las cuentas de "vegueries", que no son las vuestras, y la web muestra dos correos distintos según dónde mires. También pone "situada en 100 metros del pueblo".

¿Os preparo gratis una maqueta con reserva directa y un único correo de contacto? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Es Neres', 'Bar de tapas y alojamiento (12 habitaciones)', 'Les (Val d''Aran)', 'Lleida', 'https://www.esneres.com', 'esneres@hotmail.com', '973 64 83 89', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'En vuestra página de tarifas solo pone "hola caracola"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'esneres@hotmail.com', 'esneres.com', 'https://www.esneres.com', 'Lleida', 'guzman', 'guzmangonzalez.twati@gmail.com', 'El bar abrió en 1982 y ha ido ampliando su carta de tapas (caracoles en salsa, carne de caza, setas en temporada); 12 habitaciones en una casa aranesa reformada en 1999.', 'alta', false, 'seed', 'es-neres', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestra página de tarifas solo pone "hola caracola"
Fallos: La página "Tarifas y reservas" solo tiene el texto "¡ hola caracola" (texto de prueba) encima del calendario | Aviso caducado en "Alojamiento": "RESERVAS COMPLETAS HASTA EL 30 DE ABRIL de 2025. Disculpa las molestias." | El calendario de reservas va en un iframe fijo de width="1654px": no cabe en el móvil | Email de empresa @hotmail | Erratas: "habitaciones con de cama individual", "cama supletorio", "nuevas promociones ofertas"; WordPress 4.5 (2016)

Hola, equipo de Es Neres:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Un bar de tapas abierto desde 1982, con caracoles en salsa y setas en temporada, y doce habitaciones en una casa aranesa es exactamente lo que uno quiere encontrarse en Les.

Os escribo porque en "Tarifas y reservas" el único texto es "¡ hola caracola", en "Alojamiento" sigue el aviso "RESERVAS COMPLETAS HASTA EL 30 DE ABRIL de 2025" y el calendario de reservas está fijado a 1654 píxeles de ancho, así que en el móvil no cabe. El correo de contacto, además, es un @hotmail.

¿Os preparo gratis una maqueta con la carta de tapas y reserva directa que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Ca la Sió Hotelet Rural', 'Hotelito rural, desayunos y calçotadas', 'Aiguamúrcia (Alt Camp)', 'Tarragona', 'http://www.calasio.com', 'info@calasio.com', '977 639 195', '', 'contactado', '', null, null, '', 'Las habitaciones figuran como cerradas por reformas; siguen con desayunos y calçotadas.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Calçotadas "sin tornos" (y habitaciones a 60 € que están en obras)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@calasio.com', 'calasio.com', 'http://www.calasio.com', 'Tarragona', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Calçotada auténtica del Alt Camp para grupos de máximo 10 personas, sin turnos y en ambiente íntimo, en un pueblo de unos 60 habitantes a 2 km de Santes Creus.', 'alta', false, 'seed', 'ca-la-sio', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Calçotadas "sin tornos" (y habitaciones a 60 € que están en obras)
Fallos: Sin <meta name="viewport">: no adaptada al móvil | Erratas en castellano: "Sin tornos, sin prisas" (calçotadas) y "Monasterio Cirstercense de Santes Creus" | Contradicción: "Habitaciones cerradas por reformas" en portada y habitaciones, pero "Precios y Reservas" sigue ofreciendo la doble a "€60 la noche" | Carga el antiguo urchin.js de Google Analytics (retirado hace años) | Enlace a un ViaMichelin de la época (viamichelin.es/viamichelin/esp/tpl/hme/MaHomePage.htm)

Hola, equipo de Ca la Sió:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una calçotada para diez personas como máximo, sin turnos ni prisas, en un pueblo de 60 vecinos a dos kilómetros de Santes Creus, es un planazo.

Os escribo porque en castellano pone "Sin tornos, sin prisas" y "Monasterio Cirstercense", la página de precios sigue ofreciendo la doble a "€60 la noche" mientras las habitaciones aparecen "cerradas por reformas", y la web no se adapta al móvil y aún carga el antiguo urchin.js de Google Analytics.

¿Os preparo gratis una maqueta con las calçotadas, los horarios y reserva directa que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Cal Porxo', 'Casa rural y agrotienda de producto del Priorat', 'Pradell de la Teixeta (Priorat)', 'Tarragona', 'http://calporxo.com', 'calporxo@calporxo.com', '639 350 255', '', 'contactado', '', null, null, '', 'Hay versión en castellano (/es).', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestra portada empieza con "Strict Standards: Non-static method..."', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'calporxo@calporxo.com', 'calporxo.com', 'http://calporxo.com', 'Tarragona', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Casa rural con agrotienda al lado (vinos, miel, aceite, embutidos y quesos del Priorat), estuches de cata de aceite a domicilio y el Tast de Santa Bàrbara, que llegó a su séptima edición.', 'alta', false, 'seed', 'cal-porxo', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra portada empieza con "Strict Standards: Non-static method..."
Fallos: Todas las páginas empiezan con errores de PHP visibles: "Strict Standards : Non-static method Configure::read() should not be called statically in /home/calporxo/www/cake/basics.php on line 213" y "Warning (2) : Creating default object from empty value" | Actividad destacada con fecha "01/01/1970 01:00 - 01/01/1970 01:00" | Última noticia del "02/12/2021" | Errata en portada: "Acojedora y sugerente" | Sin <meta name="viewport">: no adaptada al móvil

Hola, equipo de Cal Porxo:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una casa rural con agrotienda al lado, catas de aceite que mandáis a casa y siete ediciones del Tast de Santa Bàrbara: os habéis currado el Priorat.

Os escribo porque al abrir la web lo primero que se ve es un error de programación ("Strict Standards : Non-static method Configure::read() should not be called statically..."), la actividad destacada tiene fecha "01/01/1970 01:00", la última noticia es del "02/12/2021" y en portada pone "Acojedora y sugerente". Además no se adapta al móvil.

¿Os preparo gratis una maqueta con reserva directa y una tienda de la agrotienda que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Ca la Nuri', 'Casa rural (vivienda de uso turístico)', 'Senan (Conca de Barberà)', 'Tarragona', 'http://calanuri.cat', 'info@calanuri.cat', '619 436 487', '', 'contactado', '', null, null, '', 'La lleva una sola persona (Mar Benseny Albà): trato de tú.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'En tu web pone "Allojamiento rural independene"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@calanuri.cat', 'calanuri.cat', 'http://calanuri.cat', 'Tarragona', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Senan, pueblo de 60 habitantes con origen en 1159 e iglesia románica de Santa Maria levantada por los monjes de Montserrat; ruta familiar por les Sorts de Senan.', 'alta', false, 'seed', 'ca-la-nuri', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En tu web pone "Allojamiento rural independene"
Fallos: Versión en castellano: "Allojamiento rural independene" | El sello de premio 2022 de la portada enlaza a "file:///C:/Users/Provisional/Documents/Mis%20Webs/index.html" (archivo local de un ordenador); otras páginas enlazan a "file:///C:/Users/Senan/Documents/Mis%20Webs/..." | Erratas en catalán: "Conca de Barnerà, 60 habitans", título "Com arrivar", "Port Ventura", "UTMx 330.150 UTMx 330.150" | El menú de portada enlaza a taller1.html, que da 404 | Sin <meta name="viewport"> y maquetada con tablas

Hola, Mar:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una casa en Senan, un pueblo de 60 vecinos con origen en 1159 e iglesia románica levantada por los monjes de Montserrat, es de esos sitios que la gente presume de haber descubierto.

Te escribo porque la versión en castellano empieza con "Allojamiento rural independene", en catalán sale "Conca de Barnerà", el sello de premio de la portada enlaza a "file:///C:/Users/Provisional/Documents/Mis%20Webs/index.html" (un archivo de un ordenador, que nadie más puede abrir) y la web no se adapta al móvil.

¿Te preparo gratis una maqueta con reserva directa, la ruta de les Sorts y cómo llegar que funcione en el móvil? Si no te gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Fonda Bohèmia Riuot', 'Fonda / hotel de 1 estrella con habitaciones temáticas', 'Montblanc (Conca de Barberà)', 'Tarragona', 'http://fondariuot.com', 'info@fondariuot.com', '977 875 145 / 629 319 408', '', 'contactado', '', null, null, '', 'El restaurante está cerrado; la oferta es solo alojamiento.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Un euro de diferencia entre temporada baja y alta', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@fondariuot.com', 'fondariuot.com', 'http://fondariuot.com', 'Tarragona', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Fonda "rústica, artística y bohemia" en la villa medieval de Montblanc, con habitaciones temáticas (egipcia, pintor, pescador, tropical) y exposiciones de pintura de artistas locales.', 'alta', false, 'seed', 'fonda-riuot', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Un euro de diferencia entre temporada baja y alta
Fallos: Contradicción: "Presentación" anuncia "un restaurante con una capacidad para 40 personas" y "Restaurante" dice "Hemos cerrado nuestro restaurante de forma permanente. Lamentamos les molestias." | Tarifas: doble "60€" en temporada baja y "61€" en alta | Catalanismos en la versión en castellano: "siempre de acuerdo con nosaltros", "com si estuvieseis en casa", "ya la vez" | Sin <meta name="viewport"> y maquetada con tablas; título "...::: FONDA BOHÈMIA RIUOT - Montblanc :::..." | Sigue ofreciendo reservas por fax ("Fax: 977 861 707")

Hola, equipo de la Fonda Riuot:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Habitaciones temáticas (egipcia, del pintor, del pescador, tropical) y exposiciones de artistas locales dentro de la villa medieval de Montblanc: lo de fonda bohemia no es postureo.

Os escribo porque en "Presentación" seguís anunciando el restaurante para 40 personas mientras en "Restaurante" pone "Hemos cerrado nuestro restaurante de forma permanente. Lamentamos les molestias", las tarifas van de "60€" en temporada baja a "61€" en alta y en las condiciones se cuela un "siempre de acuerdo con nosaltros". Además la web no se adapta al móvil.

¿Os preparo gratis una maqueta con las habitaciones temáticas y reserva directa que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Restaurante Cueva La Muralla', 'Restaurante', 'Laguardia', 'Álava', 'http://www.cuevalamuralla.es/', 'reservas@cuevalamuralla.es', '945 600 198', '', 'contactado', '', null, null, '', 'La web tiene una sola página; no hay carta ni horarios publicados.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestra web lleva años diciendo "en próximas fechas"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'reservas@cuevalamuralla.es', 'cuevalamuralla.es', 'http://www.cuevalamuralla.es/', 'Álava', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Restaurante ''Cueva La Muralla'' en la calle Páganos 42, en pleno Laguardia', 'alta', false, 'seed', 'cueva-la-muralla', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web lleva años diciendo "en próximas fechas"
Fallos: La web entera es un aviso provisional: "Muchas gracias por su interés en nuestro restaurante. En próximas fechas pondremos en Internet todos nuestros servicios." | No está adaptada al móvil: no tiene <meta name="viewport"> y está maquetada con una <table> | HTTPS roto: el certificado no corresponde al dominio (curl: "no alternative certificate subject name matches target host name ''www.cuevalamuralla.es''") | El enlace "COMO LLEGAR" es una URL antigua de maps.google.es con parámetros de geocode

Hola, equipo de Cueva La Muralla:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Un restaurante que se llama Cueva La Muralla, en plena calle Páganos de Laguardia, tiene medio trabajo de marketing hecho solo con el nombre.

Os escribo porque vuestra web sigue diciendo "En próximas fechas pondremos en Internet todos nuestros servicios", no se adapta al móvil (está maquetada con una tabla y sin etiqueta viewport) y, si alguien entra por https, el navegador avisa de que el certificado no corresponde a vuestro dominio.

¿Os preparo gratis una maqueta con la carta, cómo llegar y un botón para reservar mesa desde el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Restaurante José Mari "El Gordo"', 'Restaurante y pensión', 'Agurain/Salvatierra', 'Álava', 'https://www.restauranteelgordo.com/', 'info@restauranteelgordo.com', '945 30 00 42', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestra web pone "////Menús" (y no es un pintxo nuevo)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@restauranteelgordo.com', 'restauranteelgordo.com', 'https://www.restauranteelgordo.com/', 'Álava', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Abierto en 1893 por la familia Sáez de Asteasu; hoy lo llevan la tercera y cuarta generación y sus rabas son "muy conocidas"', 'alta', false, 'seed', 'el-gordo-agurain', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web pone "////Menús" (y no es un pintxo nuevo)
Fallos: Títulos con barras a la vista: "////Menús", "////Carta." y "////Servicio de Bar." | No está adaptada al móvil: no tiene <meta name="viewport"> | El <title> de la portada es solo "El Gordo" (sin Agurain ni ''restaurante''), malo para Google | Usa jQuery 1.7.2 y jQuery UI 1.8.18 (librerías de 2012)

Hola, equipo de El Gordo:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Un restaurante abierto en 1893 por la familia Sáez de Asteasu, que va ya por la cuarta generación y con unas rabas que la propia web define como "muy conocidas", juega en otra liga.

Os escribo porque en la web los títulos salen como "////Menús", "////Carta." y "////Servicio de Bar.", con las barras a la vista; además no está adaptada al móvil y la pestaña del navegador solo dice "El Gordo", sin mencionar Agurain ni que sois restaurante, lo que no ayuda nada en Google.

¿Os preparo gratis una maqueta con el menú del día, la pensión y un botón de llamar o reservar que funcione bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hotel Restaurante Durtzi', 'Hotel rural y restaurante', 'Sobrón (Lantarón)', 'Álava', 'https://www.hoteldurtzi.com/', 'hoteldurtzi@gmail.com', '945 35 90 78', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestro formulario dice que sois un gabinete técnico de Málaga', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'hoteldurtzi@gmail.com', 'hoteldurtzi.com', 'https://www.hoteldurtzi.com/', 'Álava', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Está en el barrio de La Presa de Sobrón, donde antiguamente hubo un balneario, cerca de Valderejo y el Valle Salado de Añana', 'alta', false, 'seed', 'hotel-durtzi', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestro formulario dice que sois un gabinete técnico de Málaga
Fallos: El aviso que sale al enviar el formulario de contacto se titula "GABINETE TÉCNICO PELICIAL EN MÁLAGA" (texto de otra web, con errata) | En el menú pone "ContactO" | Erratas en el formulario: "Pongase en contacto con nosotros para solicitar mas información", "*Nombre invalido." | No está adaptada al móvil: no tiene <meta name="viewport"> | Email de contacto @gmail.com en vez de uno del dominio

Hola, equipo del Hotel Durtzi:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Dormir en Sobrón, en el barrio de La Presa donde antiguamente hubo un balneario, con Valderejo y el Valle Salado a mano, es un plan que se vende solo.

Os escribo porque al enviar el formulario de contacto aparece un aviso titulado "GABINETE TÉCNICO PELICIAL EN MÁLAGA" (restos de otra web, me temo), en el menú pone "ContactO", el formulario dice "Pongase en contacto con nosotros para solicitar mas información" y la web no está adaptada al móvil.

¿Os preparo gratis una maqueta con las habitaciones, el restaurante y reserva directa desde el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Bodegas Finca Barronte (José Basoco Basoco)', 'Bodega familiar D.O.Ca. Rioja', 'Villabuena de Álava', 'Álava', 'http://www.fincabarronte.com/', 'info@fincabarronte.com', '657 794 964', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'En vuestra web las uvas suman un 110 %', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@fincabarronte.com', 'fincabarronte.com', 'http://www.fincabarronte.com/', 'Álava', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Bodega edificada en el año 2000 con tres plantas, dos de ellas soterradas para mantener la temperatura; viñedo ecológico desde 2020', 'alta', false, 'seed', 'finca-barronte', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestra web las uvas suman un 110 %
Fallos: Pie visible: "Create a free web site with Weebly" (plan gratuito) | Datos contradictorios: portada "8,5 Hectáreas de viñedo propio" y "un 80% en uva tempranillo, un 15% en uva graciano y un 5% en uva viura"; en Fincas y Bodega "De las nueve hectáreas" y "el 90% son de la variedad Tempranillo, 10% Viura, 5% Graciano y el otro 5% de Malvasía" (suma 110 %) | Botones en inglés en la portada castellana: "OUR WINES", "AWARDS AND MENTIONS" | No está adaptada al móvil: no tiene <meta name="viewport"> | Erratas: "info@fincabarronte.Com", "El ciego"

Hola, equipo de Finca Barronte:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una bodega familiar en Villabuena con tres plantas, dos de ellas bajo tierra para que el vino críe a temperatura constante, y en ecológico desde 2020: poco más se le puede pedir a un vino de Rioja Alavesa.

Os escribo porque en la portada pone "8,5 Hectáreas de viñedo propio" y "un 80% en uva tempranillo, un 15% en uva graciano y un 5% en uva viura", mientras que en Fincas y Bodega habláis de "nueve hectáreas" con "90% son de la variedad Tempranillo, 10% Viura, 5% Graciano y el otro 5% de Malvasía" (un 110 %); además, el pie dice "Create a free web site with Weebly" y la web no está adaptada al móvil.

¿Os preparo gratis una maqueta con vuestros vinos, las fichas de cata y una tienda sencilla que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hotel Palacio Oxangoiti', 'Hotel pequeño en palacio', 'Lekeitio', 'Bizkaia', 'http://www.oxangoiti.net/', 'hotel@oxangoiti.net', '94 465 05 55 / 659 39 39 28', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Un palacio del siglo XVII con una web en ©2020', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'hotel@oxangoiti.net', 'oxangoiti.net', 'http://www.oxangoiti.net/', 'Bizkaia', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Palacio del siglo XVII habilitado como hotel en 2008, junto al ayuntamiento de Lekeitio; citado en el New York Times ("Basque Country, Without Borders")', 'alta', false, 'seed', 'hotel-oxangoiti', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Un palacio del siglo XVII con una web en ©2020
Fallos: No está adaptada al móvil: no tiene <meta name="viewport"> | Pie desactualizado: "©2020" | Teléfono duplicado en la portada: "Movil: 659 39 39 28" y "Móvil: 659 39 39 28" | Botón para compartir en Google Bookmarks (servicio cerrado en 2021); web sin redirección a HTTPS | Errata en tarifas: "Puente Diciembre: 3 noches /02/12 al 07/12)"

Hola, equipo del Hotel Oxangoiti:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Un palacio del siglo XVII junto al ayuntamiento de Lekeitio, y encima citado en el New York Times, es de esas cosas que dan ganas de reservar sin mirar más.

Os escribo porque la web no se adapta al móvil, en el pie sigue poniendo "©2020", en el contacto repetís "Movil: 659 39 39 28" y "Móvil: 659 39 39 28", y entre los botones para compartir sigue el de Google Bookmarks, un servicio que Google cerró en 2021.

¿Os preparo gratis una maqueta con las habitaciones, las tarifas 2026 y reserva directa desde el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hotel Metrokua Karraspio', 'Hotel pequeño de playa', 'Mendexa (Lekeitio)', 'Bizkaia', 'https://www.metrokua.com/', 'info@metrokua.com', '94 684 49 80', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestra web sigue con un botón de Google Bookmarks (cerró en 2021)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@metrokua.com', 'metrokua.com', 'https://www.metrokua.com/', 'Bizkaia', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Pequeño hotel de 9 habitaciones a orillas de la playa de Karraspio, frente a la isla de San Nicolás, a la que se puede cruzar con bajamar', 'media', false, 'seed', 'hotel-metrokua', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web sigue con un botón de Google Bookmarks (cerró en 2021)
Fallos: Hecha con Joomla 1.5 (generator "Joomla! 1.5", de 2008) y sin <meta name="viewport">: no adaptada al móvil | Botón para guardar en Google Bookmarks (cerrado en 2021) y enlace a turismo.euskadi.net (dominio antiguo) | Sin tildes en tarifas: "Cancelacion gratuita hasta una semana antes" y "se cobrara una noche" | Plantilla con "© 2003-2009 Think Network" en el código

Hola, equipo del Hotel Metrokua:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Nueve habitaciones a pie de la playa de Karraspio, con la isla de San Nicolás enfrente para cruzar con bajamar, es justo lo que uno se imagina cuando piensa en Lekeitio.

Os escribo porque la web está hecha con Joomla 1.5, una versión de 2008, y no se adapta al móvil; además sigue mostrando un botón para guardar en Google Bookmarks, que cerró en 2021, y en tarifas pone "Cancelacion gratuita" y "se cobrara una noche", sin tildes.

¿Os preparo gratis una maqueta con las habitaciones, las vistas y reserva directa desde el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Pensión Txomin Ostatua', 'Pensión', 'Etxebarria', 'Bizkaia', 'http://www.txominostatua.com/ES/index.html', 'txominostatua@gmail.com', '94 61 68 222', '', 'contactado', '', null, null, '', 'La portada principal está en euskera; los textos citados son de la versión /ES/.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'En vuestra web se llega de Bilbao "en conche"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'txominostatua@gmail.com', 'txominostatua.com', 'http://www.txominostatua.com/ES/index.html', 'Bizkaia', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Pensión en el centro de Etxebarria, al lado de la iglesia y el frontón, con las etapas del Camino de Santiago y el bidegorri a Markina, Ziortza y Bolibar', 'alta', false, 'seed', 'txomin-ostatua', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestra web se llega de Bilbao "en conche"
Fallos: Erratas en la versión en castellano: "De Bilbao estamos a 45 minutos en conche", "Trasporte publico", "Sevicios de la pension" | Pie desactualizado: "Copyright © 2014" | No está adaptada al móvil: no tiene <meta name="viewport"> | HTTPS roto (error TLS al entrar por https); email @gmail.com

Hola, equipo de Txomin Ostatua:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una pensión en el centro de Etxebarria, pegada a la iglesia y al frontón, con el Camino de Santiago y el bidegorri a Markina a la puerta, tiene todo para enamorar a peregrinos y ciclistas.

Os escribo porque en la versión en castellano se cuelan algunas erratas, como "De Bilbao estamos a 45 minutos en conche", "Trasporte publico" o "Sevicios de la pension"; además, el pie sigue en "Copyright © 2014", la web no se adapta al móvil y por https no carga.

¿Os preparo gratis una maqueta con las habitaciones, las etapas del Camino y reserva directa desde el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Ikestei Casa Rural - Restaurante', 'Agroturismo / casa rural con restaurante', 'Ziortza-Bolibar', 'Bizkaia', 'http://www.ikestei.net/es/conocenos/', 'ikestei@telefonica.net', '94 616 81 27', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'En vuestra web las 4 habitaciones salen dos veces (y "el negoció")', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'ikestei@telefonica.net', 'ikestei.net', 'http://www.ikestei.net/es/conocenos/', 'Bizkaia', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Caserío familiar: la carne es de su propia explotación, el pescado de Ondarroa, los postres los hace "la amatxu de la familia" y el Camino de Santiago del Norte pasa a 150 metros', 'media', false, 'seed', 'ikestei', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestra web las 4 habitaciones salen dos veces (y "el negoció")
Fallos: Párrafo duplicado seguido: "Consta de 4 habitaciones dobles con aseo, televisión y calefacción..." aparece dos veces | Erratas: "El negoció en todo momento ha sido regentado", "se habilito", "hacía Guernica" | Dirección contradictoria: "situado en el barrio Iruzubieta de Markina-Xemein" frente a "Barrio Zeinka-Ziarregi, 3 48278 Ziortza-Bolibar" | Sin HTTPS (la web no carga por https); WordPress 4.9 (2018)

Hola, equipo de Ikestei:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Carne de vuestra propia explotación, pescado de Ondarroa, postres de la amatxu y el Camino del Norte a 150 metros: con eso yo ya tendría mesa reservada.

Os escribo porque en la web el párrafo "Consta de 4 habitaciones dobles con aseo, televisión y calefacción" aparece dos veces seguidas, se cuelan erratas como "El negoció en todo momento ha sido regentado" o "se habilito", la dirección cambia entre "el barrio Iruzubieta de Markina-Xemein" y "Barrio Zeinka-Ziarregi, 3 48278 Ziortza-Bolibar", y la web no carga por https.

¿Os preparo gratis una maqueta con el menú de fin de semana, las habitaciones y reserva directa desde el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Restaurante Otzarreta', 'Restaurante', 'Zarautz', 'Gipuzkoa', 'http://www.restauranteotzarreta.com/', 'otzarreta@restauranteotzarreta.com', '943 131 243', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Zarautz no tiene el código postal 10800', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'otzarreta@restauranteotzarreta.com', 'restauranteotzarreta.com', 'http://www.restauranteotzarreta.com/', 'Gipuzkoa', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Abrió como sidrería en 1902, reabrió en 1962 con Eleuterio Guesalaga y Mª Jesús Lopetegui; famosos sus "Txampis" del domingo; hoy cuarta generación', 'alta', false, 'seed', 'otzarreta-zarautz', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Zarautz no tiene el código postal 10800
Fallos: Código postal erróneo en el pie: "C/ Santa Clara 5 - 10800 Zarautz" (el correcto, 20800, sí sale en Reservas) | No está adaptada al móvil: sin <meta name="viewport"> y maquetada con 10 tablas | El formulario cita la "Ley Orgánica 15.1999" (derogada en 2018) y pone "claúsula" | Bodega desactualizada y con errores: "Chivite 125 aniversario 2003", "Muga 2005", "Remelluri 2006 ( Navarra )"; errata "Lenguado a la parriila"

Hola, equipo de Otzarreta:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Abrir como sidrería en 1902, reabrir en 1962 y llegar a la cuarta generación, con los famosos "Txampis" del domingo de por medio, es una historia que ya quisieran muchos restaurantes.

Os escribo porque en el pie de la web pone "C/ Santa Clara 5 - 10800 Zarautz" (el bueno es el 20800, que sí aparece en Reservas), la web no se adapta al móvil y está maquetada con tablas, y el formulario de reservas sigue citando la "Ley Orgánica 15.1999", derogada desde 2018.

¿Os preparo gratis una maqueta con la carta, los menús especiales y reservas que funcionen bien desde el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hotel San Prudentzio', 'Hotel rural familiar', 'Getaria', 'Gipuzkoa', 'https://www.hotelsanprudentzio.com/', 'info@hotelsanprudentzio.com', '943 140 411', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', '"Difrute esta oferta por tan sólo €": ¿cuántos euros?', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@hotelsanprudentzio.com', 'hotelsanprudentzio.com', 'https://www.hotelsanprudentzio.com/', 'Gipuzkoa', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Tercera generación al frente de un proyecto que iniciaron sus abuelos hace más de 50 años; hotel rodeado de viñedos con vistas sobre Getaria', 'alta', false, 'seed', 'hotel-san-prudentzio', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: "Difrute esta oferta por tan sólo €": ¿cuántos euros?
Fallos: Oferta sin precio y con errata en la portada: "Difrute esta oferta por tan sólo € persona/día" | No está adaptada al móvil: sin <meta name="viewport"> y maquetada con 16 tablas | El icono de TripAdvisor del pie enlaza a la portada genérica https://www.tripadvisor.es/, no a su ficha | Errata en el pie: "Nª Registro E. Turístico"

Hola, equipo del Hotel San Prudentzio:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Tercera generación al frente de un hotel que empezaron vuestros abuelos, rodeado de viñedos de txakoli y con Getaria a los pies: lo de "sentirte como en casa" lo tenéis fácil.

Os escribo porque en la portada la oferta de visita a una bodega de txakoli dice "Difrute esta oferta por tan sólo € persona/día", con errata y sin precio; además, la web no se adapta al móvil (está montada con tablas y sin etiqueta viewport) y el icono de TripAdvisor del pie lleva a la portada genérica de TripAdvisor, no a vuestra ficha.

¿Os preparo gratis una maqueta con las habitaciones, las ofertas con su precio y reserva directa desde el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Restaurante Kiruri', 'Restaurante', 'Azpeitia', 'Gipuzkoa', 'http://www.kiruri.com', 'kiruri2020@gmail.com', '943 815 608', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestra web anuncia "¡Crea tu página web gratis!"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'kiruri2020@gmail.com', 'kiruri.com', 'http://www.kiruri.com', 'Gipuzkoa', 'guzman', 'guzmangonzalez.twati@gmail.com', '"Cocinando con gusto desde 1847"; antiguamente era una sidrería llamada Etxaniz', 'media', false, 'seed', 'kiruri-azpeitia', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web anuncia "¡Crea tu página web gratis!"
Fallos: El dominio kiruri.com redirige a kiruri-jatetxea.webnode.es (plan gratuito) | Banner visible "¡Crea tu página web gratis!" y "Creado con Webnode" | Pie desactualizado: "Copyright © 2019 Kiruri" | "Nuestras ofertas" lista "Menú del día", "Menú fin de semana", "Menú infantil"... sin precios ni contenido; email @gmail.com; en el código queda "contacto@ejemplo.com"

Hola, equipo de Kiruri:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. "Cocinando con gusto desde 1847" y con pasado de sidrería, la antigua Etxaniz: pocos restaurantes de Gipuzkoa pueden presumir de tanta historia en el plato.

Os escribo porque kiruri.com os manda a una dirección de Webnode, en la página aparece el banner "¡Crea tu página web gratis!", el pie sigue en "Copyright © 2019" y en "Nuestras ofertas" salen el menú del día, el de fin de semana o el infantil sin precio ni detalle.

¿Os preparo gratis una maqueta con la carta, los menús con precio y reservas que funcionen bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hotel Restaurante Gurutze-Berri', 'Hotel y restaurante familiar', 'Oiartzun', 'Gipuzkoa', 'http://www.gurutzeberri.com/castellano.php', 'gurutzeberri@gurutzeberri.com', '943 490 625', 'Xabier y Gorka Zapirain', 'propuesta_enviada', 'Web completa', 490, 'fijo', 'Seguimiento de la propuesta', 'La carta de presentación de la web la firman Xabier y Gorka Zapirain. Contestaron el 7 oct: "ok pasame un borrador y si es a buen precio hablamos". Maqueta (3 imágenes) y propuesta de 490 € (castellano; los otros idiomas, aparte) enviadas el 8 oct, proponiendo una llamada de 10 minutos. · Maqueta y propuesta enviadas el 8 oct.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestra web sigue celebrando el 50 aniversario (el de 2019)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'gurutzeberri@gurutzeberri.com', 'gurutzeberri.com', 'http://www.gurutzeberri.com/castellano.php', 'Gipuzkoa', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Más de 50 años de la familia Zapirain al frente; cocina dirigida por Xabier Zapirain, con especialidades de caza en temporada', 'alta', false, 'seed', 'gurutze-berri', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (pipeline).
Asunto: Vuestra web sigue celebrando el 50 aniversario (el de 2019)
Fallos: La portada sigue celebrando el "50 aniversario: 1969 - 2019" | Contradicción: "cuenta con cuatro comedores" en Presentación y "Contamos con tres amplios comedores" en Restaurante | Errata: "commemoraciones"; menú en castellano con "Home-Page" | No está adaptada al móvil (sin <meta name="viewport">, maquetada con tablas) y sin HTTPS (https no responde)

Hola, Xabier y Gorka:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Más de cincuenta años de la familia Zapirain al frente de Gurutze-Berri y una cocina con especialidades de caza en temporada: eso no se improvisa.

Os escribo porque la portada sigue anunciando el "50 aniversario: 1969 - 2019", en un apartado decís que contáis con "cuatro comedores" y en otro con "tres amplios comedores", se cuela un "commemoraciones" y la web, maquetada con tablas, ni se adapta al móvil ni carga por https.

¿Os preparo gratis una maqueta con el hotel, el restaurante y reserva directa desde el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Rural Maialde', 'Casa rural con restaurante', 'Elgeta', 'Gipuzkoa', 'http://www.casaruralmaialde.com/cas/', 'maialde@casaruralmaialde.com', '943 789 107', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'La última noticia de vuestra web es de junio de 2012', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'maialde@casaruralmaialde.com', 'casaruralmaialde.com', 'http://www.casaruralmaialde.com/cas/', 'Gipuzkoa', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Llevada por Jesús e Izarra con sus hijas Paule y Marene; ganaron el primer premio al mejor pintxo del IV campeonato de pintxos de Elgeta y son el único hotel del casco antiguo', 'alta', false, 'seed', 'maialde-elgeta', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: La última noticia de vuestra web es de junio de 2012
Fallos: La última noticia publicada es de "junio 15, 2012" | Pie desactualizado: "Todos los derechos reservados. 2011." | Erratas: "toda Esukadi", miniatura del slider titulada "Mailade", "estais en vuestra casa" | No está adaptada al móvil: no tiene <meta name="viewport">; enlace a turismo.euskadi.net (dominio antiguo)

Hola, Jesús e Izarra:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Ganar el primer premio al mejor pintxo del campeonato de Elgeta y ser el único hotel del casco antiguo del pueblo son dos credenciales que ya quisieran muchos.

Os escribo porque la última noticia de la web es del "junio 15, 2012", el pie sigue en "Todos los derechos reservados. 2011.", en la portada se cuela "toda Esukadi" y la web no está adaptada al móvil.

¿Os preparo gratis una maqueta con las habitaciones, el restaurante y reserva directa desde el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Quitapenas', 'Restaurante de pa amb oli', 'Valldemossa', 'Illes Balears', 'https://www.quitapenasvalldemossa.com', 'quitapenas.valldemossa@gmail.com', '+34 600 73 96 66', '', 'contactado', '', null, null, '', 'Dueños: Alessandro y Massimo (sección Nosotros).', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestra web dice que Valldemossa está en "Spagna"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'quitapenas.valldemossa@gmail.com', 'quitapenasvalldemossa.com', 'https://www.quitapenasvalldemossa.com', 'Illes Balears', 'guzman', 'guzmangonzalez.twati@gmail.com', 'El local fue "Can Jordi", el principal colmado del pueblo de 1900 a 1978, atendido por el famoso "Tio" Jordi; cerrado hasta 2019, hoy es "templo del fast food mallorquín, el pa amb oli"', 'alta', false, 'seed', 'quitapenas-valldemossa', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web dice que Valldemossa está en "Spagna"
Fallos: Dirección con el país en italiano: "Carrer Vell, 4, 07170 Valldemossa, Illes Balears, Spagna" (la web está declarada como lang="it-IT") | Errata: "En el caso antiguo de Valldemossa" (casco) | Sin tildes: "esta receta mitica", "una casa tipica mallorquina" | Texto de plantilla en el pie: "Proudly powered by WordPress"

Hola, Alessandro y Massimo:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Devolverle la vida al antiguo colmado del "Tio" Jordi para convertirlo en un templo del pa amb oli es de las mejores reconversiones que he visto en la Tramuntana.

Os escribo porque en el contacto la dirección acaba en "Illes Balears, Spagna", en la presentación se lee "En el caso antiguo de Valldemossa", faltan tildes en "receta mitica" y "casa tipica", y el pie todavía dice "Proudly powered by WordPress".

¿Os preparo gratis una maqueta con la carta de pambolis, horarios y cómo llegar desde la Cartuja? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Restaurant Nama & Gastro Bar', 'Restaurante', 'Deià', 'Illes Balears', 'https://www.restaurantnama.com', 'info@nama-deia.es', '+34 971 636 102', '', 'contactado', '', null, null, '', 'Web Wix responsive; el pitch va por plantilla sin cambiar y erratas.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'En Google vuestra web se llama "My Site"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@nama-deia.es', 'nama-deia.es', 'https://www.restaurantnama.com', 'Illes Balears', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Chef propietaria Bonnie Han, cocina del sudeste asiático entre sus raíces de Singapur y Australia, en Deià desde 2017; "Good doggies are welcomed"', 'media', false, 'seed', 'nama-deia', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En Google vuestra web se llama "My Site"
Fallos: El título de la web (pestaña y Google) es el de plantilla de Wix: "Home | My Site" | Errata en horarios: "Cerrarado Martes y Miercoles" | Errata: "una copa de nuestra seleccionada bodega para maridad nuestra apetitosa cocina" | En inglés: "seemlessly blending traditional reciepes"

Hola, Bonnie y equipo de Nama:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Cocina de Singapur con raíces australianas en mitad de Deià, y encima con los perros bienvenidos: pocas cartas de la Tramuntana sorprenden tanto.

Os escribo porque el título de la web sigue siendo el de la plantilla, "Home | My Site", que es lo que sale en la pestaña y en Google; en los horarios pone "Cerrarado Martes y Miercoles", en el texto "para maridad nuestra apetitosa cocina" y en inglés "seemlessly blending traditional reciepes".

¿Os preparo gratis una maqueta con carta, horarios de temporada y reserva directa? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Ca''s Curial', 'Agroturismo / hotel rural pequeño', 'Sóller', 'Illes Balears', 'https://www.cascurial.com', 'info@cascurial.com', '+34 971 633 332', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestro blog lleva vacío desde 2014 (y se ha colado una "Ámplia")', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@cascurial.com', 'cascurial.com', 'https://www.cascurial.com', 'Illes Balears', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Tres casas de campo que se remontan a la época musulmana, aisladas del pueblo por un naranjal, y el propietario recibe en persona con un cóctel de bienvenida', 'alta', false, 'seed', 'cas-curial-soller', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestro blog lleva vacío desde 2014 (y se ha colado una "Ámplia")
Fallos: Pie de portada "© 2016 C''as Curial" (con el apóstrofo mal puesto) | El blog ("Noticias y Novedades") está vacío: "Categorias" y "Últimos Posts" sin contenido y pie "© 2014" | Erratas: "Para reserva la finca Can Pons", "Ámplia piscina privada", "En perfecta harmonia", "beneficiate de las multiples ventajas" | El aviso de cookies del blog cita el Real Decreto-ley 13/2012

Hola, equipo de Ca''s Curial:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Tres casas de época musulmana separadas de Sóller por un naranjal, y el dueño esperando con un cóctel: así cualquiera se olvida del coche de alquiler.

Os escribo porque el blog de "Noticias y Novedades" está vacío y firmado "© 2014", la portada dice "© 2016 C''as Curial" con el apóstrofo bailando, y se han colado un "Para reserva la finca Can Pons", una "Ámplia piscina privada" y una "perfecta harmonia".

¿Os preparo gratis una maqueta con reserva directa y la finca Can Pons bien presentada? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Cafè Parisien', 'Café-restaurante', 'Artà', 'Illes Balears', 'https://cafeparisien.es', 'administracio@restaurantcafeparisien.com', '971 83 54 40', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestras dos webs dicen "muy pronto"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'administracio@restaurantcafeparisien.com', 'restaurantcafeparisien.com', 'https://cafeparisien.es', 'Illes Balears', 'guzman', 'guzmangonzalez.twati@gmail.com', '"Bohemio café de aire vintage con terraza ajardinada que sirve desayunos, vermús y moderna cocina de mercado"', 'alta', false, 'seed', 'cafe-parisien-arta', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestras dos webs dicen "muy pronto"
Fallos: La web es una única página provisional: "Estamos trabajando en nuestra nueva página web. Muy pronto estará disponible con todas las funcionalidades." | Sin <meta name="viewport">: no adaptada al móvil | El dominio de su email (restaurantcafeparisien.com) muestra otro aviso: "Próximamente ... En construcción. Regresa pronto para ver las novedades." | Ni carta ni horarios en la web

Hola, equipo del Cafè Parisien:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Un café bohemio con terraza ajardinada y vermú en pleno Artà suena a plan de tarde perfecto; ahora solo falta que internet se entere.

Os escribo porque cafeparisien.es es una sola página que dice "Estamos trabajando en nuestra nueva página web. Muy pronto estará disponible", restaurantcafeparisien.com (el dominio de vuestro email) responde "En construcción. Regresa pronto", no aparecen ni la carta ni los horarios y la página no está adaptada al móvil.

¿Os preparo gratis una maqueta con la carta, horarios y cómo llegar, lista para el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Font i Roig', 'Casa de turismo de interior con spa', 'Maria de la Salut', 'Illes Balears', 'https://fontiroig.com/es/inicio/', 'info@fontiroig.com', '+34 971 85 80 07', '', 'contactado', '', null, null, '', 'Web principal en alemán; email en castellano según lo pedido.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestra web sigue anunciando que los restaurantes "han reabierto"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@fontiroig.com', 'fontiroig.com', 'https://fontiroig.com/es/inicio/', 'Illes Balears', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Casa señorial de 1520 de la familia Font i Roig, cuna de Julián Font i Roig, "El Santo Padre", con capilla y una fuente árabe del siglo XII; la recompraron en 2014 y le devolvieron su nombre original', 'alta', false, 'seed', 'casa-font-i-roig', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web sigue anunciando que los restaurantes "han reabierto"
Fallos: La versión en castellano tiene el título en alemán: "Romantisches Landhotel mit SPA im Landesinneren" | Sigue el aviso de reapertura: "nuestra casa ha vuelto a abrir ... Los restaurantes cercanos, también han reabierto" | Traducción literal: "un jardín del área de 18.000 qm" (qm es la abreviatura alemana de m²) y "profesor de novatos" | Errata: "convertido en una hostería con del nombre Casa Girasol"

Hola, equipo de Casa Font i Roig:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una casa de 1520 con capilla, fuente árabe del siglo XII y la casa natal de Julián Font i Roig: no hay hotel boutique de Palma que pueda competir con ese currículum.

Os escribo porque en la versión en castellano el título sigue en alemán ("Romantisches Landhotel mit SPA im Landesinneren"), la portada todavía anuncia que "nuestra casa ha vuelto a abrir" y que los restaurantes "también han reabierto", el jardín mide "18.000 qm" y Julián Font i Roig aparece como "profesor de novatos".

¿Os preparo gratis una maqueta con reserva directa en castellano, alemán e inglés bien traducidos? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Son Juaneda Agroturismo', 'Agroturismo (9 habitaciones)', 'Ciutadella de Menorca', 'Illes Balears', 'https://sonjuaneda.com/es/', 'agroturismo@sonjuaneda.com', '+34 686 404 275', '', 'contactado', '', null, null, '', 'Web responsive; el pitch va por contenido caducado y enlace muerto.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'El "Protocolo COVID-19" de vuestra web lleva a la portada', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'agroturismo@sonjuaneda.com', 'sonjuaneda.com', 'https://sonjuaneda.com/es/', 'Illes Balears', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Casa de campo menorquina del siglo XVIII que Jerónimo Capella compró en 1967 para volver al campo; hoy agroturismo familiar de 9 habitaciones famoso por sus "desayunos como los de antaño"', 'media', false, 'seed', 'son-juaneda-ciutadella', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: El "Protocolo COVID-19" de vuestra web lleva a la portada
Fallos: El menú principal sigue enlazando "Protocolo COVID-19", y /covid-19 redirige a la portada (la página ya no existe) | Pie con "© 2020 Son Juaneda Agroturismo" | Redacción: "En el 1967 Jerónimo Capella adquirió..."

Hola, equipo de Son Juaneda:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Que una casa del XVIII se comprara en 1967 para huir del estrés de la ciudad y hoy reciba a la gente con desayunos como los de antaño es casi un anuncio de Menorca en sí mismo.

Os escribo porque el menú principal sigue mostrando "Protocolo COVID-19" y al pinchar te devuelve a la portada porque la página ya no existe, el pie dice "© 2020" y en la historia se lee "En el 1967 Jerónimo Capella adquirió".

¿Os preparo gratis una maqueta con reserva directa más clara y la historia de la casa bien contada? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hotel Rural El Valle', 'Hotel rural familiar', 'Rascafría', 'Madrid', 'https://www.hotelruralelvalle.com', 'reservas@hotelruralelvalle.com', '91 869 12 13', '', 'contactado', '', null, null, '', 'Familiar pero con 30 habitaciones; el más grande de la lista.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'En vuestra web pone "Rascafr&iacute;a" (y Eventos está vacía)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'reservas@hotelruralelvalle.com', 'hotelruralelvalle.com', 'https://www.hotelruralelvalle.com', 'Madrid', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Alojamientos "muy coloridos y divertidos, todos con vistas a la Sierra", suites abuhardilladas con luz cenital y hasta horario del bus a Cotos en la web', 'alta', false, 'seed', 'hotel-rural-el-valle', '2026-10-07T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestra web pone "Rascafr&iacute;a" (y Eventos está vacía)
Fallos: Sin <meta name="viewport">: no está adaptada al móvil; el doctype es incluso "XHTML Mobile 1.0" de WAP (plantilla Dreamweaver) | Portada maquetada con 5 tablas | En la página de Noticias se ve literalmente "Rascafr&iacute;a (7.896 ha.)" (entidad HTML mal escapada) | La única noticia es la declaración del Parque Nacional de Guadarrama ("Primer Parque Nacional en la historia de la región"), de 2013 | La página de Eventos está vacía

Hola, equipo del Hotel Rural El Valle:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Suites abuhardilladas con luz cenital, habitaciones "muy coloridas y divertidas" y el horario del bus a Cotos a mano: se nota que pensáis en el que llega con las botas puestas.

Os escribo porque vuestra web no está adaptada al móvil (está hecha para los móviles WAP de hace veinte años, literalmente lo pone el código), en Noticias aparece escrito "Rascafr&iacute;a", la única noticia es la del Parque Nacional de 2013 y la página de Eventos sale en blanco.

¿Os preparo gratis una maqueta con reserva directa y tarifas que se lean bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-07T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Restaurante La Isla', 'Restaurante rural', 'Rascafría', 'Madrid', 'https://www.restaurantelaisla.eu', 'restaurantelaisla@hotmail.com', '680 46 13 28', '', 'contactado', '', null, null, '', 'Titular en el aviso legal: Arturo Velasco Gualda.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestra web pide usar Chrome para reservar (y se ha colado una "carrtera")', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'restaurantelaisla@hotmail.com', 'restaurantelaisla.eu', 'https://www.restaurantelaisla.eu', 'Madrid', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Restaurante en plena naturaleza al que se llega cruzando a pie el puente sobre el río Lozoya; especialidad en rabo de toro, judiones de Rascafría y jabalí con chocolate', 'alta', false, 'seed', 'restaurante-la-isla', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web pide usar Chrome para reservar (y se ha colado una "carrtera")
Fallos: Sin <meta name="viewport"> en ninguna página: no adaptada al móvil | Email de empresa en @hotmail (restaurantelaisla@hotmail.com) | Erratas: "Situado en la carrtera M-604" y "Solo se adimiten perros en terraza" | La página de reservas pide usar Chrome o Safari porque el pago con tarjeta da problemas: "Inténtelo desde Google Chrome si puede ser o en su defecto, Safari" | Texto legal citando la LOPD 15/1999, derogada en 2018

Hola, equipo de La Isla:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Un restaurante al que hay que llegar cruzando un puente sobre el Lozoya y que encima sirve jabalí con chocolate tiene media batalla ganada antes de abrir la carta.

Os escribo porque la página de reservas pide al cliente que lo intente "desde Google Chrome si puede ser o en su defecto, Safari" porque el pago falla, la web no se adapta al móvil, se han colado un "Situado en la carrtera M-604" y un "Solo se adimiten perros en terraza", y el texto legal todavía cita la Ley 15/1999, que se derogó en 2018.

¿Os preparo gratis una maqueta con la carta, cómo llegar (puente incluido) y una reserva que funcione en cualquier móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Rey de Patones', 'Restaurante', 'Patones de Arriba', 'Madrid', 'https://www.reydepatones.com', 'reservasreydepatones@gmail.com', '91 843 20 37', '', 'contactado', '', null, null, '', 'Web en Squarespace, sí es responsive; el pitch va por errores y contacto roto.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'El email de vuestra web lleva a una dirección de hotmail', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'reservasreydepatones@gmail.com', 'reydepatones.com', 'https://www.reydepatones.com', 'Madrid', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Primer restaurante de Patones de Arriba, desde 1970; Manolo y Mari, bailarines que recorrieron el mundo, se retiraron allí; hoy sigue Emily, formada en Le Cordon Bleu', 'media', false, 'seed', 'rey-de-patones', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: El email de vuestra web lleva a una dirección de hotmail
Fallos: El texto dice "e-mail: reservas reydepatones@gmail.com" pero el enlace apunta a "mailto: reydepatones@hotmail.com" (otra dirección distinta) | Pie con "Todos los derechos reservados © 2015" | Erratas: "un paisaje inmejorable, contemplado la arquitectura típica" y "las historias contados por Manolo"

Hola, equipo del Rey de Patones:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Que el primer restaurante de Patones de Arriba lo abrieran en 1970 dos bailarines que habían recorrido el mundo es de esas historias que no se pueden inventar.

Os escribo porque en la web pone "e-mail: reservas reydepatones@gmail.com" pero al pinchar se abre un correo a "reydepatones@hotmail.com", el pie sigue en "© 2015" y se han colado un "contemplado la arquitectura típica" y unas "historias contados por Manolo".

¿Os preparo gratis una maqueta con la carta y la reserva directa desde el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Horno de Lozoya', 'Obrador de pan y repostería ecológica', 'Lozoya', 'Madrid', 'http://hornolozoya.es', 'info@hornolozoya.es', '692 26 40 89', '', 'perdido', '', null, null, '', 'Email rebotó (8 oct). Llamar al 692 26 40 89.', false, '', true, 'Email rebotó (8 oct). Llamar al 692 26 40 89.', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestros cursos de pan siguen anunciando marzo, abril y mayo', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@hornolozoya.es', 'hornolozoya.es', 'http://hornolozoya.es', 'Madrid', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Pan ecológico de masa madre en horno de leña y "yemas de montaña" hechas con mantequilla de cabra', 'alta', false, 'seed', 'horno-de-lozoya', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (rebote).
Asunto: Vuestros cursos de pan siguen anunciando marzo, abril y mayo
Fallos: Sin HTTPS: https://hornolozoya.es redirige a la versión http (sin candado) | En Cursos y Eventos las "PRÓXIMAS FECHAS" son "14 de marzo, 19 de abril, 17 de mayo", sin año (imágenes subidas en 2015) | Enlaces rotos (404): elpuentedelmolino.es/Recoge-tu-propia-cosecha/ y espacioinquietudes.com/pan | WordPress 5.2 (de 2019) sin actualizar

Hola, equipo del Horno de Lozoya:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Las yemas de montaña con mantequilla de cabra y el pan de masa madre en horno de leña son exactamente el motivo por el que la gente sube a Lozoya un domingo.

Os escribo porque la web no tiene HTTPS (si entras con https os manda a la versión sin candado), en Cursos y Eventos las "PRÓXIMAS FECHAS" siguen siendo "14 de marzo, 19 de abril, 17 de mayo" en pleno octubre, y los enlaces a El Puente del Molino y a Espacio Inquietudes dan error 404.

¿Os preparo gratis una maqueta con los puntos de venta, un calendario de cursos fácil de actualizar y pedidos desde el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('La Posada de los Vientos', 'Hotel rural con restaurante', 'La Acebeda', 'Madrid', 'http://laposadadelosvientos.es', 'info@laposadadelosvientos.es', '91 869 91 95 / 619 392 742', '', 'contactado', '', null, null, '', '9 habitaciones dobles.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'El botón de Noticias de vuestra web da un 404 (y el de Bono Regalo también)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@laposadadelosvientos.es', 'laposadadelosvientos.es', 'http://laposadadelosvientos.es', 'Madrid', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Edificio del siglo XVIII; el restaurante ocupa la antigua bodega y la cuadra, con sillas del carpintero local teñidas de verde; y describen los acebos como "los eremitas de los árboles del bosque"', 'alta', false, 'seed', 'posada-de-los-vientos', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: El botón de Noticias de vuestra web da un 404 (y el de Bono Regalo también)
Fallos: El botón "Noticias" del menú (/blog/) da 404 "Not Found", y la portada dice "Accede a todas nuestras promociones desde nuestra sección de noticias" | "Bono Regalo" (/category/bono-regalo/) y "Términos y condiciones" también dan 404 | La galería de la portada está fechada "mayo 7, 2015" | Texto repetido: "Situada en la Sierra Norte de Madrid, en el Parque Nacional del Guadarrama, en la Sierra Norte de Madrid"

Hola, equipo de La Posada de los Vientos:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Comer en la antigua cuadra de una casona del XVIII, en sillas del carpintero del pueblo, y leer que los acebos son "los eremitas de los árboles del bosque" ya justifica el viaje a La Acebeda.

Os escribo porque la portada invita a ver las promociones en la sección de noticias, pero el botón "Noticias" da error 404, igual que "Bono Regalo" y "Términos y condiciones"; además la galería sigue fechada en "mayo 7, 2015" y en el texto la Sierra Norte sale dos veces en la misma frase.

¿Os preparo gratis una maqueta con reserva directa y bonos regalo que se puedan comprar online? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Bodegas Muñoz Martín', 'Bodega familiar D.O. Vinos de Madrid', 'Navalcarnero', 'Madrid', 'https://www.bodegasmunozmartin.com', 'infobodegasmunozmartin@gmail.com', '91 811 05 24', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalez.twati@gmail.com', 'Vuestra web está "ceada" por Delivertia (y la última noticia es de 2017)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'infobodegasmunozmartin@gmail.com', 'bodegasmunozmartin.com', 'https://www.bodegasmunozmartin.com', 'Madrid', 'guzman', 'guzmangonzalez.twati@gmail.com', 'Bodega familiar en pleno casco antiguo de Navalcarnero, fundada "por el año 1930", con cueva propia y la 5ª generación al frente; Sedro Negral Crianza 2013, Viña de Oro 2016', 'alta', false, 'seed', 'bodegas-munoz-martin', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web está "ceada" por Delivertia (y la última noticia es de 2017)
Fallos: Pie de página: "Web ceada por Delivertia Marketing" | Las últimas noticias son "VIÑA JESUSA TINTO 2016 – PREMIO VIÑA DE PLATA 2017" (y otras de 2016) empezando por "Este año, se ha celebrado..." | Una llave de cierre suelta visible junto al botón "Enviar" del formulario | Email de empresa en @gmail

Hola, equipo de Bodegas Muñoz Martín:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Cinco generaciones y una cueva en pleno casco antiguo de Navalcarnero: hay bodegas que pagarían por tener una historia así para contarla en una cata.

Os escribo porque en el pie de la web pone "Web ceada por Delivertia Marketing", las noticias de portada se quedaron en el premio de 2017 ("Este año, se ha celebrado..."), junto al botón "Enviar" asoma un símbolo de código suelto y el contacto es un @gmail.

¿Os preparo gratis una maqueta con tienda que funcione bien en el móvil y reserva de visitas a la cueva? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Centro de Estudios Murcia (Academia CEM)', 'Academia', 'Murcia', 'Murcia', 'https://www.centrodestudiosmurcia.com', 'info@academiacem.es', '968 90 60 22', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Vuestras "últimas plazas" de enero de 2020', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@academiacem.es', 'academiacem.es', 'https://www.centrodestudiosmurcia.com', 'Murcia', 'guzman', null, 'Maestros, doctores y preparadores de oposiciones junto al tranvía Marina Española', 'alta', false, 'seed', 'cem', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestras "últimas plazas" de enero de 2020
Fallos: Portada anuncia ''ÚLTIMAS PLAZAS'' para cursos con inicio en enero 2020 | Enlaces de ''Iniciar sesión / Editar página'' visibles al público | Teléfono repetido y campo Fax vacío

Hola, equipo de CEM:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Entrando en vuestra web vi en la portada "ÚLTIMAS PLAZAS" para los intensivos de B1/B2 con inicio en enero de 2020. O esas plazas se están vendiendo muy despacio, o la web necesita un repaso (apuesto por lo segundo).

También se ven los enlaces de "Iniciar sesión / Editar página" para cualquier visitante y el teléfono sale repetido.

Con un equipo de maestros, doctores y preparadores de oposiciones, la web debería vender lo que sois. ¿Os hago gratis una maqueta de la portada y la valoráis sin compromiso?', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Pastisseria Pla', 'Pastelería / obrador', 'Igualada (Anoia)', 'Barcelona', 'http://www.pastisseriapla.com', 'info@pastisseriapla.com', '938 032 913', '', 'contactado', '', null, null, '', 'Dos tiendas en Igualada (Av. Barcelona 22 y Rambla Nova 43).', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestro sacher se ha convertido en "sacmer"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@pastisseriapla.com', 'pastisseriapla.com', 'http://www.pastisseriapla.com', 'Barcelona', 'guzman', 'guzmangonzalezperez@gmail.com', 'Las Coques d''Igualada las creó el senyor Pla en 1920 porque la N-II pasaba por delante de la pastelería y el viajero no tenía ningún producto típico que llevarse; tradición desde 1888.', 'alta', false, 'seed', 'pastisseria-pla-igualada', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestro sacher se ha convertido en "sacmer"
Fallos: Sin <meta name="viewport">: no está adaptada al móvil (carga además hojas ie6.css/ie7.css/ie8.css) | HTTPS roto: el certificado es de "shwin302.axarnet.es", no de pastisseriapla.com (el navegador muestra aviso de seguridad) | Errata en la página de contacto: "pastissos com el sacmer" (en otra página pone "sacher") | Texto en castellano colado en la web en catalán: "Tradición desde 1888"; además "son les coques" sin acento y "major brevetat posible" | Pie con "Pastisseria Pla © 2020"

Hola, equipo de Pastisseria Pla:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Me encanta que el senyor Pla inventara las Coques d''Igualada en 1920 solo porque la N-II pasaba por delante y los viajeros no tenían nada típico que llevarse: eso es marketing de carretera con más de cien años.

Os escribo porque en la web hay un par de cosas que no hacen justicia a la coca: en contacto el sacher aparece como "sacmer", se cuela un "Tradición desde 1888" en castellano en mitad del catalán, la página no se adapta al móvil y al entrar por https el navegador avisa de que el certificado no es vuestro (es de un servidor de axarnet).

¿Os preparo gratis una maqueta con vuestras especialidades, las dos tiendas con cómo llegar y encargos de coques que funcionen bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Fleca Tascó', 'Obrador de pan ecológico (cooperativa)', 'Igualada (Anoia)', 'Barcelona', 'http://www.flecatasco.com', 'flecatasco@flecatasco.com', '93 808 40 92', '', 'contactado', '', null, null, '', 'Es una cooperativa (no franquicia). Teléfono y fax en la página de contacto.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra web dice que lleváis 20 años (y ya van unos cuantos más)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'flecatasco@flecatasco.com', 'flecatasco.com', 'http://www.flecatasco.com', 'Barcelona', 'guzman', 'guzmangonzalezperez@gmail.com', 'Cooperativa nacida en 1985 que hace pan 100% integral, de espelta, con lino y sésamo, y que en sus inicios montó el Forn de Llenya de Castellolí.', 'alta', false, 'seed', 'fleca-tasco-igualada', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web dice que lleváis 20 años (y ya van unos cuantos más)
Fallos: Maquetada con tablas (4-5 <table> por página) y sin <meta name="viewport">: no se adapta al móvil | Texto desfasado en ¿Quienes somos?: nació en 1985 y dice "A lo largo de 20 años han sido muchos los profesionales..." | Errata: "construir un mar menos jerarquizado e igualitario" (falta ''marco'') | El enlace a la tienda online "Andaira" (andairaonline.com) no resuelve: dominio muerto | La página "¿Donde puede encontrar nuestros productos?" está vacía, sin listado de tiendas; además faltan tildes en el menú ("¿Quienes somos?", "¿Donde estamos?")

Hola, equipo de Fleca Tascó:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Hacer pan de espelta y 100% integral desde 1985, cuando lo ecológico todavía sonaba a cosa rara, tiene mucho mérito (y lo del Forn de Llenya de Castellolí suena a pan del bueno).

Os escribo porque la web se ha quedado un poco atrás: en ¿Quienes somos? sigue poniendo "A lo largo de 20 años", hay una errata simpática en "construir un mar menos jerarquizado", el enlace a la tienda online Andaira lleva a un dominio que ya no existe y la página "¿Donde puede encontrar nuestros productos?" está vacía. Además está hecha con tablas y no se adapta al móvil.

¿Os preparo gratis una maqueta con vuestros panes, un mapa de tiendas donde encontrarlos y un formulario de pedidos para tiendas que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hostal Restaurant Alt Llobregat', 'Hostal y restaurante familiar', 'Castellar de n''Hug (Berguedà)', 'Barcelona', 'https://www.altllobregat.com', 'info@altllobregat.com', '93 825 70 74', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestro menú de grupos tiene una "dispocsició" curiosa', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@altllobregat.com', 'altllobregat.com', 'https://www.altllobregat.com', 'Barcelona', 'guzman', 'guzmangonzalezperez@gmail.com', 'Hostal familiar en el mismo pueblo de Castellar de n''Hug, donde nace el Llobregat; cocina casera con setas de temporada y sus peus de porc amb bolets.', 'alta', false, 'seed', 'hostal-alt-llobregat', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestro menú de grupos tiene una "dispocsició" curiosa
Fallos: Sin <meta name="viewport">: no se adapta al móvil (carga style_ie6.css y style_ie7.css) | Erratas en Menús grups: "Els posem a la seva dispocsició" y "es poden adrerçar per fer les reserves" | Frase rota en la portada: "El Hostal atent en Català, Castellà, Francés i Anglés" | Los menús de grupo no muestran precio aunque pone "Preus amb IVA inclòs"; sin reserva online, solo teléfono, fax y email

Hola, equipo del Hostal Alt Llobregat:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Dormir en el pueblo donde nace el Llobregat y cenar peus de porc amb bolets suena a plan redondo; no me extraña que la gente repita.

Os escribo porque la web tiene algunos detalles que se notan: en Menús grups pone "a la seva dispocsició" y "es poden adrerçar", en la portada aparece "El Hostal atent en Català, Castellà, Francés i Anglés", los menús dicen "Preus amb IVA inclòs" pero no sale ningún precio, y en el móvil la página no se adapta.

¿Os preparo gratis una maqueta con la carta, los menús de grupo con precio, cómo llegar y reserva directa de habitaciones desde el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('La Roda - Hostal de muntanya', 'Hostal rural con restaurante', 'Avià (Berguedà)', 'Barcelona', 'https://www.hostallaroda.com', 'info@hostallaroda.com', '938 231 825 / 679 303 444', '', 'contactado', '', null, null, '', 'En reservas aparece Roser como contacto (679 303 444).', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'En vuestra web salen unas "clelebracions"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@hostallaroda.com', 'hostallaroda.com', 'https://www.hostallaroda.com', 'Barcelona', 'guzman', 'guzmangonzalezperez@gmail.com', 'Hostal de muntanya a 3 km de Berga con esmorzars de forquilla: pa de pagès amb tomàquet, botifarra casolana i embotits del Berguedà.', 'alta', false, 'seed', 'hostal-la-roda-avia', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestra web salen unas "clelebracions"
Fallos: Sin <meta name="viewport"> en ninguna página: no se adapta al móvil | Errata en Restaurant: "Espai perfecte per a tot tipus de clelebracions" | Erratas en Activitats: "ique et descobriran", "paistages d''interès", "per les seves singularitats.e.", "tots tene un interès" y "bons homes o catàrs" | Las reservas son un formulario sin calendario ni disponibilidad

Hola, equipo de La Roda:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Un esmorzar de forquilla con pa de pagès y botifarra casolana a 3 km de Berga es exactamente el tipo de cosa por la que uno se desvía de la carretera.

Os escribo porque la web tiene unas cuantas erratas que se ven mucho: en el restaurante pone "tot tipus de clelebracions", y en actividades aparecen "paistages d''interès", "tots tene un interès" y "singularitats.e.". Además ninguna página se adapta al móvil y la reserva es un formulario sin disponibilidad.

¿Os preparo gratis una maqueta con habitaciones, tarifas y reserva directa con calendario que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Cansaladeria Singla', 'Charcutería / embutidos artesanos', 'Navarcles (Bages)', 'Barcelona', 'http://www.cansingla.com', 'cansingla@hotmail.com', '938 270 380', '', 'perdido', '', null, null, '', 'Manel Singla contestó el 8 oct: viven de sus dos tiendas, dejaron la venta online por el coste del envío en frío y tienen una empresa que les lleva el dominio con poco presupuesto. Guarda el contacto por si cambian de opinión. Respondido el 9 oct con un consejo sobre los Warning de PHP.', false, '', false, 'Manel Singla contestó el 8 oct: viven de sus dos tiendas, dejaron la venta online por el coste del envío en frío y tienen una empresa que les lleva el dominio con poco presupuesto. Guarda el contacto por si cambian de opinión. Respondido el 9 oct con un consejo sobre los Warning de PHP.', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra web saluda con un "Warning" de PHP', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'cansingla@hotmail.com', 'cansingla.com', 'http://www.cansingla.com', 'Barcelona', 'guzman', 'guzmangonzalezperez@gmail.com', 'La fundaron en 1968 Francisco Singla (que era paleta) y Manola Soto, porque el tiet Joan le dijo: "Francisco a Navarcles el que hi fa falta és una tocineria".', 'alta', false, 'seed', 'cansaladeria-singla-navarcles', '2026-10-09T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (perdido_revisar).
Asunto: Vuestra web saluda con un "Warning" de PHP
Fallos: La portada muestra errores de PHP visibles: "Warning: Undefined array key "HTTP_ACCEPT_LANGUAGE" in /homepages/19/d265551570/htdocs/web3/obtenir_idioma.php on line 48" y varios más | Email de contacto @hotmail en la web de empresa: cansingla@hotmail.com | HTTPS no funciona (error SSL al entrar por https://www.cansingla.com) | Erratas en Origens: "Cansalaoleria Singla", "rudimentéries", "majoritériament" y "Iâ''ambició" | Contador de visitas antiguo en el pie: "n° visites: 494682"

Hola, equipo de Cansaladeria Singla:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Lo del tiet Joan diciendo "a Navarcles el que hi fa falta és una tocineria" a un paleta en 1968 es de las mejores historias de origen que he leído; menos mal que le hizo caso.

Os escribo porque al entrar en la web lo primero que aparece son errores técnicos como "Warning: Undefined array key" y "Cannot modify header information", en Origens pone "Cansalaoleria Singla" y "rudimentéries", el email de contacto es un @hotmail y por https la página directamente no carga.

¿Os preparo gratis una maqueta con vuestros productos, la historia del tiet Joan y encargos que funcionen bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-09T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Delícies del Moianès', 'Tienda y distribución de producto local', 'Moià (Moianès)', 'Barcelona', 'https://www.deliciesdelmoianes.com', 'info@deliciesdelmoianes.com', '', '', 'contactado', '', null, null, '', 'No hay teléfono visible en la web; dirección C/ Mn. Isidre Dalmau 14, Moià.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'En vuestra portada pone 12 veces "Título de diapositiva"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@deliciesdelmoianes.com', 'deliciesdelmoianes.com', 'https://www.deliciesdelmoianes.com', 'Barcelona', 'guzman', 'guzmangonzalezperez@gmail.com', 'Celebran "10 ANYS CREIXENT AMB TU DIA A DIA": empresa del Moianès de productos naturales de proximidad, con catálogo sin gluten, sin huevo y sin lactosa.', 'alta', false, 'seed', 'delicies-del-moianes', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestra portada pone 12 veces "Título de diapositiva"
Fallos: Texto de plantilla sin cambiar en la portada: "Título de diapositiva / Escriba su subtítulo aquí / Botón" repetido 12 veces | 6 botones vacíos que solo dicen "Button" en el bloque "Distribuïdors de:" | Errata en el pie: "© 2021 DELICÍES DEL MOIANÈS" (acento mal puesto) | Formulario de contacto en castellano en una web en catalán: "Envíanos un mensaje" / "Vaya, hubo un error al enviar su mensaje"

Hola, equipo de Delícies del Moianès:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Diez años "creixent amb tu dia a dia" moviendo producto de proximidad, y encima pensando en celíacos y gente sin lactosa, es de las cosas que más se agradecen en una comarca.

Os escribo porque en la portada se ha quedado el texto de la plantilla: "Título de diapositiva" y "Escriba su subtítulo aquí" aparecen 12 veces, hay seis botones que solo dicen "Button", en el pie pone "DELICÍES" y el formulario de contacto está en castellano ("Envíanos un mensaje").

¿Os preparo gratis una maqueta con el catálogo por categorías y pedidos para tiendas y particulares que funcione bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Cal Serrador', 'Granja lechera / leche fresca', 'Avià (Berguedà)', 'Barcelona', 'http://www.calserrador.cat', 'calserrador@hotmail.com', '93 823 04 45', '', 'perdido', '', null, null, '', 'Jordi contestó el 9 oct: ya no venden leche y no les interesa. No volver a escribir.', true, 'Jordi contestó el 9 oct: ya no venden leche y no les interesa. No volver a escribir.', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'El botón "PROJECTE" de vuestra web da error 404', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'calserrador@hotmail.com', 'calserrador.cat', 'http://www.calserrador.cat', 'Barcelona', 'guzman', 'guzmangonzalezperez@gmail.com', 'Tradición lechera desde 1950, cuando compraron cuatro vacas frisonas para tener leche para la familia; hoy tienen capacidad para 200 vacas y envasan su propia leche fresca.', 'alta', false, 'seed', 'cal-serrador-avia', '2026-10-09T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (no_contactar).
Asunto: El botón "PROJECTE" de vuestra web da error 404
Fallos: Email @hotmail en la web de empresa: calserrador@hotmail.com | El botón del menú "PROJECTE" lleva a projectes.html, que da error 404 | En Punts de venda los logos de Petit Preu (aceb.cat) y Fleca Vidal (navas.cat) enlazan a páginas que dan 404 | HTTPS roto: el certificado es de "*.dadapro.com", no de calserrador.cat; pie "© 2017 Cal Serrador"

Hola, equipo de Cal Serrador:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Pasar de cuatro vacas frisonas en 1950 a envasar vuestra propia leche fresca con 200 vacas es una evolución preciosa (y "A Cal Serrador sempre hem fet de pagesos" es un lema que ya quisieran muchas marcas).

Os escribo porque el botón "PROJECTE" del menú lleva a una página que da error 404, los logos de Petit Preu y Fleca Vidal en puntos de venta también llevan a páginas rotas, el email de contacto es un @hotmail y por https el navegador avisa porque el certificado es de otro dominio (dadapro.com).

¿Os preparo gratis una maqueta con un mapa de puntos de venta actualizado y pedidos que funcionen en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-09T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Formatge Bauma', 'Quesería artesana (leche de cabra)', 'Borredà (Berguedà)', 'Barcelona', 'http://www.formatgebauma.com', 'bauma@formatgebauma.com', '93 823 90 64', '', 'perdido', '', null, null, '', 'Contestó "no" el 8 oct. No volver a escribir.', true, 'Contestó "no" el 8 oct. No volver a escribir.', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Se te han colado enlaces a una tienda de PDFs en la web', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'bauma@formatgebauma.com', 'formatgebauma.com', 'http://www.formatgebauma.com', 'Barcelona', 'guzman', 'guzmangonzalezperez@gmail.com', 'Desde 1980 Toni Chueca es pionero en recuperar quesos tradicionales catalanes; tiene la carta de "Mestre Formatger" (1998) y un Oro en los World Cheese Awards para el Ovella Bauma.', 'alta', false, 'seed', 'formatge-bauma-borreda', '2026-10-09T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (no_contactar).
Asunto: Se te han colado enlaces a una tienda de PDFs en la web
Fallos: Certificado HTTPS caducado ("certificate has expired" al entrar por https://www.formatgebauma.com) | Sin <meta name="viewport">: no se adapta al móvil | Enlaces ajenos colados en la sección de premios: "S''ha publicat una nova https://pdfstandards.shop/product-category/publishers/asme/ revista" y otro a pdfstandards.shop en lo de FORMAT-JAZZ (pinta a spam inyectado) | Errata en el título: "Infomracions i premis de Formatge Bauma" | Novedades congeladas: "aquest any 2011"

Hola, Toni:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Llevar desde 1980 recuperando quesos catalanes de cabra, con carta de Mestre Formatger y un Oro en los World Cheese Awards para el Ovella Bauma, es un currículum que pocos queseros pueden enseñar.

Te escribo porque en la sección de premios aparecen enlaces que no son tuyos ("S''ha publicat una nova https://pdfstandards.shop/..."), que suelen ser señal de que alguien ha tocado la web; además el título dice "Infomracions i premis", el certificado HTTPS está caducado y la página no se adapta al móvil.

¿Te preparo gratis una maqueta limpia con tus quesos, premios y puntos de venta que funcione bien en el móvil? Si no te gusta, la borro y aquí no ha pasado nada.', '2026-10-09T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Molí d''oli Roch del Bages (Olí del Bages)', 'Molino de aceite / tienda online', 'Sant Fruitós de Bages (Bages)', 'Barcelona', 'https://www.olidelbages.com', 'info@olidelbages.com', '938 760 583', '', 'contactado', '', null, null, '', 'Titular en el pie: Carmen Vendrell Ollé.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestro horario se vende a 0,00 €', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@olidelbages.com', 'olidelbages.com', 'https://www.olidelbages.com', 'Barcelona', 'guzman', 'guzmangonzalezperez@gmail.com', 'Familia pagesa con sus propios olivos y molino propio en medio de la finca, para extraer el aceite en frío justo después de recoger la oliva.', 'alta', false, 'seed', 'moli-oli-roch-bages', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestro horario se vende a 0,00 €
Fallos: Maquetada con tablas (35 <table> en la portada) y sin <meta name="viewport">: no se adapta al móvil | El horario de la tienda aparece como un producto a la venta: "HORARI DE LA NOSTRA BOTIGA DEL MOLÍ 0.00 € ((IVA inclòs))"; igual con "TRANSPORT GRATUÏT 0.00 €" | Paréntesis duplicados en todos los precios: "((IVA inclòs))" | Errata en el acceso de usuarios: "Registri´s"; precio mal formateado "35,00/€ garrafa"

Hola, equipo del Molí d''oli Roch:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Tener el molino en medio de vuestros propios olivos y prensar en frío nada más recoger la oliva es justo lo que uno quiere oír antes de comprar una garrafa de arbequina.

Os escribo porque en la tienda online el horario aparece como si fuera un producto: "HORARI DE LA NOSTRA BOTIGA DEL MOLÍ 0.00 €", igual que "TRANSPORT GRATUÏT 0.00 €"; además todos los precios llevan "((IVA inclòs))" con doble paréntesis, pone "Registri´s" y la página, hecha con tablas, no se adapta al móvil.

¿Os preparo gratis una maqueta de tienda que funcione en el móvil, con el horario y el transporte donde tocan? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Pastisseria Miró', 'Pastelería', 'Castellterçol (Moianès)', 'Barcelona', 'http://www.pastisseriamiro.com', 'miro@pastisseriamiro.com', '93 866 80 34', '', 'contactado', '', null, null, '', 'Gancho limitado: la web no cuenta la historia de la pastelería.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra sección "Història" habla de pastas de té', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'miro@pastisseriamiro.com', 'pastisseriamiro.com', 'http://www.pastisseriamiro.com', 'Barcelona', 'guzman', 'guzmangonzalezperez@gmail.com', 'Su catálogo incluye clásicos como el Sant Marc (pa de pessic con nata y trufa y gema cremada), el bombó de músic y las neules de xocolata.', 'media', false, 'seed', 'pastisseria-miro-castelltercol', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra sección "Història" habla de pastas de té
Fallos: Sin <meta name="viewport">: no se adapta al móvil (carga estilie6.css para Internet Explorer 6) | Aviso de cookies en castellano en una web en catalán: "Pastisseria Miró sólo utiliza una cookie de sesión "PHPSESSID"... De acuerdo" | La sección "Història" no tiene historia: solo muestra la ficha de "Pastes de te" | No hay tienda ni encargos online, solo un enlace mailto

Hola, equipo de Pastisseria Miró:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Un Sant Marc con nata, trufa y gema cremada encima es de esos pasteles que justifican por sí solos el viaje a Castellterçol.

Os escribo porque al pulsar "Història" la web no cuenta vuestra historia, solo enseña las "Pastes de te"; además el aviso de cookies sale en castellano ("sólo utiliza una cookie de sesión... De acuerdo") y la página no se adapta al móvil.

¿Os preparo gratis una maqueta con vuestra historia, el catálogo y encargos de pasteles y monas desde el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Carn i Bestiar Prat (Cal Caleio)', 'Carnicería / carne de proximidad', 'Casserres (Berguedà)', 'Barcelona', 'http://www.carnibestiarprat.com', 'info@carnibestiarprat.com', '93 823 40 06', '', 'contactado', '', null, null, '', 'El directorio de la Diputació la sitúa en Sant Martí de Tous; la web indica Plç. Sta. Maria 11, Casserres.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra Botiga Virtual está "fora de servei temporalment"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@carnibestiarprat.com', 'carnibestiarprat.com', 'http://www.carnibestiarprat.com', 'Barcelona', 'guzman', 'guzmangonzalezperez@gmail.com', 'Microempresa familiar nacida en 1989, cuatro generaciones vinculadas al campo; venden ternera ecológica certificada de la Cortada de Puig-reig y cordero de pequeñas explotaciones de la comarca.', 'alta', false, 'seed', 'carn-i-bestiar-prat-casserres', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra Botiga Virtual está "fora de servei temporalment"
Fallos: La "Botiga Virtual" (/catalog/) da error 503: "la nostra botiga ha estat fora de servei temporalment" | Sin <meta name="viewport">: no se adapta al móvil (plantilla Joomla "Designed by RocketTheme") | Widget antiguo de Twitter en la barra lateral: "El nostre twitter / Tweets by @carnibestprat" | Erratas: "us ofereim carn de xai" y "Des d''aqui veureu el productes"

Hola, equipo de Carn i Bestiar Prat:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Lo de vender ternera ecológica de la Cortada de Puig-reig desde Cal Caleio, con cuatro generaciones detrás, es exactamente lo que la gente busca cuando dice "carne de proximidad".

Os escribo porque la Botiga Virtual da error y muestra "la nostra botiga ha estat fora de servei temporalment", sigue el widget antiguo de Twitter, en Qui som pone "us ofereim" y la página no se adapta al móvil.

¿Os preparo gratis una maqueta con una tienda de encargos que funcione en el móvil y reparto a domicilio? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Fainatur (Fai Natur)', 'Obrador de infusiones con miel', 'Sant Quirze Safaja (Moianès)', 'Barcelona', 'https://www.fainatur.com', 'info@fainatur.com', '600 479 680 / 617 955 159', '', 'contactado', '', null, null, '', 'Empresa pequeña (S.L.) del Moianès; también venden chai latte, matcha y red velvet latte.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'En vuestro menú sale un "Chais latte"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@fainatur.com', 'fainatur.com', 'https://www.fainatur.com', 'Barcelona', 'guzman', 'guzmangonzalezperez@gmail.com', 'Hacen infusiones solubles con miel (honey teas): raíces, frutas, hierbas y flores infusionadas y mezcladas con miel, que se diluyen con una o dos cucharadas.', 'media', false, 'seed', 'fainatur-sant-quirze-safaja', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestro menú sale un "Chais latte"
Fallos: Errata en el menú de todas las páginas: "Chais latte" (la página se llama "Chai latte") | Errata en la portada: "situada al bellmig de la natura" | Las páginas interiores (contactar.php, chai_latte.php, herbes.php) no tienen <meta name="viewport">: no se adaptan al móvil | Pie desactualizado: "© Fainatur 2014"

Hola, equipo de Fainatur:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Lo de meter raíces, flores y hierbas dentro de la miel para tener una infusión con dos cucharadas es tan sencillo que da rabia no haberlo pensado antes.

Os escribo porque en el menú de todas las páginas pone "Chais latte", en la portada aparece "al bellmig de la natura", el pie sigue en "© Fainatur 2014" y las páginas interiores, como contacto o los productos, no se adaptan al móvil.

¿Os preparo gratis una maqueta con vuestros productos y una tienda online que funcione bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Pere Olivella Galimany', 'Bodega / cava familiar', 'Guardiola de Font-rubí (Alt Penedès)', 'Barcelona', 'http://olivellagalimany.com', 'info@olivellagalimany.com', '938 979 310', '', 'contactado', '', null, null, '', 'Web con viewport y HTTPS correctos; los fallos son de contenido desactualizado y CMS obsoleto.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'La última noticia de vuestra web es de mayo de 2021', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@olivellagalimany.com', 'olivellagalimany.com', 'http://olivellagalimany.com', 'Barcelona', 'guzman', 'guzmangonzalezperez@gmail.com', 'Familia de viticultores con más de 150 años de historia: 1859, "una anyada fantàstica", y seis generaciones interpretando la viña "de manera senzilla".', 'media', false, 'seed', 'olivella-galimany-font-rubi', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: La última noticia de vuestra web es de mayo de 2021
Fallos: Pie con "© 2016 Olivella Galimany." | Notícies parada: la más reciente es del "03 May 21" y debajo sigue "Patrocinem el XXè Cicle de Cava Jazz" ("El dissabte vinent...") de enero de 2018 | Hecha con Drupal 7 (meta generator "Drupal 7"), versión sin soporte oficial desde enero de 2025 | No hay tienda online: los vinos y caves solo se presentan en fichas sin compra ni reserva de visitas

Hola, equipo de Olivella Galimany:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Seis generaciones y un 1859 que llamáis "una anyada fantàstica" es una forma muy elegante de decir que lleváis más tiempo haciendo vino que casi nadie en el Penedès.

Os escribo porque la web se ha quedado parada: la última noticia es del "03 May 21", justo debajo sigue el anuncio del "XXè Cicle de Cava Jazz" de 2018 diciendo "el dissabte vinent", el pie pone "© 2016" y está montada con Drupal 7, que ya no recibe actualizaciones de seguridad.

¿Os preparo gratis una maqueta con vuestros vinos y caves, venta online y reserva de visitas que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Rural Sant Antoni', 'Casa rural', 'Biar', 'Alicante', 'https://www.ruralbiar.com/', 'info@ruralbiar.com', '675 817 677', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'En vuestro menú se ha colado un "ITINERIARIO"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@ruralbiar.com', 'ruralbiar.com', 'https://www.ruralbiar.com/', 'Alicante', 'guzman', 'guzmangonzalezperez@gmail.com', 'Antigua casa de pueblo del siglo XIX en pleno casco histórico, "colindante con el mismo castillo que corona el pueblo". Contacto: Juanjo / Ana Mª.', 'alta', false, 'seed', 'sant-antoni-biar', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestro menú se ha colado un "ITINERIARIO"
Fallos: Sin <meta name="viewport">: no está adaptada al móvil (comprobado en todas las páginas) | Errata en el menú: "ITINERIARIO BOTÁNICO" | Codificación rota: el enlace ''Localización'' del menú está guardado en ISO-8859-1, pero el servidor lo envía como UTF-8, y se ve "Localizaci�n" | Sellos antiguos en el pie: "XHTML 1.1 | CSS | W3C WAI-AA"; el código PHP del contador de visitas (mysql_connect) aparece sin ejecutar en el HTML

Hola, Juanjo y Ana:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una casa del siglo XIX pegada al mismo castillo que corona Biar es de esas cosas que no se pueden copiar.

Os escribo porque la web no está adaptada al móvil (no tiene la etiqueta viewport, así que en el teléfono se ve en miniatura), en el menú pone "ITINERIARIO BOTÁNICO" y el enlace de "Localización" sale con un símbolo raro en lugar de la ó por un problema de codificación. Además, el pie todavía luce los sellos de "XHTML 1.1" y "W3C WAI-AA" de hace un par de décadas.

¿Os preparo gratis una maqueta con reserva directa y que se vea bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Rural Masía Los Pasos', 'Casa rural', 'Biar', 'Alicante', 'https://casarurallospasos.com/', 'reservas@casarurallospasos.com', '+34 620 159 081', '', 'contactado', '', null, null, '', 'Tienen un Instagram activo enlazado en la portada, así que es probable que alguien conteste.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', '"All Right Revised" en el pie de vuestra web', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'reservas@casarurallospasos.com', 'casarurallospasos.com', 'https://casarurallospasos.com/', 'Alicante', 'guzman', 'guzmangonzalezperez@gmail.com', 'Casa de labranza del siglo XIX; la escalera tiene frentes de azulejo antiguo de la zona y barandilla de antiguas balconadas de Almagro; muebles de más de un siglo restaurados.', 'alta', false, 'seed', 'los-pasos-biar', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: "All Right Revised" en el pie de vuestra web
Fallos: Pie de todas las páginas: "Copyright 2019 All Right Revised." (sic) | Errata: "en la misma planta se haya un cuarto de baño" (halla) | Errata: "la casa rural los Pasos rehabilito la antigua cuadra" (sin tilde) | En la política de privacidad el email aparece pegado a un &nbsp; ("nbspreservas@casarurallospasos.com")

Hola, equipo de Casa Rural Los Pasos:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una escalera con frentes de azulejo antiguo y una barandilla hecha con balconadas de Almagro ya justifican el viaje a Biar.

Os escribo porque en el pie de la web sigue poniendo "Copyright 2019 All Right Revised.", en la descripción de la casa se cuela un "se haya un cuarto de baño" (de hallar, no de haber) y un "los Pasos rehabilito la antigua cuadra" sin tilde. Y es una pena, porque vuestro Instagram está mucho más vivo que la web.

¿Os preparo gratis una maqueta con reserva directa y fechas libres que se vea bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Alfarería Severino Boix', 'Taller artesano (alfarería)', 'Agost', 'Alicante', 'https://www.severinoboix.com/', 'alfarero@severinoboix.com', '651 642 528', '', 'contactado', '', null, null, '', 'Agost es un pueblo alfarero del interior de Alicante. No estaba en la lista, pero encaja (no es capital ni costa).', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestro contador de "Deco Alma" está a cero', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'alfarero@severinoboix.com', 'severinoboix.com', 'https://www.severinoboix.com/', 'Alicante', 'guzman', 'guzmangonzalezperez@gmail.com', 'Taller en marcha desde 1920; José Ángel Boix es la quinta generación de alfareros ("El torno ha formado parte de mi vida desde mi niñez"); cada botijo se hace uno a uno.', 'alta', false, 'seed', 'severino-boix-agost', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestro contador de "Deco Alma" está a cero
Fallos: Cuenta atrás muerta en la portada: "00 Days 00 Hours 00 Min 00 Sec" junto a "pronto estará online" (proyecto Deco Alma) | Shortcode roto a la vista: "[shareaholic app=”share_buttons” id=”18500121″]" | Erratas: "Maestro Alfafero" y "Se pone el funcionamiento el Taller en la Calle Alfarería" | Enlace a Google+ (plus.google.com, cerrado en 2019) y pie "©2021 SEVERINO BOIX"; la cronología se queda en 2015

Hola, equipo de Alfarería Severino Boix:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Cinco generaciones haciendo botijos a mano en Agost, con taller desde 1920, es una historia que muy pocas marcas pueden contar.

Os escribo porque en la portada el contador de "Deco Alma" marca "00 Days 00 Hours 00 Min 00 Sec" junto a un "pronto estará online", debajo se ve el código "[shareaholic app=”share_buttons” id=”18500121″]" en lugar de los botones de compartir, en un testimonio pone "Maestro Alfafero" y en la cronología "Se pone el funcionamiento el Taller". Además hay un enlace a Google+, que cerró en 2019.

¿Os preparo gratis una maqueta con tienda online que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Rural Miramontes', 'Casa rural', 'Villena', 'Alicante', 'https://www.miramontesrural.com/', 'info@miramontesrural.com', '676 367 446', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'En vuestra web la casa "estáenclavada" (todo junto)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@miramontesrural.com', 'miramontesrural.com', 'https://www.miramontesrural.com/', 'Alicante', 'guzman', 'guzmangonzalezperez@gmail.com', 'La casa la mandó construir en 1899 el canónigo de la catedral de Toledo D. Juan Chaumel, hijo de Villena, por la sequedad del aire y las aguas saladas de la finca.', 'alta', false, 'seed', 'miramontes-villena', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestra web la casa "estáenclavada" (todo junto)
Fallos: Erratas literales en la portada: "la casa estáenclavada" y "zona agrícoladonde" | Maquetada con tablas de ancho fijo (<table width="761" height="500">) y scripts de Dreamweaver (MM_preloadImages, MM_swapImage) | Título de plantilla sin cambiar en el código: "Untitled Document" | Menú con "Galeria" sin tilde; banderitas .gif para elegir idioma

Hola, equipo de Casa Rural Miramontes:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Que la casa la mandara construir en 1899 un canónigo de la catedral de Toledo por lo sano del aire y las aguas saladas de la finca es un argumento de venta buenísimo.

Os escribo porque en la portada pone "la casa estáenclavada" y "zona agrícoladonde" (sin espacios), la página está maquetada con tablas de ancho fijo y scripts de Dreamweaver, y en el código se ha quedado el título de plantilla "Untitled Document". El menú, además, dice "Galeria" sin tilde.

¿Os preparo gratis una maqueta con reserva directa y un cómo llegar con mapa, pensada para el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Bernabé', 'Casa rural y eventos', 'Xàtiva', 'Valencia', 'https://lacasabernabe.com/', 'alojamiento@lacasabernabe.com', '666 363 050', '', 'contactado', '', null, null, '', 'En la portada aparece también eventos@lacasabernabe.com.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra web sigue con el aviso de COVID (y un © 2010)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'alojamiento@lacasabernabe.com', 'lacasabernabe.com', 'https://lacasabernabe.com/', 'Valencia', 'guzman', 'guzmangonzalezperez@gmail.com', 'Está en una finca de vegetación autóctona a 8,8 km de Xàtiva, al final de un camino que lleva su nombre: el "Camino Casa Bernabé". También hacen bodas civiles en sus jardines.', 'alta', false, 'seed', 'casa-bernabe-xativa', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web sigue con el aviso de COVID (y un © 2010)
Fallos: Portada sin <meta name="viewport"> y maquetada con tablas: no está adaptada al móvil | Pies desfasados: "Copyright Casa Bernabé 2013" y "Copyright Eventos Casa Bernabé 2010" | Sigue el bloque "Prevención COVID" en las webs de alojamiento y de eventos | La portada es solo una pantalla de entrada con dos imágenes subidas en 2013 (wp-content/uploads/2013) y lleva a dos webs separadas (/casarural y /eventos)

Hola, equipo de Casa Bernabé:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. No todas las casas rurales tienen un camino con su propio nombre: llegar por el "Camino Casa Bernabé" ya es medio encanto.

Os escribo porque la portada de la web no está adaptada al móvil (no tiene etiqueta viewport), en las páginas de alojamiento y eventos sigue el bloque "Prevención COVID" y los pies dicen "Copyright Casa Bernabé 2013" y "Copyright Eventos Casa Bernabé 2010".

¿Os preparo gratis una maqueta con reserva directa para el alojamiento y una sección de bodas que se vea bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('La Maga Rooms', 'Alojamiento rural (habitaciones)', 'Xàtiva', 'Valencia', 'https://www.lamagarooms.com/', 'info@lamagarooms.com', '695 79 65 87', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', '"Thacia el castillo": vuestras indicaciones tienen una errata', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@lamagarooms.com', 'lamagarooms.com', 'https://www.lamagarooms.com/', 'Valencia', 'guzman', 'guzmangonzalezperez@gmail.com', 'Sus indicaciones avisan de "un semáforo que está siempre en rojo" y de que "los castillos siempre están arriba de todo".', 'alta', false, 'seed', 'la-maga-rooms-xativa', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: "Thacia el castillo": vuestras indicaciones tienen una errata
Fallos: Erratas en las indicaciones de cómo llegar: "(thacia el castillo" y "centro de especiealidades médicas" | La versión en español termina en inglés: "Go straight up to the second square (Plaza de San Jordi) with a shop called Piroshopping..." | Menú: "La ciudad de Xátiva" (con acento agudo en vez de grave) | Pie desfasado: "© La Maga ROOMS 2013"; párrafos de las indicaciones duplicados

Hola, equipo de La Maga Rooms:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Unas indicaciones que avisan de "un semáforo que está siempre en rojo" y de que "los castillos siempre están arriba de todo" tienen más gracia que cualquier GPS.

Os escribo porque en esas mismas indicaciones pone "(thacia el castillo" y "centro de especiealidades médicas", la versión en español termina en inglés ("Go straight up to the second square..."), el menú dice "La ciudad de Xátiva" con la tilde al revés y el pie sigue en "© La Maga ROOMS 2013".

¿Os preparo gratis una maqueta con reserva directa y un cómo llegar con mapa que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Restaurante El Carro', 'Restaurante (con hospedaje)', 'Utiel', 'Valencia', 'https://restauranteelcarro.com/', 'info@restauranteelcarro.com', '962 171 131', '', 'contactado', '', null, null, '', 'La web es un WordPress que siguen manteniendo (el aviso de cookies es de 2025). El argumento son la sección de bodega rota y las erratas.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'El botón de vuestra bodega lleva a un error 404', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@restauranteelcarro.com', 'restauranteelcarro.com', 'https://restauranteelcarro.com/', 'Valencia', 'guzman', 'guzmangonzalezperez@gmail.com', 'Lo abrieron en 1992 Maribel Martínez (fogones) y José Luis Fernández (sala) en la calle de La Rambla, donde se fabricaban carros, y de ahí el nombre; en la carta tienen solomillo de cola de cocodrilo y tournedo de canguro.', 'media', false, 'seed', 'el-carro-utiel', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: El botón de vuestra bodega lleva a un error 404
Fallos: El botón "MAS DETALLES" de "Nuestra bodega" en la portada lleva a /bodega, que da error 404 | Erratas: "Contactanos y no te arrepentiras" y "la reserva no sera efectiva" | En la carta: "Costillar de cerdo ibèrico" (acento grave) | "COMO LLEGAR" y "MAS DETALLES" sin tilde en la portada

Hola, Maribel y José Luis:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Empezar en 1992 en la calle donde se fabricaban carros y acabar sirviendo "Tournedo de canguro" en Utiel es una evolución de lo más sorprendente.

Os escribo porque en la portada el botón "MAS DETALLES" de "Nuestra bodega" lleva a una página que da error 404, en contacto pone "Contactanos y no te arrepentiras" sin tildes, en reservas "la reserva no sera efectiva" y en la carta se ha colado un "Costillar de cerdo ibèrico" con acento catalán.

¿Os preparo gratis una maqueta con la carta y reserva de mesa que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Torrebale', 'Apartamentos rurales', 'Morella', 'Castellón', 'http://casatorrebale.com/', 'alojamientostorrebale@gmail.com', '608 669 361', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'El certificado de vuestra web caducó', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'alojamientostorrebale@gmail.com', 'casatorrebale.com', 'http://casatorrebale.com/', 'Castellón', 'guzman', 'guzmangonzalezperez@gmail.com', 'Tres apartamentos llamados La Falsa, La Cuina y El Pati, con patio, porche y barbacoa, a dos minutos del ayuntamiento de Morella; certificación SICTED.', 'alta', false, 'seed', 'torrebale-morella', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: El certificado de vuestra web caducó
Fallos: HTTPS roto: el certificado de https://casatorrebale.com está caducado | El enlace "Situada en el centro de la ciudad" de la portada lleva a contacto.html, que da 404 | Pie desfasado: "CasaTorrebale 2019"; la página Ofertas solo dice "Consultar con el propietario." | Erratas: "¿Que ofrecemos?", "Vitroceramica", "Frigorifico"; la plantilla aún incluye un aviso para Internet Explorer 8

Hola, equipo de Casa Torrebale:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Tres apartamentos con nombres tan de casa como La Falsa, La Cuina y El Pati, a dos minutos del ayuntamiento de Morella, es difícil de mejorar.

Os escribo porque si alguien entra por https://casatorrebale.com el navegador avisa de que el certificado de seguridad ha caducado, el enlace "Situada en el centro de la ciudad" de la portada lleva a una página 404, el pie sigue en "CasaTorrebale 2019" y en Ofertas solo pone "Consultar con el propietario." Por cierto, el titular "¿Que ofrecemos?" va sin tilde.

¿Os preparo gratis una maqueta con calendario y reserva directa que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('La Casa de las Orquídeas', 'Casa rural', 'Morella (Xiva de Morella)', 'Castellón', 'http://lacasadelaluzmorella.blogspot.com/', 'samarcanda40@gmail.com', '672 380 578', '', 'contactado', '', null, null, '', 'La propietaria es Amparo Chaler; como es una sola persona, el trato es de tú. También usa samarcanda40@hotmail.com.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Tu web dice "No hay publicaciones" dos veces', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'samarcanda40@gmail.com', 'lacasadelaluzmorella.blogspot.com', 'http://lacasadelaluzmorella.blogspot.com/', 'Castellón', 'guzman', 'guzmangonzalezperez@gmail.com', 'Antiguo cobertizo junto a Morella que su propietaria decoró inspirándose en la decoración balinesa, los monasterios budistas y el Feng Shui; se define como "alojamiento sensorial".', 'alta', false, 'seed', 'orquideas-morella', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Tu web dice "No hay publicaciones" dos veces
Fallos: Blog de Blogger sin <meta name="viewport"> en ninguna página: no está adaptado al móvil | La portada muestra dos veces "No hay publicaciones." | En contacto enlaza a http://www.lacasadelasorquideas.com, un dominio que ya no responde | Contacto por Skype ("SKYPE: amparochalerpablo") y con un email @hotmail (samarcanda40@hotmail.com) junto al de Gmail

Hola, Amparo:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Un antiguo cobertizo junto a Morella decorado con inspiración balinesa, monasterios budistas y Feng Shui no es algo que se encuentre en cualquier casa rural del Maestrazgo.

Te escribo porque la web de La Casa de las Orquídeas es un blog que no está adaptado al móvil (no tiene etiqueta viewport), en la portada aparece dos veces "No hay publicaciones.", el enlace a www.lacasadelasorquideas.com que pones en contacto ya no funciona y como contacto aparecen un Skype y un correo de Hotmail.

¿Te preparo gratis una maqueta con reserva directa y unas fotos que luzcan en el móvil? Si no te gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Quesería Artesana Los Corrales', 'Quesería artesana', 'Almedíjar', 'Castellón', 'https://www.queserialoscorrales.com/', 'info@queserialoscorrales.com', '964 137 050', '', 'contactado', '', null, null, '', 'Almedíjar está en la Sierra de Espadán, en el interior de Castellón. No estaba en la lista, pero encaja.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', '"Nos pondremos en contacto contigo la antes posible"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@queserialoscorrales.com', 'queserialoscorrales.com', 'https://www.queserialoscorrales.com/', 'Castellón', 'guzman', 'guzmangonzalezperez@gmail.com', 'Quesería nacida en 1990 en el Parque Natural de la Sierra de Espadán; hacen "quesos de autor", un Tronchón con cuajo vegetal y cortezas comestibles porque solo se impregnan con aceite de oliva de Espadán.', 'alta', false, 'seed', 'los-corrales-almedijar', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: "Nos pondremos en contacto contigo la antes posible"
Fallos: Errata: "Nos pondremos en contacto contigo la antes posible." (página Comprar queso) | Errata en la portada: "Elaboramos fermentos propios para los quesos que de leche cruda" | Pie desfasado: "© Los Corrales de Almedíjar, S.L. 2020"; maquetación con tablas (6 <table> en la portada, hecha con el constructor cm4all) y URLs con los acentos rotos (/Almed-jar/, /La-queser-a/) | El botón "Tienda online" lleva a una página intermedia que solo dice "Accede desde aquí a nuestra Tienda online" y desde ahí manda a otro dominio (.es)

Hola, equipo de la Quesería Artesana Los Corrales:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Hacer quesos de autor en Almedíjar desde 1990, con un Tronchón de cuajo vegetal y cortezas que se pueden comer porque solo llevan aceite de Espadán, es un lujo de los de verdad.

Os escribo porque en "Comprar queso" pone "Nos pondremos en contacto contigo la antes posible", en la portada "Elaboramos fermentos propios para los quesos que de leche cruda", el pie sigue en "© Los Corrales de Almedíjar, S.L. 2020" y el botón "Tienda online" lleva a una página intermedia que solo dice "Accede desde aquí a nuestra Tienda online" antes de mandar a otra web distinta.

¿Os preparo gratis una maqueta con la tienda integrada en la misma web y que funcione bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Rural Argen', 'Casa rural', 'Segorbe', 'Castellón', 'https://casaargen.com/', 'casaargen@gmail.com', '+34 625 739 565', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Debajo de vuestro nombre pone "Just another WordPress site"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'casaargen@gmail.com', 'casaargen.com', 'https://casaargen.com/', 'Castellón', 'guzman', 'guzmangonzalezperez@gmail.com', 'Casa del siglo XIX restaurada en 2014, estrecha pero de gran altura, a 40 metros de la Muralla y los Arcos del Argén, de donde viene el nombre.', 'alta', false, 'seed', 'casa-argen-segorbe', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Debajo de vuestro nombre pone "Just another WordPress site"
Fallos: Texto de plantilla sin cambiar bajo el nombre: "Just another WordPress site" (también en el título de la pestaña) | Sigue la página "Anticovid" en el menú y la condición "Si se cancela por motivos relacionados por el Covid-19" | Errata en precios: "Checki in/out horario flexible" | Pie con dos fechas: "© 2021 desarrollado por BusinessInFact" y "© Copyright 2026"; la versión http no redirige a https

Hola, equipo de Casa Argen:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una casa estrecha y altísima a 40 metros de los Arcos del Argén, de donde sale hasta el nombre, es justo lo que uno busca en el casco antiguo de Segorbe.

Os escribo porque debajo del nombre de la casa aparece "Just another WordPress site", el texto por defecto de WordPress; el menú sigue teniendo una página "Anticovid", en precios pone "Checki in/out horario flexible" y el pie mezcla "© 2021" con "© Copyright 2026".

¿Os preparo gratis una maqueta con reserva directa y calendario que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('La Belluga (apartamentos y Museo del Aceite)', 'Apartamentos rurales y producto local (AOVE)', 'Segorbe', 'Castellón', 'https://labelluga.com/', 'infobelluga@labelluga.com', '+34 691 02 06 46', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestro botón "Apartamentos" lleva a un 404', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'infobelluga@labelluga.com', 'labelluga.com', 'https://labelluga.com/', 'Castellón', 'guzman', 'guzmangonzalezperez@gmail.com', 'Antigua almazara rehabilitada con 6 apartamentos y su propio Museo del Aceite; Sheila y Manolo son guías oficiales de turismo desde 2008.', 'alta', false, 'seed', 'belluga-segorbe', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestro botón "Apartamentos" lleva a un 404
Fallos: El botón "Apartamentos" de la portada lleva a /apartamentos-turisticos-segorbe/, que da 404 | Pie desfasado: "Copyright © 2017 Belluga Alojamiento" | Erratas: "¿Qué por qué decidimos por apostar por el turismo en Segorbe?" y "Elaboramos A.O.V.E. pates de aceituna, cosmetica con aceite." | Errata: "Vista nuestra web" (por "Visita"); en contacto pone "la union de la calleu Argen"

Hola, Sheila y Manolo:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Dormir en una almazara rehabilitada con su propio Museo del Aceite, y que encima los anfitriones sean guías oficiales desde 2008, es un plan muy redondo.

Os escribo porque el botón "Apartamentos" de la portada lleva a una página que da error 404, el pie sigue en "Copyright © 2017" y se han colado algunas erratas como "¿Qué por qué decidimos por apostar por el turismo", "pates de aceituna, cosmetica con aceite" y "Vista nuestra web".

¿Os preparo gratis una maqueta con reserva directa y una tienda de vuestro aceite que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Masía Campos', 'Casa rural (masía)', 'Culla', 'Castellón', 'https://masiacamposculla.wordpress.com/', 'masiacamposculla@gmail.com', '+34 696 66 23 59', '', 'contactado', '', null, null, '', 'La web es reciente (2024), pero está en el plan gratuito de wordpress.com. Buen caso para ofrecer dominio propio y reserva directa.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'En vuestra web 21 noches son "una semana completa"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'masiacamposculla@gmail.com', 'masiacamposculla.wordpress.com', 'https://masiacamposculla.wordpress.com/', 'Castellón', 'guzman', 'guzmangonzalezperez@gmail.com', 'Masía de piedra de 175 m² para 12 personas, con barbacoa cubierta y leña gratis, a kilómetro y medio de Culla.', 'media', false, 'seed', 'masia-campos-culla', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestra web 21 noches son "una semana completa"
Fallos: Tarifas copiadas mal: en "21 NOCHES" pone "Disfruta de una semana completa" y en "28 NOCHES" "por dos semanas al completo" | Errata en el pie de una foto: "Facha de piedra" | Preguntas frecuentes desfasadas: "¿Aceptáis el BonoViaje de la Comunidad Valenciana 2024?"; el formulario tiene el campo "Name" en inglés | Sin dominio propio: la web está en un subdominio de wordpress.com

Hola, familia de Masía Campos:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una masía de piedra para 12 personas con barbacoa cubierta y la leña incluida, a kilómetro y medio de Culla, es el plan perfecto para grupos.

Os escribo porque en precios la tarifa de 21 noches dice "Disfruta de una semana completa" y la de 28 noches "por dos semanas al completo", el pie de una foto dice "Facha de piedra", las preguntas frecuentes siguen hablando del "BonoViaje de la Comunidad Valenciana 2024" y el formulario pide el "Name" en inglés. Además, la web vive en un subdominio de wordpress.com en lugar de en un dominio propio.

¿Os preparo gratis una maqueta con reserva directa y vuestro propio dominio, pensada para el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Formatgeria Serrat Gros', 'Quesería artesana (cabra)', 'Josa de Cadí (Josa i Tuixent, Alt Urgell)', 'Lleida', 'https://formatgeriaserratgros.com', 'info@formatgeriaserratgros.com', '690 38 55 56', '', 'contactado', '', null, null, '', 'Alt Urgell (no estaba en la lista de comarcas, pero es pueblo pequeño de Lleida).', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra web dice "ALIMENT�RIA" (y no es culpa de las cabras)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@formatgeriaserratgros.com', 'formatgeriaserratgros.com', 'https://formatgeriaserratgros.com', 'Lleida', 'guzman', 'guzmangonzalezperez@gmail.com', 'Fundada por Eulàlia Torras en 1980; Raül Alcaraz y Mercè Lagrava cogen el relevo en 2006 y son Mestres Artesans Formatgers (2021). Por la mañana se ven las cabras porque cada tarde salen a pastar.', 'alta', false, 'seed', 'serrat-gros', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web dice "ALIMENT�RIA" (y no es culpa de las cabras)
Fallos: Sin <meta name="viewport">: no está adaptada al móvil | Maquetada con tablas (4-5 <table> por página) | Caracteres rotos en Contactar: "EMPRESA ARTESANAL ALIMENT�RIA", "Josa de Cad�", "Tel�fon" | Pie con "© 2013-2024"

Hola, Raül y Mercè:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Que por la mañana se puedan ver las cabras porque cada tarde se van a pastar es el mejor horario de visitas que he leído en mucho tiempo, y ser Mestres Artesans Formatgers no es poca cosa.

Os escribo porque en la página de Contactar se han roto los acentos y pone "EMPRESA ARTESANAL ALIMENT�RIA", "Josa de Cad�" y "Tel�fon", la web no tiene etiqueta viewport (en el móvil se ve en miniatura) y el pie sigue en "© 2013-2024".

¿Os preparo gratis una maqueta con vuestros quesos, los meses en que hay formatge y cómo llegar a Josa, pensada para el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Formatges L''Oliva', 'Quesería artesana (leche cruda de cabra)', 'Oliana (Alt Urgell)', 'Lleida', 'http://formatgesloliva.com', 'contacte@formatgesloliva.com', '', '', 'contactado', '', null, null, '', 'Sin teléfono visible en la web. Alt Urgell.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Al coscollet de vuestra web se le ha caído una "a"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'contacte@formatgesloliva.com', 'formatgesloliva.com', 'http://formatgesloliva.com', 'Lleida', 'guzman', 'guzmangonzalezperez@gmail.com', 'Joel, Aina y Arnau dejaron la capital y recuperaron una pallera de la masía familiar centenaria; elaboran con fermentos propios. Queso estrella: "Lo coscollet".', 'alta', false, 'seed', 'formatges-loliva', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Al coscollet de vuestra web se le ha caído una "a"
Fallos: Sin <meta name="viewport">: no adaptada al móvil | Errata en la ficha del coscollet: "és un formtge de coagulació làctica" | Erratas en Contacte: "Per concertar vistes" y "Asumpte"; en Formatgers "una manera d''entedre la feina"; en Productes "tene en comú" | Portada con "© FORMATGES L''OLIVA 2015" y apartado de prensa que acaba en 2015

Hola, Joel, Aina y Arnau:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Dejar la capital para recuperar la pallera de una masía centenaria y hacer quesos con fermentos propios es una historia preciosa, y el nombre de "Lo coscollet" ya me ha ganado.

Os escribo porque la ficha del coscollet dice "és un formtge de coagulació làctica", en Contacte pone "Per concertar vistes" y "Asumpte", la portada sigue en "© FORMATGES L''OLIVA 2015" y la web no está adaptada al móvil.

¿Os preparo gratis una maqueta con vuestros quesos, las ferias donde estaréis y un formulario de pedido que funcione bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Roca (Agroturisme)', 'Casa rural / agroturismo con restaurante', 'Sant Martí de Barcedana (Gavet de la Conca, Pallars Jussà)', 'Lleida', 'http://casaroca.info', 'monica@casaroca.info', '973 651 070', '', 'contactado', '', null, null, '', 'El email visible es de Mònica ("monica @ casaroca.info"); el propietario según la web es Josep Maria Roca i Canal.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra página "Nosaltres" esconde un enlace de cannabis medicinal en Modesto', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'monica@casaroca.info', 'casaroca.info', 'http://casaroca.info', 'Lleida', 'guzman', 'guzmangonzalezperez@gmail.com', 'Casa fundada en el siglo XV por Francesc Roca, con foc de rogle (habitación cuyo techo entero es chimenea) y capilla de Sant Francesc consagrada en 1637; Medalla de Turisme a Josep Maria Roca i Canal.', 'alta', false, 'seed', 'casa-roca-barcedana', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra página "Nosaltres" esconde un enlace de cannabis medicinal en Modesto
Fallos: Enlace oculto inyectado en la página Nosaltres: "medical cannabis license in Modesto" (señal de web hackeada) | La portada aún enlaza a Google+ (plus.google.com) | Pie "© Copyright 2012"; última noticia "Publicat el Juny de 2017"

Hola, familia Roca:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una casa fundada en el siglo XV, con un foc de rogle donde todo el techo es chimenea y una capilla de 1637 junto al portal, casi no necesita publicidad, aunque la Medalla de Turisme tampoco está mal.

Os escribo porque en el código de la página "Nosaltres" hay un enlace oculto a "medical cannabis license in Modesto" (típico de una web hackeada, y a Google no le gusta nada), la portada todavía enlaza a Google+, el pie dice "© Copyright 2012" y la última noticia es de "Juny de 2017".

¿Os preparo gratis una maqueta limpia con las habitaciones, los precios y reserva directa sin intermediarios? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Martí', 'Casa rural y legumbres propias', 'Sant Domí (Sant Guim de Freixenet, Segarra)', 'Lleida', 'https://www.casamarti.cat', 'rural@casamarti.cat', '639 434 285 / 973 556 372', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Las fotos de vuestra portada llevan a un error 404', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'rural@casamarti.cat', 'casamarti.cat', 'https://www.casamarti.cat', 'Lleida', 'guzman', 'guzmangonzalezperez@gmail.com', 'Familia de tradición agrícola que recupera legumbres de la Alta Segarra; su "cigronet" triplica su volumen al cocerse.', 'media', false, 'seed', 'casa-marti-segarra', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Las fotos de vuestra portada llevan a un error 404
Fallos: Las fotos del carrusel de portada enlazan a "casa_marti1", "casa_marti2"... que dan error 404 | Erratas en portada: "al l’altiplà" y "limitrofe" | En Preus: "RESERVA INMEDIATA" (en catalán, immediata) | Pie "Copyright © 2014" y widget del tiempo en inglés ("Feels like")

Hola, equipo de Casa Martí:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Un garbancito que triplica su volumen al cocerse y una familia que vuelve a sembrar las legumbres de los abuelos en la Alta Segarra se merecen una web a la altura del cigronet.

Os escribo porque al pinchar en las fotos del carrusel de la portada sale un error 404 (enlazan a "casa_marti1", "casa_marti2"...), en la misma portada pone "al l’altiplà" y "limitrofe", en Preus aparece "RESERVA INMEDIATA" y el pie sigue en "Copyright © 2014".

¿Os preparo gratis una maqueta con reserva directa de la casa y una pequeña tienda de legumbres que funcione bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Bar-Restaurant Can Tomàs', 'Restaurante de cocina casera', 'Cantallops (Alt Empordà)', 'Girona', 'http://www.cantomas.info/cat', 'cantomascantallops@gmail.com', '972 55 48 89', '', 'contactado', '', null, null, '', 'Uso el email del enlace mailto (coincide con su Instagram). Alternativa en la web: mburset@cantomas.info (pedidos del libro).', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra web anuncia películas en streaming (y no es la carta)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'cantomascantallops@gmail.com', 'cantomas.info', 'http://www.cantomas.info/cat', 'Girona', 'guzman', 'guzmangonzalezperez@gmail.com', 'Miquel Cardoner compró la casa el 4 de junio de 1890 por 300 duros de plata, cruzando la montaña a pie hasta Cadaqués; en Tomàs escribió un libro de rodolins para la Colla del Senglar (se vende a 7 €).', 'alta', false, 'seed', 'can-tomas-cantallops', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web anuncia películas en streaming (y no es la carta)
Fallos: Texto spam en inglés al final de la portada: "Discover the latest movies and high-quality streaming options at sflix.com" | El email que se lee es "cantallopscantomas@gmail.com" pero el enlace abre "cantomascantallops@gmail.com" | Títulos de plantilla visibles "Text/HTML" en la página Origens i història | En Comanda del llibre: "Si vosté desitja un ejemplar" (castellanismo)

Hola, familia de Can Tomàs:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Que en 1890 se comprara la casa por 300 duros de plata cruzando la montaña a pie hasta Cadaqués, y que en Tomàs dedicara un libro de rodolins a la Colla del Senglar, es más historia de la que tienen muchos museos.

Os escribo porque al final de la portada aparece "Discover the latest movies and high-quality streaming options at sflix.com" (un enlace colado que nadie ha puesto a propósito), en Origens i història los bloques se titulan "Text/HTML", y el email que se lee es "cantallopscantomas@gmail.com" pero al pulsarlo se abre "cantomascantallops@gmail.com".

¿Os preparo gratis una maqueta con la carta, los menús y cómo llegar a la Plaça Major, que se vea bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('La Escapada Ventalló', 'Casa rural (masía s. XVII)', 'Ventalló (Alt Empordà)', 'Girona', 'http://www.laescapadaventallo.com', 'sgrau@laescapadaventallo.com', '619 757 037', '', 'perdido', '', null, null, '', 'Contestó el 8 oct: la casa está cerrada al turismo rural por motivos personales; toma nota por si reabre. Respondido con agradecimiento el 9 oct.', false, '', false, 'Contestó el 8 oct: la casa está cerrada al turismo rural por motivos personales; toma nota por si reabre. Respondido con agradecimiento el 9 oct.', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Las "payas" de vuestra web y un email que no llega', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'sgrau@laescapadaventallo.com', 'laescapadaventallo.com', 'http://www.laescapadaventallo.com', 'Girona', 'guzman', 'guzmangonzalezperez@gmail.com', 'Masía del siglo XVII con 15.000 m2 de jardines, museo de coches antiguos, parque zoológico, put in green y salidas al mar con embarcación propia.', 'alta', false, 'seed', 'la-escapada-ventallo', '2026-10-09T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (perdido_revisar).
Asunto: Las "payas" de vuestra web y un email que no llega
Fallos: El enlace de email abre "info@laescapadaventallo.es", un dominio que no existe (los correos rebotan) | Sin <meta name="viewport">: no adaptada al móvil | Erratas en Alojamiento: "grandes payas de Costa Brava", "habitaciones dobles, tripes y cuádrupes", "El tren de alta velocidad t iene parada" | Menú en catalán: "CODICIONS DE CONTRATACIÓ"; título de plantilla "Título" en Condiciones

Hola, equipo de La Escapada:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una masía del siglo XVII en Ventalló con museo de coches antiguos, parque zoológico y barco propio para salir al mar es una combinación que no he visto en ninguna otra casa rural del Empordà.

Os escribo porque el enlace del email de la web abre "info@laescapadaventallo.es", un dominio que no existe (esos correos se pierden), en Alojamiento pone "Una de las grandes payas de Costa Brava" y "habitaciones dobles, tripes y cuádrupes", y en catalán el menú dice "CODICIONS DE CONTRATACIÓ".

¿Os preparo gratis una maqueta con las habitaciones, las tarifas y reserva directa que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-09T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Mas Can Salvi', 'Casa rural (alquiler íntegro)', 'Parlavà (Baix Empordà)', 'Girona', 'http://mascansalvi.com', 'mascansalvi@yahoo.es', '629 49 03 97', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'La portada de vuestra web dice "Nothing Found"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'mascansalvi@yahoo.es', 'mascansalvi.com', 'http://mascansalvi.com', 'Girona', 'guzman', 'guzmangonzalezperez@gmail.com', 'Antiguo pajar del Mas Saló rehabilitado, para 7 personas con jardín grande y piscina; ofrecen dos tipos de almohada.', 'alta', false, 'seed', 'mas-can-salvi-parlava', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: La portada de vuestra web dice "Nothing Found"
Fallos: La portada muestra "Nothing Found. Sorry, no posts matched your criteria" | WordPress 3.5.1 (de 2013) y sin <meta name="viewport">: no adaptada al móvil | Errata: "Disposem de 2 tipos de coixins" (en catalán, tipus) | Email de contacto @yahoo.es en una web de empresa

Hola, equipo de Mas Can Salvi:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Convertir el antiguo pajar del Mas Saló en una casa con jardín y piscina, y encima ofrecer dos tipos de almohada, es el nivel de detalle que uno busca en el Empordà.

Os escribo porque lo primero que se ve al entrar en la web es "Nothing Found. Sorry, no posts matched your criteria", en la página de la casa pone "Disposem de 2 tipos de coixins", el WordPress es la versión 3.5.1 (de 2013) sin adaptar al móvil y el contacto es un @yahoo.es.

¿Os preparo gratis una maqueta con fotos, tarifas y reserva directa que se vea bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Mas Tarascó', 'Agroturismo (masía s. XVI)', 'Vilanant (Alt Empordà)', 'Girona', 'https://mastarasco.com', 'mastarasco@mastarasco.com', '972 54 63 35 / 666 34 85 15', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'En vuestra web se sale de "passajades" por Vilanant', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'mastarasco@mastarasco.com', 'mastarasco.com', 'https://mastarasco.com', 'Girona', 'guzman', 'guzmangonzalezperez@gmail.com', 'Masía datada en el siglo XVI por los dinteles de piedra, con restos que delatan el siglo XIII; capacidad 20 personas y granja propia con conejos, gallinas y patos.', 'media', false, 'seed', 'mas-tarasco-vilanant', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestra web se sale de "passajades" por Vilanant
Fallos: Sin <meta name="viewport">: no adaptada al móvil (el código dice "Copyright (c) Anna Pigem 2006") | Erratas en Entorn: "fer passajades" y "Llocs d''interés" | El enlace a Vilanant (www.ddgi.cat/vilanant/) da error 404 | La página Tarifes no tiene ningún precio

Hola, equipo de Mas Tarascó:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una masía cuyos dinteles dicen siglo XVI pero cuyos restos chivan que es del XIII, con sitio para 20 personas y conejos, gallinas y patos criados como toda la vida, es un argumento de venta buenísimo.

Os escribo porque en Entorn pone "fer passajades" y "Llocs d''interés", el enlace a la web de Vilanant da error 404, la página de Tarifes no tiene ni un precio y la web, que según su código es de 2006, no está adaptada al móvil.

¿Os preparo gratis una maqueta con la casa, la granja y reserva directa con disponibilidad, pensada para el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Serveis Agraris Maiva', 'Servicios agrarios y maquinaria (taller/campo)', 'Batea (Terra Alta)', 'Tarragona', 'http://samaiva.com', 'info@samaiva.com', '+34 615 243 136', '', 'perdido', '', null, null, '', 'Email rebotó (no existe). Llamar al +34 615 243 136.', false, '', true, 'Email rebotó (no existe). Llamar al +34 615 243 136.', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra web dice "FAIL" en todas las páginas', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@samaiva.com', 'samaiva.com', 'http://samaiva.com', 'Tarragona', 'guzman', 'guzmangonzalezperez@gmail.com', 'Empresa fundada en 2008 por Josep Mª Maijó Vallespí; da servicio en Terra Alta, Baix Aragó, Matarranya y Ribera d''Ebre, con vendimiadora New Holland de 105 CV y recolector Topavi.', 'alta', false, 'seed', 'samaiva-batea', '2026-10-09T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (rebote).
Asunto: Vuestra web dice "FAIL" en todas las páginas
Fallos: Cabecera en Flash: todas las páginas muestran "FAIL (the browser should render some flash content, not this)." | Erratas: "sóm una empresa", "rrecol·lector d''ametlles", "Venta de ceps", "Montatge de reg" | Pie "(c) 2011" y sin <meta name="viewport"> | Formulario con botones en inglés "send / reset" y "Benvinguts al nostre Site!"

Hola, Josep Maria:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Montar en 2008 una empresa de servicios agrarios que cubre Terra Alta, Matarranya y Ribera d''Ebre, con vendimiadora New Holland de 105 CV incluida, tiene mucho más mérito que cualquier web.

Te escribo porque arriba de cada página aparece "FAIL (the browser should render some flash content, not this)" porque la cabecera es Flash, en Empresa pone "sóm una empresa" y en la portada "rrecol·lector d''ametlles", y el pie sigue en "(c) 2011" sin versión para móvil.

¿Te preparo gratis una maqueta con los servicios, la maquinaria y un botón de llamar o WhatsApp que funcione en el móvil? Si no te gusta, la borro y aquí no ha pasado nada.', '2026-10-09T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Ca La Lola', 'Casa rural (casa de pagès)', 'La Serra d''Almos (Tivissa, Ribera d''Ebre)', 'Tarragona', 'http://calalola.net', 'calalola.agroturisme@gmail.com', '638 840 631 (Ramón) / 605 065 944 (Fina)', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestro botón de Toprural lleva a una web que ya no existe', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'calalola.agroturisme@gmail.com', 'calalola.net', 'http://calalola.net', 'Tarragona', 'guzman', 'guzmangonzalezperez@gmail.com', 'Tienen su propia app de senderismo (SenderismeCalaLola.apk) y presumen de estar entre Els Ports, el Delta de l''Ebre y el Montsant.', 'media', false, 'seed', 'ca-la-lola-serra-almos', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestro botón de Toprural lleva a una web que ya no existe
Fallos: Maquetada con tablas y Comic Sans, sin <meta name="viewport"> | El botón de información enlaza a toprural.com, dominio que ya no funciona | Cabecera "CASA DE PAGÉS" (en catalán, pagès) | El blog enlazado tiene la última entrada del 12/09/2013, "Publicat per Unknown"

Hola, Ramón y Fina:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una casa en La Serra d''Almos que tiene hasta su propia app de senderismo es algo que no esperaba encontrar, y encima a tiro de Els Ports, el Delta y el Montsant.

Os escribo porque el botón de información lleva a toprural.com, una web que ya no existe, la cabecera dice "CASA DE PAGÉS" (con el acento al revés), la última entrada del blog es del 12 de septiembre de 2013 firmada por "Unknown" y la página está hecha con tablas y Comic Sans, sin adaptar al móvil.

¿Os preparo gratis una maqueta con fotos, precios, calendario y reserva directa que funcione bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Mas Daudén', 'Casa rural (finca familiar)', 'Tortosa (rural, Baix Ebre)', 'Tarragona', 'https://www.masdauden.com', 'info@masdauden.com', '661 219 199', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'En vuestra página de tarifas no hay ni un precio', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@masdauden.com', 'masdauden.com', 'https://www.masdauden.com', 'Tarragona', 'guzman', 'guzmangonzalezperez@gmail.com', 'La familia Daudén, llegada de Aragón, se hizo cargo de la finca en 1945; empezó con diez vacas de leche y conserva "la casa de las Tías" (Mariana, Consuelo y Teresa).', 'media', false, 'seed', 'mas-dauden-tortosa', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestra página de tarifas no hay ni un precio
Fallos: En Tarifas pone "PRECIO:" y solo aparece el email, sin ningún precio | La página Ofertas está vacía | Erratas en la portada: "la casa de la Tías", "porqué Mariana compartía", "el procedía de Iglesuela" | Pie "Copyright © 2014" (Joomla con plantilla de 2014)

Hola, familia Daudén:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una finca que empezó en 1945 con diez vacas de leche y que tiene una "casa de las Tías" porque Mariana la compartía con Consuelo y Teresa es justo el tipo de historia que hace que alguien elija vuestra casa y no otra.

Os escribo porque en Tarifas, donde debería ir el precio, pone "PRECIO:" y solo aparece el email, la página de Ofertas está vacía, en la historia se lee "la casa de la Tías" y "porqué", y el pie sigue en "Copyright © 2014".

¿Os preparo gratis una maqueta con precios claros, calendario de disponibilidad y reserva directa que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('La Vinícola de Gandesa', 'Bodega (vinos, vermuts y moscateles)', 'Gandesa (Terra Alta)', 'Tarragona', 'https://lavinicoladegandesa.com', 'sales@lavinicoladegandesa.com', '+34 977 42 06 50', '', 'contactado', '', null, null, '', 'Email protegido por Cloudflare (se muestra con JavaScript en la web). Titular según registro: Les Vinyes del Convent SLU.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestras noticias son de 2015 y están en la categoría "Sport"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'sales@lavinicoladegandesa.com', 'lavinicoladegandesa.com', 'https://lavinicoladegandesa.com', 'Tarragona', 'guzman', 'guzmangonzalezperez@gmail.com', 'Su marca Pedro Masana patrocinó a Marc Hernández en un viaje de 3.700 km de Barcelona a Estambul en bicicleta de bambú; sumilleres americanos visitaron la bodega.', 'media', false, 'seed', 'vinicola-gandesa', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestras noticias son de 2015 y están en la categoría "Sport"
Fallos: Última noticia del 21/09/2015; todas firmadas "Admin (2)" en la categoría "Sport" | Carácter roto en noticias: "la gama Puig Vent�" | Pie con "Terra Alta Conultoria TIC", "© Copyright 2016." y "© Copyright 2014. All Rights Reserved." a la vez

Hola, equipo de La Vinícola de Gandesa:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Patrocinar con Pedro Masana a un ciclista que se fue de Barcelona a Estambul en una bicicleta de bambú es de las acciones de marca más simpáticas que he visto en una bodega de la Terra Alta.

Os escribo porque la última noticia de la web es del 21 de septiembre de 2015 y todas salen firmadas por "Admin (2)" en la categoría "Sport", en una de ellas se lee "la gama Puig Vent�", y en el pie conviven "Terra Alta Conultoria TIC", "© Copyright 2016." y "© Copyright 2014. All Rights Reserved.".

¿Os preparo gratis una maqueta con vuestros vinos, vermuts y moscateles en una tienda que funcione bien en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Rincón de Aiara, Apartamentos Rurales', 'Apartamentos rurales / casa rural', 'Menagarai (Ayala/Aiara)', 'Álava', 'https://www.rincondeaiara.com/', 'info@rincondeaiara.com', '945 39 90 20 / 656 71 59 25', '', 'contactado', '', null, null, '', 'Negocio familiar. Reserva online rota: argumento fuerte.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra hoja en Flash ya no se balancea (y la reserva online tampoco)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@rincondeaiara.com', 'rincondeaiara.com', 'https://www.rincondeaiara.com/', 'Álava', 'guzman', 'guzmangonzalezperez@gmail.com', 'El caserío Mendieta (s. XVIII) fue posada y estación de diligencias para viajeros hacia Sodupe, Luiaondo y la feria de ganado de Quejana por San Juan; pertenece a la familia desde principios del s. XIX', 'alta', false, 'seed', 'rincon-de-aiara', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra hoja en Flash ya no se balancea (y la reserva online tampoco)
Fallos: La cabecera carga una animación Flash (object application/x-shockwave-flash, “hoja.swf”) que ningún navegador actual reproduce | El botón “RESERVA YA TU APARTAMENTO ONLINE” enlaza a http://reservas.rincondeaiara.com/, un subdominio que ya no resuelve | Las entrevistas de radio enlazadas (entrevistas/apartamentos.mp3, etc.) dan 404 | Errata en portada: “INAGURACIÓN 06/12/2008”

Hola, equipo de Rincón de Aiara:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Me ha encantado descubrir que el caserío Mendieta fue posada y estación de diligencias para los que iban a la feria de ganado de Quejana: pocos apartamentos pueden presumir de haber tenido huéspedes antes que wifi.

Os escribo porque la cabecera de la web sigue cargando una animación Flash (“hoja.swf”) que ya ningún navegador reproduce, el botón “RESERVA YA TU APARTAMENTO ONLINE” lleva a reservas.rincondeaiara.com, que ya no existe, las entrevistas de radio en mp3 dan error 404 y en la portada pone “INAGURACIÓN 06/12/2008”.

¿Os preparo gratis una maqueta con reserva directa que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hotel Asador Jatorrena', 'Asador y hotel familiar', 'Labastida (Rioja Alavesa)', 'Álava', 'https://jatorrena.com/', 'jatorrena@gmail.com', '+34 945 33 10 50', '', 'contactado', '', null, null, '', 'Titular en aviso legal: Manu Urkidi. Comedores para hasta 500 comensales: negocio familiar pero mediano. Alternativa en Álava si se descarta: Hotel Valle de Ayala (Llodio, valledeayala.com, info@valledeayala.com: tablas, sin viewport, sin HTTPS).', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'En vuestra web pone “Descubir” dos veces', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'jatorrena@gmail.com', 'jatorrena.com', 'https://jatorrena.com/', 'Álava', 'guzman', 'guzmangonzalezperez@gmail.com', 'Especialidades: patatas a la riojana, chuletillas al sarmiento y “pochas con sus sacramentos”; asador donde se ve la preparación a la brasa del sarmiento', 'media', false, 'seed', 'jatorrena-labastida', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestra web pone “Descubir” dos veces
Fallos: Errata repetida en portada: los botones dicen “Descubir” (x2) en vez de “Descubrir” | El banner alterna “WEB OFICIAL” con “OFICIAL WEB” | Pie de página anclado en “© 2018 Hotel Asador Jatorrena” | El aviso legal dice literalmente “Datos registrales: dss” | Email de contacto @gmail.com en la web de la empresa

Hola, equipo de Jatorrena:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Las pochas con sus sacramentos y las chuletillas al sarmiento ya me tenían ganado, pero lo de ver la brasa desde la mesa del asador es jugar con ventaja.

Os escribo porque en la portada los botones dicen “Descubir”, el banner alterna “WEB OFICIAL” con “OFICIAL WEB”, el pie sigue en “© 2018”, el aviso legal tiene un “Datos registrales: dss” y el email de contacto es un @gmail.com.

¿Os preparo gratis una maqueta con reserva directa de habitación y mesa que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Apartamentos Rurales Larrago', 'Apartamentos rurales en caserío', 'Busturia (Urdaibai)', 'Bizkaia', 'https://larrago.es/', 'info@larrago.es', '+34 699 79 77 82', '', 'contactado', '', null, null, '', 'Contacto en la web: Gorka Olabe Anasagasti; Saioa aparece como anfitriona en las reseñas.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra web se llama “My CMS” (y el formulario enseña su código)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@larrago.es', 'larrago.es', 'https://larrago.es/', 'Bizkaia', 'guzman', 'guzmangonzalezperez@gmail.com', 'Reseña en su web: una familia llegó desde Jerez “sin nada en las maletas” y Saioa, la anfitriona, les recibió “con un par de cervecitas y unos yogures para el niño”; vieron un zorro y un corzo junto a la casa', 'alta', false, 'seed', 'larrago-busturia', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web se llama “My CMS” (y el formulario enseña su código)
Fallos: La etiqueta <title> de la portada es la de plantilla: “My CMS – Apartamentos rurales” | La página de Contacto muestra el shortcode sin procesar “[contact-form-7 id=»9″ title=»Formulario de contacto 1″]” y avisa de “problemas técnicos con el formulario de contacto” | Pie: “Copyright 2015 All Right Reserved” | Errata: “contactar con nostros” | WordPress 5.4 (versión de 2020)

Hola, Gorka y Saioa:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. He leído la reseña de la familia que llegó desde Jerez sin nada en las maletas y a la que recibisteis con cervecitas y yogures para el niño; con eso y un zorro y un corzo de vecinos, poco más hay que vender.

Os escribo porque la pestaña del navegador dice “My CMS – Apartamentos rurales”, en Contacto aparece el código “[contact-form-7 id=»9″ title=»Formulario de contacto 1″]” junto a un aviso de “problemas técnicos con el formulario”, el pie dice “Copyright 2015 All Right Reserved” y se ha colado un “contactar con nostros”.

¿Os preparo gratis una maqueta con reserva directa y un formulario que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Restaurante Mendiondo', 'Restaurante de cocina tradicional', 'Sopuerta (Encartaciones)', 'Bizkaia', 'https://www.mendiondo.com/', 'jlezama@mendiondo.com', '946 504 452', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestros “Comendores” y una página de cocina que está vacía', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'jlezama@mendiondo.com', 'mendiondo.com', 'https://www.mendiondo.com/', 'Bizkaia', 'guzman', 'guzmangonzalezperez@gmail.com', 'Bodega de 70 m2 con más de 360 referencias, horno de leña y cenas-cata con bodegas', 'alta', false, 'seed', 'mendiondo-sopuerta', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestros “Comendores” y una página de cocina que está vacía
Fallos: Errata en portada: “Disponemos de dos Comendores” | El menú muestra “Cocina_tradicional” con guion bajo y esa página (y su variante cocina%20tradicional.html) está vacía, solo el título | La última noticia es “CENA - CATA - MARIDAJE ... 16 DE OCTUBRE DE 2.020” | Horarios contradictorios: Reservas dice “Domingo noche y Lunes (salvo festivo): Cerrado” y la portada “LUNES - MARTES - MIERCOLES CERRADO POR DESCANSO” | Copyright © 2015; aforo incoherente (“aforo para 85 comensales” vs “Comedor Grande: Capacidad 80 personas”)

Hola, equipo de Mendiondo:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una bodega de 70 m2 con más de 360 referencias en plenas Encartaciones, y encima con horno de leña, es motivo de sobra para cruzar Bizkaia.

Os escribo porque en la portada pone “Disponemos de dos Comendores”, el menú muestra “Cocina_tradicional” con guion bajo y esa página está vacía, la última noticia es una cata del “16 DE OCTUBRE DE 2.020” y en Reservas pone “Domingo noche y Lunes (salvo festivo): Cerrado” mientras la portada dice “LUNES - MARTES - MIERCOLES CERRADO POR DESCANSO”.

¿Os preparo gratis una maqueta con la carta, el horario bien claro y reserva de mesa desde el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Nerea Jatetxea', 'Restaurante', 'Lazkao (Goierri)', 'Gipuzkoa', 'http://www.nereajatetxea.com/', 'info@nereajatetxea.com', '943 088 088', '', 'contactado', '', null, null, '', 'Dos emails en la web: info@nereajatetxea.com (mailto) y mncterra@gmail.com (texto visible).', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'En vuestra web pone “coicna tradicional” (y “Nera Jatetxea”)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@nereajatetxea.com', 'nereajatetxea.com', 'http://www.nereajatetxea.com/', 'Gipuzkoa', 'guzman', 'guzmangonzalezperez@gmail.com', 'Nerea y Alberto abrieron en 2008; sus calamares frescos hechos en casa son el “auténtico buque insignia del local”', 'alta', false, 'seed', 'nerea-lazkao', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestra web pone “coicna tradicional” (y “Nera Jatetxea”)
Fallos: Erratas en Nosotros: “coicna tradicional”, “no sóo” y el propio nombre mal escrito: “Nera Jatetxea” (también en Menú) | En Contacto el enlace mailto es info@nereajatetxea.com pero el texto visible es “mncterra@gmail.com” | Botón a Google+ (plus.google.com), servicio cerrado en 2019 | Pie “Copyright © 2015” | HTTPS con certificado autofirmado (el navegador da aviso de seguridad)

Hola, Nerea y Alberto:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Que unos calamares frescos hechos en casa sean el “auténtico buque insignia” del local desde 2008 dice mucho de cómo cocináis en Lazkao.

Os escribo porque en Nosotros se han colado “coicna tradicional”, “no sóo” y hasta “Nera Jatetxea”, el enlace de email lleva a info@nereajatetxea.com pero lo que se lee es “mncterra@gmail.com”, sigue habiendo un botón a Google+, cerrado desde 2019, y el pie dice “Copyright © 2015”.

¿Os preparo gratis una maqueta con el menú del día fácil de actualizar y reserva desde el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Perlakua - Saka (agroturismo, restaurante y ganadería)', 'Agroturismo y restaurante', 'Itziar, Deba (Bajo Deba)', 'Gipuzkoa', 'http://www.sakabaserria.com/', 'info@sakabaserria.com', '943 19 11 37 / 615 73 94 32', '', 'contactado', '', null, null, '', 'Lo regenta la familia Arrizabalaga.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra web dice “VER DISPONIBIILIDAD” (con dos íes)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@sakabaserria.com', 'sakabaserria.com', 'http://www.sakabaserria.com/', 'Gipuzkoa', 'guzman', 'guzmangonzalezperez@gmail.com', 'Ganadería “Marqués de Saka”, existente desde 1897 y presentada como la más antigua de Euskadi, que sigue llevando sus reses a sokamuturras; la dueña restauró todos los muebles de la casa', 'alta', false, 'seed', 'saka-perlakua-deba', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web dice “VER DISPONIBIILIDAD” (con dos íes)
Fallos: Errata en el botón principal de todas las páginas: “VER DISPONIBIILIDAD” | La página de Contacto muestra dos textos de plantilla sin rellenar: “<< Nueva imagen con texto >>” | Teléfono mal escrito en Restaurante: “94343191137” | Sin <meta viewport> (IONOS MyWebsite antiguo, no adaptada al móvil) y sin HTTPS | Precio ausente: “MENU ESPECIAL (Menu completo por persona )”

Hola, familia Arrizabalaga:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Tener la ganadería “Marqués de Saka”, que viene de 1897 y presentáis como la más antigua de Euskadi, y además un agroturismo con vistas al mar de Deba, es una combinación que no se ve todos los días.

Os escribo porque el botón principal dice “VER DISPONIBIILIDAD”, en la página de contacto se ven dos “<< Nueva imagen con texto >>” de la plantilla, en Restaurante aparece el teléfono “94343191137” y la web no se adapta al móvil ni carga por HTTPS.

¿Os preparo gratis una maqueta con reserva directa del agroturismo y la carta del restaurante bien visibles en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('La abeja Meli (Apiarte)', 'Miel ecológica / apicultura artesana', 'Torremocha de Jarama (Sierra Norte)', 'Madrid', 'http://laabejameli.com/', 'info@laabejameli.com', '91 843 16 94', '', 'contactado', '', null, null, '', 'Torremocha de Jarama no estaba en la lista de ejemplos, pero es Sierra Norte (pueblo pequeño).', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra web se quedó en 2012 (y los premios en 2011)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@laabejameli.com', 'laabejameli.com', 'http://laabejameli.com/', 'Madrid', 'guzman', 'guzmangonzalezperez@gmail.com', 'Más de 30 años de apicultura, producción ecológica desde los inicios, circuito corto de menos de 90 km y 72 placas fotovoltaicas en el tejado', 'alta', false, 'seed', 'la-abeja-meli', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web se quedó en 2012 (y los premios en 2011)
Fallos: Sin <meta viewport> y maquetada con 7 tablas: no adaptada al móvil | Sin HTTPS (https://laabejameli.com no carga) | Pie “Copyright 2012 | La abeja Meli ® Apiarte | website template by ARaynorDesign” | La lista de premios se queda en “2008 - 2009 - 2010 - 2011” | Errata: “vídeos de La abeja Meli en televisón”; la sección “Comprar” es solo una lista de tiendas, no hay venta online

Hola, equipo de Apiarte:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Más de 30 años de miel ecológica de cosecha propia, a menos de 90 km del colmenar a la tienda y con 72 placas solares en el tejado: lo vuestro es kilómetro cero de verdad.

Os escribo porque el pie dice “Copyright 2012” y “website template by ARaynorDesign”, la lista de premios se para en “2008 - 2009 - 2010 - 2011”, se ha colado un “televisón” y la web está maquetada con tablas, sin versión móvil ni HTTPS, con una sección Comprar que solo lista tiendas.

¿Os preparo gratis una maqueta con tienda online que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Bodegas Bernabeleva', 'Bodega familiar', 'San Martín de Valdeiglesias', 'Madrid', 'http://bernabeleva.com/', 'bodega@bernabeleva.com', '+34 91 509 19 09', '', 'contactado', '', null, null, '', 'Bodega familiar de cierto prestigio (prensa internacional); trato con equipo.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra historia dice “Huelva en Andaluc?a”', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'bodega@bernabeleva.com', 'bernabeleva.com', 'http://bernabeleva.com/', 'Madrid', 'guzman', 'guzmangonzalezperez@gmail.com', 'El Dr. Vicente Álvarez-Villamil compró la finca en 1923; sus herederos cuidan las viejas cepas; “Bernabeleva significa literalmente la ruta del oso”', 'alta', false, 'seed', 'bernabeleva', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra historia dice “Huelva en Andaluc?a”
Fallos: En la página de Historia (bernabeleva.htm) las fotos llevan pies de otra web: “Huelva en Andaluc?a” y “Parque Natural Sierra de Aracena y Picos de Aroche” | Sin <meta viewport> en toda la web, incluida la tienda online (tienda.php): no adaptada al móvil | Pie “BERNABELEVA S.L. © 2011” | La sección Prensa termina en “APERITIF - Bernabeleva en Noruega - 2016_11” | Errata en Contacto: “A 2 km dela salida del pueblo”

Hola, equipo de Bernabeleva:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Saber que Bernabeleva significa “la ruta del oso” y que seguís cuidando las cepas que plantó el Dr. Álvarez-Villamil en 1923 hace que la garnacha sepa todavía mejor.

Os escribo porque en la página de Historia las fotos llevan los pies “Huelva en Andaluc?a” y “Parque Natural Sierra de Aracena y Picos de Aroche”, el pie sigue en “© 2011”, la prensa más reciente es de “2016_11” y ni la web ni la tienda online están adaptadas al móvil.

¿Os preparo gratis una maqueta con tienda y reserva de visitas que funcionen en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Restaurante Mesón Quiñones (Cuevas del Murciélago)', 'Restaurante / mesón', 'Chinchón', 'Madrid', 'https://www.cuevasdelmurcielago.com/', 'info@cuevasdelmurcielago.com', '918 94 05 32', '', 'contactado', '', null, null, '', 'Web WordPress con viewport; los fallos son de contenido y enlaces muertos. Enlaza a La Casa del Pregonero (mismos dueños).', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'En vuestra web pone “Cuevas del Murciélado”', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@cuevasdelmurcielago.com', 'cuevasdelmurcielago.com', 'https://www.cuevasdelmurcielago.com/', 'Madrid', 'guzman', 'guzmangonzalezperez@gmail.com', 'Abrió como mesón en 1971, uno de los primeros de Chinchón; el nombre viene de los murciélagos que anidaban en la antigua casa de labranza; catas en su bodega subterránea', 'media', false, 'seed', 'meson-quinones-chinchon', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: En vuestra web pone “Cuevas del Murciélado”
Fallos: Errata en el slider de portada: “Restaurante Cuevas del Murciélado” | El botón “Download MENU IN PDF” (en inglés) apunta a “#” y no descarga nada | Los botones FACEBOOK, TWITTER y YOUTUBE del slider apuntan a “#” | Pie desactualizado: “2021© Restaurante Mesón Quiñones” | Erratas: “Fué abierta como mesón”, “decorados con vasíjas de barro”

Hola, equipo del Mesón Quiñones:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Abrir como mesón en 1971 en una casa de labranza donde anidaban murciélagos, y conservar la cueva para catas, es tener la historia de Chinchón bajo los pies.

Os escribo porque la portada dice “Restaurante Cuevas del Murciélado”, el botón “Download MENU IN PDF” no lleva a ningún sitio, los de FACEBOOK, TWITTER y YOUTUBE tampoco, y el pie sigue en “2021©”.

¿Os preparo gratis una maqueta con la carta, cómo llegar y reserva de mesa desde el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Agroturisme Ca n''Escandell', 'Agroturismo', 'Sant Joan de Labritja (Ibiza)', 'Illes Balears', 'http://canescandell.com/', 'info@canescandell.com', '971 333 540 / 619 419 193', '', 'contactado', '', null, null, '', 'Web en catalán (citado tal cual). Contacto de reservas: Toni Escandell.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestras tarifas siguen en 2018 (y la oferta de octubre también)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@canescandell.com', 'canescandell.com', 'http://canescandell.com/', 'Illes Balears', 'guzman', 'guzmangonzalezperez@gmail.com', 'Casa original de la familia Escandell del siglo XVIII en Es Amunts, finca de cultivo de más de 200 años; calçotades cada sábado de febrero a abril', 'alta', false, 'seed', 'can-escandell-ibiza', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestras tarifas siguen en 2018 (y la oferta de octubre también)
Fallos: Tarifas caducadas: “Temporada baixa 2018”, “Temporada mitja 2018”, “Temporada alta 2018” | Oferta caducada: “Oferta vigent dels dies 1 al 31 d''octubre de 2018” | Sin <meta viewport> y maquetada con tablas: no adaptada al móvil | Servicios de otra época en Habitacions: “connexió a internet ADSL/WI-FI”, “TV, DVD” | Errata: “un apartament per a quatres persones”

Hola, Toni:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Una casa familiar del siglo XVIII en Es Amunts, con el halcón de Eleonor sobrevolando y calçotades cada sábado de febrero a abril, es una rareza preciosa en Ibiza.

Os escribo porque en Tarifes pone “Temporada baixa 2018”, en Ofertes “Oferta vigent dels dies 1 al 31 d''octubre de 2018”, en Habitacions se promete “connexió a internet ADSL/WI-FI” y “DVD”, y la web está hecha con tablas y no se adapta al móvil.

¿Os preparo gratis una maqueta con tarifas al día y reserva directa desde el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Agroturismo Finca Sant Blai', 'Agroturismo', 'Campos (Mallorca)', 'Illes Balears', 'https://www.santblai.com/', 'agroturismo@santblai.com', '+34 685 955 000', '', 'contactado', '', null, null, '', 'Campos linda con Santanyí.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestra web enseña “-->” por todas partes', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'agroturismo@santblai.com', 'santblai.com', 'https://www.santblai.com/', 'Illes Balears', 'guzman', 'guzmangonzalezperez@gmail.com', 'Finca de 1800; el antiguo molino es biblioteca y bodega, el safreig es la piscina; habitaciones llamadas Agua, Aire, Flora, Fuego, Tierra y Fauna; nombre de la capilla de Sant Blai del s. XIII', 'alta', false, 'seed', 'sant-blai-campos', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestra web enseña “-->” por todas partes
Fallos: Restos de código visibles en portada: “-->” repetido entre los textos y el menú | El menú incluye “HTML Columns Layout” de la plantilla; ese enlace (columns.asp) y el “Guest Book” (Guestbook.asp) dan 404 | Pie roto: “copyright; 2012 Agroturismo Finca Sant Blai in Mallorca” | Sin <meta viewport>: no adaptada al móvil | Erratas: “most beutiful beaches”; en la versión española “los niños y mayer”, “apartamientos”, “estenso desayuno”; caracteres rotos en About: “â€œsafreigâ€”

Hola, equipo de Sant Blai:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Que las habitaciones se llamen Agua, Aire, Flora, Fuego, Tierra y Fauna, y que el antiguo safreig sea ahora la piscina, es de esos detalles que hacen inolvidable una finca.

Os escribo porque en la portada aparecen restos de código “-->” entre los textos, el menú incluye un “HTML Columns Layout” de la plantilla y tanto ese enlace como el Guest Book dan error 404, el pie dice “copyright; 2012” y en la versión en castellano pone “los niños y mayer” y “apartamientos”.

¿Os preparo gratis una maqueta con reserva directa que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Agroturisme Es Figueral', 'Agroturismo', 'Campos (Mallorca)', 'Illes Balears', 'http://www.esfigueral.com/', 'info@esfigueral.com', '', '', 'contactado', '', null, null, '', 'Sin teléfono visible en la web. Directorio de mallorca.com lo sitúa en Montuïri; TripAdvisor y su Facebook, en Campos.', false, '', false, '', 'seed-2026-10-13', 'guzmangonzalezperez@gmail.com', 'Vuestro blog se quedó en 2010 (con un título en hindi)', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@esfigueral.com', 'esfigueral.com', 'http://www.esfigueral.com/', 'Illes Balears', 'guzman', 'guzmangonzalezperez@gmail.com', 'Agroturismo con jardín del lago y cisnes, algarrobos, frutales, huerto ecológico y gallinas', 'media', false, 'seed', 'es-figueral-campos', '2026-10-08T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Vuestro blog se quedó en 2010 (con un título en hindi)
Fallos: Sin <meta viewport>: no adaptada al móvil | Música de fondo en autoplay con reproductor Flash de respaldo (“player.swf?soundFile=archivo.mp3”), y tanto player.swf como archivo.mp3 dan 404 | Enlace a Fotolog (fotolog.com/esfigueral) que da 404 | El blog enlazado (petithotelesfigueral.blogspot.com) tiene como última entrada el “sábado, 10 de julio de 2010”, titulada “इल्ला दे काबरेरा” (en escritura hindi) | Erratas: “la tranquildad”, “doble nº5de 36m2”, en catalán “La nostre habitació”

Hola, equipo de Es Figueral:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Un agroturismo con jardín junto al lago, cisnes, algarrobos, frutales y huerto ecológico suena exactamente a lo que uno busca cuando huye de la playa.

Os escribo porque la web intenta poner música sola al entrar y su reproductor Flash de respaldo (“player.swf”) da error 404, el enlace a Fotolog lleva a una página que no existe, el blog enlazado tiene como última entrada el 10 de julio de 2010 con el título “इल्ला दे काबरेरा” y la web no se adapta al móvil.

¿Os preparo gratis una maqueta con reserva directa que funcione en el móvil? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-08T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Carpinterías Mixtas', 'Carpintería madera/PVC/aluminio', 'Cobatillas (Murcia)', 'Murcia', 'https://carpinteriasmixtas.com', 'info@carpinteriasmixtas.com', '968 865 284', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Unas "puertas de entranda" en vuestra web', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@carpinteriasmixtas.com', 'carpinteriasmixtas.com', 'https://carpinteriasmixtas.com', 'Murcia', 'guzman', null, 'Familiar, +30 años, 15 personas, distribuidores de Finstral', 'media', false, 'seed', 'carp-mixtas', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Unas "puertas de entranda" en vuestra web
Fallos: Footer ''© Copyright 2016'' | Teléfono de cabecera ''+968 865 284'' (prefijo mal) | Errata ''Puertas de entranda en madera'' | Tema y plugins de 2016

Hola, equipo de Carpinterías Mixtas:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Más de 30 años, 15 personas y distribuidores de Finstral: lo vuestro es serio. Por eso me llamaron la atención un par de detalles de la web. El pie sigue en 2016, el teléfono de arriba sale como "+968 865 284" (con un + que despista a cualquier móvil) y en la galería hay unas "puertas de entranda en madera".

Son tonterías, pero a quien va a gastarse miles de euros en ventanas le dan que pensar. ¿Os preparo gratis una maqueta con vuestros proyectos bien lucidos? Si no os gusta, a la papelera.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Confitería La Peladilla', 'Confitería', 'Murcia', 'Murcia', 'https://lapeladilla.com', 'lapeladilla@hotmail.com', '968 21 63 71', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Pastel de Cierva desde 1902… y un "croasant"', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'lapeladilla@hotmail.com', 'lapeladilla.com', 'https://lapeladilla.com', 'Murcia', 'guzman', null, 'Desde 1902, 6 generaciones, Solete Repsol 2024; Juan Pardo se hizo confitero porque se mareaba en los barcos', 'alta', false, 'seed', 'peladilla', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Pastel de Cierva desde 1902… y un "croasant"
Fallos: ''croasant'' y ''croosan'' en la web | Faltan tildes en la historia | Horarios contradictorios | Email de hotmail | Footer © 2022

Hola, equipo de La Peladilla:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. He leído vuestra historia y me ha encantado, sobre todo lo de Juan Pardo, que acabó de confitero porque se mareaba en los barcos. Seis generaciones y un Solete de Repsol: poca broma.

La web, en cambio, se ha quedado un poco atrás. El croissant aparece como "croasant" y "croosan", faltan tildes en la historia, los horarios se contradicen y el correo es un hotmail.

¿Os hago gratis una maqueta de una web a la altura de 124 años de pasteles? Si no os gusta, me como el disgusto (y un pastel de Cierva).

Seguimiento: 2026-10-02 maqueta + 490 €', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Mármoles Santa Catalina', 'Marmolería / cocinas', 'Santo Ángel (Murcia)', 'Murcia', 'https://www.marmolessantacatalina.com', 'info@marmolessantacatalina.com', '+34 968 840 632', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'El Black Friday de 2019 sigue en vuestra web', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@marmolessantacatalina.com', 'marmolessantacatalina.com', 'https://www.marmolessantacatalina.com', 'Murcia', 'guzman', null, '+30 años; 1.500 m² de travertino en Madrid; trabajan Neolith, Silestone y Dekton', 'media', false, 'seed', 'marmoles-sc', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: El Black Friday de 2019 sigue en vuestra web
Fallos: Última noticia del blog: Black Friday de noviembre 2019 | Footer © 2019 | WordPress de 2018 | http no redirige a https

Hola, equipo de Mármoles Santa Catalina:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. 1.500 m² de travertino en Madrid y trabajo con Neolith, Silestone y Dekton: tenéis proyectos para presumir.

Pero en la web lo último que aparece es "El Black Friday llega a tu cocina", de noviembre de 2019, y el pie sigue en 2019. Quien busca encimera en Google puede pensar que habéis cerrado.

¿Os preparo gratis una maqueta con vuestras cocinas bien enseñadas? Si no os convence, la borro sin más.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Restaurante Paredes', 'Restaurante', 'Lorca', 'Murcia', 'https://restauranteparedes.es', 'reservas@restauranteparedes.com', '+34 626 277 725', '', 'contactado', '', null, null, '', '', false, '', false, '', 'seed-2026-10-13', '', 'Ostras Gillardeau y una carta sin precios', '1–6')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'reservas@restauranteparedes.com', 'restauranteparedes.com', 'https://restauranteparedes.es', 'Murcia', 'guzman', null, 'Salón coqueto para 40, vajilla inglesa, ostras Gillardeau y gamba roja de Garrucha', 'media', false, 'seed', 'paredes', '2026-10-01T09:00:00+02:00' from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (contactado).
Asunto: Ostras Gillardeau y una carta sin precios
Fallos: Carta sin precios | Filtro de la carta en inglés (''Show all'') | Imágenes de 2014, WordPress 4.1 | Web .es y email .com

Hola, equipo del Restaurante Paredes:

Soy Guzmán, tengo 19 años y hago webs desde Madrid. Vajilla inglesa, cubiertos franceses, ostras Gillardeau y gamba roja de Garrucha: vuestra carta da hambre solo de leerla.

Lo que no ayuda es la web. La carta no tiene precios (y hoy casi todo el mundo los mira antes de reservar), el filtro pone "Show all" en inglés y las fotos son de 2014.

¿Os hago gratis una maqueta de una web con carta clara y reservas? Si no os gusta, la borro y aquí no ha pasado nada.', '2026-10-01T09:00:00+02:00' from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Mas Serra-rica', 'Casa rural (masoveries independientes)', 'Muntanyola (Osona)', 'Barcelona', 'https://www.masserrarica.com', 'info@masserrarica.com', '938 13 70 66', '', 'lead', '', null, null, '', 'Experimento LP: grupo B', false, '', false, '', 'seed-2026-10-13', '', 'Vuestras tarifas siguen en 2013 (y la galería pide Flash)', '7')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@masserrarica.com', 'masserrarica.com', 'https://www.masserrarica.com', 'Barcelona', 'guzman', null, '', null, false, 'seed', 'csv-280', null from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (preparado).
Asunto: Vuestras tarifas siguen en 2013 (y la galería pide Flash)', now() from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('El Mas de Vilalleons', 'Casa rural (2 viviendas independientes)', 'Vilalleons, Sant Julià de Vilatorta (Osona)', 'Barcelona', 'https://www.elmasdevilalleons.com', 'info@elmasdevilalleons.com', '659 822 712 / 93 888 78 44', '', 'lead', '', null, null, '', 'Experimento LP: grupo A', false, '', false, '', 'seed-2026-10-13', '', 'En vuestra web pone "Cataluinya" (y el castellano está escondido)', '7')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@elmasdevilalleons.com', 'elmasdevilalleons.com', 'https://www.elmasdevilalleons.com', 'Barcelona', 'guzman', null, '', null, false, 'seed', 'csv-281', null from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (preparado).
Asunto: En vuestra web pone "Cataluinya" (y el castellano está escondido)', now() from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Ca l''Avi', 'Casa rural (2 apartamentos de alquiler íntegro)', 'Sant Boi de Lluçanès (Lluçanès, Osona)', 'Barcelona', 'http://www.calavi.cat', 'info@calavi.cat', '629 712 339', '', 'lead', '', null, null, '', 'Experimento LP: grupo B', false, '', false, '', 'seed-2026-10-13', '', 'Vuestra web dice "manífiques vistes" (y las tarifas no tienen tarifas)', '7')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@calavi.cat', 'calavi.cat', 'http://www.calavi.cat', 'Barcelona', 'guzman', null, '', null, false, 'seed', 'csv-282', null from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (preparado).
Asunto: Vuestra web dice "manífiques vistes" (y las tarifas no tienen tarifas)', now() from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Mas El Francàs Vell', 'Casa rural (alquiler íntegro)', 'Sant Agustí de Lluçanès (Lluçanès, Osona)', 'Barcelona', 'https://elfrancasvell.blogspot.com', 'alfrancas@hotmail.com', '677 755 460', '', 'lead', '', null, null, '', 'Experimento LP: grupo A', false, '', false, '', 'seed-2026-10-13', '', 'Tu web tiene la palabra "pestanyes" colgando bajo el título', '7')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'alfrancas@hotmail.com', 'elfrancasvell.blogspot.com', 'https://elfrancasvell.blogspot.com', 'Barcelona', 'guzman', null, '', null, false, 'seed', 'csv-283', null from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (preparado).
Asunto: Tu web tiene la palabra "pestanyes" colgando bajo el título', now() from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Pedra Salera', 'Casa rural (alquiler íntegro)', 'Perafita (Lluçanès, Osona)', 'Barcelona', 'https://casapedrasalera.cat', 'info@casapedrasalera.cat', '655 10 15 51 / 655 10 15 75', '', 'lead', '', null, null, '', 'Experimento LP: grupo B', false, '', false, '', 'seed-2026-10-13', '', 'Vuestra web dice "[FREE]" en el selector de idioma', '7')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@casapedrasalera.cat', 'casapedrasalera.cat', 'https://casapedrasalera.cat', 'Barcelona', 'guzman', null, '', null, false, 'seed', 'csv-284', null from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (preparado).
Asunto: Vuestra web dice "[FREE]" en el selector de idioma', now() from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Restaurant La Posada (Posada-Piques)', 'Restaurante', 'Sant Pere Molanta, Olèrdola (Alt Penedès)', 'Barcelona', 'https://www.posada-piques.com', 'infoposada@yahoo.es', '93 892 13 99', '', 'lead', '', null, null, '', 'Experimento LP: grupo A', false, '', false, '', 'seed-2026-10-13', '', 'Vuestra web sigue en "Maintenance Mode" (y dice "Hola benvinguts:)")', '7')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'infoposada@yahoo.es', 'posada-piques.com', 'https://www.posada-piques.com', 'Barcelona', 'guzman', null, '', null, false, 'seed', 'csv-285', null from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (preparado).
Asunto: Vuestra web sigue en "Maintenance Mode" (y dice "Hola benvinguts:)")', now() from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Restaurant Masia La Figuera', 'Restaurante', 'L''Astor, Pujalt (Alta Anoia)', 'Barcelona', 'http://www.masialafiguera.cat', 'masialafiguera@gmail.com', '652 41 86 25 / 93 868 13 14', '', 'lead', '', null, null, '', 'Experimento LP: grupo B', false, '', false, '', 'seed-2026-10-13', '', 'Vuestra carta sigue siendo la de otoño 2021-2022', '7')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'masialafiguera@gmail.com', 'masialafiguera.cat', 'http://www.masialafiguera.cat', 'Barcelona', 'guzman', null, '', null, false, 'seed', 'csv-286', null from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (preparado).
Asunto: Vuestra carta sigue siendo la de otoño 2021-2022', now() from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hotel-Restaurant Ermitatge de Quadres', 'Hotel rural y restaurante', 'Quadres, Isòvol (Cerdanya)', 'Girona', 'http://www.ermitatge.com', 'contacte@ermitatge.com', '972 19 11 05 / 608 075 176', '', 'lead', '', null, null, '', 'Experimento LP: grupo A', false, '', false, '', 'seed-2026-10-13', '', 'Vuestra portada aún anuncia el Cap d''Any de 2010', '7')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'contacte@ermitatge.com', 'ermitatge.com', 'http://www.ermitatge.com', 'Girona', 'guzman', null, '', null, false, 'seed', 'csv-287', null from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (preparado).
Asunto: Vuestra portada aún anuncia el Cap d''Any de 2010', now() from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Recuits i Formatges Nuri', 'Quesería / obrador de lácteos de cabra con tienda', 'Ullastret (Baix Empordà)', 'Girona', 'http://www.recuitsnuri.com', 'recuitsnuri@gmail.com', '972 757 674', '', 'lead', '', null, null, '', 'Experimento LP: grupo B', false, '', false, '', 'seed-2026-10-13', '', 'Vuestra web cierra a las 19:00 y a las 20:00 a la vez', '7')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'recuitsnuri@gmail.com', 'recuitsnuri.com', 'http://www.recuitsnuri.com', 'Girona', 'guzman', null, '', null, false, 'seed', 'csv-288', null from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (preparado).
Asunto: Vuestra web cierra a las 19:00 y a las 20:00 a la vez', now() from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Can Salgueda', 'Casa rural (2 apartamentos)', 'Santa Pau (Garrotxa)', 'Girona', 'https://www.cansalgueda.com', 'cansalgueda@cansalgueda.com', '626 302 273 / 936 501 821', '', 'lead', '', null, null, '', 'Experimento LP: grupo A', false, '', false, '', 'seed-2026-10-13', '', 'Tu página de reservas en catalán está en castellano', '7')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'cansalgueda@cansalgueda.com', 'cansalgueda.com', 'https://www.cansalgueda.com', 'Girona', 'guzman', null, '', null, false, 'seed', 'csv-289', null from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (preparado).
Asunto: Tu página de reservas en catalán está en castellano', now() from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Bosc de Can Ginebreda', 'Artesano / parque de esculturas', 'Porqueres (Pla de l''Estany)', 'Girona', 'http://www.canginebreda.cat', 'info@canginebreda.com', '656 614 370', '', 'lead', '', null, null, '', 'Experimento LP: grupo B', false, '', false, '', 'seed-2026-10-13', '', 'Tu web abre a las 8 y a las 9 (y el email acaba en ".co m")', '7')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@canginebreda.com', 'canginebreda.com', 'http://www.canginebreda.cat', 'Girona', 'guzman', null, '', null, false, 'seed', 'csv-290', null from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (preparado).
Asunto: Tu web abre a las 8 y a las 9 (y el email acaba en ".co m")', now() from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Can Vilà', 'Casas rurales (alquiler íntegro)', 'Ullastret (Baix Empordà)', 'Girona', 'http://can-vila.blogspot.com', 'can-vila@hotmail.com', '972 757 966 / 669 302 056', '', 'lead', '', null, null, '', 'Experimento LP: grupo A', false, '', false, '', 'seed-2026-10-13', '', 'Vuestra web habla de una estancia "acojedora" desde 2007', '7')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'can-vila@hotmail.com', 'can-vila.blogspot.com', 'http://can-vila.blogspot.com', 'Girona', 'guzman', null, '', null, false, 'seed', 'csv-291', null from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (preparado).
Asunto: Vuestra web habla de una estancia "acojedora" desde 2007', now() from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('La Cantonada', 'Restaurante', 'La Bisbal d''Empordà (Baix Empordà)', 'Girona', 'http://lacantonada.cat', 'lacantonadacat@gmail.com', '621 185 255', '', 'lead', '', null, null, '', 'Experimento LP: grupo B', false, '', false, '', 'seed-2026-10-13', '', 'Vuestra web sigue volviendo de vacaciones el 26 de junio', '7')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'lacantonadacat@gmail.com', 'lacantonada.cat', 'http://lacantonada.cat', 'Girona', 'guzman', null, '', null, false, 'seed', 'csv-292', null from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (preparado).
Asunto: Vuestra web sigue volviendo de vacaciones el 26 de junio', now() from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Raquel', 'Casa rural', 'Montanejos', 'Castellón', 'https://www.casaraquelmontanejos.com/', 'rakelmileo@hotmail.com', '648 788 568', '', 'lead', '', null, null, '', 'Experimento LP: grupo A', false, '', false, '', 'seed-2026-10-13', '', 'Si pulso vuestro teléfono, mi móvil marca el 0000000', '7')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'rakelmileo@hotmail.com', 'casaraquelmontanejos.com', 'https://www.casaraquelmontanejos.com/', 'Castellón', 'guzman', null, '', null, false, 'seed', 'csv-293', null from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (preparado).
Asunto: Si pulso vuestro teléfono, mi móvil marca el 0000000', now() from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Clínica Dental Vilafamés', 'Clínica dental', 'Vilafamés', 'Castellón', 'https://clinicavilafames.com/', 'info@clinicavilafames.com', '964 32 98 96', '', 'lead', '', null, null, '', 'Experimento LP: grupo B', false, '', false, '', 'seed-2026-10-13', '', 'En vuestro menú pone "Peridoncia" (y sigue saliendo Google+)', '7')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@clinicavilafames.com', 'clinicavilafames.com', 'https://clinicavilafames.com/', 'Castellón', 'guzman', null, '', null, false, 'seed', 'csv-294', null from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (preparado).
Asunto: En vuestro menú pone "Peridoncia" (y sigue saliendo Google+)', now() from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Motorjérica', 'Taller mecánico y concesionario multimarca', 'Jérica', 'Castellón', 'https://motorjerica.com/', 'info@motorjerica.com', '964 129 189', '', 'lead', '', null, null, '', 'Experimento LP: grupo A', false, '', false, '', 'seed-2026-10-13', '', 'Vuestras "ofertas del mes" son de la primavera de 2022', '7')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@motorjerica.com', 'motorjerica.com', 'https://motorjerica.com/', 'Castellón', 'guzman', null, '', null, false, 'seed', 'csv-295', null from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (preparado).
Asunto: Vuestras "ofertas del mes" son de la primavera de 2022', now() from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Quesería Tot de Poble', 'Quesería artesana', 'Les Coves de Vinromà', 'Castellón', 'https://queseriatotdepoble.com/', 'totdepoble@hotmail.com', '616 076 752 (Mayte) / 636 671 654 (Óscar)', '', 'lead', '', null, null, '', 'Experimento LP: grupo B', false, '', false, '', 'seed-2026-10-13', '', 'Lleváis "cuatro años" en la quesería desde antes de 2016', '7')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'totdepoble@hotmail.com', 'queseriatotdepoble.com', 'https://queseriatotdepoble.com/', 'Castellón', 'guzman', null, '', null, false, 'seed', 'csv-296', null from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (preparado).
Asunto: Lleváis "cuatro años" en la quesería desde antes de 2016', now() from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hotel Restaurante El Rullo', 'Hotel rural pequeño y restaurante', 'Vilafamés', 'Castellón', 'https://www.elrullo.es/', 'info@elrullo.es', '640 930 614', '', 'lead', '', null, null, '', 'Experimento LP: grupo A', false, '', false, '', 'seed-2026-10-13', '', 'Vuestra web sigue invitando a la Nochevieja de 2025', '7')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@elrullo.es', 'elrullo.es', 'https://www.elrullo.es/', 'Castellón', 'guzman', null, '', null, false, 'seed', 'csv-297', null from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (preparado).
Asunto: Vuestra web sigue invitando a la Nochevieja de 2025', now() from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Hotel Rural La Taifa', 'Hotel rural y restaurante', 'Alpuente', 'Valencia', 'http://lataifa.com/', 'lataifa@lataifa.com', '600 693 639', '', 'lead', '', null, null, '', 'Experimento LP: grupo A', false, '', false, '', 'seed-2026-10-13', '', 'Vuestra "disponibiidad" lleva tiempo en obras', '7')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'lataifa@lataifa.com', 'lataifa.com', 'http://lataifa.com/', 'Valencia', 'guzman', null, '', null, false, 'seed', 'csv-298', null from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (preparado).
Asunto: Vuestra "disponibiidad" lleva tiempo en obras', now() from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Rural Kairós', 'Casa rural', 'Siete Aguas', 'Valencia', 'https://ruralkairos.com/', 'info@ruralkairos.com', '629 049 477', '', 'lead', '', null, null, '', 'Experimento LP: grupo B', false, '', false, '', 'seed-2026-10-13', '', 'Vuestras opiniones más recientes son de 2019', '7')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@ruralkairos.com', 'ruralkairos.com', 'https://ruralkairos.com/', 'Valencia', 'guzman', null, '', null, false, 'seed', 'csv-299', null from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (preparado).
Asunto: Vuestras opiniones más recientes son de 2019', now() from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Cofrentes Turismo Activo', 'Turismo activo y casa rural', 'Cofrentes', 'Valencia', 'https://www.cofrentesturismoactivo.com/', 'info@cofrentesturismoactivo.com', '619 35 47 81', '', 'lead', '', null, null, '', 'Experimento LP: grupo A', false, '', false, '', 'seed-2026-10-13', '', 'Vuestro enlace de "Golf" acaba en un error 404', '7')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@cofrentesturismoactivo.com', 'cofrentesturismoactivo.com', 'https://www.cofrentesturismoactivo.com/', 'Valencia', 'guzman', null, '', null, false, 'seed', 'csv-300', null from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (preparado).
Asunto: Vuestro enlace de "Golf" acaba en un error 404', now() from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Moviment i Salut (Arturo Such)', 'Clínica de fisioterapia', 'L''Olleria', 'Valencia', 'https://arturosuch.com/', 'movimentisalut@gmail.com', '644 200 582', '', 'lead', '', null, null, '', 'Experimento LP: grupo B', false, '', false, '', 'seed-2026-10-13', '', 'Tu blog se quedó en junio de 2022 (y se coló un "biopsiocosocial")', '7')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'movimentisalut@gmail.com', 'arturosuch.com', 'https://arturosuch.com/', 'Valencia', 'guzman', null, '', null, false, 'seed', 'csv-301', null from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (preparado).
Asunto: Tu blog se quedó en junio de 2022 (y se coló un "biopsiocosocial")', now() from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('El Mirador de Agres', 'Restaurante', 'Agres', 'Alicante', 'https://www.elmiradordeagres.es/', 'info@elmiradordeagres.es', '682 869 455', '', 'lead', '', null, null, '', 'Experimento LP: grupo A', false, '', false, '', 'seed-2026-10-13', '', 'En vuestra web os habéis convertido en un "sitio espacial"', '7')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@elmiradordeagres.es', 'elmiradordeagres.es', 'https://www.elmiradordeagres.es/', 'Alicante', 'guzman', null, '', null, false, 'seed', 'csv-302', null from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (preparado).
Asunto: En vuestra web os habéis convertido en un "sitio espacial"', now() from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Clínica Dental Muro', 'Clínica dental', 'Muro d''Alcoi', 'Alicante', 'http://clinicadentalmuro.es/', 'info@clinicadentalmuro.es', '966 517 068', '', 'lead', '', null, null, '', 'Experimento LP: grupo B', false, '', false, '', 'seed-2026-10-13', '', 'Vuestra web se quedó en 2024 (y sin candado)', '7')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@clinicadentalmuro.es', 'clinicadentalmuro.es', 'http://clinicadentalmuro.es/', 'Alicante', 'guzman', null, '', null, false, 'seed', 'csv-303', null from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (preparado).
Asunto: Vuestra web se quedó en 2024 (y sin candado)', now() from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Óptica Domenech', 'Óptica y audiología', 'Pinoso', 'Alicante', 'https://opticadomenech.com/', 'info@opticadomenech.com', '684 41 07 10', '', 'lead', '', null, null, '', 'Experimento LP: grupo A', false, '', false, '', 'seed-2026-10-13', '', 'Tu botón de gafas de sol "A por la mía" lleva a un error 404', '7')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@opticadomenech.com', 'opticadomenech.com', 'https://opticadomenech.com/', 'Alicante', 'guzman', null, '', null, false, 'seed', 'csv-304', null from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (preparado).
Asunto: Tu botón de gafas de sol "A por la mía" lleva a un error 404', now() from l;
with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values ('Casa Rosalineta', 'Carnicería y embutidos artesanos', 'Cocentaina', 'Alicante', 'https://casarosalineta.com/', 'info@casarosalineta.com', '96 559 08 28', '', 'lead', '', null, null, '', 'Experimento LP: grupo B', false, '', false, '', 'seed-2026-10-13', '', 'Vuestra tienda online habla inglés ("No products in the cart")', '7')
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, 'info@casarosalineta.com', 'casarosalineta.com', 'https://casarosalineta.com/', 'Alicante', 'guzman', null, '', null, false, 'seed', 'csv-305', null from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', 'Importado del tracker (preparado).
Asunto: Vuestra tienda online habla inglés ("No products in the cart")', now() from l;
insert into public.clients (name, sector, city, contact_name, stage, service, value_eur, next_action, notes, source)
  values ('Red F7', 'Ligas de fútbol 7', 'Madrid', 'Israel', 'reunion', 'Automatización de procesos', null, 'Preparar reunión', 'Unos 420 equipos y procesos manuales por email y WhatsApp.', 'clientes-csv-2026-10-13');
commit;
