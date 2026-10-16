'use client';

import { useTransition } from 'react';
import { cambiarTema } from '@/app/acciones';

export function SelectorTema({ tema }: { tema: 'claro' | 'oscuro' }) {
  const [, empezar] = useTransition();
  const siguiente = tema === 'oscuro' ? 'claro' : 'oscuro';
  return (
    <button
      type="button"
      onClick={() => {
        document.documentElement.dataset.theme = siguiente === 'claro' ? 'light' : 'dark';
        empezar(() => cambiarTema(siguiente));
      }}
      className="flex h-7 w-7 items-center justify-center rounded-[6px] text-texto-2 hover:bg-hover hover:text-texto"
      aria-label={`Cambiar a tema ${siguiente}`}
      title={`Tema ${siguiente}`}
    >
      {tema === 'oscuro' ? (
        <svg width="14" height="14" viewBox="0 0 16 16" aria-hidden="true"><circle cx="8" cy="8" r="3.2" fill="none" stroke="currentColor" strokeWidth="1.4" /><path d="M8 1.5v1.6M8 12.9v1.6M1.5 8h1.6M12.9 8h1.6M3.4 3.4l1.1 1.1M11.5 11.5l1.1 1.1M3.4 12.6l1.1-1.1M11.5 4.5l1.1-1.1" stroke="currentColor" strokeWidth="1.4" strokeLinecap="round" /></svg>
      ) : (
        <svg width="14" height="14" viewBox="0 0 16 16" aria-hidden="true"><path d="M13.5 9.6A5.8 5.8 0 0 1 6.4 2.5a5.8 5.8 0 1 0 7.1 7.1Z" fill="none" stroke="currentColor" strokeWidth="1.4" strokeLinejoin="round" /></svg>
      )}
    </button>
  );
}
