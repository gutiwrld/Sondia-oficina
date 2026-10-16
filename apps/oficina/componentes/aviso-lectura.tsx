/** Aviso discreto cuando una lectura falla (p. ej. los esquemas aún no están expuestos en la API de Supabase). */
export function AvisoLectura({ errores }: { errores: (string | null)[] }) {
  const lista = [...new Set(errores.filter((e): e is string => Boolean(e)))];
  if (!lista.length) return null;
  const esquema = lista.some((e) => /schema|esquema|PGRST106|not.*exposed/i.test(e));
  return (
    <div role="alert" className="flex flex-col gap-1 border-l-2 border-acento py-1 pl-3 text-[13px] text-texto-2">
      <span className="font-medium text-texto">No se han podido leer los datos.</span>
      {esquema ? (
        <span>
          Añade <code className="font-mono text-[12px]">agents</code> y <code className="font-mono text-[12px]">hunter</code> a «Exposed schemas» en
          Supabase → Project Settings → Data API.
        </span>
      ) : null}
      <span className="font-mono text-[11.5px] text-texto-3">{lista.join(' · ')}</span>
    </div>
  );
}
