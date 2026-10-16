/**
 * Importación del seed (volcado del 13-oct-2026) a public.clients + hunter.leads + client_events.
 *
 *   pnpm seed:informe          → solo el informe en seco (datos-iniciales/informe-importacion.md) y el SQL
 *                                 en supabase/seed/seed_hunter.sql. NO escribe en la base de datos.
 *
 * El SQL se aplica a mano una vez revisado el informe (regla: primero informe, después escritura).
 */
import { mkdirSync, readFileSync, writeFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';
import { dominioDelLead, normalizarEmail, normalizarProvincia, provincia, type Etapa } from '@sondia/core';
import { leerCsv } from './csv';

const RAIZ = join(dirname(fileURLToPath(import.meta.url)), '../../../..');
const DATOS = join(RAIZ, 'datos-iniciales');

interface FilaCsv {
  nombre: string; sector: string; ciudad: string; provincia: string; web: string; email: string; telefono: string;
  estado: string; cuenta_envio: string; asunto: string; nota: string; tanda: string;
}
interface EntradaTracker {
  id: string; nombre: string; sector: string; ciudad: string; region: string; web: string; email: string;
  telefono: string; estado: string; cuenta?: string | null; asunto: string; cuerpo: string; gancho: string;
  problemas: string[]; prioridad: 'alta' | 'media' | 'baja'; nota?: string; cambiado: string; seguimiento?: string;
}
interface FilaCliente {
  cliente: string; sector: string; ciudad: string; contacto: string; etapa: string; servicio: string;
  valor_eur: string; responsable: string; proxima_accion: string; nota: string;
}

export type Decision =
  | 'contactado' | 'respondio' | 'no_contactar' | 'rebote' | 'perdido_revisar' | 'preparado' | 'pipeline';

export interface LeadSeed {
  seedId: string;
  nombre: string;
  sector: string;
  ciudad: string;
  provincia: string;
  provinciaOriginal: string;
  web: string;
  email: string;
  dominio: string | null;
  telefono: string;
  cuenta: string | null;
  asunto: string;
  cuerpo: string | null;
  gancho: string;
  problemas: string[];
  prioridad: 'alta' | 'media' | 'baja' | null;
  nota: string;
  tanda: string;
  fecha: string | null;
  seguimiento: string | null;
  etapa: Etapa;
  decision: Decision;
  noContactar: boolean;
  rebote: boolean;
  motivo: string;
  pipeline?: FilaCliente;
}

const RE_NO = /no volver a escribir|no insistir|contest(?:ó|aron)\s*(?:el \d+ oct\s*)?[:"“«]?\s*["“«]?no\b|no (?:est[aá]n? )?interesad|no le interesa|no les interesa|"no, gracias"/i;
const RE_REBOTE = /rebot|no existe|ya no recibe correo/i;

const ETAPA_PIPELINE: Record<string, Etapa> = {
  ganado: 'ganado',
  'propuesta enviada': 'propuesta_enviada',
  negociación: 'negociacion',
  'maqueta enviada': 'maqueta_enviada',
  'reunión acordada': 'reunion',
};

const claveNombre = (s: string) =>
  s.normalize('NFD').replace(/\p{Diacritic}/gu, '').toLowerCase().replace(/[^a-z0-9]+/g, ' ').trim();

export function clasificar(estado: string, nota: string): { decision: Decision; etapa: Etapa; motivo: string } {
  if (RE_NO.test(nota)) return { decision: 'no_contactar', etapa: 'perdido', motivo: 'Contestó que no' };
  if (RE_REBOTE.test(nota)) return { decision: 'rebote', etapa: 'perdido', motivo: 'Rebote del email' };
  if (estado === 'enviado') return { decision: 'contactado', etapa: 'contactado', motivo: '' };
  if (estado === 'respondido') return { decision: 'respondio', etapa: 'respondio', motivo: '' };
  if (estado.startsWith('preparado')) return { decision: 'preparado', etapa: 'lead', motivo: 'Preparado sin enviar' };
  return { decision: 'perdido_revisar', etapa: 'perdido', motivo: nota || 'Descartado' };
}

export function construirSeed() {
  const csv = leerCsv<FilaCsv>(readFileSync(join(DATOS, 'leads-cold-email.csv'), 'utf8'));
  const tracker = JSON.parse(readFileSync(join(DATOS, 'tracker-leads-2026-10-13.json'), 'utf8')) as EntradaTracker[];
  const clientes = leerCsv<FilaCliente>(readFileSync(join(DATOS, 'clientes.csv'), 'utf8'));
  const porEmail = new Map(tracker.map((t) => [normalizarEmail(t.email), t]));

  const leads: LeadSeed[] = csv.map((f, i) => {
    const email = normalizarEmail(f.email) ?? f.email.trim().toLowerCase();
    const t = porEmail.get(email);
    const nota = (t?.nota ?? f.nota ?? '').trim();
    const c = clasificar(f.estado, nota);
    const cuenta = normalizarEmail(t?.cuenta ?? f.cuenta_envio) ?? null;
    return {
      seedId: t?.id ?? `csv-${i + 1}`,
      nombre: f.nombre.trim(),
      sector: f.sector.trim(),
      ciudad: f.ciudad.trim(),
      provincia: normalizarProvincia(f.provincia) ?? f.provincia,
      provinciaOriginal: f.provincia,
      web: f.web.trim(),
      email,
      dominio: dominioDelLead({ email, web: f.web }),
      telefono: f.telefono.trim(),
      cuenta,
      asunto: (t?.asunto ?? f.asunto).trim(),
      cuerpo: t?.cuerpo ?? null,
      gancho: t?.gancho ?? '',
      problemas: t?.problemas ?? [],
      prioridad: t?.prioridad ?? null,
      nota,
      tanda: f.tanda,
      fecha: t?.cambiado ? t.cambiado.slice(0, 10) : null,
      seguimiento: t?.seguimiento ?? null,
      etapa: c.etapa,
      decision: c.decision,
      noContactar: c.decision === 'no_contactar',
      rebote: c.decision === 'rebote',
      motivo: c.motivo,
    };
  });

  // Pipeline de clientes.csv: se fusiona por nombre con el lead correspondiente.
  const sinLead: FilaCliente[] = [];
  for (const cl of clientes) {
    const k = claveNombre(cl.cliente.split('/')[0]!);
    const lead = leads.find((l) => {
      const ln = claveNombre(l.nombre);
      return ln.includes(k) || k.includes(ln) || (k.length > 6 && ln.includes(k.split(' ').slice(-2).join(' ')));
    });
    if (!lead) {
      sinLead.push(cl);
      continue;
    }
    lead.pipeline = cl;
    const etapa = ETAPA_PIPELINE[cl.etapa.trim().toLowerCase()];
    if (etapa && !lead.noContactar) {
      lead.etapa = etapa;
      lead.decision = 'pipeline';
    }
  }

  // Comprobaciones: territorio, duplicados de email y de dominio dentro del propio seed.
  const provinciasDesconocidas = leads.filter((l) => !provincia(l.provincia));
  const provinciasAjenas = leads.filter((l) => provincia(l.provincia) && provincia(l.provincia)!.dueno !== 'guzman');
  const vistosEmail = new Map<string, LeadSeed>();
  const vistosDominio = new Map<string, LeadSeed>();
  const duplicadosEmail: [LeadSeed, LeadSeed][] = [];
  const duplicadosDominio: [LeadSeed, LeadSeed][] = [];
  for (const l of leads) {
    const e = vistosEmail.get(l.email);
    if (e) duplicadosEmail.push([e, l]);
    else vistosEmail.set(l.email, l);
    if (l.dominio) {
      const d = vistosDominio.get(l.dominio);
      if (d) duplicadosDominio.push([d, l]);
      else vistosDominio.set(l.dominio, l);
    }
  }
  return { leads, sinLead, provinciasDesconocidas, provinciasAjenas, duplicadosEmail, duplicadosDominio };
}

// ---------------------------------------------------------------------------
// SQL
// ---------------------------------------------------------------------------
const q = (v: string | null | undefined) => (v === null || v === undefined ? 'null' : `'${v.replace(/'/g, "''")}'`);

export function generarSql(s: ReturnType<typeof construirSeed>): string {
  const dominiosRepetidos = new Set(s.duplicadosDominio.map(([, b]) => b.seedId));
  const out: string[] = [
    '-- Seed de Hunter (volcado del 13-oct-2026). Generado por workers/hunter/src/seed/importar.ts. No editar a mano.',
    '-- Idempotente: no hace nada si el seed ya está importado.',
    'begin;',
    "do $$ begin if exists (select 1 from hunter.leads where origen = 'seed') then raise exception 'SEED_YA_IMPORTADO'; end if; end $$;",
  ];
  for (const l of s.leads) {
    const p = l.pipeline;
    const notas = [l.nota, p?.nota].filter(Boolean).join(' · ');
    const valor = p?.valor_eur ? Number(p.valor_eur) : null;
    const pricing = p ? (/comisi/i.test(p.servicio) ? "'fijo_comision'" : valor ? "'fijo'" : 'null') : 'null';
    out.push(
      `with c as (insert into public.clients (name, sector, city, province, website, email, phone, contact_name, stage, service, value_eur, pricing, next_action, notes, do_not_contact, do_not_contact_reason, email_bounced, lost_reason, source, send_account, email_subject, batch)
  values (${q(l.nombre)}, ${q(l.sector)}, ${q(l.ciudad)}, ${q(l.provincia)}, ${q(l.web)}, ${q(l.email)}, ${q(l.telefono)}, ${q(p?.contacto ?? '')}, '${l.etapa}', ${q(p?.servicio ?? '')}, ${valor ?? 'null'}, ${pricing}, ${q(p?.proxima_accion ?? '')}, ${q(notas)}, ${l.noContactar}, ${q(l.noContactar ? l.nota : '')}, ${l.rebote}, ${q(l.decision === 'perdido_revisar' || l.rebote ? l.nota : '')}, 'seed-2026-10-13', ${q(l.cuenta ?? '')}, ${q(l.asunto)}, ${q(l.tanda)})
  returning id),
l as (insert into hunter.leads (client_id, email, dominio, email_fuente_url, provincia, socio, cuenta_email, gancho, prioridad, sin_hilo, origen, seed_id, primer_envio_at)
  select id, ${q(l.email)}, ${dominiosRepetidos.has(l.seedId) ? 'null' : q(l.dominio)}, ${q(l.web)}, ${q(l.provincia)}, 'guzman', ${q(l.cuenta)}, ${q(l.gancho)}, ${l.prioridad ? q(l.prioridad) : 'null'}, false, 'seed', ${q(l.seedId)}, ${l.fecha && l.decision !== 'preparado' ? q(`${l.fecha}T09:00:00+02:00`) : 'null'} from c returning client_id)
insert into public.client_events (client_id, type, body, occurred_at)
  select client_id, 'importacion', ${q(
    [
      `Importado del tracker (${l.decision}).`,
      l.asunto ? `Asunto: ${l.asunto}` : '',
      l.problemas.length ? `Fallos: ${l.problemas.join(' | ')}` : '',
      l.cuerpo ? `\n${l.cuerpo}` : '',
      l.seguimiento ? `\nSeguimiento: ${l.seguimiento}` : '',
    ]
      .filter(Boolean)
      .join('\n'),
  )}, ${l.fecha ? q(`${l.fecha}T09:00:00+02:00`) : 'now()'} from l;`,
    );
  }
  for (const cl of s.sinLead) {
    out.push(
      `insert into public.clients (name, sector, city, contact_name, stage, service, value_eur, next_action, notes, source)
  values (${q(cl.cliente)}, ${q(cl.sector)}, ${q(cl.ciudad)}, ${q(cl.contacto)}, '${ETAPA_PIPELINE[cl.etapa.trim().toLowerCase()] ?? 'lead'}', ${q(cl.servicio)}, ${cl.valor_eur ? Number(cl.valor_eur) : 'null'}, ${q(cl.proxima_accion)}, ${q(cl.nota)}, 'clientes-csv-2026-10-13');`,
    );
  }
  out.push('commit;');
  return `${out.join('\n')}\n`;
}

// ---------------------------------------------------------------------------
// Informe
// ---------------------------------------------------------------------------
export function generarInforme(s: ReturnType<typeof construirSeed>): string {
  const cuenta = <T>(xs: T[], f: (x: T) => string) =>
    [...xs.reduce((m, x) => m.set(f(x), (m.get(f(x)) ?? 0) + 1), new Map<string, number>())].sort((a, b) => b[1] - a[1]);
  const lista = (xs: LeadSeed[], f: (l: LeadSeed) => string) => xs.map((l) => `- ${f(l)}`).join('\n') || '- (ninguno)';
  const de = (d: Decision) => s.leads.filter((l) => l.decision === d);
  const sinCuenta = s.leads.filter((l) => !l.cuenta && l.decision !== 'preparado');

  return `# Informe de importación del seed (en seco)

> Generado por \`pnpm seed:informe\`. **No se ha escrito nada en la base de datos.** El SQL está en \`supabase/seed/seed_hunter.sql\` y se aplica cuando des el OK.

## Resumen

| | |
|---|---:|
| Leads en el CSV | ${s.leads.length} |
| Con correo y cuerpo en el tracker | ${s.leads.filter((l) => l.cuerpo).length} |
| Etapa resultante | ${cuenta(s.leads, (l) => l.etapa).map(([k, n]) => `${k} ${n}`).join(' · ')} |
| **No contactar** (email y dominio a la lista de supresión) | ${de('no_contactar').length} |
| Rebotes (Perdido, email rebotado, se queda el teléfono) | ${de('rebote').length} |
| Perdidos sin «no» explícito (revisar) | ${de('perdido_revisar').length} |
| Preparados sin enviar (se reauditan antes de la mesa) | ${de('preparado').length} |
| Contactados sin cuenta registrada (la bandeja buscará su hilo) | ${sinCuenta.length} |
| Fusionados con \`clientes.csv\` | ${s.leads.filter((l) => l.pipeline).length} |
| Clientes de \`clientes.csv\` sin lead (se crean solo en el ERP) | ${s.sinLead.length} |

Por cuenta: ${cuenta(s.leads, (l) => l.cuenta ?? 'sin cuenta').map(([k, n]) => `${k} ${n}`).join(' · ')}

## Pasan a «No contactar» (irreversible)

${lista(de('no_contactar'), (l) => `**${l.nombre}** (${l.provincia}) · ${l.email} — ${l.nota}`)}

## Rebotes

${lista(de('rebote'), (l) => `**${l.nombre}** · ${l.email} · tel. ${l.telefono || '—'} — ${l.nota}`)}

## Perdidos sin «no» explícito: revísalos

Quedan en **Perdido**, pero **no** en No contactar (por ejemplo, jubilaciones, traspasos o cierres). Si alguno debe ir a No contactar, dímelo antes de aplicar.

${lista(de('perdido_revisar'), (l) => `**${l.nombre}** · ${l.email} — ${l.nota}`)}

## Respondieron (siguen en «Respondió»)

${lista(de('respondio'), (l) => `**${l.nombre}** · ${l.email} — ${l.nota}`)}

## Pipeline fusionado desde clientes.csv

${lista(s.leads.filter((l) => l.pipeline), (l) => `**${l.nombre}** → ${l.etapa}${l.pipeline?.valor_eur ? ` · ${l.pipeline.valor_eur} €` : ''} · ${l.pipeline?.servicio}`)}

${s.sinLead.length ? `Sin lead de cold email (solo ERP): ${s.sinLead.map((c) => `**${c.cliente}** (${c.etapa})`).join(', ')}` : ''}

## Comprobaciones

- Provincias desconocidas: ${s.provinciasDesconocidas.length ? s.provinciasDesconocidas.map((l) => `${l.nombre} (${l.provinciaOriginal})`).join(', ') : 'ninguna'}
- Provincias de Hugo: ${s.provinciasAjenas.length ? s.provinciasAjenas.map((l) => `${l.nombre} (${l.provincia})`).join(', ') : 'ninguna'}
- Provincias renombradas: ${[...new Set(s.leads.filter((l) => l.provincia !== l.provinciaOriginal).map((l) => `${l.provinciaOriginal} → ${l.provincia}`))].join(', ') || 'ninguna'}
- Emails duplicados: ${s.duplicadosEmail.length ? s.duplicadosEmail.map(([a, b]) => `${a.nombre} / ${b.nombre} (${a.email})`).join('; ') : 'ninguno'}
- Dominios duplicados: ${s.duplicadosDominio.length ? s.duplicadosDominio.map(([a, b]) => `${a.nombre} / ${b.nombre} (${a.dominio})`).join('; ') + ' — el segundo se importa sin dominio para no romper el índice único; ningún correo nuevo saldrá a ese dominio.' : 'ninguno'}

## Contactados sin cuenta registrada

${sinCuenta.length} leads. La bandeja buscará su hilo en las dos cuentas por el destinatario. Si no aparece, el lead queda «sin hilo» y no recibe seguimiento.

## Notas

- **URL de origen del email:** el seed no guarda la página exacta donde salía cada email, así que se usa la web del negocio. Los leads nuevos de Hunter guardarán la URL exacta.
- Cada lead lleva un evento de importación con su asunto, sus fallos y el cuerpo enviado. Son los ejemplos de estilo de Hunter.
`;
}

if (process.argv.includes('--informe')) {
  const s = construirSeed();
  writeFileSync(join(DATOS, 'informe-importacion.md'), generarInforme(s));
  mkdirSync(join(RAIZ, 'supabase/seed'), { recursive: true });
  writeFileSync(join(RAIZ, 'supabase/seed/seed_hunter.sql'), generarSql(s));
  console.log(`Informe: datos-iniciales/informe-importacion.md · SQL: supabase/seed/seed_hunter.sql (${s.leads.length} leads)`);
}
