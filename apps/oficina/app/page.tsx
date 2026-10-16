import Link from 'next/link';
import { cookies } from 'next/headers';
import { Etiqueta, PuntoVivo } from '@sondia/ui';
import { fechaConDia, numero } from '@sondia/core';
import { BarraSuperior, textoEstado } from '@/componentes/barra-superior';
import { AvisoLectura } from '@/componentes/aviso-lectura';
import { departamentos, estadoHunter, resumenHoy } from '@/lib/datos';
import { exigirSocio } from '@/lib/sesion';

export default async function Vestibulo() {
  const sesion = await exigirSocio();
  const [deps, estado, hoy] = await Promise.all([departamentos(), estadoHunter(), resumenHoy()]);
  const tema = (await cookies()).get('tema')?.value === 'claro' ? 'claro' : 'oscuro';
  const vivo = textoEstado(estado.datos);
  const hunter = deps.datos.find((d) => d.slug === 'hunter');
  const libres = deps.datos.filter((d) => d.slug !== 'hunter');
  const saludo = sesion.modo === 'socio' ? `Hola, ${sesion.nombre}` : 'Oficina de agentes';

  return (
    <>
      <BarraSuperior sesion={sesion} estado={estado.datos} tema={tema} />
      <main className="mx-auto flex max-w-[1440px] flex-col gap-8 px-4 pb-16 pt-8 sm:px-6 sm:pt-10">
        <div className="flex flex-col gap-1.5">
          <Etiqueta>Vestíbulo · {fechaConDia(new Date())}</Etiqueta>
          <h1 className="text-[22px] font-medium tracking-[-0.01em] sm:text-[26px]">{saludo}</h1>
        </div>
        <AvisoLectura errores={[deps.error, estado.error, hoy.error]} />

        <section aria-label="Salas de la oficina" className="grid grid-cols-1 border-l border-t border-linea lg:grid-cols-[minmax(0,1.35fr)_minmax(0,1fr)]">
          {/* 01 · Hunter, la sala activa */}
          <Link
            href="/hunter"
            className="group flex flex-col gap-8 border-b border-r border-linea p-5 transition-colors duration-100 hover:bg-superficie sm:p-7 lg:row-span-3"
          >
            <div className="flex items-start justify-between gap-4">
              <div className="flex flex-col gap-3">
                <span className="font-mono text-[11px] uppercase tracking-[0.14em] text-texto-3">Dept. 01</span>
                <span className="text-[30px] font-medium leading-none tracking-[-0.02em] sm:text-[38px]">{hunter?.nombre ?? 'Hunter'}</span>
              </div>
              <span className="font-mono text-[56px] font-light leading-none tracking-[-0.04em] text-linea-fuerte sm:text-[72px]">01</span>
            </div>
            <p className="max-w-[46ch] text-[14px] leading-relaxed text-texto-2">{hunter?.descripcion}</p>
            <div className="flex items-center gap-2.5">
              <PuntoVivo estado={vivo.estado} />
              <span className="font-mono text-[12.5px] text-texto">{vivo.texto}</span>
            </div>
            <dl className="grid grid-cols-3 gap-3 border-t border-linea pt-5" aria-label="Hoy">
              <div className="flex flex-col gap-1.5">
                <dt><Etiqueta className={hoy.datos.mesa ? 'text-acento-tinta' : undefined}>En la mesa</Etiqueta></dt>
                <dd className={`font-mono text-[22px] tabular-nums ${hoy.datos.mesa ? 'text-acento-tinta' : ''}`}>{numero(hoy.datos.mesa)}</dd>
              </div>
              <div className="flex flex-col gap-1.5">
                <dt><Etiqueta>Enviados</Etiqueta></dt>
                <dd className="font-mono text-[22px] tabular-nums">
                  {numero(hoy.datos.enviadosHoy)}
                  <span className="text-[13px] text-texto-3"> / {numero(hoy.datos.limiteHoy)}</span>
                </dd>
              </div>
              <div className="flex flex-col gap-1.5">
                <dt><Etiqueta>Respuestas</Etiqueta></dt>
                <dd className="font-mono text-[22px] tabular-nums">{numero(hoy.datos.respuestasHoy)}</dd>
              </div>
            </dl>
            <span className="mt-auto inline-flex items-center gap-2 text-[13px] text-texto-2 group-hover:text-texto">
              Entrar en la sala <span aria-hidden="true">→</span>
            </span>
          </Link>

          {/* Salas libres: sin datos inventados, solo lo que serán. */}
          {libres.map((d) => (
            <div key={d.slug} className="flex items-start justify-between gap-6 border-b border-r border-linea p-5 sm:p-6">
              <div className="flex min-w-0 flex-col gap-2">
                <div className="flex items-center gap-3">
                  <span className="text-[16px] font-medium text-texto-2">{d.nombre}</span>
                  <Etiqueta className="rounded-[3px] border border-dashed border-linea-fuerte px-1.5 py-0.5">Sala libre</Etiqueta>
                </div>
                <p className="text-[13px] leading-relaxed text-texto-3">{d.descripcion}</p>
              </div>
              <span className="font-mono text-[28px] font-light leading-none text-linea-fuerte">{String(d.numero).padStart(2, '0')}</span>
            </div>
          ))}
        </section>
      </main>
    </>
  );
}
