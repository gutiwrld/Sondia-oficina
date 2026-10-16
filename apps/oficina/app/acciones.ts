'use server';

import { cookies } from 'next/headers';
import { revalidatePath } from 'next/cache';
import { redirect } from 'next/navigation';
import { esVistaPrevia } from '@/lib/sesion';
import { supabaseServidor } from '@/lib/supabase/servidor';

export type Respuesta = { ok: true; n?: number } | { ok: false; error: string };

const VISTA_PREVIA: Respuesta = { ok: false, error: 'Vista previa local: no hay base de datos conectada.' };

/** Errores de las RPC traducidos a algo legible (los códigos vienen de las reglas de la base de datos). */
function legible(mensaje: string): string {
  const codigos: Record<string, string> = {
    NO_AUTORIZADO: 'Solo un socio autenticado puede hacer esto.',
    PAUSA: 'Hunter está en pausa. Quita la pausa para aprobar.',
    NO_CONTACTAR: 'Este negocio está en «No contactar».',
    SUPRIMIDO: 'Este email o dominio está en la lista de supresión.',
    CUENTA_DISTINTA: 'El correo saldría de una cuenta que no es la del lead.',
    CUENTA_SIN_ASIGNAR: 'El lead no tiene cuenta de envío asignada.',
    DESTINATARIO_DISTINTO: 'El destinatario no es el email del lead.',
    APROBACION_NO_PENDIENTE: 'Este borrador ya no está pendiente.',
    LOTE_SIN_CONFIRMAR: 'Confirma el envío del lote.',
  };
  const codigo = Object.keys(codigos).find((c) => mensaje.includes(c));
  return codigo ? codigos[codigo]! : mensaje;
}

export async function pausar(activa: boolean): Promise<Respuesta> {
  if (esVistaPrevia()) return VISTA_PREVIA;
  const sb = await supabaseServidor();
  const { data, error } = await sb.schema('agents').rpc('pausar', { p_department: 'hunter', p_activa: activa });
  if (error) return { ok: false, error: legible(error.message) };
  revalidatePath('/', 'layout');
  return { ok: true, n: data as number };
}

export async function aprobar(id: string, cambios?: { asunto?: string; cuerpo?: string; diff?: unknown }): Promise<Respuesta> {
  if (esVistaPrevia()) return VISTA_PREVIA;
  const sb = await supabaseServidor();
  const { error } = await sb.schema('agents').rpc('aprobar', {
    p_approval: id,
    p_asunto: cambios?.asunto ?? null,
    p_cuerpo: cambios?.cuerpo ?? null,
    p_diff: cambios?.diff ?? null,
  });
  if (error) return { ok: false, error: legible(error.message) };
  revalidatePath('/hunter', 'layout');
  return { ok: true };
}

export async function aprobarLote(ids: string[], confirmado: boolean): Promise<Respuesta> {
  if (esVistaPrevia()) return VISTA_PREVIA;
  const sb = await supabaseServidor();
  const { data, error } = await sb.schema('agents').rpc('aprobar_lote', { p_ids: ids, p_confirmado: confirmado });
  if (error) return { ok: false, error: legible(error.message) };
  revalidatePath('/hunter', 'layout');
  return { ok: true, n: data as number };
}

export async function rechazar(id: string, motivo: string, rehacer: boolean): Promise<Respuesta> {
  if (esVistaPrevia()) return VISTA_PREVIA;
  const sb = await supabaseServidor();
  const { error } = await sb.schema('agents').rpc('rechazar', { p_approval: id, p_motivo: motivo, p_rehacer: rehacer });
  if (error) return { ok: false, error: legible(error.message) };
  revalidatePath('/hunter', 'layout');
  return { ok: true };
}

export async function cambiarTema(tema: 'claro' | 'oscuro') {
  (await cookies()).set('tema', tema, { path: '/', maxAge: 60 * 60 * 24 * 365, sameSite: 'lax' });
  revalidatePath('/', 'layout');
}

export async function salir() {
  if (!esVistaPrevia()) await (await supabaseServidor()).auth.signOut();
  redirect('/entrar');
}
