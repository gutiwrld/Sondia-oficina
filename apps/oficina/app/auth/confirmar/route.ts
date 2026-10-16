import type { EmailOtpType } from '@supabase/supabase-js';
import { NextResponse, type NextRequest } from 'next/server';
import { supabaseServidor } from '@/lib/supabase/servidor';

/** Destino del enlace mágico: canjea el código (PKCE) o el token y entra en la oficina. */
export async function GET(req: NextRequest) {
  const url = req.nextUrl;
  const code = url.searchParams.get('code');
  const tokenHash = url.searchParams.get('token_hash');
  const tipo = url.searchParams.get('type') as EmailOtpType | null;
  const sb = await supabaseServidor();

  const { error } = code
    ? await sb.auth.exchangeCodeForSession(code)
    : tokenHash && tipo
      ? await sb.auth.verifyOtp({ token_hash: tokenHash, type: tipo })
      : { error: new Error('sin código') };

  return NextResponse.redirect(new URL(error ? '/entrar?error=enlace' : '/', url.origin));
}
