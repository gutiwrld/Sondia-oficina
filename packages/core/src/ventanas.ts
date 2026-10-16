import { DateTime } from 'luxon';

/** Zona horaria de toda la oficina. Se pasa siempre de forma explícita (el calendario de Guzmán está en Costa Rica). */
export const ZONA = 'Europe/Madrid';

export type TipoEnvio = 'nuevo' | 'seguimiento' | 'respuesta' | 'reunion';

export interface Franja {
  /** Días ISO: 1 = lunes … 7 = domingo. */
  dias: number[];
  /** «HH:mm», hora de Madrid, inclusive. */
  desde: string;
  /** «HH:mm», hora de Madrid, exclusive. */
  hasta: string;
}

export interface Peldano {
  /** Desde este día de calentamiento (1 = primer día)… */
  desdeDia: number;
  /** …el límite diario es este. */
  limite: number;
}

export interface ConfigEnvio {
  limiteDiario: number;
  esperaMinMinutos: number;
  esperaMaxMinutos: number;
  franjas: Record<TipoEnvio, Franja>;
  rampa: Peldano[];
}

export const CONFIG_ENVIO_POR_DEFECTO: ConfigEnvio = {
  limiteDiario: 50,
  esperaMinMinutos: 2,
  esperaMaxMinutos: 6,
  franjas: {
    nuevo: { dias: [1, 2, 3, 4], desde: '09:00', hasta: '11:00' },
    seguimiento: { dias: [1, 2, 3, 4], desde: '11:00', hasta: '13:00' },
    respuesta: { dias: [1, 2, 3, 4, 5], desde: '09:00', hasta: '19:00' },
    reunion: { dias: [1, 2, 3, 4, 5], desde: '09:00', hasta: '19:00' },
  },
  rampa: [
    { desdeDia: 1, limite: 10 },
    { desdeDia: 4, limite: 20 },
    { desdeDia: 8, limite: 30 },
    { desdeDia: 15, limite: 40 },
    { desdeDia: 22, limite: 50 },
  ],
};

const enMadrid = (instante: Date) => DateTime.fromJSDate(instante, { zone: ZONA });

const minutosDe = (hhmm: string) => {
  const [h, m] = hhmm.split(':').map(Number);
  return (h ?? 0) * 60 + (m ?? 0);
};

/** Día natural en Madrid («2026-10-25»), para contar envíos por día. */
export function diaMadrid(instante: Date): string {
  return enMadrid(instante).toISODate()!;
}

export function enFranja(tipo: TipoEnvio, instante: Date, cfg: ConfigEnvio = CONFIG_ENVIO_POR_DEFECTO): boolean {
  const f = cfg.franjas[tipo];
  const t = enMadrid(instante);
  if (!f.dias.includes(t.weekday)) return false;
  const min = t.hour * 60 + t.minute;
  return min >= minutosDe(f.desde) && min < minutosDe(f.hasta);
}

/** Primer instante ≥ `desde` que cae dentro de la franja del tipo (mira hasta 14 días). */
export function siguienteApertura(
  tipo: TipoEnvio,
  desde: Date,
  cfg: ConfigEnvio = CONFIG_ENVIO_POR_DEFECTO,
): Date {
  if (enFranja(tipo, desde, cfg)) return desde;
  const f = cfg.franjas[tipo];
  const inicio = minutosDe(f.desde);
  let dia = enMadrid(desde).startOf('day');
  for (let i = 0; i < 15; i++) {
    if (f.dias.includes(dia.weekday)) {
      // Construimos la hora local; luxon resuelve el desfase correcto de ese día (cambio de hora incluido).
      const apertura = dia.set({ hour: Math.floor(inicio / 60), minute: inicio % 60 });
      if (apertura.toMillis() >= desde.getTime()) return apertura.toJSDate();
    }
    dia = dia.plus({ days: 1 });
  }
  throw new Error(`La franja «${tipo}» no tiene ningún día configurado`);
}

/** Límite diario de una cuenta ese día, con la rampa de calentamiento si la cuenta es nueva. */
export function limiteDelDia(
  cuenta: { calentamientoDesde?: string | null; limiteDiario?: number | null },
  instante: Date,
  cfg: ConfigEnvio = CONFIG_ENVIO_POR_DEFECTO,
): number {
  const tope = cuenta.limiteDiario ?? cfg.limiteDiario;
  if (!cuenta.calentamientoDesde) return tope;
  const inicio = DateTime.fromISO(cuenta.calentamientoDesde, { zone: ZONA }).startOf('day');
  const hoy = enMadrid(instante).startOf('day');
  const diaN = Math.floor(hoy.diff(inicio, 'days').days) + 1;
  if (diaN < 1) return 0;
  let limite = 0;
  for (const p of cfg.rampa) if (diaN >= p.desdeDia) limite = p.limite;
  return Math.min(limite, tope);
}

/** Espera aleatoria entre envíos, en milisegundos. `aleatorio` ∈ [0, 1). */
export function esperaEntreEnvios(aleatorio: number, cfg: ConfigEnvio = CONFIG_ENVIO_POR_DEFECTO): number {
  const r = Math.min(Math.max(aleatorio, 0), 0.999999);
  const minutos = cfg.esperaMinMinutos + r * (cfg.esperaMaxMinutos - cfg.esperaMinMinutos);
  return Math.round(minutos * 60_000);
}

export type DecisionEnvio =
  | { enviar: true }
  | {
      enviar: false;
      motivo: 'pausa' | 'fuera_de_franja' | 'limite_diario' | 'espera_entre_envios';
      reintentarEn: Date | null;
    };

/**
 * La decisión de la outbox para el siguiente correo de una cuenta.
 * `enviadosHoy` son los enviados por esa cuenta en el día de Madrid de `ahora`.
 * `noAntesDe` es el último envío más la espera aleatoria que se sorteó al enviarlo.
 */
export function decidirEnvio(p: {
  tipo: TipoEnvio;
  ahora: Date;
  enviadosHoy: number;
  noAntesDe?: Date | null;
  cuenta: { calentamientoDesde?: string | null; limiteDiario?: number | null };
  pausa?: boolean;
  cfg?: ConfigEnvio;
}): DecisionEnvio {
  const cfg = p.cfg ?? CONFIG_ENVIO_POR_DEFECTO;
  if (p.pausa) return { enviar: false, motivo: 'pausa', reintentarEn: null };
  if (!enFranja(p.tipo, p.ahora, cfg)) {
    return { enviar: false, motivo: 'fuera_de_franja', reintentarEn: siguienteApertura(p.tipo, p.ahora, cfg) };
  }
  if (p.enviadosHoy >= limiteDelDia(p.cuenta, p.ahora, cfg)) {
    const manana = enMadrid(p.ahora).plus({ days: 1 }).startOf('day').toJSDate();
    return { enviar: false, motivo: 'limite_diario', reintentarEn: siguienteApertura(p.tipo, manana, cfg) };
  }
  if (p.noAntesDe && p.ahora < p.noAntesDe) {
    const reintento = p.noAntesDe;
    return {
      enviar: false,
      motivo: 'espera_entre_envios',
      reintentarEn: enFranja(p.tipo, reintento, cfg) ? reintento : siguienteApertura(p.tipo, reintento, cfg),
    };
  }
  return { enviar: true };
}

/** Fecha en que toca preparar el seguimiento: 3 días naturales tras el envío. */
export function fechaSeguimiento(enviado: Date, dias = 3): Date {
  return enMadrid(enviado).plus({ days: dias }).toJSDate();
}
