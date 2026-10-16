import type { Metadata } from 'next';
import { EscalaSenal, EstadoVacio, Etiqueta, cn } from '@sondia/ui';
import { ETAPAS, ETIQUETA_ETAPA, fecha, numero, type Etapa } from '@sondia/core';
import { AvisoLectura } from '@/componentes/aviso-lectura';
import { radar, type FiltrosRadar, type FilaRadar } from '@/lib/datos';

export const metadata: Metadata = { title: 'Radar · Hunter' };

const CUENTAS = [
  { valor: 'guzmangonzalezperez@gmail.com', etiqueta: 'guzmangonzalezperez' },
  { valor: 'guzmangonzalez.twati@gmail.com', etiqueta: 'guzmangonzalez.twati' },
  { valor: 'sin_cuenta', etiqueta: 'Sin cuenta' },
];

const cuentaCorta = (c: string | null) => (c ? c.replace('@gmail.com', '').replace('guzmangonzalez', '…') : '—');
const host = (w: string) => w.replace(/^https?:\/\/(www\.)?/, '').replace(/\/.*$/, '');

function EtiquetaEtapa({ f }: { f: FilaRadar }) {
  if (f.no_contactar) return <span className="font-mono text-[10.5px] uppercase tracking-[0.12em] text-texto-3 line-through decoration-texto-3">No contactar</span>;
  return (
    <span className={cn('text-[12.5px]', f.etapa === 'respondio' || f.etapa === 'reunion' ? 'text-acento-tinta' : 'text-texto-2')}>
      {ETIQUETA_ETAPA[f.etapa as Etapa] ?? f.etapa}
      {f.rebotado ? <span className="ml-1.5 font-mono text-[10.5px] text-texto-3">rebote</span> : null}
    </span>
  );
}

const SELECT = 'h-8 min-w-0 rounded-[6px] border border-linea-fuerte bg-superficie px-2 text-[12.5px] text-texto focus:border-acento focus:outline-none';

