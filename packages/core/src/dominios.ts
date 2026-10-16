import { getDomain, getHostname } from 'tldts';

/** Email en minúsculas y sin espacios. Devuelve null si no parece un email. */
export function normalizarEmail(email: string | null | undefined): string | null {
  if (!email) return null;
  const limpio = email.trim().toLowerCase().replace(/^mailto:/, '');
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(limpio) ? limpio : null;
}

/**
 * Hostings compartidos: cada negocio es un subdominio (`casa.blogspot.com`), así que su «dominio» es ese
 * subdominio y nunca el del hosting. Si no, suprimir a un negocio de Blogspot suprimiría a todos.
 * Se mantiene igual en la migración SQL (agents.dominio_registrable); un test lo comprueba.
 */
export const HOSTS_COMPARTIDOS = [
  'blogspot.com', 'blogspot.es', 'webnode.es', 'webnode.com', 'webnode.page', 'wordpress.com', 'wixsite.com',
  'jimdofree.com', 'jimdo.com', 'jimdosite.com', 'weebly.com', 'site123.me', 'webcindario.com', 'es.tl',
  'business.site', 'negocio.site', 'ueniweb.com', 'github.io', 'netlify.app', 'vercel.app', 'godaddysites.com',
  'squarespace.com', 'mystrikingly.com', 'strikingly.com', 'webador.es', 'webador.com', 'myshopify.com', 'carrd.co',
  'my.canva.site', 'canva.site', 'blogia.com', 'over-blog.com', 'over-blog.es', 'hostinger.es', 'hostingersite.com',
] as const;

/** Plataformas donde el negocio no tiene dominio propio (perfiles, directorios, Google Sites…): sin dominio. */
export const PLATAFORMAS_SIN_DOMINIO = [
  'google.com', 'google.es', 'facebook.com', 'instagram.com', 'tripadvisor.es', 'tripadvisor.com', 'booking.com',
  'linktr.ee', 'wa.me', 'youtube.com', 'twitter.com', 'x.com', 'tiktok.com', 'airbnb.es', 'airbnb.com',
  'escapadarural.com', 'clubrural.com', 'tuscasasrurales.com', 'paginasamarillas.es', 'linkedin.com',
] as const;

/**
 * Dominio registrable de una URL, un host o un email:
 * sin protocolo, sin `www`, sin subdominios y en minúsculas, con la lista de sufijos públicos
 * (así `tienda.casa-pepe.com.es` y `WWW.Casa-Pepe.com.es` dan `casa-pepe.com.es`).
 * En hostings compartidos devuelve el subdominio del negocio; en plataformas, null.
 */
export function dominioRegistrable(entrada: string | null | undefined): string | null {
  if (!entrada) return null;
  let texto = entrada.trim().toLowerCase();
  if (!texto) return null;
  const arroba = texto.lastIndexOf('@');
  if (arroba >= 0 && !texto.includes('/')) texto = texto.slice(arroba + 1);
  const host = getHostname(texto.includes('://') ? texto : `http://${texto}`)?.replace(/^www\./, '');
  if (!host) return null;
  for (const h of HOSTS_COMPARTIDOS) {
    if (host === h) return null;
    if (host.endsWith(`.${h}`)) {
      const etiquetas = host.slice(0, -(h.length + 1)).split('.');
      return `${etiquetas[etiquetas.length - 1]}.${h}`;
    }
  }
  const dominio = getDomain(host, { allowPrivateDomains: false }) ?? null;
  if (dominio && (PLATAFORMAS_SIN_DOMINIO as readonly string[]).includes(dominio)) return null;
  return dominio;
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
