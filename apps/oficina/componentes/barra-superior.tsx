import Link from 'next/link';
import { Marca, PuntoVivo } from '@sondia/ui';
import { ETIQUETA_TURNO, type Turno } from '@sondia/core';
import type { EstadoHunter } from '@/lib/datos';
import type { Sesion } from '@/lib/sesion';
import { salir } from '@/app/acciones';
import { BotonPausa } from './boton-pausa';
import { SelectorTema } from './selector-tema';

export function textoEstado(e: EstadoHunter): { estado: 'activo' | 'espera' | 'parado'; texto: string } {
  if (e.pausa) return { estado: 'parado', texto: 'En pausa' };
  if (e.enCurso) {
    const p = e.enCurso.progreso;
    const base = e.estadoVivo ?? ETIQUETA_TURNO[e.enCurso.turno as Turno] ?? e.enCurso.turno;
    return { estado: 'activo', texto: p.total ? `${base} · ${p.hecho ?? 0}/${p.total}` : base };
  }
  return { estado: 'espera', texto: e.estadoVivo ?? 'En espera' };
}

export function BarraSuperior({
  sesion,
  estado,
  tema,
  departamento,
}: {
  sesion: Sesion;
  estado: EstadoHunter;
  tema: 'claro' | 'oscuro';
  departamento?: { etiqueta: string };
}) {
  const vivo = textoEstado(estado);
  return (
    <header className="sticky top-0 z-30 border-b border-linea bg-fondo">
      {estado.pausa ? (
        <div className="flex h-7 items-center justify-center gap-2 bg-acento px-4 font-mono text-[10.5px] uppercase tracking-[0.14em] text-sobre-acento">
          Hunter en pausa · la cola de envío está vacía
        </div>
      ) : null}
      <div className="mx-auto flex h-12 max-w-[1440px] items-center gap-3 px-4 sm:gap-4 sm:px-6">
        <Link href="/" className="shrink-0 rounded-[4px]" aria-label="Vestíbulo de la oficina">
          <Marca etiqueta={departamento?.etiqueta} />
        </Link>

        <Link
          href="/hunter"
          className="ml-0.5 flex min-w-0 items-center gap-2 rounded-[6px] px-1.5 py-1 text-[12.5px] text-texto-2 hover:bg-hover hover:text-texto md:ml-1 md:px-2"
          title={`Hunter · ${vivo.texto}`}
        >
          <PuntoVivo estado={vivo.estado} />
          <span className="hidden truncate font-mono text-[11.5px] md:inline">{vivo.texto}</span>
        </Link>

        <div className="ml-auto flex items-center gap-1.5 sm:gap-2">
          {sesion.modo === 'vista_previa' ? (
            <span className="hidden font-mono text-[10.5px] uppercase tracking-[0.12em] text-texto-3 lg:inline">Vista previa local · sin datos</span>
          ) : null}
          <BotonPausa activa={estado.pausa} />
          <SelectorTema tema={tema} />
          {sesion.modo === 'socio' ? (
            <form action={salir}>
              <button
                type="submit"
                title={`${sesion.nombre} · salir`}
                className="flex h-7 w-7 items-center justify-center rounded-full border border-linea-fuerte font-mono text-[11px] text-texto-2 hover:bg-hover"
              >
                {sesion.iniciales}
              </button>
            </form>
          ) : null}
        </div>
      </div>
    </header>
  );
}
