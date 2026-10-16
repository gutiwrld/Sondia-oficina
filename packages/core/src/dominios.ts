import { getDomain, getHostname } from 'tldts';

/** Email en minúsculas y sin espacios. Devuelve null si no parece un email. */
export function normalizarEmail(email: string | null | undefined): string | null {
  if (!email) return null;
  const limpio = email.trim().toLowerCase().replace(/^mailto:/, '');
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(limpio) ? limpio : null;
}

/**
 * Dominio registrable de una URL, un host o un email:
 * sin protocolo, sin `www`, sin subdominios y en minúsculas, con la lista de sufijos públicos
 * (así `tienda.casa-pepe.com.es` y `WWW.Casa-Pepe.com.es` dan `casa-pepe.com.es`).
 */
export function dominioRegistrable(entrada: string | null | undefined): string | null {
  if (!entrada) return null;
  let texto = entrada.trim().toLowerCase();
  if (!texto) return null;
  const arroba = texto.lastIndexOf('@');
  if (arroba >= 0 && !texto.includes('/')) texto = texto.slice(arroba + 1);
  const host = getHostname(texto.includes('://') ? texto : `http://${texto}`);
  if (!host) return null;
  return getDomain(host, { allowPrivateDomains: false }) ?? null;
}

/** Dominios de correo gratuito: un email así en una web de empresa es un fallo. */
export const DOMINIOS_CORREO_GRATUITO = new Set([
  'gmail.com',
  'googlemail.com',
  'hotmail.com',
  'hotmail.es',
  'outlook.com',
  'outlook.es',
  'live.com',
  'live.es',
  'msn.com',
  'yahoo.com',
  'yahoo.es',
  'icloud.com',
  'me.com',
  'aol.com',
  'gmx.es',
  'gmx.com',
  'terra.es',
  'telefonica.net',
  'ono.com',
]);

export function esCorreoGratuito(email: string): boolean {
  const dominio = normalizarEmail(email)?.split('@')[1];
  return dominio ? DOMINIOS_CORREO_GRATUITO.has(dominio) : false;
}

/**
 * Dominio que cuenta para duplicados y supresión de un lead.
 * Con email corporativo, el del email; con email gratuito, el de la web
 * (si no, todos los @gmail.com serían «el mismo negocio»).
 */
export function dominioDelLead(lead: { email?: string | null; web?: string | null }): string | null {
  const email = normalizarEmail(lead.email);
  if (email && !esCorreoGratuito(email)) return dominioRegistrable(email);
  return dominioRegistrable(lead.web);
}
