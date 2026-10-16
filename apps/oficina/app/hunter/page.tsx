import type { Metadata } from 'next';
import Link from 'next/link';
import { DateTime } from 'luxon';
import { Contador, Etiqueta, EstadoVacio, cn } from '@sondia/ui';
import { fechaConDia, hora, numero, porcentaje, ZONA } from '@sondia/core';
import { AvisoLectura } from '@/componentes/aviso-lectura';
import { resumenHoy } from '@/lib/datos';

export const metadata: Metadata = { title: 'Hoy · Hunter' };

/** La jornada de Hunter según la programación (hora de Madrid). Son horarios, no datos. */
const JORNADA = [
  { desde: '07:30', hasta: null, nombre: 'Rastreo', detalle: 'Busca y audita negocios nuevos en tus provincias activas', dias: [1, 2, 3, 4, 5] },
  { desde: '08:00', hasta: null, nombre: 'Redacción', detalle: 'Primeros correos a la mesa, ya verificados', dias: [1, 2, 3, 4, 5] },
  { desde: '08:30', hasta: null, nombre: 'Parte de caza', detalle: 'El resumen del día, aquí arriba', dias: [1, 2, 3, 4, 5, 6, 7] },
  { desde: '09:00', hasta: '11:00', nombre: 'Envío de nuevos', detalle: 'Lo aprobado sale de lunes a jueves', dias: [1, 2, 3, 4] },
  { desde: '11:00', hasta: '13:00', nombre: 'Seguimientos', detalle: 'Segundo correo con maqueta y precio', dias: [1, 2, 3, 4] },
  { desde: '08:00', hasta: '20:00', nombre: 'Bandeja', detalle: 'Lee y clasifica respuestas cada 15 minutos', dias: [1, 2, 3, 4, 5] },
  { desde: '19:00', hasta: null, nombre: 'Preparación', detalle: 'Fichas de las llamadas y visitas de mañana', dias: [1, 2, 3, 4, 5] },
];

function estadoTramo(t: (typeof JORNADA)[number], ahora: DateTime): 'hecho' | 'ahora' | 'luego' | 'hoy_no' {
  if (!t.dias.includes(ahora.weekday)) return 'hoy_no';
  const min = ahora.hour * 60 + ahora.minute;
  const [dh, dm] = t.desde.split(':').map(Number);
  const desde = dh! * 60 + dm!;
  const hasta = t.hasta ? Number(t.hasta.slice(0, 2)) * 60 + Number(t.hasta.slice(3)) : desde + 30;
  if (min < desde) return 'luego';
  if (min < hasta) return 'ahora';
  return 'hecho';
}

