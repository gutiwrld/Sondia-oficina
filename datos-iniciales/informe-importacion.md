# Informe de importación del seed (en seco)

> Generado por `pnpm seed:informe`. **No se ha escrito nada en la base de datos.** El SQL está en `supabase/seed/seed_hunter.sql` y se aplica cuando des el OK.

## Resumen

| | |
|---|---:|
| Leads en el CSV | 305 |
| Con correo y cuerpo en el tracker | 279 |
| Etapa resultante | contactado 251 · lead 26 · perdido 22 · propuesta_enviada 2 · negociacion 1 · maqueta_enviada 1 · ganado 1 · respondio 1 |
| **No contactar** (email y dominio a la lista de supresión) | 8 |
| Rebotes (Perdido, email rebotado, se queda el teléfono) | 8 |
| Perdidos sin «no» explícito (revisar) | 6 |
| Preparados sin enviar (se reauditan antes de la mesa) | 26 |
| Contactados sin cuenta registrada (la bandeja buscará su hilo) | 78 |
| Fusionados con `clientes.csv` | 5 |
| Clientes de `clientes.csv` sin lead (se crean solo en el ERP) | 1 |

Por cuenta: sin cuenta 104 · guzmangonzalezperez@gmail.com 101 · guzmangonzalez.twati@gmail.com 100

## Pasan a «No contactar» (irreversible)

- **Ibermonesterio** (Badajoz) · ibermonesterio@ibermonesterio.com — Contestaron "no". No volver a escribir.
- **Restaurante Salzillo** (Murcia) · contacto@restaurantesalzillo.com — Contestaron: la web la lleva un familiar y no pueden cambiar de proveedor; le pasarán los cambios. No insistir.
- **Trufas Bertolin** (Teruel) · info@trufasbertolin.com — Isabel Bertolín contestó 5 oct: no están interesados. No volver a escribir.
- **Casa Rural Pitu** (Cuenca) · casaruralpitu@gmail.com — Contestó "No, gracias". No volver a escribir.
- **Carlos Jimeno · Cerámica y Patrimonio** (Valladolid) · carjimeno@hotmail.com — Contestó 5 oct: no le interesa, se está jubilando. No volver a escribir.
- **La Caseta del Forn** (Castellón) · lacasetadelforn@gmail.com — Contestó 7 oct (Jose Manuel Edo): ese blog no lo usan, su web es lacasetadelforn.com y no necesitan nada. No volver a escribir.
- **Cal Serrador** (Barcelona) · calserrador@hotmail.com — Jordi contestó el 9 oct: ya no venden leche y no les interesa. No volver a escribir.
- **Formatge Bauma** (Barcelona) · bauma@formatgebauma.com — Contestó "no" el 8 oct. No volver a escribir.

## Rebotes

- **Pulpería El Dorado** · info@pulperiaeldorado.com · tel. 988 321 728 — Email rebotó (no existe). Llamar al 988 321 728.
- **Embutidos Agustín** · fabrica@embutidosagustin.es · tel. 987 357 172 — Rebote del email. Llamar al 987 357 172
- **Embutidos Cauria** · cauria@embutidoscauria.es · tel. 630 424 748 — El correo rebotó: la dirección no existe. Si interesa, llamar al 630 424 748.
- **Casa Rural La Tahona** · casarurallatahona@gmail.com · tel. 656 60 62 48 — Rebote: la dirección no existe. Llamar al 656 60 62 48
- **Productos Silvestres Florencio Ramos** · productossilvestres@hotmail.com · tel. 652 91 55 74 / 923 47 51 80 — Rebote: la dirección no existe. Llamar al 652 91 55 74 / 923 47 51 80
- **Bodegas Rueda Pérez S.A.T.** · satruedaperez@terra.com · tel. 983 822 049 — Email rebotó (el dominio terra.com ya no recibe correo).
- **Horno de Lozoya** · info@hornolozoya.es · tel. 692 26 40 89 — Email rebotó (8 oct). Llamar al 692 26 40 89.
- **Serveis Agraris Maiva** · info@samaiva.com · tel. +34 615 243 136 — Email rebotó (no existe). Llamar al +34 615 243 136.

## Perdidos sin «no» explícito: revísalos

Quedan en **Perdido**, pero **no** en No contactar (por ejemplo, jubilaciones, traspasos o cierres). Si alguno debe ir a No contactar, dímelo antes de aplicar.

- **La Casa de Sebastián** · info@lacasadesebastian.com — Contestó: están traspasando el negocio. Respondido el 8 oct ofreciendo ayuda a los nuevos dueños.
- **La Tinaja - Apartamentos Rurales** · info@casarurallatinaja.com — Contestó: se jubiló el 1 de octubre. Respondido con agradecimiento el 8 oct.
- **Alojamiento Rural Cruz del Gallo** · cruzdelgallocasarural@gmail.com — Raquel contestó: la casa se vendió a finales de septiembre; quizá los nuevos dueños. Guzmán ya le respondió.
- **Hostal Rural La Piedra del Mediodía (Restaurante Sorni)** · info@piedramediodia.com — Contestó 7 oct: cierran el 15 de noviembre por jubilación. Respondido con agradecimiento el 8 oct.
- **Cansaladeria Singla** · cansingla@hotmail.com — Manel Singla contestó el 8 oct: viven de sus dos tiendas, dejaron la venta online por el coste del envío en frío y tienen una empresa que les lleva el dominio con poco presupuesto. Guarda el contacto por si cambian de opinión. Respondido el 9 oct con un consejo sobre los Warning de PHP.
- **La Escapada Ventalló** · sgrau@laescapadaventallo.com — Contestó el 8 oct: la casa está cerrada al turismo rural por motivos personales; toma nota por si reabre. Respondido con agradecimiento el 9 oct.

## Respondieron (siguen en «Respondió»)

- **Cervantes College** · hola@cervantescollege.com — Respondió Raquel Mtz. Vera-Meseguer (directora): ya son Guay Spanish School y tienen web nueva (guayspanishschool.com). Oportunidad: redirigir el dominio viejo.

## Pipeline fusionado desde clientes.csv

- **Legumbres La Gallareta** → negociacion · Webs + ventas online (fijo + comisión)
- **Mesón Asador Valderrey** → maqueta_enviada · 490 € · Web completa
- **Librería Alcaraván** → ganado · 290 € · Web informativa de una página
- **Embutidos Pimar** → propuesta_enviada · 490 € · Web completa
- **Hotel Restaurante Gurutze-Berri** → propuesta_enviada · 490 € · Web completa

Sin lead de cold email (solo ERP): **Red F7** (Reunión acordada)

## Comprobaciones

- Provincias desconocidas: ninguna
- Provincias de Hugo: ninguna
- Provincias renombradas: Baleares → Illes Balears
- Emails duplicados: ninguno
- Dominios duplicados: ninguno

## Contactados sin cuenta registrada

78 leads. La bandeja buscará su hilo en las dos cuentas por el destinatario. Si no aparece, el lead queda «sin hilo» y no recibe seguimiento.

## Notas

- **URL de origen del email:** el seed no guarda la página exacta donde salía cada email, así que se usa la web del negocio. Los leads nuevos de Hunter guardarán la URL exacta.
- Cada lead lleva un evento de importación con su asunto, sus fallos y el cuerpo enviado. Son los ejemplos de estilo de Hunter.
