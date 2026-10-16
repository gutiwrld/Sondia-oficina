import { ZONA } from './ventanas';

// es-ES no agrupa los miles en números de 4 cifras por defecto («1234,56 €»); forzamos «1.234,56 €».
const eurosFmt = new Intl.NumberFormat('es-ES', {
  style: 'currency',
  currency: 'EUR',
  useGrouping: 'always',
});
const eurosEnterosFmt = new Intl.NumberFormat('es-ES', {
  style: 'currency',
  currency: 'EUR',
  useGrouping: 'always',
  minimumFractionDigits: 0,
  maximumFractionDigits: 0,
});
const numeroFmt = new Intl.NumberFormat('es-ES', { useGrouping: 'always' });
const pctFmt = new Intl.NumberFormat('es-ES', { style: 'percent', maximumFractionDigits: 1 });

/** 1234.56 → «1.234,56 €». Con `enteros`, sin decimales cuando el importe es redondo («490 €»). */
export function euros(importe: number, opciones: { enteros?: boolean } = {}): string {
  const fmt = opciones.enteros && Number.isInteger(importe) ? eurosEnterosFmt : eurosFmt;
  return fmt.format(importe).replace(/ /g, ' ');
}

/** Céntimos (como se guardan los costes) → «0,42 €». */
export function eurosDesdeCentimos(centimos: number): string {
  return euros(centimos / 100);
}

export const numero = (n: number) => numeroFmt.format(n);
export const porcentaje = (fraccion: number) => pctFmt.format(fraccion).replace(/ /g, ' ');

const fechaCorta = new Intl.DateTimeFormat('es-ES', { timeZone: ZONA, day: 'numeric', month: 'short' });
const fechaLarga = new Intl.DateTimeFormat('es-ES', {
  timeZone: ZONA,
  weekday: 'long',
  day: 'numeric',
  month: 'long',
});
const fechaNum = new Intl.DateTimeFormat('es-ES', {
  timeZone: ZONA,
  day: '2-digit',
  month: '2-digit',
  year: 'numeric',
});
const horaFmt = new Intl.DateTimeFormat('es-ES', { timeZone: ZONA, hour: '2-digit', minute: '2-digit' });

const aFecha = (d: Date | string) => (typeof d === 'string' ? new Date(d) : d);

/** «16 oct» */
export const fecha = (d: Date | string) => fechaCorta.format(aFecha(d)).replace('.', '');
/** «viernes, 16 de octubre» */
export const fechaConDia = (d: Date | string) => fechaLarga.format(aFecha(d));
/** «16/10/2026» */
export const fechaNumerica = (d: Date | string) => fechaNum.format(aFecha(d));
/** «09:30», hora de Madrid */
export const hora = (d: Date | string) => horaFmt.format(aFecha(d));