export default async function Radar({ searchParams }: { searchParams: Promise<FiltrosRadar> }) {
  const f = await searchParams;
  const { datos, error } = await radar(f);
  const hayFiltros = Object.values(f).some(Boolean);

  return (
    <div className="flex flex-col gap-5">
      <AvisoLectura errores={[error]} />
      <div className="flex flex-wrap items-end justify-between gap-3">
        <div className="flex flex-col gap-1.5">
          <Etiqueta>Radar</Etiqueta>
          <h1 className="text-[22px] font-medium tracking-[-0.01em]">
            {numero(datos.total)} <span className="text-texto-3">{datos.total === 1 ? 'negocio' : 'negocios'}{hayFiltros ? ' con estos filtros' : ''}</span>
          </h1>
        </div>
      </div>

      {/* Filtros: un formulario GET, la URL guarda la vista. */}
      <form className="grid grid-cols-2 gap-2 sm:flex sm:flex-wrap sm:items-center" role="search">
        <input name="q" defaultValue={f.q} placeholder="Buscar nombre o email" className={cn(SELECT, 'col-span-2 sm:w-56')} />
        <select name="provincia" defaultValue={f.provincia ?? ''} className={SELECT} aria-label="Provincia">
          <option value="">Provincia</option>
          {datos.facetas.provincias.map((p) => <option key={p}>{p}</option>)}
        </select>
        <select name="sector" defaultValue={f.sector ?? ''} className={cn(SELECT, 'sm:max-w-48')} aria-label="Sector">
          <option value="">Sector</option>
          {datos.facetas.sectores.map((s) => <option key={s}>{s}</option>)}
        </select>
        <select name="etapa" defaultValue={f.etapa ?? ''} className={SELECT} aria-label="Etapa">
          <option value="">Etapa</option>
          {ETAPAS.map((e) => <option key={e} value={e}>{ETIQUETA_ETAPA[e]}</option>)}
          <option value="no_contactar">No contactar</option>
        </select>
        <select name="senal" defaultValue={f.senal ?? ''} className={SELECT} aria-label="Señal mínima">
          <option value="">Señal</option>
          {[30, 50, 70, 85].map((s) => <option key={s} value={s}>≥ {s}</option>)}
        </select>
        <select name="cuenta" defaultValue={f.cuenta ?? ''} className={cn(SELECT, 'col-span-2 sm:col-span-1')} aria-label="Cuenta">
          <option value="">Cuenta</option>
          {CUENTAS.map((c) => <option key={c.valor} value={c.valor}>{c.etiqueta}</option>)}
        </select>
        <button type="submit" className="h-8 rounded-[6px] bg-texto px-3 text-[12.5px] font-medium text-fondo">Filtrar</button>
        {hayFiltros ? <a href="/hunter/radar" className="flex h-8 items-center px-2 text-[12.5px] text-texto-3 hover:text-texto">Quitar filtros</a> : null}
      </form>

      {datos.filas.length === 0 ? (
        <EstadoVacio
          titulo={hayFiltros ? 'Ningún negocio con estos filtros.' : 'El radar está vacío.'}
          quien={hayFiltros ? undefined : 'Importación del seed · rastreo'}
        >
          {hayFiltros ? 'Prueba a quitar algún filtro.' : (
            <>
              Aquí estarán todos los leads: los 305 del volcado del 13 de octubre en cuanto apruebes la importación, y los que encuentre Hunter
              en cada rastreo. Cada uno con su Señal, su etapa, su cuenta y la fecha del primer correo.
            </>
          )}
        </EstadoVacio>
      ) : (
        <>
          {/* Escritorio: tabla densa */}
          <div className="hidden max-h-[calc(100dvh-260px)] overflow-auto border-t border-linea md:block">
            <table className="tabla-densa">
              <thead>
                <tr>
                  <th>Señal</th><th>Negocio</th><th>Sector</th><th>Provincia</th><th>Etapa</th><th>Cuenta</th><th>Primer correo</th>
                </tr>
              </thead>
              <tbody>
                {datos.filas.map((l) => (
                  <tr key={l.client_id} className={l.no_contactar ? 'opacity-55' : undefined}>
                    <td><EscalaSenal valor={l.senal} /></td>
                    <td className="max-w-[320px]">
                      <span className="flex min-w-0 flex-col leading-tight">
                        <span className="truncate text-[13px] text-texto">{l.nombre}</span>
                        <span className="truncate font-mono text-[11px] text-texto-3">{l.web ? host(l.web) : l.email}</span>
                      </span>
                    </td>
                    <td className="max-w-[200px] truncate">{l.sector}</td>
                    <td>{l.provincia}</td>
                    <td><EtiquetaEtapa f={l} /></td>
                    <td className="font-mono text-[11.5px] text-texto-3">{cuentaCorta(l.cuenta)}{l.sin_hilo ? ' · sin hilo' : ''}</td>
                    <td className="font-mono text-[11.5px] tabular-nums text-texto-3">{l.primer_envio_at ? fecha(l.primer_envio_at) : '—'}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
          {/* Móvil: lista compacta */}
          <ul className="flex flex-col border-t border-linea md:hidden">
            {datos.filas.map((l) => (
              <li key={l.client_id} className={cn('flex items-center justify-between gap-3 border-b border-linea py-2.5', l.no_contactar && 'opacity-55')}>
                <span className="flex min-w-0 flex-col gap-0.5">
                  <span className="truncate text-[13.5px] text-texto">{l.nombre}</span>
                  <span className="truncate text-[12px] text-texto-3">{l.provincia} · <EtiquetaEtapa f={l} /></span>
                </span>
                <EscalaSenal valor={l.senal} className="shrink-0 [&>span:last-child]:hidden" />
              </li>
            ))}
          </ul>
          {datos.total > datos.filas.length ? (
            <p className="font-mono text-[11.5px] text-texto-3">Se muestran {datos.filas.length} de {numero(datos.total)}. Filtra para acotar.</p>
          ) : null}
        </>
      )}
    </div>
  );
}
