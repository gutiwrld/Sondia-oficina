'use server';

import { headers } from 'next/headers';
import { configSupabase, supabaseServidor } from '@/lib/supabase/servidor';

export type EstadoEnlace = { tipo: 'inicio' } | { tipo: 'enviado'; email: string } | { tipo: 'error'; mensaje: string };

/**
 * Pide el enlace mágico. La lista cerrada la impone la base de datos del ERP
 * (trigger enforce_member_allowlist en auth.users): un email que no es de un socio no puede crear cuenta.
 */
export async function pedirEnlace(_: EstadoEnlace, form: FormData): Promise<EstadoEnlace> {
  const email = String(form.get('email') ?? '').trim().toLowerCase();
  if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) return { tipo: 'error', mensaje: 'Escribe un email válido.' };
  if (!configSupabase()) return { tipo: 'error', mensaje: 'La oficina no está conectada a Supabase todavía.' };

  const h = await headers();
  const origen = process.env.NEXT_PUBLIC_SITE_URL ?? `${h.get('x-forwarded-proto') ?? 'https'}://${h.get('host')}`;
  const sb = await supabaseServidor();
  const { error } = await sb.auth.signInWithOtp({
    email,
    options: { emailRedirectTo: `${origen}/auth/confirmar`, shouldCreateUser: true },
  });
  if (error) {
    // No distinguimos «no permitido» de otros fallos para no revelar qué emails son de socios.
    return { tipo: 'error', mensaje: 'No hemos podido enviar el enlace a ese email.' };
  }
  return { tipo: 'enviado', email };
}
