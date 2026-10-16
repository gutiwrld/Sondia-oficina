import type { Metadata } from 'next';
import { Boton, Etiqueta, cn } from '@sondia/ui';
import { CONFIG_ENVIO_POR_DEFECTO, TERRITORIO, euros, fecha, type ConfigEnvio } from '@sondia/core';
import { AvisoLectura } from '@/componentes/aviso-lectura';
import { ajustes } from '@/lib/datos';
import { FormSupresion } from './form-supresion';

export const metadata: Metadata = { title: 'Ajustes · Hunter' };

const DIAS = ['', 'L', 'M', 'X', 'J', 'V', 'S', 'D'];
const FRANJAS: { clave: keyof ConfigEnvio['franjas']; nombre: string }[] = [
  { clave: 'nuevo', nombre: 'Correos nuevos' },
  { clave: 'seguimiento', nombre: 'Seguimientos' },
  { clave: 'respuesta', nombre: 'Respuestas' },
  { clave: 'reunion', nombre: 'Propuestas de reunión' },
];

function Tarjeta({ titulo, nota, children, className }: { titulo: string; nota?: string; children: React.ReactNode; className?: string }) {
  return (
    <section className={cn('flex flex-col gap-4 border-t border-linea-fuerte pt-4', className)}>
      <div className="flex flex-col gap-1">
        <h2 className="text-[15px] font-medium">{titulo}</h2>
        {nota ? <p className="text-[12.5px] leading-relaxed text-texto-3">{nota}</p> : null}
      </div>
      {children}
    </section>
  );
}

function Fila({ k, v }: { k: string; v: React.ReactNode }) {
  return (
    <div className="flex items-baseline justify-between gap-4 border-b border-linea py-2 text-[13px]">
      <span className="text-texto-2">{k}</span>
      <span className="text-right font-mono text-[12.5px] tabular-nums text-texto">{v}</span>
    </div>
  );
}

const CUENTAS_POR_DEFECTO = ['guzmangonzalez.twati@gmail.com', 'guzmangonzalezperez@gmail.com'];

