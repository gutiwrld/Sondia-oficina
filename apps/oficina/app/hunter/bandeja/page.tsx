import type { Metadata } from 'next';
import Link from 'next/link';
import { EstadoVacio, Etiqueta, cn } from '@sondia/ui';
import { ETIQUETA_CLASIFICACION, fecha, hora, type Clasificacion } from '@sondia/core';
import { AvisoLectura } from '@/componentes/aviso-lectura';
import { bandeja } from '@/lib/datos';

export const metadata: Metadata = { title: 'Bandeja · Hunter' };

/** Lo que propone Hunter para cada tipo de respuesta (manual, sección 9). */
const ACCION: Record<Clasificacion, string> = {
  no: 'Pasado a No contactar. No se responde.',
  interes: 'Respuesta con la maqueta y una llamada de 10 minutos',
  precio: 'Respuesta con el precio claro',
  llamada_visita: 'Dos huecos libres de tu calendario',
  fuera_oficina: 'Seguimiento aplazado hasta su vuelta',
  rebote: 'Descartado para email; queda el teléfono',
};

const ATENCION: Clasificacion[] = ['llamada_visita', 'interes', 'precio'];

export default async function Bandeja() {
  const { datos, error } = await bandeja();
  return (
    <div className="flex flex-col gap-5">
      <AvisoLectura errores={[error]} />
      <div className="flex flex-col gap-1.5">
        <Etiqueta>Bandeja · dos cuentas de Gmail</Etiqueta>
        <h1 className="text-[22px] font-medium tracking-[-0.01em]">Respuestas clasificadas</h1>
      </div>
      {datos.length === 0 ? (
        <EstadoVacio titulo="Todavía no hay respuestas leídas." quien="Turno de bandeja · cada 15 minutos">
          <p>Cuando conectes tus dos Gmail, Hunter leerá cada respuesta y cada rebote y los clasificará:</p>
          <ul className="mt-2 grid grid-cols-1 gap-x-6 gap-y-1 sm:grid-cols-2">
            {(Object.keys(ACCION) as Clasificacion[]).map((c) => (
              <li key={c} className="flex gap-2">
                <span className="w-[16ch] shrink-0 font-mono text-[11.5px] text-texto">{ETIQUETA_CLASIFICACION[c]}</span>
                <span className="text-[12.5px] text-texto-3">{ACCION[c]}</span>
              </li>
            ))}
          </ul>
          <p className="mt-3">Un «no» pasa el lead a No contactar de forma automática e irreversible.</p>
        </EstadoVacio>
      ) : (
        <ul className="flex flex-col border-t border-linea">
          {datos.map((m) => {
            const c = m.clasificacion as Clasificacion | null;
            const atencion = c ? ATENCION.includes(c) && m.accion_estado === 'pendiente' : false;
            return (
              <li key={m.id} className="grid grid-cols-1 gap-2 border-b border-linea py-3 md:grid-cols-[150px_minmax(0,1fr)_minmax(0,0.8fr)_auto] md:items-center md:gap-4">
                <span className={cn('font-mono text-[11px] uppercase tracking-[0.12em]', atencion ? 'text-acento-tinta' : 'text-texto-3')}>
                  {c ? ETIQUETA_CLASIFICACION[c] : 'Sin clasificar'}
                </span>
                <span className="flex min-w-0 flex-col gap-0.5">
                  <span className="truncate text-[13.5px] text-texto">{m.nombre ?? m.de}</span>
                  <span className="truncate text-[12.5px] text-texto-3">{m.resumen ?? m.fragmento}</span>
                </span>
                <span className="text-[12.5px] text-texto-2">
                  {m.approval_id ? (
                    <Link href="/hunter/mesa" className={cn('underline underline-offset-4', atencion ? 'decoration-acento text-acento-tinta' : 'decoration-linea-fuerte')}>
                      {c ? ACCION[c] : 'Ver propuesta'}
                    </Link>
                  ) : c ? ACCION[c] : '—'}
                </span>
                <span className="font-mono text-[11.5px] tabular-nums text-texto-3">{fecha(m.recibido_at)} · {hora(m.recibido_at)}</span>
              </li>
            );
          })}
        </ul>
      )}
    </div>
  );
}
