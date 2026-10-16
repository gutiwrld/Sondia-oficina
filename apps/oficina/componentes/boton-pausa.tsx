'use client';

import { useState, useTransition } from 'react';
import { pausar } from '@/app/acciones';
import { cn } from '@sondia/ui';

/**
 * Botón de pausa, visible en toda la oficina. Pausar es inmediato (detiene a Hunter y vacía la cola de envío);
 * reanudar pide confirmación.
 */
export function BotonPausa({ activa }: { activa: boolean }) {
  const [pendiente, empezar] = useTransition();
  const [aviso, setAviso] = useState<string | null>(null);

  const alternar = () => {
    if (activa && !window.confirm('¿Reanudar a Hunter? Lo que volvió a la mesa tendrás que aprobarlo otra vez.')) return;
    empezar(async () => {
      const r = await pausar(!activa);
      setAviso(r.ok ? (!activa && r.n ? `${r.n} en cola devueltos a la mesa` : null) : r.error);
      if (!r.ok || r.n) setTimeout(() => setAviso(null), 4000);
    });
  };

  return (
    <span className="relative">
      <button
        type="button"
        onClick={alternar}
        disabled={pendiente}
        aria-pressed={activa}
        className={cn(
          'inline-flex h-7 items-center gap-2 rounded-[6px] px-2.5 text-[12.5px] font-medium transition-colors duration-100 disabled:opacity-60',
          activa
            ? 'bg-acento text-sobre-acento hover:brightness-110'
            : 'border border-linea-fuerte text-texto hover:border-acento-linea hover:text-acento-tinta',
        )}
      >
        {activa ? (
          <svg width="10" height="10" viewBox="0 0 10 10" aria-hidden="true"><path d="M2 1.2v7.6L8.6 5z" fill="currentColor" /></svg>
        ) : (
          <svg width="10" height="10" viewBox="0 0 10 10" aria-hidden="true"><rect x="1.5" y="1" width="2.4" height="8" rx=".5" fill="currentColor" /><rect x="6.1" y="1" width="2.4" height="8" rx=".5" fill="currentColor" /></svg>
        )}
        {activa ? 'Reanudar' : 'Pausa'}
      </button>
      {aviso ? (
        <span role="status" className="absolute right-0 top-9 z-40 w-max max-w-[260px] rounded-[6px] border border-linea-fuerte bg-superficie px-3 py-2 text-[12px] text-texto-2">
          {aviso}
        </span>
      ) : null}
    </span>
  );
}