export default async function Ajustes() {
  const { datos, error } = await ajustes();
  const envio = (datos.settings.envio as ConfigEnvio | undefined) ?? CONFIG_ENVIO_POR_DEFECTO;
  const pres = (datos.settings.presupuesto as Record<string, number> | undefined) ?? {
    anthropicPorEjecucionEur: 2, anthropicPorDiaEur: 8, placesPorEjecucionEur: 1, placesPorDiaEur: 3,
  };
  const modelos = (datos.settings.modelos as Record<string, string> | undefined) ?? { redactar: 'claude-opus-5-5', clasificar: 'claude-haiku-5-5' };
  const cuentas = datos.cuentas.length
    ? datos.cuentas
    : CUENTAS_POR_DEFECTO.map((email) => ({ email, firma_nombre: 'Guzmán', conectada_lectura_at: null, conectada_envio_at: null, calentamiento_desde: null, limite_diario: null, activa: true }));
  const territorio = datos.territorio.length
    ? datos.territorio
    : TERRITORIO.map((p) => ({ provincia: p.nombre, socio: p.dueno, rastreo: p.rastreo }));
  const grupos = [
    { titulo: 'Guzmán · rastreo activo', lista: territorio.filter((p) => p.socio === 'guzman' && p.rastreo) },
    { titulo: 'Guzmán · ya trabajadas', lista: territorio.filter((p) => p.socio === 'guzman' && !p.rastreo) },
    { titulo: 'Hugo · Hunter no las toca', lista: territorio.filter((p) => p.socio === 'hugo') },
  ];

  return (
    <div className="flex flex-col gap-6">
      <AvisoLectura errores={[error]} />
      <div className="flex flex-col gap-1.5">
        <Etiqueta>Ajustes</Etiqueta>
        <h1 className="text-[22px] font-medium tracking-[-0.01em]">Cómo trabaja Hunter</h1>
      </div>

      <div className="grid grid-cols-1 gap-x-10 gap-y-10 lg:grid-cols-2">
        <Tarjeta
          titulo="Cuentas de Gmail"
          nota="Cada cuenta se conecta dos veces: «lectura» (la usa Hunter) y «envío» (solo la outbox). En modo de prueba, Google caduca el acceso a los 7 días: te avisaremos en naranja antes."
          className="lg:col-span-2"
        >
          <div className="overflow-x-auto">
            <table className="tabla-densa min-w-[640px]">
              <thead><tr><th>Cuenta</th><th>Lectura</th><th>Envío</th><th>Límite diario</th><th>Calentamiento</th><th /></tr></thead>
              <tbody>
                {cuentas.map((c) => (
                  <tr key={c.email}>
                    <td className="font-mono text-[12px] text-texto">{c.email}</td>
                    <td className="font-mono text-[11.5px]">{c.conectada_lectura_at ? `Conectada · ${fecha(c.conectada_lectura_at)}` : 'Sin conectar'}</td>
                    <td className="font-mono text-[11.5px]">{c.conectada_envio_at ? `Conectada · ${fecha(c.conectada_envio_at)}` : 'Sin conectar'}</td>
                    <td className="font-mono text-[12px] tabular-nums">{c.limite_diario ?? envio.limiteDiario}</td>
                    <td className="font-mono text-[11.5px]">{c.calentamiento_desde ? `Desde ${fecha(c.calentamiento_desde)}` : 'No (cuenta con historial)'}</td>
                    <td className="text-right"><Boton tamano="sm" disabled title="La conexión con Google llega en la Fase 3">Conectar</Boton></td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </Tarjeta>

        <Tarjeta titulo="Límites y horarios" nota="Hora de Madrid. Cada correo sale de la cuenta del lead.">
          <div>
            <Fila k="Máximo por cuenta y día" v={`${envio.limiteDiario} correos`} />
            <Fila k="Espera entre envíos" v={`${envio.esperaMinMinutos}–${envio.esperaMaxMinutos} min, al azar`} />
            {FRANJAS.map((f) => {
              const fr = envio.franjas[f.clave];
              return <Fila key={f.clave} k={f.nombre} v={`${fr.dias.map((d) => DIAS[d]).join(' ')} · ${fr.desde}–${fr.hasta}`} />;
            })}
            <Fila k="Rampa de cuentas nuevas" v={envio.rampa.map((p) => `día ${p.desdeDia}: ${p.limite}`).join(' · ')} />
          </div>
          <p className="font-mono text-[11px] text-texto-3">
            Con 2–6 min entre envíos, en la franja de 9:00 a 11:00 caben unos 30 correos nuevos por cuenta.
          </p>
        </Tarjeta>

        <Tarjeta titulo="Presupuesto" nota="Si una ejecución o el día pasan del tope, Hunter para y te avisa.">
          <div>
            <Fila k="Anthropic · por ejecución" v={euros(pres.anthropicPorEjecucionEur ?? 0)} />
            <Fila k="Anthropic · por día" v={euros(pres.anthropicPorDiaEur ?? 0)} />
            <Fila k="Google Places · por ejecución" v={euros(pres.placesPorEjecucionEur ?? 0)} />
            <Fila k="Google Places · por día" v={euros(pres.placesPorDiaEur ?? 0)} />
            <Fila k="Modelo para redactar" v={modelos.redactar} />
            <Fila k="Modelo para clasificar" v={modelos.clasificar} />
          </div>
        </Tarjeta>

        <Tarjeta titulo="Territorio" nota="Cada provincia tiene un único dueño. Hunter solo rastrea las de Guzmán con rastreo activo.">
          <div className="flex flex-col gap-4">
            {grupos.map((g) => (
              <div key={g.titulo} className="flex flex-col gap-2">
                <Etiqueta className={g.titulo.startsWith('Hugo') ? undefined : 'text-texto-2'}>{g.titulo} · {g.lista.length}</Etiqueta>
                <p className={cn('text-[13px] leading-relaxed', g.titulo.startsWith('Hugo') ? 'text-texto-3' : 'text-texto')}>
                  {g.lista.map((p) => p.provincia).join(', ')}
                </p>
              </div>
            ))}
          </div>
        </Tarjeta>

        <Tarjeta
          titulo="Lista de supresión"
          nota="Global e irreversible: un «no» mete aquí su email y su dominio, y nadie vuelve a escribirles. Nunca se borra."
        >
          <div className="flex items-baseline gap-2">
            <span className="font-mono text-[26px] tabular-nums">{datos.totalSupresion}</span>
            <span className="text-[12.5px] text-texto-3">{datos.totalSupresion === 1 ? 'entrada' : 'entradas'}</span>
          </div>
          {datos.supresion.length ? (
            <ul className="flex max-h-56 flex-col overflow-y-auto border-t border-linea">
              {datos.supresion.map((s) => (
                <li key={`${s.tipo}-${s.valor}`} className="flex items-baseline justify-between gap-3 border-b border-linea py-1.5 text-[12.5px]">
                  <span className="truncate font-mono text-texto">{s.valor}</span>
                  <span className="shrink-0 text-texto-3">{s.motivo || s.tipo} · {fecha(s.created_at)}</span>
                </li>
              ))}
            </ul>
          ) : (
            <p className="text-[12.5px] text-texto-3">Vacía. Al importar el seed entrarán los 8 negocios que dijeron que no.</p>
          )}
          <FormSupresion />
        </Tarjeta>
      </div>
    </div>
  );
}
