'use client';

import { createBrowserClient } from '@supabase/ssr';

let cliente: ReturnType<typeof createBrowserClient> | null = null;

/** Cliente de Supabase del navegador (sesión por cookies). null si la oficina no está configurada. */
export function supabaseNavegador() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const clave = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
  if (!url || !clave) return null;
  cliente ??= createBrowserClient(url, clave);
  return cliente;
}