export default async function Hoy() {
  const { datos: r, error } = await resumenHoy();
  const ahora = DateTime.now().setZone(ZONA);

  return (
    <div className="flex flex-col gap-8">
      <AvisoLectura errores={[error]} />

      <section className="flex flex-col gap-3">
        <Etiqueta>Parte de caza · {fechaConDia(ahora.toJSDate())}</Etiqueta>
        {r.parte ? (
          <h1 className="max-w-[28ch] font-titular text-[34px] leading-[1.1] tracking-[-0.01em] sm:text-[46px]">{r.parte.titular}</h1>
        ) : (
          <>
            <h1 className="max-w-[28ch] font-titular text-[34px] leading-[1.1] tracking-[-0.01em] text-texto sm:text-[46px]">
              Hoy todavía no hay parte de caza.
            </h1>
            <p className="max-w-[60ch] text-[14px] leading-relaxed text-texto-2">
              Hunter lo deja cada mañana a las 8:30: negocios nuevos, respuestas, reuniones y lo que espera tu aprobación, en una frase.
            </p>
          </>
        )}
      </section>

      <section aria-label="Contadores de hoy" className="grid grid-cols-2 gap-px border-y border-linea bg-linea lg:grid-cols-5 [&>*]:bg-fondo">
        <Contador etiqueta="Enviados hoy" valor={numero(r.enviadosHoy)} de={numero(r.limiteHoy)} nota={`${r.cuentas} cuentas · 50/día cada una`} />
        <Contador etiqueta="Respuestas hoy" valor={numero(r.respuestasHoy)} nota="Sin rebotes ni ausencias" />
        <Contador
          etiqueta="Reuniones"
          valor={numero(r.reunionesProximas)}
          nota={r.proximaReunion ? `Próxima: ${fechaConDia(r.proximaReunion)}, ${hora(r.proximaReunion)}` : 'Ninguna prevista'}
        />
        <Contador
          etiqueta="Respuesta a 7 días"
          valor={r.tasa7 ? porcentaje(r.tasa7.respondieron / r.tasa7.enviados) : '—'}
          nota={r.tasa7 ? `${r.tasa7.respondieron} de ${r.tasa7.enviados} primeros correos` : 'Sin envíos en 7 días'}
        />
        <Link href="/hunter/mesa" className="col-span-2 transition-colors duration-100 hover:!bg-superficie lg:col-span-1">
          <Contador etiqueta="Espera tu aprobación" valor={numero(r.mesa)} nota={r.mesa ? 'Abrir la mesa →' : 'La mesa está vacía'} atencion={r.mesa > 0} />
        </Link>
      </section>

      <div className="grid grid-cols-1 gap-8 lg:grid-cols-[minmax(0,1fr)_minmax(0,1fr)]">
        <section className="flex flex-col gap-3">
          <Etiqueta>La jornada de Hunter · hora de Madrid</Etiqueta>
          <ol className="flex flex-col border-t border-linea">
            {JORNADA.map((t) => {
              const e = estadoTramo(t, ahora);
              return (
                <li key={t.nombre} className="grid grid-cols-[76px_minmax(0,1fr)] sm:grid-cols-[92px_minmax(0,1fr)] items-baseline gap-3 border-b border-linea py-2.5">
                  <span className={cn('font-mono text-[11.5px] tabular-nums sm:text-[12px]', e === 'ahora' ? 'text-texto' : 'text-texto-3')}>
                    {t.desde}
                    {t.hasta ? `–${t.hasta}` : ''}
                  </span>
                  <span className="flex min-w-0 flex-col gap-0.5">
                    <span className={cn('flex items-center gap-2 text-[13.5px]', e === 'hoy_no' || e === 'hecho' ? 'text-texto-3' : 'text-texto')}>
                      {t.nombre}
                      {e === 'ahora' ? <Etiqueta className="text-texto-2">· ahora</Etiqueta> : null}
                      {e === 'hoy_no' ? <Etiqueta>· hoy no toca</Etiqueta> : null}
                    </span>
                    <span className="text-[12.5px] text-texto-3">{t.detalle}</span>
                  </span>
                </li>
              );
            })}
          </ol>
        </section>

        <section className="flex flex-col gap-3">
          <Etiqueta>Lo que necesita tu atención</Etiqueta>
          {r.mesa > 0 ? (
            <Link href="/hunter/mesa" className="flex items-center justify-between gap-4 border border-acento-linea bg-acento-suave px-4 py-3.5">
              <span className="text-[14px] text-texto">
                {r.mesa === 1 ? 'Un borrador espera tu aprobación' : `${numero(r.mesa)} borradores esperan tu aprobación`}
              </span>
              <span className="font-mono text-[12px] text-acento-tinta">Mesa →</span>
            </Link>
          ) : (
            <EstadoVacio titulo="Nada pendiente por ahora." quien="Mesa · bandeja · agenda">
              Aquí aparecerán los borradores que esperan tu aprobación, las respuestas que piden una reunión y las llamadas de mañana.
              Lo urgente se marca en naranja.
            </EstadoVacio>
          )}
        </section>
      </div>
    </div>
  );
}
