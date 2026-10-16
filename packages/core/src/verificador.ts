import { pruebaEnAuditoria, type Auditoria, type TipoFallo } from './auditoria';
import { colapsarEspacios, htmlATexto, htmlPlano } from './html';

export interface FalloCitado {
  tipo: TipoFallo;
  descripcion: string;
  /** Texto literal de la web que prueba el fallo (obligatorio en `texto_literal`). */
  cita?: string | null;
}

export type ProblemaVerificacion =
  | { tipo: 'cita_inexistente'; cita: string }
  | { tipo: 'fallo_sin_prueba'; fallo: FalloCitado }
  | { tipo: 'fallo_sin_cita'; fallo: FalloCitado }
  | { tipo: 'pocos_fallos'; cuantos: number }
  | { tipo: 'demasiados_fallos'; cuantos: number };

export interface Verificacion {
  ok: boolean;
  citas: { cita: string; encontrada: boolean }[];
  problemas: ProblemaVerificacion[];
}

/** Citas de la plantilla del manual que no salen de su web (la PD del «no»). */
export const CITAS_DE_PLANTILLA = ['no'];

/** Extrae los textos entre comillas: "…", “…”, «…». */
export function extraerCitas(texto: string): string[] {
  const re = /"([^"\n]{1,400})"|“([^”\n]{1,400})”|«([^»\n]{1,400})»/g;
  const out: string[] = [];
  for (const m of texto.matchAll(re)) {
    const c = (m[1] ?? m[2] ?? m[3] ?? '').trim();
    if (c) out.push(c);
  }
  return out;
}

const normalizarCita = (s: string) => colapsarEspacios(s.replace(/ /g, ' '));

/**
 * ¿Existe la cita literalmente en la web? Distingue mayúsculas y signos; solo normaliza
 * espacios y entidades HTML. Una cita con «…» o «...» se trata como fragmentos que deben existir todos.
 */
export function citaEnHtml(cita: string, html: string, cache?: { texto: string; plano: string }): boolean {
  const texto = cache?.texto ?? htmlATexto(html);
  const plano = cache?.plano ?? htmlPlano(html);
  const fragmentos = normalizarCita(cita)
    .split(/…|\.\.\./)
    .map((f) => f.trim())
    .filter((f) => f.length > 0);
  if (fragmentos.length === 0) return false;
  return fragmentos.every((f) => texto.includes(f) || plano.includes(f));
}

/**
 * El verificador de citas. Antes de que un borrador llegue a la mesa:
 * 1. cada texto entre comillas del asunto y del cuerpo existe literalmente en el HTML descargado;
 * 2. cada fallo citado tiene su prueba en la auditoría (o su cita literal en la web);
 * 3. hay entre `minFallos` y `maxFallos` fallos.
 * Si algo no cuadra, el borrador se rechaza y se rehace. Hunter nunca inventa.
 */
export function verificarBorrador(p: {
  asunto: string;
  cuerpo: string;
  fallos: FalloCitado[];
  html: string;
  auditoria: Auditoria;
  anioActual: number;
  minFallos?: number;
  maxFallos?: number;
  citasPermitidas?: readonly string[];
}): Verificacion {
  const cache = { texto: htmlATexto(p.html), plano: htmlPlano(p.html) };
  const permitidas = new Set((p.citasPermitidas ?? CITAS_DE_PLANTILLA).map(normalizarCita));
  const problemas: ProblemaVerificacion[] = [];

  const vistas = new Set<string>();
  const citas = [...extraerCitas(p.asunto), ...extraerCitas(p.cuerpo)]
    .filter((c) => {
      const k = normalizarCita(c);
      if (vistas.has(k) || permitidas.has(k)) return false;
      vistas.add(k);
      return true;
    })
    .map((cita) => ({ cita, encontrada: citaEnHtml(cita, p.html, cache) }));

  for (const c of citas) if (!c.encontrada) problemas.push({ tipo: 'cita_inexistente', cita: c.cita });

  for (const fallo of p.fallos) {
    if (fallo.tipo === 'texto_literal' && !fallo.cita) {
      problemas.push({ tipo: 'fallo_sin_cita', fallo });
      continue;
    }
    if (fallo.cita && !citaEnHtml(fallo.cita, p.html, cache)) {
      problemas.push({ tipo: 'cita_inexistente', cita: fallo.cita });
      continue;
    }
    if (!pruebaEnAuditoria(fallo.tipo, p.auditoria, p.anioActual)) {
      problemas.push({ tipo: 'fallo_sin_prueba', fallo });
    }
  }

  const min = p.minFallos ?? 2;
  const max = p.maxFallos ?? 4;
  if (p.fallos.length < min) problemas.push({ tipo: 'pocos_fallos', cuantos: p.fallos.length });
  if (p.fallos.length > max) problemas.push({ tipo: 'demasiados_fallos', cuantos: p.fallos.length });

  return { ok: problemas.length === 0, citas, problemas };
}
