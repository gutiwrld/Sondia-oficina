import 'server-only';
import { DateTime } from 'luxon';
import { ZONA, type PuntoSenal } from '@sondia/core';
import { esVistaPrevia } from './sesion';
import { supabaseServidor } from './supabase/servidor';

/** Resultado de una lectura: datos (vacíos si no hay) y el error, si lo hubo, para enseñarlo sin romper la sala. */
export interface Lectura<T> {
  datos: T;
  error: string | null;
}

async function leer<T>(vacio: T, fn: (sb: Awaited<ReturnType<typeof supabaseServidor>>) => Promise<T>): Promise<Lectura<T>> {
  if (esVistaPrevia()) return { datos: vacio, error: null };
  try {
    return { datos: await fn(await supabaseServidor()), error: null };
  } catch (e) {
    return { datos: vacio, error: e instanceof Error ? e.message : String(e) };
  }
}

const exigir = <T>(r: { data: T | null; error: { message: string } | null }): T => {
  if (r.error) throw new Error(r.error.message);
  return r.data as T;
};

const inicioDeHoy = () => DateTime.now().setZone(ZONA).startOf('day').toUTC().toISO()!;

// ---------------------------------------------------------------------------
// Departamentos y estado vivo
// ---------------------------------------------------------------------------
export interface Departamento {
  slug: string;
  numero: number;
  nombre: string;
  descripcion: string;
  estado: 'activo' | 'libre';
  estado_vivo: string | null;
  estado_vivo_at: string | null;
}

const DEPARTAMENTOS_BASE: Departamento[] = [
  { slug: 'hunter', numero: 1, nombre: 'Hunter', descripcion: 'Encuentra negocios con webs anticuadas, los audita, escribe, lee respuestas y prepara las llamadas.', estado: 'activo', estado_vivo: null, estado_vivo_at: null },
  { slug: 'cierre', numero: 2, nombre: 'Cierre', descripcion: 'Propuestas, presupuestos y seguimiento hasta el «sí».', estado: 'libre', estado_vivo: null, estado_vivo_at: null },
  { slug: 'entrega', numero: 3, nombre: 'Entrega', descripcion: 'Del «sí» a la web publicada: maqueta, contenidos, dominio y entrega.', estado: 'libre', estado_vivo: null, estado_vivo_at: null },
  { slug: 'finanzas', numero: 4, nombre: 'Finanzas', descripcion: 'Cobros, facturas y caja de SONDIA.', estado: 'libre', estado_vivo: null, estado_vivo_at: null },
];

export async function departamentos(): Promise<Lectura<Departamento[]>> {
  const r = await leer<Departamento[]>([], async (sb) =>
    exigir(await sb.schema('agents').from('departments').select('*').order('numero')),
  );
  return r.datos.length ? r : { ...r, datos: DEPARTAMENTOS_BASE };
}

export interface EstadoHunter {
  pausa: boolean;
  enCurso: { turno: string; progreso: { hecho?: number; total?: number; etiqueta?: string } } | null;
  estadoVivo: string | null;
  mesa: number;
}

export async function estadoHunter(): Promise<Lectura<EstadoHunter>> {
  return leer<EstadoHunter>({ pausa: false, enCurso: null, estadoVivo: null, mesa: 0 }, async (sb) => {
    const [pausa, run, dep, mesa] = await Promise.all([
      sb.schema('agents').from('settings').select('valor').eq('department', 'hunter').eq('clave', 'pausa').maybeSingle(),
      sb.schema('agents').from('agent_runs').select('turno, progreso').eq('department', 'hunter').eq('estado', 'en_curso')
        .order('iniciado_at', { ascending: false }).limit(1).maybeSingle(),
      sb.schema('agents').from('departments').select('estado_vivo').eq('slug', 'hunter').maybeSingle(),
      sb.schema('agents').from('approvals').select('id', { count: 'exact', head: true }).eq('department', 'hunter').eq('estado', 'pendiente'),
    ]);
    for (const r of [pausa, run, dep, mesa]) if (r.error) throw new Error(r.error.message);
    return {
      pausa: Boolean((pausa.data?.valor as { activa?: boolean } | undefined)?.activa),
      enCurso: run.data ? { turno: run.data.turno, progreso: run.data.progreso ?? {} } : null,
      estadoVivo: dep.data?.estado_vivo ?? null,
      mesa: mesa.count ?? 0,
    };
  });
}

