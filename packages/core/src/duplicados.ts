import { dominioDelLead, dominioRegistrable, normalizarEmail } from './dominios';

export type MotivoBloqueo =
  | 'sin_email'
  | 'suprimido_email'
  | 'suprimido_dominio'
  | 'duplicado_email'
  | 'duplicado_dominio';

export interface Conocidos {
  /** Emails ya contactados o en la base (normalizados). */
  emails: ReadonlySet<string>;
  /** Dominios registrables ya contactados o en la base. */
  dominios: ReadonlySet<string>;
  /** Lista de supresión global. */
  suprimidosEmail: ReadonlySet<string>;
  suprimidosDominio: ReadonlySet<string>;
}

/**
 * ¿Podemos escribir a este candidato? La supresión manda sobre todo;
 * después, los duplicados por email y por dominio normalizado.
 */
export function comprobarCandidato(
  candidato: { email?: string | null; web?: string | null },
  conocidos: Conocidos,
): { ok: true; email: string; dominio: string | null } | { ok: false; motivo: MotivoBloqueo } {
  const email = normalizarEmail(candidato.email);
  if (!email) return { ok: false, motivo: 'sin_email' };
  const dominio = dominioDelLead(candidato);
  const dominioEmail = dominioRegistrable(email);
  const dominioWeb = dominioRegistrable(candidato.web);

  if (conocidos.suprimidosEmail.has(email)) return { ok: false, motivo: 'suprimido_email' };
  for (const d of [dominio, dominioWeb, dominioEmail]) {
    if (d && conocidos.suprimidosDominio.has(d)) return { ok: false, motivo: 'suprimido_dominio' };
  }
  if (conocidos.emails.has(email)) return { ok: false, motivo: 'duplicado_email' };
  for (const d of [dominio, dominioWeb]) {
    if (d && conocidos.dominios.has(d)) return { ok: false, motivo: 'duplicado_dominio' };
  }
  return { ok: true, email, dominio };
}
