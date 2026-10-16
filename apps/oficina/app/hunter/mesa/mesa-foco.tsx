'use client';

import { useCallback, useEffect, useMemo, useRef, useState, useTransition } from 'react';
import { Boton, EscalaSenal, Etiqueta, Tecla, cn } from '@sondia/ui';
import { fechaConDia, hora } from '@sondia/core';
import type { Borrador } from '@/lib/datos';
import { aprobar, aprobarLote, rechazar } from '@/app/acciones';
import { diffLineas } from './diff';

const TIPO: Record<Borrador['tipo'], string> = {
  nuevo: 'Primer correo',
  seguimiento: 'Seguimiento',
  respuesta: 'Respuesta',
  reunion: 'Propuesta de reunión',
  llamada: 'Llamada',
};

/** Resalta en el texto las citas de su web. */
function ConCitas({ texto, citas }: { texto: string; citas: string[] }) {
  if (!citas.length) return <>{texto}</>;
  const escapar = (s: string) => s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
  const partes = texto.split(new RegExp(`(${citas.map(escapar).join('|')})`, 'g'));
  return <>{partes.map((p, i) => (citas.includes(p) ? <mark key={i} className="cita">{p}</mark> : <span key={i}>{p}</span>))}</>;
}

export function MesaFoco({ borradores: iniciales }: { borradores: Borrador[] }) {
  const [lista, setLista] = useState(iniciales);
  const [i, setI] = useState(0);
  const [editando, setEditando] = useState(false);
  const [ediciones, setEdiciones] = useState<Record<string, { asunto: string; cuerpo: string }>>({});
  const [rechazo, setRechazo] = useState<{ motivo: string } | null>(null);
  const [lote, setLote] = useState(false);
  const [vista, setVista] = useState<'borrador' | 'evidencia'>('borrador');
  const [aviso, setAviso] = useState<string | null>(null);
  const [pendiente, empezar] = useTransition();
  const cuerpoRef = useRef<HTMLTextAreaElement>(null);

  const actual = lista[Math.min(i, lista.length - 1)];
  const edicion = actual ? (ediciones[actual.id] ?? { asunto: actual.asunto, cuerpo: actual.cuerpo }) : null;
  const citas = useMemo(
    () => (actual?.evidencia.fallos ?? []).map((f) => f.cita).filter((c): c is string => Boolean(c)),
    [actual],
  );

  const quitar = useCallback((id: string) => {
    setLista((l) => l.filter((b) => b.id !== id));
    setEditando(false);
    setRechazo(null);
  }, []);

  const avisar = (t: string) => {
    setAviso(t);
    setTimeout(() => setAviso(null), 3500);
  };

  const hacerAprobar = useCallback(() => {
    if (!actual || !edicion) return;
    const editado = edicion.asunto !== actual.asunto || edicion.cuerpo !== actual.cuerpo;
    empezar(async () => {
      const r = await aprobar(
        actual.id,
        editado
          ? { asunto: edicion.asunto, cuerpo: edicion.cuerpo, diff: diffLineas(`${actual.asunto}\n\n${actual.cuerpo}`, `${edicion.asunto}\n\n${edicion.cuerpo}`) }
          : undefined,
      );
      if (r.ok) {
        quitar(actual.id);
        avisar(actual.tipo === 'llamada' ? 'Llamada aprobada' : 'Aprobado · a la cola de envío');
      } else avisar(r.error);
    });
  }, [actual, edicion, quitar]);

  const hacerRechazar = (rehacer: boolean) => {
    if (!actual) return;
    empezar(async () => {
      const r = await rechazar(actual.id, rechazo?.motivo ?? '', rehacer);
      if (r.ok) {
        quitar(actual.id);
        avisar(rehacer ? 'Devuelto a Hunter para rehacer' : 'Rechazado');
      } else avisar(r.error);
    });
  };

  const hacerLote = () => {
    const ids = lista.filter((b) => !ediciones[b.id]).map((b) => b.id);
    empezar(async () => {
      const r = await aprobarLote(ids, true);
      if (r.ok) {
        setLista((l) => l.filter((b) => !ids.includes(b.id)));
        avisar(`${r.n} aprobados · a la cola de envío`);
      } else avisar(r.error);
      setLote(false);
    });
  };

  useEffect(() => {
    const tecla = (e: KeyboardEvent) => {
      const enCampo = e.target instanceof HTMLElement && ['INPUT', 'TEXTAREA'].includes(e.target.tagName);
      if ((e.metaKey || e.ctrlKey) && e.key === 'Enter') {
        e.preventDefault();
        setLote(true);
        return;
      }
      if (e.key === 'Escape') {
        setEditando(false);
        setRechazo(null);
        setLote(false);
        (document.activeElement as HTMLElement | null)?.blur();
        return;
      }
      if (enCampo || pendiente || lote || rechazo) return;
      const k = e.key.toLowerCase();
      if (k === 'j') setI((x) => Math.min(x + 1, lista.length - 1));
      else if (k === 'k') setI((x) => Math.max(x - 1, 0));
      else if (k === 'a') hacerAprobar();
      else if (k === 'r') setRechazo({ motivo: '' });
      else if (k === 'e') {
        e.preventDefault();
        setEditando(true);
        setVista('borrador');
        setTimeout(() => cuerpoRef.current?.focus(), 0);
      } else return;
      e.preventDefault();
    };
    window.addEventListener('keydown', tecla);
    return () => window.removeEventListener('keydown', tecla);
  }, [hacerAprobar, lista.length, pendiente, lote, rechazo]);

  if (!actual || !edicion) {
    return (
      <div className="flex flex-col items-start gap-2 py-16">
        <Etiqueta>Mesa de aprobación</Etiqueta>
        <p className="text-[18px] font-medium">Mesa despejada.</p>
        <p className="text-[13.5px] text-texto-2">Lo aprobado está en la cola y saldrá en su franja horaria.</p>
      </div>
    );
  }

  const setCampo = (campo: 'asunto' | 'cuerpo', valor: string) =>
    setEdiciones((m) => ({ ...m, [actual.id]: { ...edicion, [campo]: valor } }));
  const verif = actual.verificacion;
  const citasOk = verif.citas?.filter((c) => c.encontrada).length ?? 0;

  return (
    <div className="flex flex-col gap-4 pb-24 lg:pb-0">
      {/* Cabecera de la mesa */}
      <div className="flex flex-wrap items-center gap-x-4 gap-y-2">
        <span className="font-mono text-[12px] tabular-nums text-texto-2">
          {Math.min(i, lista.length - 1) + 1} <span className="text-texto-3">de {lista.length}</span>
        </span>
        <span className="flex h-[3px] w-24 overflow-hidden rounded-full bg-linea" aria-hidden="true">
          <span className="bg-texto" style={{ width: `${((Math.min(i, lista.length - 1) + 1) / lista.length) * 100}%` }} />
        </span>
        <Etiqueta className="text-texto-2">{TIPO[actual.tipo]}</Etiqueta>
        <span className="ml-auto flex gap-1 lg:hidden">
          <Boton tamano="sm" variante="secundario" onClick={() => setI((x) => Math.max(x - 1, 0))} aria-label="Anterior" disabled={i === 0}>‹</Boton>
          <Boton tamano="sm" variante="secundario" onClick={() => setI((x) => Math.min(x + 1, lista.length - 1))} aria-label="Siguiente" disabled={i >= lista.length - 1}>›</Boton>
        </span>
        <div className="ml-auto hidden items-center gap-2 lg:flex">
          <Boton tamano="sm" variante="fantasma" onClick={() => setI((x) => Math.max(x - 1, 0))} aria-label="Anterior">
            <Tecla>K</Tecla>
          </Boton>
          <Boton tamano="sm" variante="fantasma" onClick={() => setI((x) => Math.min(x + 1, lista.length - 1))} aria-label="Siguiente">
            <Tecla>J</Tecla>
          </Boton>
          <Boton tamano="sm" onClick={() => setRechazo({ motivo: '' })} disabled={pendiente}>Rechazar <Tecla>R</Tecla></Boton>
          <Boton tamano="sm" onClick={() => { setEditando(true); setTimeout(() => cuerpoRef.current?.focus(), 0); }}>Editar <Tecla>E</Tecla></Boton>
          <Boton tamano="sm" variante="primario" onClick={hacerAprobar} disabled={pendiente}>Aprobar <span className="font-mono text-[11px] opacity-70">A</span></Boton>
          <Boton tamano="sm" variante="secundario" onClick={() => setLote(true)}>Lote <Tecla>⌘↵</Tecla></Boton>
        </div>
      </div>

      {/* Pestañas en el móvil */}
      <div className="flex border-b border-linea lg:hidden" role="tablist">
        {(['borrador', 'evidencia'] as const).map((v) => (
          <button
            key={v}
            role="tab"
            aria-selected={vista === v}
            onClick={() => setVista(v)}
            className={cn('h-9 flex-1 text-[13px] capitalize', vista === v ? 'border-b border-texto text-texto' : 'text-texto-3')}
          >
            {v}
          </button>
        ))}
      </div>

      <div className="grid grid-cols-1 border-linea lg:grid-cols-[minmax(0,0.95fr)_minmax(0,1.2fr)] lg:border-t">
        {/* Evidencia */}
        <section aria-label="Evidencia" className={cn('flex flex-col gap-6 border-linea py-5 lg:border-r lg:pr-6', vista !== 'evidencia' && 'max-lg:hidden')}>
          <div className="flex flex-col gap-1">
            <span className="text-[17px] font-medium">{actual.nombre}</span>
            <span className="text-[12.5px] text-texto-3">
              {[actual.sector, actual.ciudad, actual.provincia].filter(Boolean).join(' · ')}
              {actual.web ? <> · <a className="underline decoration-linea-fuerte underline-offset-2 hover:text-texto-2" href={actual.web} target="_blank" rel="noreferrer noopener">{actual.web.replace(/^https?:\/\/(www\.)?/, '').replace(/\/$/, '')}</a></> : null}
            </span>
          </div>

          <div className="grid grid-cols-[minmax(0,150px)_minmax(0,1fr)] gap-5">
            <div className="aspect-[390/780] overflow-hidden rounded-[10px] border border-linea-fuerte bg-superficie-2">
              {actual.evidencia.captura_url ? (
                // eslint-disable-next-line @next/next/no-img-element
                <img src={actual.evidencia.captura_url} alt={`Portada de ${actual.nombre} a 390 px`} className="h-full w-full object-cover object-top" />
              ) : (
                <span className="flex h-full items-center justify-center px-3 text-center font-mono text-[10.5px] uppercase tracking-[0.12em] text-texto-3">Sin captura</span>
              )}
            </div>
            <div className="flex flex-col gap-3">
              <Etiqueta>Señal</Etiqueta>
              <EscalaSenal valor={actual.evidencia.senal} tamano="completa" />
              {actual.evidencia.senal_desglose?.length ? (
                <ul className="flex flex-col gap-1">
                  {actual.evidencia.senal_desglose.filter((p) => p.puntos > 0).map((p) => (
                    <li key={p.clave} className="flex items-baseline justify-between gap-3 text-[12px]">
                      <span className="truncate text-texto-2">{p.etiqueta}</span>
                      <span className="font-mono tabular-nums text-texto-3">+{p.puntos}</span>
                    </li>
                  ))}
                </ul>
              ) : null}
            </div>
          </div>

          {actual.evidencia.fallos?.length ? (
            <div className="flex flex-col gap-2">
              <Etiqueta>Fallos citados</Etiqueta>
              <ol className="flex flex-col border-t border-linea">
                {actual.evidencia.fallos.map((f, n) => (
                  <li key={n} className="flex flex-col gap-1 border-b border-linea py-2.5 text-[13px]">
                    <span className="text-texto">{f.descripcion}</span>
                    {f.cita ? <span className="text-texto-2">«<mark className="cita">{f.cita}</mark>»</span> : null}
                    <span className="font-mono text-[10.5px] uppercase tracking-[0.12em] text-texto-3">{f.tipo.replace(/_/g, ' ')}</span>
                  </li>
                ))}
              </ol>
            </div>
          ) : null}

          {actual.evidencia.mensaje ? (
            <div className="flex flex-col gap-2">
              <Etiqueta>Lo que escribió · {fechaConDia(actual.evidencia.mensaje.recibido_at)}, {hora(actual.evidencia.mensaje.recibido_at)}</Etiqueta>
              <blockquote className="border-l-2 border-linea-fuerte pl-3 text-[13px] leading-relaxed text-texto-2">{actual.evidencia.mensaje.fragmento}</blockquote>
            </div>
          ) : null}

          <div className="flex flex-col gap-1.5 border-t border-linea pt-3 font-mono text-[11.5px] text-texto-3">
            {verif.citas ? (
              <span>Verificador · {citasOk}/{verif.citas.length} citas encontradas literalmente en su web</span>
            ) : null}
            {actual.evidencia.porque ? <span>Por qué · {actual.evidencia.porque}</span> : null}
          </div>
        </section>

        {/* Borrador */}
        <section aria-label="Borrador" className={cn('flex flex-col gap-4 py-5 lg:pl-6', vista !== 'borrador' && 'max-lg:hidden')}>
          <dl className="grid grid-cols-[52px_minmax(0,1fr)] gap-x-3 gap-y-1.5 text-[13px]">
            <dt className="font-mono text-[11px] uppercase tracking-[0.12em] text-texto-3">Para</dt>
            <dd className="truncate font-mono text-[12.5px] text-texto">{actual.para_email ?? '—'}</dd>
            <dt className="font-mono text-[11px] uppercase tracking-[0.12em] text-texto-3">Desde</dt>
            <dd className="truncate font-mono text-[12.5px] text-texto-2">{actual.cuenta_email ?? '—'}</dd>
          </dl>
          {actual.tipo !== 'llamada' ? (
            <>
              {editando ? (
                <input
                  value={edicion.asunto}
                  onChange={(e) => setCampo('asunto', e.target.value)}
                  aria-label="Asunto"
                  className="h-10 w-full rounded-[6px] border border-acento bg-transparent px-3 text-[15px] font-medium text-texto focus:outline-none"
                />
              ) : (
                <p className="rounded-[6px] border border-linea px-3 py-2 text-[15px] font-medium leading-snug text-texto">
                  <ConCitas texto={edicion.asunto} citas={citas} />
                </p>
              )}
              {editando ? (
                <textarea
                  ref={cuerpoRef}
                  value={edicion.cuerpo}
                  onChange={(e) => setCampo('cuerpo', e.target.value)}
                  aria-label="Cuerpo del correo"
                  rows={18}
                  className="w-full resize-y rounded-[6px] border border-acento bg-transparent px-3 py-3 text-[14px] leading-[1.65] text-texto focus:outline-none"
                />
              ) : (
                <div
                  onDoubleClick={() => { setEditando(true); setTimeout(() => cuerpoRef.current?.focus(), 0); }}
                  className="whitespace-pre-wrap rounded-[6px] border border-linea px-3 py-3 text-[14px] leading-[1.65] text-texto"
                >
                  <ConCitas texto={edicion.cuerpo} citas={citas} />
                </div>
              )}
              {ediciones[actual.id] ? (
                <span className="font-mono text-[11px] text-texto-3">Editado · Hunter guardará el cambio como ejemplo de estilo</span>
              ) : null}
            </>
          ) : (
            <p className="text-[14px] text-texto-2">Hunter propone llamar a este negocio. Al aprobar, aparecerá en la agenda.</p>
          )}
          {actual.huecos?.length ? (
            <div className="flex flex-col gap-2">
              <Etiqueta>Huecos propuestos · hora de Madrid</Etiqueta>
              <ul className="flex flex-wrap gap-2">
                {actual.huecos.map((h) => (
                  <li key={h.inicio} className="rounded-[6px] border border-linea-fuerte px-2.5 py-1 font-mono text-[12px]">
                    {fechaConDia(h.inicio)}, {hora(h.inicio)}
                  </li>
                ))}
              </ul>
            </div>
          ) : null}
        </section>
      </div>

      {/* Barra de acciones en el móvil */}
      <div className="fixed inset-x-0 bottom-0 z-20 grid grid-cols-[1fr_1fr_1.4fr] gap-2 border-t border-linea bg-fondo px-4 pb-[max(12px,env(safe-area-inset-bottom))] pt-3 lg:hidden">
        <Boton onClick={() => setRechazo({ motivo: '' })} disabled={pendiente} className="h-11">Rechazar</Boton>
        <Boton onClick={() => { setEditando(true); setVista('borrador'); setTimeout(() => cuerpoRef.current?.focus(), 0); }} className="h-11">Editar</Boton>
        <Boton variante="primario" onClick={hacerAprobar} disabled={pendiente} className="h-11">Aprobar</Boton>
        <button onClick={() => setLote(true)} className="col-span-3 h-8 text-[12.5px] text-texto-2 underline decoration-linea-fuerte underline-offset-4">
          Aprobar los {lista.length} del lote…
        </button>
      </div>

      {/* Rechazo */}
      {rechazo ? (
        <Dialogo titulo="Rechazar este borrador" onCerrar={() => setRechazo(null)}>
          <textarea
            autoFocus
            value={rechazo.motivo}
            onChange={(e) => setRechazo({ motivo: e.target.value })}
            placeholder="Motivo (opcional). Si pides rehacer, Hunter lo tendrá en cuenta."
            rows={3}
            className="w-full rounded-[6px] border border-linea-fuerte bg-transparent px-3 py-2 text-[13.5px] focus:border-acento focus:outline-none"
          />
          <div className="flex flex-wrap justify-end gap-2">
            <Boton variante="fantasma" onClick={() => setRechazo(null)}>Cancelar</Boton>
            <Boton onClick={() => hacerRechazar(true)} disabled={pendiente}>Pedir que lo rehaga</Boton>
            <Boton variante="atencion" onClick={() => hacerRechazar(false)} disabled={pendiente}>Rechazar</Boton>
          </div>
        </Dialogo>
      ) : null}

      {/* Lote: confirmación explícita */}
      {lote ? (
        <Dialogo titulo={`Aprobar el lote de ${lista.filter((b) => !ediciones[b.id]).length}`} onCerrar={() => setLote(false)}>
          <p className="text-[13.5px] leading-relaxed text-texto-2">
            Van a la cola de envío y saldrán en su franja (nuevos de lunes a jueves de 9:00 a 11:00), con el límite diario de cada cuenta.
            {Object.keys(ediciones).length ? ' Los que has editado no entran en el lote: apruébalos uno a uno.' : ''}
          </p>
          <ul className="max-h-48 overflow-y-auto border-y border-linea text-[12.5px]">
            {lista.filter((b) => !ediciones[b.id]).map((b) => (
              <li key={b.id} className="flex justify-between gap-3 border-b border-linea py-1.5 last:border-0">
                <span className="truncate text-texto">{b.nombre}</span>
                <span className="shrink-0 font-mono text-texto-3">{TIPO[b.tipo]}</span>
              </li>
            ))}
          </ul>
          <div className="flex justify-end gap-2">
            <Boton variante="fantasma" onClick={() => setLote(false)}>Cancelar</Boton>
            <Boton variante="primario" onClick={hacerLote} disabled={pendiente}>
              Sí, enviar {lista.filter((b) => !ediciones[b.id]).length} a la cola
            </Boton>
          </div>
        </Dialogo>
      ) : null}

      {aviso ? (
        <div role="status" className="fixed bottom-28 left-1/2 z-40 -translate-x-1/2 rounded-[6px] border border-linea-fuerte bg-superficie px-3.5 py-2 text-[13px] lg:bottom-6">
          {aviso}
        </div>
      ) : null}
    </div>
  );
}

function Dialogo({ titulo, children, onCerrar }: { titulo: string; children: React.ReactNode; onCerrar: () => void }) {
  return (
    <div className="fixed inset-0 z-50 flex items-end justify-center bg-black/50 p-4 sm:items-center" onClick={onCerrar}>
      <div
        role="dialog"
        aria-modal="true"
        aria-label={titulo}
        onClick={(e) => e.stopPropagation()}
        className="flex w-full max-w-[460px] flex-col gap-4 rounded-[10px] border border-linea-fuerte bg-superficie p-5"
      >
        <h2 className="text-[15px] font-medium">{titulo}</h2>
        {children}
      </div>
    </div>
  );
}
