/** Precios del manual (sección 2). */
export const PRECIOS = {
  informativa: 290,
  completa: 490,
  minimoInformativa: 250,
} as const;

/** Importes en euros que aparecen en un texto («490 €», «290€», «1.200 euros»). */
export function importesEnTexto(texto: string): number[] {
  const re = /(\d{1,3}(?:\.\d{3})+|\d+)(?:,(\d{1,2}))?\s?(?:€|euros?\b|eur\b)/gi;
  const out: number[] = [];
  for (const m of texto.matchAll(re)) {
    const entero = Number(m[1]!.replace(/\./g, ''));
    const dec = m[2] ? Number(`0.${m[2]}`) : 0;
    out.push(entero + dec);
  }
  return out;
}

export type ProblemaPrecio = { importe: number; motivo: 'por_debajo_del_minimo' | 'precio_no_autorizado' };

/**
 * Comprueba los precios de un borrador. Solo se permiten los del manual;
 * cualquier otro (o uno por debajo de 250 €) lo decide Guzmán, no Hunter.
 */
export function comprobarPrecios(
  texto: string,
  permitidos: readonly number[] = [PRECIOS.informativa, PRECIOS.completa],
): ProblemaPrecio[] {
  return importesEnTexto(texto).flatMap((importe): ProblemaPrecio[] => {
    if (importe < PRECIOS.minimoInformativa) return [{ importe, motivo: 'por_debajo_del_minimo' }];
    if (!permitidos.includes(importe)) return [{ importe, motivo: 'precio_no_autorizado' }];
    return [];
  });
}
