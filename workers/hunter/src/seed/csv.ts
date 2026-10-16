/** Lector de CSV con comillas (RFC 4180) sin dependencias. La primera fila son las cabeceras. */
export function leerCsv<T extends object>(texto: string): T[] {
  const filas: string[][] = [];
  let fila: string[] = [];
  let campo = '';
  let comillas = false;
  const t = texto.replace(/^\uFEFF/, '');
  for (let i = 0; i < t.length; i++) {
    const ch = t[i]!;
    if (comillas) {
      if (ch === '"' && t[i + 1] === '"') {
        campo += '"';
        i++;
      } else if (ch === '"') comillas = false;
      else campo += ch;
    } else if (ch === '"') comillas = true;
    else if (ch === ',') {
      fila.push(campo);
      campo = '';
    } else if (ch === '\n' || ch === '\r') {
      if (ch === '\r' && t[i + 1] === '\n') i++;
      fila.push(campo);
      filas.push(fila);
      fila = [];
      campo = '';
    } else campo += ch;
  }
  if (campo !== '' || fila.length) {
    fila.push(campo);
    filas.push(fila);
  }
  const [cab, ...resto] = filas.filter((f) => f.some((c) => c.trim() !== ''));
  if (!cab) return [];
  return resto.map((f) => Object.fromEntries(cab.map((c, i) => [c.trim(), f[i] ?? ''])) as T);
}
