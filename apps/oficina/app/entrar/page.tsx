import type { Metadata } from 'next';
import { Marca } from '@sondia/ui';
import { FormularioEntrar } from './formulario';

export const metadata: Metadata = { title: 'Entrar' };

const ERRORES: Record<string, string> = {
  no_permitido: 'Ese email no está en la lista de la oficina. Solo pueden entrar Guzmán, Dani y Hugo.',
  enlace: 'El enlace ha caducado o ya se usó. Pide uno nuevo.',
  config: 'La oficina no está conectada a Supabase todavía (faltan las variables de entorno).',
};

export default async function Entrar({ searchParams }: { searchParams: Promise<{ error?: string }> }) {
  const { error } = await searchParams;
  return (
    <main className="mx-auto flex min-h-dvh max-w-[400px] flex-col justify-center gap-10 px-4 py-16">
      <Marca etiqueta="Oficina de agentes" />
      <div className="flex flex-col gap-2">
        <h1 className="text-[22px] font-medium tracking-[-0.01em]">Entrar en la oficina</h1>
        <p className="text-[14px] leading-relaxed text-texto-2">
          Te mandamos un enlace a tu email. Solo funciona con los emails de los tres socios.
        </p>
      </div>
      {error && ERRORES[error] ? (
        <p role="alert" className="border-l-2 border-acento pl-3 text-[13px] text-texto-2">
          {ERRORES[error]}
        </p>
      ) : null}
      <FormularioEntrar />
    </main>
  );
}
