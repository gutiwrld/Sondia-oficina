import { readdirSync, readFileSync, statSync } from 'node:fs';
import { join } from 'node:path';
import { fileURLToPath } from 'node:url';
import { describe, expect, it } from 'vitest';
import { HERRAMIENTAS, HERRAMIENTAS_INTEGRADAS_PROHIBIDAS, opcionesAgente } from '../src/herramientas';

const TURNOS = ['rastreo', 'redaccion', 'bandeja', 'seguimiento', 'preparacion', 'parte', 'informe'] as const;
const PARECE_ENVIO = /(enviar|envia|send|outbox|mandar|reply|responder_correo|despachar|publicar)/i;

describe('Hunter no puede enviar', () => {
  it('tiene exactamente sus 8 herramientas, y ninguna envía', () => {
    expect(HERRAMIENTAS.map((h) => h.nombre)).toEqual([
      'buscar_negocios',
      'auditar_web',
      'capturar_web',
      'leer_bandeja',
      'consultar_disponibilidad',
      'crear_borrador',
      'generar_maqueta',
      'escribir_ficha',
    ]);
    for (const h of HERRAMIENTAS) expect(h.nombre).not.toMatch(PARECE_ENVIO);
  });

  it.each(TURNOS)('en el turno «%s» el modelo solo recibe herramientas MCP de Hunter', async (turno) => {
    const o = opcionesAgente(turno);
    for (const t of o.allowedTools) {
      expect(t.startsWith('mcp__hunter__')).toBe(true);
      expect(t).not.toMatch(PARECE_ENVIO);
    }
    expect(o.settingSources).toEqual([]);
    for (const integrada of HERRAMIENTAS_INTEGRADAS_PROHIBIDAS) {
      expect(o.disallowedTools).toContain(integrada);
      expect((await o.canUseTool(integrada)).behavior).toBe('deny');
    }
    expect((await o.canUseTool('mcp__hunter__enviar_correo')).behavior).toBe('deny');
    expect((await o.canUseTool('mcp__gmail__send')).behavior).toBe('deny');
  });

  it('el código del worker del agente no contiene ninguna llamada de envío', () => {
    const raiz = fileURLToPath(new URL('../src', import.meta.url));
    const archivos: string[] = [];
    const recorrer = (dir: string) => {
      for (const f of readdirSync(dir)) {
        const p = join(dir, f);
        if (statSync(p).isDirectory()) recorrer(p);
        else if (/\.(ts|js|mjs)$/.test(f)) archivos.push(p);
      }
    };
    recorrer(raiz);
    const prohibido = /messages\.send|users\.messages\.send|gmail\.send|token_envio|agents\.outbox|from\(['"]outbox['"]\)/;
    for (const a of archivos) expect(readFileSync(a, 'utf8'), a).not.toMatch(prohibido);
  });
});
