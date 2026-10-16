import { z } from 'zod';
import { TIPOS_FALLO } from './auditoria';

/** Etapas del pipeline: son las de `public.client_stage` del ERP. */
export const ETAPAS = [
  'lead',
  'contactado',
  'respondio',
  'reunion',
  'maqueta_enviada',
  'propuesta_enviada',
  'negociacion',
  'ganado',
  'perdido',
] as const;
export type Etapa = (typeof ETAPAS)[number];

export const ETIQUETA_ETAPA: Record<Etapa, string> = {
  lead: 'Lead',
  contactado: 'Contactado',
  respondio: 'Respondió',
  reunion: 'Reunión',
  maqueta_enviada: 'Maqueta enviada',
  propuesta_enviada: 'Propuesta enviada',
  negociacion: 'Negociación',
  ganado: 'Ganado',
  perdido: 'Perdido',
};

export const TURNOS = ['rastreo', 'redaccion', 'bandeja', 'seguimiento', 'preparacion', 'parte', 'informe'] as const;
export type Turno = (typeof TURNOS)[number];

export const ETIQUETA_TURNO: Record<Turno, string> = {
  rastreo: 'Rastreo',
  redaccion: 'Redacción',
  bandeja: 'Bandeja',
  seguimiento: 'Seguimiento',
  preparacion: 'Preparación',
  parte: 'Parte de caza',
  informe: 'Informe semanal',
};

export const TIPOS_APROBACION = ['nuevo', 'seguimiento', 'respuesta', 'reunion', 'llamada'] as const;
export type TipoAprobacion = (typeof TIPOS_APROBACION)[number];

export const ESTADOS_APROBACION = ['pendiente', 'aprobado', 'rechazado', 'rehacer', 'caducado'] as const;
export type EstadoAprobacion = (typeof ESTADOS_APROBACION)[number];

export const ESTADOS_OUTBOX = ['en_cola', 'enviando', 'enviado', 'fallido', 'cancelado'] as const;
export type EstadoOutbox = (typeof ESTADOS_OUTBOX)[number];

export const CLASIFICACIONES = ['no', 'interes', 'precio', 'llamada_visita', 'fuera_oficina', 'rebote'] as const;
export type Clasificacion = (typeof CLASIFICACIONES)[number];

export const ETIQUETA_CLASIFICACION: Record<Clasificacion, string> = {
  no: 'No',
  interes: 'Interés',
  precio: 'Pregunta el precio',
  llamada_visita: 'Pide llamada o visita',
  fuera_oficina: 'Fuera de la oficina',
  rebote: 'Rebote',
};

/** Lo que devuelve el modelo al redactar un primer correo. Se valida antes de tocar nada. */
export const BorradorModelo = z.object({
  asunto: z.string().min(5).max(120),
  saludo: z.string().min(3).max(120),
  cuerpo: z.string().min(80).max(2_500),
  gancho: z.string().min(5).max(400),
  oferta: z.enum(['completa', 'informativa']),
  fallos: z
    .array(
      z.object({
        tipo: z.enum(TIPOS_FALLO),
        descripcion: z.string().min(3).max(300),
        cita: z.string().max(400).nullable().optional(),
      }),
    )
    .min(2)
    .max(4),
  observaciones: z.string().max(600).optional(),
});
export type BorradorModelo = z.infer<typeof BorradorModelo>;

/** Lo que devuelve el modelo rápido al clasificar una respuesta. */
export const ClasificacionModelo = z.object({
  clasificacion: z.enum(CLASIFICACIONES),
  confianza: z.number().min(0).max(1),
  resumen: z.string().max(300),
  vuelveEl: z.string().nullable().optional(),
});
export type ClasificacionModelo = z.infer<typeof ClasificacionModelo>;
