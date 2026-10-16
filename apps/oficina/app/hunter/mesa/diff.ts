export type LineaDiff = { op: '=' | '-' | '+'; texto: string };

/** Diff por líneas (LCS). Se guarda con cada edición para que Hunter aprenda el estilo de Guzmán. */
export function diffLineas(antes: string, despues: string): LineaDiff[] {
  const a = antes.split('\n');
  const b = despues.split('\n');
  const n = a.length;
  const m = b.length;
  const lcs = Array.from({ length: n + 1 }, () => new Array<number>(m + 1).fill(0));
  for (let i = n - 1; i >= 0; i--) {
    for (let j = m - 1; j >= 0; j--) {
      lcs[i]![j] = a[i] === b[j] ? lcs[i + 1]![j + 1]! + 1 : Math.max(lcs[i + 1]![j]!, lcs[i]![j + 1]!);
    }
  }
  const out: LineaDiff[] = [];
  let i = 0;
  let j = 0;
  while (i < n && j < m) {
    if (a[i] === b[j]) {
      out.push({ op: '=', texto: a[i]! });
      i++;
      j++;
    } else if (lcs[i + 1]![j]! >= lcs[i]![j + 1]!) out.push({ op: '-', texto: a[i++]! });
    else out.push({ op: '+', texto: b[j++]! });
  }
  while (i < n) out.push({ op: '-', texto: a[i++]! });
  while (j < m) out.push({ op: '+', texto: b[j++]! });
  return out;
}
