'use server';

import { revalidatePath } from 'next/cache';
import { dominioRegistrable, esCorreoGratuito, normalizarEmail } from '@sondia/core';
import { esVistaPrevia } from '@/lib/sesion';
import { supabaseServidor } from '@/lib/supabase/servidor';

export type EstadoSupresion = { tipo: 'inicio' } | { tipo: 'ok' | 'error'; mensaje: string };

/** Añade a mano un email o un dominio a la lista de supresión global (no se puede deshacer). */
export async function anadirSupresion(_: EstadoSupresion, form: FormData): Promise<EstadoSupresion> {
  if (esVistaPrevia()) return { tipo: 'error', mensaje: 'Vista previa local: no hay base de datos conectada.' };
  const entrada = String(form.get('valor') ?? '').trim();
  const email = normalizarEmail(entrada);
  const fila = email
    ? { tipo: 'email', valor: email }
    : (() => {
        const d = dominioRegistrable(entrada);
        return d ? { tipo: 'dominio', valor: d } : null;
      })();
  if (!fila) return { tipo: 'error', mensaje: 'No parece un email ni un dominio.' };
  if (fila.tipo === 'dominio' && esCorreoGratuito(`x@${fila.valor}`)) {
    return { tipo: 'error', mensaje: `No se puede suprimir ${fila.valor} entero: es un proveedor de correo.` };
  }
  const sb = await supabaseServidor();
  const { error } = await sb.schema('agents').from('suppression_list').insert({ ...fila, motivo: 'Añadido a mano', origen: 'ajustes' });
  if (error) {
    return { tipo: 'error', mensaje: error.code === '23505' ? 'Ya estaba en la lista.' : error.message };
  }
  revalidatePath('/hunter/ajustes');
  return { tipo: 'ok', mensaje: `${fila.valor} añadido. Nadie volverá a escribirle.` };
}