// ---------------------------------------------------------------------------
// Hoy
// ---------------------------------------------------------------------------
export interface ResumenHoy {
  parte: { titular: string; fecha: string } | null;
  enviadosHoy: number;
  limiteHoy: number;
  respuestasHoy: number;
  reunionesProximas: number;
  proximaReunion: string | null;
  tasa7: { respondieron: number; enviados: number } | null;
  mesa: number;
  cuentas: number;
}

export async function resumenHoy(): Promise<Lectura<ResumenHoy>> {
  const vacio: ResumenHoy = {
    parte: null, enviadosHoy: 0, limiteHoy: 100, respuestasHoy: 0, reunionesProximas: 0, proximaReunion: null,
    tasa7: null, mesa: 0, cuentas: 2,
  };
  return leer(vacio, async (sb) => {
    const hoy = inicioDeHoy();
    const hace7 = DateTime.now().minus({ days: 7 }).toUTC().toISO()!;
    const fechaHoy = DateTime.now().setZone(ZONA).toISODate()!;
    const [parte, enviados, respuestas, reuniones, mesa, cuentas, enviados7, respondidos7] = await Promise.all([
      sb.schema('hunter').from('reports').select('titular, fecha').eq('tipo', 'parte').eq('fecha', fechaHoy).maybeSingle(),
      sb.schema('agents').from('outbox').select('id', { count: 'exact', head: true }).eq('estado', 'enviado').gte('enviado_at', hoy),
      sb.schema('hunter').from('messages').select('id', { count: 'exact', head: true }).eq('direccion', 'entrante')
        .gte('recibido_at', hoy).not('clasificacion', 'in', '(rebote,fuera_oficina)'),
      sb.schema('hunter').from('meetings').select('empieza_at').eq('estado', 'prevista').gte('empieza_at', new Date().toISOString())
        .order('empieza_at').limit(50),
      sb.schema('agents').from('approvals').select('id', { count: 'exact', head: true }).eq('estado', 'pendiente'),
      sb.schema('hunter').from('mail_accounts').select('limite_diario, activa').eq('activa', true),
      sb.schema('hunter').from('leads').select('client_id', { count: 'exact', head: true }).gte('primer_envio_at', hace7),
      sb.schema('hunter').from('leads').select('client_id', { count: 'exact', head: true }).gte('primer_envio_at', hace7)
        .not('ultima_respuesta_at', 'is', null),
    ]);
    for (const r of [parte, enviados, respuestas, reuniones, mesa, cuentas, enviados7, respondidos7]) {
      if (r.error) throw new Error(r.error.message);
    }
    const listaCuentas = (cuentas.data ?? []) as { limite_diario: number | null }[];
    return {
      parte: parte.data ? { titular: parte.data.titular, fecha: parte.data.fecha } : null,
      enviadosHoy: enviados.count ?? 0,
      limiteHoy: listaCuentas.reduce((s, c) => s + (c.limite_diario ?? 50), 0),
      respuestasHoy: respuestas.count ?? 0,
      reunionesProximas: reuniones.data?.length ?? 0,
      proximaReunion: reuniones.data?.[0]?.empieza_at ?? null,
      tasa7: (enviados7.count ?? 0) > 0 ? { respondieron: respondidos7.count ?? 0, enviados: enviados7.count ?? 0 } : null,
      mesa: mesa.count ?? 0,
      cuentas: listaCuentas.length,
    };
  });
}

// ---------------------------------------------------------------------------
// Mesa
// ---------------------------------------------------------------------------
export interface Borrador {
  id: string;
  tipo: 'nuevo' | 'seguimiento' | 'respuesta' | 'reunion' | 'llamada';
  client_id: string;
  nombre: string;
  ciudad: string;
  provincia: string;
  web: string;
  sector: string;
  cuenta_email: string | null;
  para_email: string | null;
  asunto: string;
  cuerpo: string;
  huecos: { inicio: string; fin: string }[];
  evidencia: {
    senal?: number;
    senal_desglose?: PuntoSenal[];
    captura_url?: string | null;
    fallos?: { tipo: string; descripcion: string; cita?: string | null }[];
    porque?: string;
    mensaje?: { de: string; fragmento: string; recibido_at: string };
  };
  verificacion: { ok?: boolean; citas?: { cita: string; encontrada: boolean }[] };
  created_at: string;
}

/**
 * Solo en vista previa local con OFICINA_EJEMPLO_MESA=1: dos correos REALES ya enviados del tracker del 13-oct,
 * para revisar el diseño del modo foco. No son borradores y no se pueden aprobar (no hay base de datos).
 */
