import type { Metadata } from 'next';
import Link from 'next/link';
import { EstadoVacio, Etiqueta, cn } from '@sondia/ui';
import { ETIQUETA_TURNO, eurosDesdeCentimos, fecha, hora, numero, type Turno } from '@sondia/core';
import { AvisoLectura } from '@/componentes/aviso-lectura';
import { rastro } from '@/lib/datos';

export const metadata: Metadata = { title: 'El rastro · Hunter' };

const duracion = (ms: number | null) => (ms === null ? 'en curso' : ms < 60_000 ? `${Math.round(ms / 1000)} s` : `${Math.round(ms / 60_000)} min`);

export default async function Rastro({ searchParams }: { searchParams: Promise<{ ejecucion?: string }> }) {
  const { ejecucion } = await searchParams;
  const { datos, error } = await rastro(ejecucion);
  const sel = datos.ejecuciones.find((e) => e.id === ejecucion);

  return (
    <div className="flex flex-col gap-5">
      <AvisoLectura errores={[error]} />
      <div className="flex flex-col gap-1.5">
        <Etiqueta>El rastro</Etiqueta>
        <h1 className="text-[22px] font-medium tracking-[-0.01em]">Cada acción de Hunter, con su porqué</h1>
      </div>

      {datos.ejecuciones.length === 0 ? (
        <EstadoVacio titulo="Hunter todavía no ha hecho nada." quien="Todos los turnos">
          Cada vez que Hunter haga algo (buscar un negocio, auditar una web, descartar una franquicia, escribir un borrador), aquí quedará una
          línea con la hora, la herramienta, sobre quién, la evidencia, el coste y un porqué de una línea. Se filtra por ejecución: si Hunter hace
          algo raro, aquí se ve por qué.
        </EstadoVacio>
      ) : (
        <div className="grid grid-cols-1 gap-6 lg:grid-cols-[300px_minmax(0,1fr)]">
          <aside className="flex flex-col gap-2">
            <Etiqueta>Ejecuciones</Etiqueta>
            <ul className="flex max-h-[60dvh] flex-col overflow-y-auto border-t border-linea">
              <li>
                <Link href="/hunter/rastro" className={cn('block border-b border-linea px-2 py-2 text-[13px]', !ejecucion ? 'bg-superficie text-texto' : 'text-texto-2 hover:bg-hover')}>
                  Todas
                </Link>
              </li>
              {datos.ejecuciones.map((e) => (
                <li key={e.id}>
                  <Link
                    href={`/hunter/rastro?ejecucion=${e.id}`}
                    className={cn('flex flex-col gap-0.5 border-b border-linea px-2 py-2', e.id === ejecucion ? 'bg-superficie' : 'hover:bg-hover')}
                  >
                    <span className="flex items-center justify-between gap-2 text-[13px] text-texto">
                      {ETIQUETA_TURNO[e.turno as Turno] ?? e.turno}
                      <span className={cn('font-mono text-[10.5px] uppercase tracking-[0.1em]', e.estado.startsWith('parado') || e.estado === 'error' ? 'text-acento-tinta' : 'text-texto-3')}>
                        {e.estado.replace('_', ' ')}
                      </span>
                    </span>
                    <span className="font-mono text-[11px] text-texto-3">
                      {fecha(e.iniciado_at)} {hora(e.iniciado_at)} · {duracion(e.duracion_ms)} · {eurosDesdeCentimos(Number(e.coste_ia_centimos) + Number(e.coste_places_centimos))}
                    </span>
                  </Link>
                </li>
              ))}
            </ul>
          </aside>

          <section className="flex min-w-0 flex-col gap-3">
            {sel ? (
              <div className="flex flex-wrap gap-x-6 gap-y-1 border-b border-linea pb-3 font-mono text-[11.5px] text-texto-3">
                <span>Tokens {numero(sel.tokens_entrada)} → {numero(sel.tokens_salida)}</span>
                <span>IA {eurosDesdeCentimos(Number(sel.coste_ia_centimos))}</span>
                <span>Places {eurosDesdeCentimos(Number(sel.coste_places_centimos))}</span>
                <span>{duracion(sel.duracion_ms)}</span>
                {sel.resumen ? <span className="basis-full text-texto-2">{sel.resumen}</span> : null}
              </div>
            ) : null}
            {datos.acciones.length === 0 ? (
              <p className="text-[13px] text-texto-3">Sin acciones en esta ejecución.</p>
            ) : (
              <ol className="flex flex-col">
                {datos.acciones.map((a) => (
                  <li key={a.id} className="grid grid-cols-[52px_minmax(0,1fr)] gap-3 border-b border-linea py-2.5">
                    <span className="pt-0.5 font-mono text-[11.5px] tabular-nums text-texto-3">{hora(a.at)}</span>
                    <div className="flex min-w-0 flex-col gap-1">
                      <span className="flex flex-wrap items-baseline gap-x-2 text-[13px]">
                        <span className={cn('font-mono text-[11.5px]', a.resultado === 'alerta' || a.resultado === 'error' ? 'text-acento-tinta' : 'text-texto-2')}>{a.herramienta}</span>
                        {a.objetivo_etiqueta ? <span className="text-texto">{a.objetivo_etiqueta}</span> : null}
                        {a.resultado !== 'ok' ? <Etiqueta>{a.resultado}</Etiqueta> : null}
                      </span>
                      <span className="text-[13px] text-texto-2">{a.porque}</span>
                      <details className="text-[12px]">
                        <summary className="cursor-pointer font-mono text-[11px] text-texto-3">
                          Evidencia{a.tokens ? ` · ${numero(a.tokens)} tokens` : ''}{Number(a.coste_centimos) ? ` · ${eurosDesdeCentimos(Number(a.coste_centimos))}` : ''}
                        </summary>
                        <pre className="mt-2 overflow-x-auto rounded-[6px] bg-superficie-2 p-3 font-mono text-[11.5px] leading-relaxed text-texto-2">{JSON.stringify(a.evidencia, null, 2)}</pre>
                      </details>
                    </div>
                  </li>
                ))}
              </ol>
            )}
          </section>
        </div>
      )}
    </div>
  );
}
