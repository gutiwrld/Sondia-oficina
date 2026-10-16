/** Resultado de la auditoría automática (sin IA) de una web. */
export interface Auditoria {
  urlFinal: string;
  httpStatus: number | null;
  /** La web carga por HTTPS. */
  https: boolean;
  /** El certificado es válido. null si no hay HTTPS. */
  certificadoValido: boolean | null;
  viewport: boolean;
  tablasMaquetacion: boolean;
  frames: boolean;
  flash: boolean;
  anioCopyright: number | null;
  /** Textos de plantilla sin cambiar, copiados literalmente. */
  textosPlantilla: string[];
  /** Fechas o tarifas viejas, copiadas literalmente («Tarifas 2019»). */
  fechasViejas: string[];
  enlacesRotos: { url: string; status: number | null }[];
  /** Widgets muertos detectados (Google+, contadores…). */
  widgetsMuertos: string[];
  /** Emails @gmail, @hotmail… visibles en la web. */
  emailsGratuitos: string[];
}

/** Tipos de fallo que un borrador puede citar. Los de auditoría necesitan su prueba en `Auditoria`. */
export const TIPOS_FALLO = [
  'sin_viewport',
  'sin_https',
  'certificado_roto',
  'tablas',
  'frames',
  'flash',
  'copyright_viejo',
  'texto_plantilla',
  'fecha_vieja',
  'enlace_roto',
  'widget_muerto',
  'email_gratuito',
  /** Errata, texto en inglés sin traducir, dato incoherente…: la prueba es la cita literal. */
  'texto_literal',
] as const;
export type TipoFallo = (typeof TIPOS_FALLO)[number];

/** ¿La auditoría respalda este tipo de fallo? `texto_literal` se prueba con su cita. */
export function pruebaEnAuditoria(tipo: TipoFallo, a: Auditoria, anioActual: number): boolean {
  switch (tipo) {
    case 'sin_viewport':
      return !a.viewport;
    case 'sin_https':
      return !a.https;
    case 'certificado_roto':
      return a.https === false ? false : a.certificadoValido === false;
    case 'tablas':
      return a.tablasMaquetacion;
    case 'frames':
      return a.frames;
    case 'flash':
      return a.flash;
    case 'copyright_viejo':
      return a.anioCopyright !== null && anioActual - a.anioCopyright >= 3;
    case 'texto_plantilla':
      return a.textosPlantilla.length > 0;
    case 'fecha_vieja':
      return a.fechasViejas.length > 0;
    case 'enlace_roto':
      return a.enlacesRotos.length > 0;
    case 'widget_muerto':
      return a.widgetsMuertos.length > 0;
    case 'email_gratuito':
      return a.emailsGratuitos.length > 0;
    case 'texto_literal':
      return true;
  }
}
