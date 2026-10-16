import type { ButtonHTMLAttributes, ReactNode } from 'react';

export const cn = (...c: (string | false | null | undefined)[]) => c.filter(Boolean).join(' ');

/** Símbolo de SONDIA (de marca/sondia-simbolo.svg) en el color de acento. */
export function Simbolo({ tamano = 18, className }: { tamano?: number; className?: string }) {
  return (
    <svg viewBox="0 0 100 100" width={tamano} height={tamano} aria-hidden="true" className={className}>
      <g fill="var(--acento)">
        <path d="M0 27C0 12.1 12.1 0 27 0H87C94.2 0 100 5.8 100 13V39H68C57.5 39 54 54 41 54H7C3.1 54 0 50.9 0 47Z" />
        <path d="M100 73C100 87.9 87.9 100 73 100H13C5.8 100 0 94.2 0 87V61H32C42.5 61 46 46 59 46H93C96.9 46 100 49.1 100 53Z" />
      </g>
    </svg>
  );
}

/** Marca del departamento: símbolo + «sondia» en Sora + etiqueta en mono (p. ej. «HUNTER · DEPT. 01»). */
export function Marca({ etiqueta, className }: { etiqueta?: string; className?: string }) {
  return (
    <span className={cn('inline-flex items-center gap-2.5', className)}>
      <Simbolo tamano={18} />
      <span className="font-logo text-[17px] font-semibold leading-none tracking-[-0.02em] text-texto">sondia</span>
      {etiqueta ? (
        <span className="hidden border-l border-linea-fuerte pl-2.5 font-mono text-[10.5px] uppercase leading-none tracking-[0.14em] text-texto-2 sm:inline">
          {etiqueta}
        </span>
      ) : null}
    </span>
  );
}

/** Etiqueta en mono, mayúsculas y con tracking. */
export function Etiqueta({ children, className }: { children: ReactNode; className?: string }) {
  return <span className={cn('font-mono text-[10.5px] uppercase tracking-[0.13em] text-texto-3', className)}>{children}</span>;
}

/** Estado vivo de un agente: un punto pequeño con pulso (respeta prefers-reduced-motion). */
export function PuntoVivo({ estado, etiqueta }: { estado: 'activo' | 'espera' | 'parado'; etiqueta?: string }) {
  return (
    <span
      className="sondia-punto"
      data-estado={estado}
      role="img"
      aria-label={etiqueta ?? (estado === 'activo' ? 'Trabajando' : estado === 'espera' ? 'En espera' : 'Parado')}
    />
  );
}

/**
 * La Señal (0–100) como escala fina en mono: 20 marcas de 5 puntos.
 * No es un círculo de progreso: se lee como un instrumento.
 */
export function EscalaSenal({
  valor,
  tamano = 'compacta',
  className,
}: {
  valor: number | null | undefined;
  tamano?: 'compacta' | 'completa';
  className?: string;
}) {
  const v = valor === null || valor === undefined ? null : Math.max(0, Math.min(100, Math.round(valor)));
  const llenas = v === null ? 0 : Math.round(v / 5);
  const marcas = Array.from({ length: 20 }, (_, i) => i < llenas);
  const alto = tamano === 'completa' ? 'h-3' : 'h-2.5';
  return (
    <span
      className={cn('inline-flex items-center gap-2', className)}
      role="meter"
      aria-valuemin={0}
      aria-valuemax={100}
      aria-valuenow={v ?? undefined}
      aria-label={v === null ? 'Señal sin calcular' : `Señal ${v} de 100`}
    >
      <span className={cn('font-mono tabular-nums text-texto', tamano === 'completa' ? 'text-2xl font-medium' : 'w-[2ch] text-right text-[12px]')}>
        {v === null ? '—' : v}
      </span>
      <span className="inline-flex items-end gap-[2px]" aria-hidden="true">
        {marcas.map((llena, i) => (
          <span
            key={i}
            className={cn(
              'w-[2px] rounded-[0.5px]',
              (i + 1) % 10 === 0 ? (tamano === 'completa' ? 'h-4' : 'h-3') : alto,
              llena ? 'bg-texto' : 'bg-linea-fuerte',
            )}
          />
        ))}
      </span>
    </span>
  );
}

export function Boton({
  variante = 'secundario',
  tamano = 'md',
  className,
  children,
  ...props
}: ButtonHTMLAttributes<HTMLButtonElement> & {
  variante?: 'primario' | 'secundario' | 'fantasma' | 'atencion';
  tamano?: 'sm' | 'md';
}) {
  return (
    <button
      {...props}
      className={cn(
        'inline-flex items-center justify-center gap-2 rounded-[6px] font-medium transition-colors duration-100 disabled:cursor-not-allowed disabled:opacity-45',
        'focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-acento',
        tamano === 'sm' ? 'h-7 px-2.5 text-[12.5px]' : 'h-9 px-3.5 text-[13.5px]',
        variante === 'primario' && 'bg-acento text-sobre-acento hover:brightness-110',
        variante === 'secundario' && 'border border-linea-fuerte bg-superficie text-texto hover:bg-hover',
        variante === 'fantasma' && 'text-texto-2 hover:bg-hover hover:text-texto',
        variante === 'atencion' && 'border border-acento-linea bg-acento-suave text-acento-tinta hover:brightness-110',
        className,
      )}
    >
      {children}
    </button>
  );
}

export function Tecla({ children }: { children: ReactNode }) {
  return (
    <kbd className="inline-flex h-5 min-w-5 items-center justify-center rounded-[4px] border border-linea-fuerte bg-superficie-2 px-1 font-mono text-[11px] leading-none text-texto-2">
      {children}
    </kbd>
  );
}

/** Contador de la sala: etiqueta en mono y cifra en mono. `atencion` lo pinta de naranja. */
export function Contador({
  etiqueta,
  valor,
  de,
  nota,
  atencion,
}: {
  etiqueta: string;
  valor: ReactNode;
  de?: ReactNode;
  nota?: ReactNode;
  atencion?: boolean;
}) {
  return (
    <div className="flex min-w-0 flex-col gap-2 px-4 py-3.5">
      <Etiqueta className={atencion ? 'text-acento-tinta' : undefined}>{etiqueta}</Etiqueta>
      <div className="flex items-baseline gap-1.5">
        <span className={cn('font-mono text-[26px] font-medium leading-none tabular-nums', atencion ? 'text-acento-tinta' : 'text-texto')}>
          {valor}
        </span>
        {de !== undefined ? <span className="font-mono text-[13px] tabular-nums text-texto-3">/ {de}</span> : null}
      </div>
      {nota ? <span className="truncate text-[12px] text-texto-3">{nota}</span> : null}
    </div>
  );
}

/** Estado vacío que explica qué va a aparecer aquí y quién lo trae. */
export function EstadoVacio({
  titulo,
  children,
  quien,
  className,
}: {
  titulo: string;
  children?: ReactNode;
  quien?: string;
  className?: string;
}) {
  return (
    <div className={cn('flex flex-col gap-3 border border-dashed border-linea-fuerte px-5 py-6 sm:px-6', className)}>
      {quien ? <Etiqueta>{quien}</Etiqueta> : null}
      <p className="text-[15px] font-medium text-texto">{titulo}</p>
      {children ? <div className="max-w-[62ch] text-[13.5px] leading-relaxed text-texto-2">{children}</div> : null}
    </div>
  );
}
