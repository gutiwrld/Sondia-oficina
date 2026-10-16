export type Socio = 'guzman' | 'hugo' | 'dani';

export interface Provincia {
  nombre: string;
  dueno: Socio;
  /** Si Hunter puede rastrear negocios nuevos aquí. */
  rastreo: boolean;
}

const g = (nombre: string, rastreo: boolean): Provincia => ({ nombre, dueno: 'guzman', rastreo });
const h = (nombre: string): Provincia => ({ nombre, dueno: 'hugo', rastreo: false });

/** Reparto del manual (sección 3). Es la semilla de `hunter.territories`. */
export const TERRITORIO: readonly Provincia[] = [
  ...[
    'Alicante', 'Castellón', 'Valencia', 'Barcelona', 'Girona', 'Lleida', 'Tarragona',
    'Álava', 'Bizkaia', 'Gipuzkoa', 'Illes Balears', 'Madrid',
  ].map((n) => g(n, true)),
  ...[
    'Murcia', 'León', 'Albacete', 'Ciudad Real', 'Jaén', 'Badajoz', 'Cáceres', 'Zamora',
    'Palencia', 'Soria', 'Teruel', 'Cuenca', 'Ourense', 'Lugo', 'Huesca', 'Burgos', 'Ávila',
    'Segovia', 'Toledo', 'Guadalajara', 'Salamanca', 'Valladolid', 'La Rioja', 'Navarra',
    'Asturias', 'Cantabria',
  ].map((n) => g(n, false)),
  ...[
    'Almería', 'Cádiz', 'Córdoba', 'Granada', 'Huelva', 'Málaga', 'Sevilla', 'A Coruña',
    'Pontevedra', 'Zaragoza', 'Las Palmas', 'Santa Cruz de Tenerife',
  ].map(h),
];

const clave = (s: string) =>
  s
    .normalize('NFD')
    .replace(/\p{Diacritic}/gu, '')
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, ' ')
    .trim();

const ALIAS: Record<string, string> = {
  baleares: 'Illes Balears',
  'islas baleares': 'Illes Balears',
  'illes balears': 'Illes Balears',
  mallorca: 'Illes Balears',
  vizcaya: 'Bizkaia',
  guipuzcoa: 'Gipuzkoa',
  araba: 'Álava',
  'alava araba': 'Álava',
  'araba alava': 'Álava',
  gerona: 'Girona',
  lerida: 'Lleida',
  'la coruna': 'A Coruña',
  coruna: 'A Coruña',
  orense: 'Ourense',
  'castellon de la plana': 'Castellón',
  'castello': 'Castellón',
  alacant: 'Alicante',
  'valencia valencia': 'Valencia',
  tenerife: 'Santa Cruz de Tenerife',
  'gran canaria': 'Las Palmas',
  'principado de asturias': 'Asturias',
  'comunidad de madrid': 'Madrid',
  'region de murcia': 'Murcia',
  'comunidad foral de navarra': 'Navarra',
};

const POR_CLAVE = new Map(TERRITORIO.map((p) => [clave(p.nombre), p]));

/** Nombre canónico de una provincia («Baleares» → «Illes Balears»). null si no se reconoce. */
export function normalizarProvincia(nombre: string | null | undefined): string | null {
  if (!nombre) return null;
  const k = clave(nombre);
  return ALIAS[k] ?? POR_CLAVE.get(k)?.nombre ?? null;
}

export function provincia(nombre: string | null | undefined): Provincia | null {
  const canon = normalizarProvincia(nombre);
  return canon ? (POR_CLAVE.get(clave(canon)) ?? null) : null;
}

/** ¿Puede Hunter, trabajando para `socio`, rastrear o escribir a un negocio de esta provincia? */
export function puedeTrabajar(
  socio: Socio,
  nombreProvincia: string | null | undefined,
  modo: 'rastreo' | 'contacto',
  territorio: readonly Provincia[] = TERRITORIO,
): { ok: true } | { ok: false; motivo: 'provincia_desconocida' | 'provincia_ajena' | 'rastreo_apagado' } {
  const canon = normalizarProvincia(nombreProvincia);
  const p = canon ? territorio.find((t) => t.nombre === canon) : undefined;
  if (!p) return { ok: false, motivo: 'provincia_desconocida' };
  if (p.dueno !== socio) return { ok: false, motivo: 'provincia_ajena' };
  if (modo === 'rastreo' && !p.rastreo) return { ok: false, motivo: 'rastreo_apagado' };
  return { ok: true };
}
