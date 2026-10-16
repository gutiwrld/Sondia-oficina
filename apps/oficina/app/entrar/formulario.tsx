'use client';

import { useActionState } from 'react';
import { Boton } from '@sondia/ui';
import { pedirEnlace, type EstadoEnlace } from './acciones';

export function FormularioEntrar() {
  const [estado, accion, pendiente] = useActionState<EstadoEnlace, FormData>(pedirEnlace, { tipo: 'inicio' });
  if (estado.tipo === 'enviado') {
    return (
      <div className="flex flex-col gap-2 border border-linea px-4 py-4">
        <p className="text-[14px] font-medium">Revisa tu correo</p>
        <p className="text-[13px] leading-relaxed text-texto-2">
          Hemos enviado el enlace a <span className="font-mono text-texto">{estado.email}</span>. Caduca en una hora.
        </p>
      </div>
    );
  }
  return (
    <form action={accion} className="flex flex-col gap-3">
      <label className="flex flex-col gap-1.5">
        <span className="font-mono text-[10.5px] uppercase tracking-[0.13em] text-texto-3">Email</span>
        <input
          name="email"
          type="email"
          required
          autoComplete="email"
          inputMode="email"
          placeholder="tu@email.com"
          className="h-10 rounded-[6px] border border-linea-fuerte bg-superficie px-3 text-[14px] text-texto placeholder:text-texto-3 focus:border-acento focus:outline-none"
        />
      </label>
      {estado.tipo === 'error' ? <p role="alert" className="text-[13px] text-acento-tinta">{estado.mensaje}</p> : null}
      <Boton type="submit" variante="primario" disabled={pendiente} className="h-10">
        {pendiente ? 'Enviando…' : 'Enviarme el enlace'}
      </Boton>
    </form>
  );
}
