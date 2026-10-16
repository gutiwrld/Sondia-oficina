import type { Auditoria } from './auditoria';

export interface PuntoSenal {
  clave: string;
  etiqueta: string;
  puntos: number;
  maximo: number;
  /** Prueba legible: qué se encontró. */
  detalle: string;
}

export interface Senal {
  /** 0–100: cuánto necesitan una web nueva. */
  total: number;
  desglose: PuntoSenal[];
}

/**
 * La Señal. Cada punto sale de una comprobación de la auditoría y lleva su prueba;
 * los máximos suman 100.
 */
export function calcularSenal(a: Auditoria, anioActual: number): Senal {
  const d: PuntoSenal[] = [];
  const add = (clave: string, etiqueta: string, puntos: number, maximo: number, detalle: string) => {
    d.push({ clave, etiqueta, puntos: Math.min(puntos, maximo), maximo, detalle });
  };

  add('movil', 'No se adapta al móvil', a.viewport ? 0 : 25, 25, a.viewport ? 'Tiene meta viewport' : 'Sin <meta name="viewport">');

  const seguridad = !a.https ? 15 : a.certificadoValido === false ? 15 : 0;
  add(
    'https',
    'HTTPS',
    seguridad,
    15,
    !a.https ? 'No carga por HTTPS' : a.certificadoValido === false ? 'Certificado no válido' : 'HTTPS correcto',
  );

  const maquetacion = (a.flash ? 12 : 0) + (a.frames ? 10 : 0) + (a.tablasMaquetacion ? 8 : 0);
  const piezas = [a.tablasMaquetacion && 'tablas', a.frames && 'frames', a.flash && 'Flash'].filter(Boolean);
  add('maquetacion', 'Maquetación antigua', maquetacion, 15, piezas.length ? `Usa ${piezas.join(', ')}` : 'Sin tablas, frames ni Flash');

  const antiguedad = a.anioCopyright === null ? 0 : anioActual - a.anioCopyright;
  const ptsCopy = antiguedad >= 8 ? 15 : antiguedad >= 5 ? 10 : antiguedad >= 3 ? 5 : 0;
  add('copyright', 'Copyright viejo', ptsCopy, 15, a.anioCopyright === null ? 'Sin año de copyright' : `© ${a.anioCopyright}`);

  add(
    'plantilla',
    'Textos de plantilla',
    a.textosPlantilla.length ? 10 : 0,
    10,
    a.textosPlantilla.length ? a.textosPlantilla.map((t) => `«${t}»`).join(', ') : 'Ninguno',
  );

  add(
    'fechas',
    'Fechas o tarifas viejas',
    a.fechasViejas.length ? 7 : 0,
    7,
    a.fechasViejas.length ? a.fechasViejas.map((t) => `«${t}»`).join(', ') : 'Ninguna',
  );

  add(
    'enlaces',
    'Enlaces rotos',
    a.enlacesRotos.length * 3,
    6,
    a.enlacesRotos.length ? `${a.enlacesRotos.length} enlace(s) rotos` : 'Ninguno',
  );

  add(
    'widgets',
    'Widgets muertos',
    a.widgetsMuertos.length * 2,
    4,
    a.widgetsMuertos.length ? a.widgetsMuertos.join(', ') : 'Ninguno',
  );

  add(
    'email',
    'Email gratuito en web de empresa',
    a.emailsGratuitos.length ? 3 : 0,
    3,
    a.emailsGratuitos.length ? a.emailsGratuitos.join(', ') : 'No',
  );

  const total = Math.min(100, d.reduce((s, p) => s + p.puntos, 0));
  return { total, desglose: d };
}

export const SENAL_MAXIMO_TOTAL = 25 + 15 + 15 + 15 + 10 + 7 + 6 + 4 + 3;
