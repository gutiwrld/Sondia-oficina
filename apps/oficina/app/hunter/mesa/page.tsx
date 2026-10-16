import type { Metadata } from 'next';
import { EstadoVacio, Etiqueta, Tecla } from '@sondia/ui';
import { AvisoLectura } from '@/componentes/aviso-lectura';
import { mesa } from '@/lib/datos';
import { MesaFoco } from './mesa-foco';

export const metadata: Metadata = { title: 'Mesa · Hunter' };

const ATAJOS: [string, string][] = [
  ['A', 'Aprobar'],
  ['R', 'Rechazar'],
  ['E', 'Editar'],
  ['J / K', 'Siguiente / anterior'],
  ['⌘ ↵', 'Aprobar el lote (con confirmación)'],
];

export default async function Mesa() {
  const { datos, error } = await mesa();
  if (!datos.length) {
    return (
      <div className="flex flex-col gap-6">
        <AvisoLectura errores={[error]} />
        <div className="flex flex-col gap-1.5">
          <Etiqueta>Mesa de aprobación</Etiqueta>
          <h1 className="text-[22px] font-medium tracking-[-0.01em]">La mesa está vacía</h1>
        </div>
        <div className="grid grid-cols-1 gap-6 lg:grid-cols-[minmax(0,1.4fr)_minmax(0,1fr)]">
          <EstadoVacio titulo="Aquí llegan los borradores de Hunter, uno cada vez." quien="Redacción · bandeja · seguimiento">
            <p>
              A la izquierda verás la evidencia: la captura de su web en el móvil, los fallos con la cita resaltada y la Señal. A la derecha,
              el borrador, listo para editar.
            </p>
            <p className="mt-2">
              Nada sale sin tu aprobación. Antes de llegar aquí, cada borrador pasa el verificador de citas: si una frase entre comillas no está
              literalmente en su web, se rehace.
            </p>
          </EstadoVacio>
          <div className="flex flex-col gap-3">
            <Etiqueta>Atajos</Etiqueta>
            <ul className="flex flex-col border-t border-linea">
              {ATAJOS.map(([tecla, que]) => (
                <li key={tecla} className="flex items-center justify-between gap-4 border-b border-linea py-2.5 text-[13px] text-texto-2">
                  {que}
                  <span className="flex gap-1">
                    {tecla.split(' ').map((t) => (t === '/' ? <span key={t} className="text-texto-3">/</span> : <Tecla key={t}>{t}</Tecla>))}
                  </span>
                </li>
              ))}
            </ul>
          </div>
        </div>
      </div>
    );
  }
  return (
    <>
      <AvisoLectura errores={[error]} />
      <MesaFoco borradores={datos} />
    </>
  );
}
