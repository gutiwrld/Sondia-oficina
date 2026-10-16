'use client';

import { useActionState } from 'react';
import { Boton } from '@sondia/ui';
import { anadirSupresion, type EstadoSupresion } from './acciones';

export function FormSupresion() {
  const [estado, accion, pendiente] = useActionState<EstadoSupresion, FormData>(anadirSupresion, { tipo: 'inicio' });
  return (
    <form action={accion} className="flex flex-col gap-2">
      <div className="flex gap-2">
        <input
          name="valor"
          required
          placeholder="email@negocio.es o negocio.es"
          aria-label="Email o dominio para la lista de supresión"
          className="h-8 min-w-0 flex-1 rounded-[6px] border border-linea-fuerte bg-superficie px-2.5 font-mono text-[12px] text-texto placeholder:text-texto-3 focus:border-acento focus:outline-none"
        />
        <Boton tamano="sm" type="submit" disabled={pendiente} className="h-8">Añadir</Boton>
      </div>
      {estado.tipo !== 'inicio' ? (
        <p role="status" className={estado.tipo === 'error' ? 'text-[12px] text-acento-tinta' : 'text-[12px] text-texto-3'}>{estado.mensaje}</p>
      ) : null}
    </form>
  );
}
