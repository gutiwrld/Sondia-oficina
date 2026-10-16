/**
 * Outbox de la oficina · el ÚNICO proceso que envía correos.
 *
 * - Se conecta a Postgres con el rol `hunter_outbox` (nunca con el del agente).
 * - Solo ve filas de `agents.outbox`, que solo se crean con `agents.aprobar()` (un socio autenticado).
 * - Antes de cada envío la base de datos vuelve a comprobar supresión, «No contactar», cuenta y pausa
 *   (transición en_cola → enviando); aquí además se aplican límites, franjas y la espera aleatoria
 *   con `decidirEnvio` de @sondia/core.
 * - El token de Google con permiso de envío solo existe en este contenedor (`hunter.token_envio`).
 *
 * El bucle de envío con la API de Gmail llega en la Fase 3.
 */
export { decidirEnvio, esperaEntreEnvios, CONFIG_ENVIO_POR_DEFECTO } from '@sondia/core';
