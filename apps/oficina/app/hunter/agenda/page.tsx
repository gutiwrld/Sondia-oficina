import type { Metadata } from 'next';
import { EstadoVacio, Etiqueta } from '@sondia/ui';
import { fechaConDia, hora } from '@sondia/core';
import { AvisoLectura } from '@/componentes/aviso-lectura';
import { agenda, type Cita } from '@/lib/datos';

export const metadata: Metadata = { title: 'Agenda · Hunter' };

const PARTES_FICHA = [
  'Quién es',
  'Qué le escribimos y qué contestó',
  'Los fallos de su web',
  'Qué ofrecer y a qué precio',
  'Tres preguntas',
  'Objeciones probables y su respuesta',
  'El siguiente paso que buscamos',
];

export default async function Agenda() {
  const { datos, error } = await agenda();
  const porDia = datos.reduce<Map<string, Cita[]>>((m, c) => {
    const k = fechaConDia(c.empieza_at);
    m.set(k, [...(m.get(k) ?? []), c]);
    return m;
  }, new Map());

  return (
    <div className="flex flex-col gap-5">
      <AvisoLectura errores={[error]} />
      <div className="flex flex-col gap-1.5">
        <Etiqueta>Agenda · hora de Madrid</Etiqueta>
        <h1 className="text-[22px] font-medium tracking-[-0.01em]">Llamadas y visitas</h1>
      </div>
      {datos.length === 0 ? (
        <div className="grid grid-cols-1 gap-6 lg:grid-cols-[minmax(0,1.4fr)_minmax(0,1fr)]">
          <EstadoVacio titulo="No hay llamadas ni visitas previstas." quien="Bandeja · seguimiento · preparación">
            Aquí aparecerán las reuniones que acepten por correo (Hunter propone dos huecos libres de tu calendario, entre las 10:00 y las
            19:00) y las llamadas que te propone a la semana sin respuesta. La víspera, a las 19:00, cada una tendrá su ficha.
          </EstadoVacio>
          <div className="flex flex-col gap-3">
            <Etiqueta>Lo que lleva cada ficha</Etiqueta>
            <ol className="flex flex-col border-t border-linea">
              {PARTES_FICHA.map((p, n) => (
                <li key={p} className="flex gap-3 border-b border-linea py-2 text-[13px] text-texto-2">
                  <span className="font-mono text-[11.5px] text-texto-3">{String(n + 1).padStart(2, '0')}</span>
                  {p}
                </li>
              ))}
            </ol>
          </div>
        </div>
      ) : (
        <div className="flex flex-col gap-6">
          {[...porDia].map(([dia, citas]) => (
            <section key={dia} className="flex flex-col gap-2">
              <Etiqueta className="text-texto-2">{dia}</Etiqueta>
              <ul className="flex flex-col border-t border-linea">
                {citas.map((c) => (
                  <li key={c.id} className="border-b border-linea py-3">
                    <details className="group">
                      <summary className="grid cursor-pointer list-none grid-cols-[56px_minmax(0,1fr)_auto] items-center gap-3">
                        <span className="font-mono text-[13px] tabular-nums text-texto">{hora(c.empieza_at)}</span>
                        <span className="flex min-w-0 flex-col">
                          <span className="truncate text-[13.5px] text-texto">{c.nombre}</span>
                          <span className="truncate text-[12px] text-texto-3">{c.tipo === 'visita' ? 'Visita' : 'Llamada'} · {c.ciudad} · <span className="font-mono">{c.telefono}</span></span>
                        </span>
                        <span className="font-mono text-[11px] uppercase tracking-[0.12em] text-texto-3">{c.tiene_ficha ? 'Ficha ▾' : 'Sin ficha'}</span>
                      </summary>
                      {c.ficha_md ? <div className="mt-3 whitespace-pre-wrap border-l-2 border-linea-fuerte pl-4 text-[13px] leading-relaxed text-texto-2">{c.ficha_md}</div> : null}
                    </details>
                  </li>
                ))}
              </ul>
            </section>
          ))}
        </div>
      )}
    </div>
  );
}
