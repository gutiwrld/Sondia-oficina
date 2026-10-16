import { createServerClient } from '@supabase/ssr';
import { cookies } from 'next/headers';

export function configSupabase() {
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const clave = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
  if (!url || !clave) return null;
  return { url, clave };
}

/** Cliente de Supabase para componentes de servidor y server actions, con la sesión del socio. */
export async function supabaseServidor() {
  const cfg = configSupabase();
  if (!cfg) throw new Error('Faltan NEXT_PUBLIC_SUPABASE_URL y NEXT_PUBLIC_SUPABASE_ANON_KEY');
  const almacen = await cookies();
  return createServerClient(cfg.url, cfg.clave, {
    cookies: {
      getAll: () => almacen.getAll(),
      setAll: (lista) => {
        try {
          for (const { name, value, options } of lista) almacen.set(name, value, options);
        } catch {
          // En un componente de servidor no se pueden escribir cookies; el middleware refresca la sesión.
        }
      },
    },
  });
}
