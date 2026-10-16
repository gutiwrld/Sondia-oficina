const ENTIDADES: Record<string, string> = {
  amp: '&', lt: '<', gt: '>', quot: '"', apos: "'", nbsp: ' ', laquo: '«', raquo: '»',
  ldquo: '“', rdquo: '”', lsquo: '‘', rsquo: '’', hellip: '…', ndash: '–', mdash: '—',
  aacute: 'á', eacute: 'é', iacute: 'í', oacute: 'ó', uacute: 'ú', ntilde: 'ñ', uuml: 'ü',
  Aacute: 'Á', Eacute: 'É', Iacute: 'Í', Oacute: 'Ó', Uacute: 'Ú', Ntilde: 'Ñ', Uuml: 'Ü',
  ccedil: 'ç', Ccedil: 'Ç', agrave: 'à', egrave: 'è', ograve: 'ò', iexcl: '¡', iquest: '¿',
  ordf: 'ª', ordm: 'º', deg: '°', copy: '©', reg: '®', euro: '€', middot: '·', prime: '′', Prime: '″',
};

export function decodificarEntidades(texto: string): string {
  return texto.replace(/&(#x[0-9a-f]+|#\d+|[a-z]+);/gi, (m, cuerpo: string) => {
    if (cuerpo[0] === '#') {
      const cp = cuerpo[1]?.toLowerCase() === 'x' ? parseInt(cuerpo.slice(2), 16) : parseInt(cuerpo.slice(1), 10);
      return Number.isFinite(cp) && cp > 0 && cp < 0x110000 ? String.fromCodePoint(cp) : m;
    }
    return ENTIDADES[cuerpo] ?? m;
  });
}

/** Espacios (incluido el duro) colapsados a uno. */
export const colapsarEspacios = (s: string) => s.replace(/[\s ​]+/g, ' ').trim();

/**
 * Texto visible aproximado de un HTML, sin dependencias y determinista:
 * quita scripts, estilos y comentarios, cambia etiquetas por espacios y decodifica entidades.
 */
export function htmlATexto(html: string): string {
  const sinBloques = html
    .replace(/<!--[\s\S]*?-->/g, ' ')
    .replace(/<(script|style|noscript|template)\b[\s\S]*?<\/\1\s*>/gi, ' ');
  return colapsarEspacios(decodificarEntidades(sinBloques.replace(/<[^>]+>/g, ' ')));
}

/** HTML completo decodificado y colapsado (incluye atributos como alt, title o mailto:). */
export function htmlPlano(html: string): string {
  return colapsarEspacios(decodificarEntidades(html.replace(/<!--[\s\S]*?-->/g, ' ')));
}