async function ejemploMesa(): Promise<Borrador[]> {
  const { readFile } = await import('node:fs/promises');
  const { join } = await import('node:path');
  const tracker = JSON.parse(await readFile(join(process.cwd(), '../../datos-iniciales/tracker-leads-2026-10-13.json'), 'utf8')) as {
    id: string; nombre: string; sector: string; ciudad: string; region: string; web: string; email: string; cuenta?: string;
    asunto: string; cuerpo: string; problemas: string[]; cambiado: string;
  }[];
  return tracker
    .filter((t) => ['adelfas-olveite'].includes(t.id) || t.nombre.includes('Valderrey'))
    .slice(0, 2)
    .map((t) => ({
      id: t.id, tipo: 'nuevo' as const, client_id: t.id, nombre: t.nombre, ciudad: t.ciudad, provincia: t.region, web: t.web,
      sector: t.sector, cuenta_email: t.cuenta ?? 'guzmangonzalezperez@gmail.com', para_email: t.email, asunto: t.asunto,
      cuerpo: t.cuerpo, huecos: [],
      evidencia: {
        fallos: t.problemas.map((p) => ({ tipo: 'texto_literal', descripcion: p.replace(/[:(].*$/, '').trim(), cita: p.match(/"([^"]+)"/)?.[1] ?? null })),
        porque: 'Ejemplo de vista previa: correo real ya enviado, no es un borrador',
      },
      verificacion: {},
      created_at: t.cambiado,
    }));
}

export async function mesa(): Promise<Lectura<Borrador[]>> {
  if (esVistaPrevia() && process.env.OFICINA_EJEMPLO_MESA === '1') return { datos: await ejemploMesa(), error: null };
  return leer<Borrador[]>([], async (sb) =>
    exigir(
      await sb.schema('agents').from('v_mesa').select('*').eq('department', 'hunter').eq('estado', 'pendiente')
        .order('created_at').limit(200),
    ) as Borrador[],
  );
}

// ---------------------------------------------------------------------------
// Radar
// ---------------------------------------------------------------------------
export interface FilaRadar {
  client_id: string;
  nombre: string;
  sector: string;
  ciudad: string;
  provincia: string;
  web: string;
  email: string | null;
  etapa: string;
  no_contactar: boolean;
  rebotado: boolean;
  cuenta: string | null;
  senal: number | null;
  prioridad: string | null;
  sin_hilo: boolean;
  primer_envio_at: string | null;
  asunto: string;
}

export interface FiltrosRadar {
  provincia?: string;
  sector?: string;
  etapa?: string;
  cuenta?: string;
  senal?: string;
  q?: string;
}

export async function radar(f: FiltrosRadar): Promise<Lectura<{ filas: FilaRadar[]; total: number; facetas: { provincias: string[]; sectores: string[] } }>> {
  return leer({ filas: [] as FilaRadar[], total: 0, facetas: { provincias: [] as string[], sectores: [] as string[] } }, async (sb) => {
    let q = sb.schema('hunter').from('v_radar').select('*', { count: 'exact' });
    if (f.provincia) q = q.eq('provincia', f.provincia);
    if (f.sector) q = q.eq('sector', f.sector);
    if (f.etapa === 'no_contactar') q = q.eq('no_contactar', true);
    else if (f.etapa) q = q.eq('etapa', f.etapa);
    if (f.cuenta === 'sin_cuenta') q = q.is('cuenta', null);
    else if (f.cuenta) q = q.eq('cuenta', f.cuenta);
    if (f.senal) q = q.gte('senal', Number(f.senal));
    if (f.q) q = q.or(`nombre.ilike.%${f.q.replace(/[%,()]/g, '')}%,email.ilike.%${f.q.replace(/[%,()]/g, '')}%`);
    const [filas, facetas] = await Promise.all([
      q.order('senal', { ascending: false, nullsFirst: false }).order('nombre').limit(500),
      sb.schema('hunter').from('v_radar').select('provincia, sector').limit(5000),
    ]);
    if (filas.error) throw new Error(filas.error.message);
    if (facetas.error) throw new Error(facetas.error.message);
    const fs = (facetas.data ?? []) as { provincia: string; sector: string }[];
    return {
      filas: (filas.data ?? []) as FilaRadar[],
      total: filas.count ?? 0,
      facetas: {
        provincias: [...new Set(fs.map((x) => x.provincia))].sort((a, b) => a.localeCompare(b, 'es')),
        sectores: [...new Set(fs.map((x) => x.sector).filter(Boolean))].sort((a, b) => a.localeCompare(b, 'es')),
      },
    };
  });
}

// ---------------------------------------------------------------------------
// Bandeja, agenda, rastro y ajustes
// ---------------------------------------------------------------------------
export interface MensajeBandeja {
  id: string;
  cuenta_email: string;
  de: string;
  asunto: string;
  fragmento: string;
  recibido_at: string;
  clasificacion: string | null;
  resumen: string | null;
  nombre: string | null;
  etapa: string | null;
  no_contactar: boolean | null;
  approval_id: string | null;
  accion_tipo: string | null;
  accion_estado: string | null;
}

export async function bandeja(): Promise<Lectura<MensajeBandeja[]>> {
  return leer<MensajeBandeja[]>([], async (sb) =>
    exigir(await sb.schema('hunter').from('v_bandeja').select('*').order('recibido_at', { ascending: false }).limit(200)) as MensajeBandeja[],
  );
}

export interface Cita {
  id: string;
  client_id: string;
  nombre: string;
  ciudad: string;
  telefono: string;
  tipo: 'llamada' | 'visita';
  empieza_at: string;
  estado: string;
  tiene_ficha: boolean;
  ficha_md: string | null;
}

export async function agenda(): Promise<Lectura<Cita[]>> {
  return leer<Cita[]>([], async (sb) =>
    exigir(
      await sb.schema('hunter').from('v_agenda').select('*').gte('empieza_at', inicioDeHoy()).order('empieza_at').limit(100),
    ) as Cita[],
  );
}

export interface Ejecucion {
  id: string;
  turno: string;
  disparador: string;
  estado: string;
  iniciado_at: string;
  duracion_ms: number | null;
  tokens_entrada: number;
  tokens_salida: number;
  coste_ia_centimos: number;
  coste_places_centimos: number;
  resumen: string;
}

export interface Accion {
  id: string;
  run_id: string;
  at: string;
  herramienta: string;
  objetivo_etiqueta: string | null;
  porque: string;
  evidencia: Record<string, unknown>;
  resultado: string;
  tokens: number;
  coste_centimos: number;
}

export async function rastro(runId?: string): Promise<Lectura<{ ejecuciones: Ejecucion[]; acciones: Accion[] }>> {
  return leer({ ejecuciones: [] as Ejecucion[], acciones: [] as Accion[] }, async (sb) => {
    let acciones = sb.schema('agents').from('agent_actions').select('*').eq('department', 'hunter').order('at', { ascending: false }).limit(300);
    if (runId) acciones = acciones.eq('run_id', runId);
    const [e, a] = await Promise.all([
      sb.schema('agents').from('agent_runs').select('*').eq('department', 'hunter').order('iniciado_at', { ascending: false }).limit(60),
      acciones,
    ]);
    return { ejecuciones: exigir(e) as Ejecucion[], acciones: exigir(a) as Accion[] };
  });
}

export interface Ajustes {
  cuentas: {
    email: string;
    firma_nombre: string;
    conectada_lectura_at: string | null;
    conectada_envio_at: string | null;
    calentamiento_desde: string | null;
    limite_diario: number | null;
    activa: boolean;
  }[];
  settings: Record<string, unknown>;
  territorio: { provincia: string; socio: string; rastreo: boolean }[];
  supresion: { tipo: string; valor: string; motivo: string; created_at: string }[];
  totalSupresion: number;
}

export async function ajustes(): Promise<Lectura<Ajustes>> {
  return leer<Ajustes>({ cuentas: [], settings: {}, territorio: [], supresion: [], totalSupresion: 0 }, async (sb) => {
    const [c, s, t, sup] = await Promise.all([
      sb.schema('hunter').from('mail_accounts').select('email, firma_nombre, conectada_lectura_at, conectada_envio_at, calentamiento_desde, limite_diario, activa').order('email'),
      sb.schema('agents').from('settings').select('clave, valor').eq('department', 'hunter'),
      sb.schema('hunter').from('territories').select('provincia, socio, rastreo').order('provincia'),
      sb.schema('agents').from('suppression_list').select('tipo, valor, motivo, created_at', { count: 'exact' }).order('created_at', { ascending: false }).limit(50),
    ]);
    for (const r of [c, s, t, sup]) if (r.error) throw new Error(r.error.message);
    return {
      cuentas: (c.data ?? []) as Ajustes['cuentas'],
      settings: Object.fromEntries(((s.data ?? []) as { clave: string; valor: unknown }[]).map((x) => [x.clave, x.valor])),
      territorio: (t.data ?? []) as Ajustes['territorio'],
      supresion: (sup.data ?? []) as Ajustes['supresion'],
      totalSupresion: sup.count ?? 0,
    };
  });
}
