import 'server-only';
import { redirect } from 'next/navigation';
import { configSupabase, supabaseServidor } from './supabase/servidor';

export type Sesion =
  | { modo: 'socio'; email: string; nombre: string; iniciales: string }
  | { modo: 'vista_previa' };

/**
 * Vista previa local: solo con `next dev` y OFICINA_VISTA_PREVIA=1. Enseña la oficina sin sesión y SIN datos
 * (estados vacíos), para revisar el diseño y hacer capturas. En producción no existe.
 */
export function esVistaPrevia() {
  return process.env.NODE_ENV === 'development' && process.env.OFICINA_VISTA_PREVIA === '1';
}

/** Exige un socio autenticado (lista cerrada de `public.members`). Si no, al formulario de entrada. */
export async function exigirSocio(): Promise<Sesion> {
  if (esVistaPrevia()) return { modo: 'vista_previa' };
  if (!configSupabase()) redirect('/entrar?error=config');
  const sb = await supabaseServidor();
  const { data } = await sb.auth.getUser();
  if (!data.user) redirect('/entrar');
  const { data: socio } = await sb.from('members').select('name, short_name, initials, active').eq('user_id', data.user.id).maybeSingle();
  if (!socio?.active) {
    await sb.auth.signOut();
    redirect('/entrar?error=no_permitido');
  }
  return { modo: 'socio', email: data.user.email ?? '', nombre: socio.short_name, iniciales: socio.initials };
}
