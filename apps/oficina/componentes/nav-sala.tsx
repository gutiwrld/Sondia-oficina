'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { cn } from '@sondia/ui';

const PESTANAS = [
  { href: '/hunter', etiqueta: 'Hoy' },
  { href: '/hunter/mesa', etiqueta: 'Mesa' },
  { href: '/hunter/radar', etiqueta: 'Radar' },
  { href: '/hunter/bandeja', etiqueta: 'Bandeja' },
  { href: '/hunter/agenda', etiqueta: 'Agenda' },
  { href: '/hunter/rastro', etiqueta: 'El rastro' },
  { href: '/hunter/ajustes', etiqueta: 'Ajustes' },
];

export function NavSala({ mesa }: { mesa: number }) {
  const ruta = usePathname();
  return (
    <nav aria-label="Sala de Hunter" className="border-b border-linea bg-fondo">
      <ul className="sin-barra mx-auto flex max-w-[1440px] gap-1 overflow-x-auto px-3 sm:px-5">
        {PESTANAS.map((p) => {
          const activa = p.href === '/hunter' ? ruta === '/hunter' : ruta.startsWith(p.href);
          return (
            <li key={p.href} className="shrink-0">
              <Link
                href={p.href}
                aria-current={activa ? 'page' : undefined}
                className={cn(
                  'relative flex h-10 items-center gap-2 px-2.5 text-[13px] transition-colors duration-100',
                  activa ? 'text-texto' : 'text-texto-3 hover:text-texto-2',
                )}
              >
                {p.etiqueta}
                {p.href === '/hunter/mesa' && mesa > 0 ? (
                  <span className="rounded-[4px] bg-acento px-1.5 py-px font-mono text-[10.5px] leading-[16px] text-sobre-acento">{mesa}</span>
                ) : null}
                {activa ? <span className="absolute inset-x-2.5 -bottom-px h-px bg-texto" aria-hidden="true" /> : null}
              </Link>
            </li>
          );
        })}
      </ul>
    </nav>
  );
}
