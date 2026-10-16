import { createServerClient } from '@supabase/ssr';
import { NextResponse, type NextRequest } from 'next/server';

/** Refresca la sesión de Supabase en cada petición (patrón de @supabase/ssr). */
export async function middleware(req: NextRequest) {
  let res = NextResponse.next({ request: req });
  const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
  const clave = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;
  if (!url || !clave) return res;
  const sb = createServerClient(url, clave, {
    cookies: {
      getAll: () => req.cookies.getAll(),
      setAll: (lista) => {
        for (const { name, value } of lista) req.cookies.set(name, value);
        res = NextResponse.next({ request: req });
        for (const { name, value, options } of lista) res.cookies.set(name, value, options);
      },
    },
  });
  await sb.auth.getUser();
  return res;
}

export const config = {
  matcher: ['/((?!_next/static|_next/image|icon.svg|sondia-simbolo.svg|.*\\.(?:png|jpg|svg|woff2?)$).*)'],
};
