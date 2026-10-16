import { readFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { describe, expect, it } from 'vitest';
import { TERRITORIO } from '../src';

// El territorio vive en dos sitios (core y la semilla SQL): este test impide que se desincronicen.
describe('territorio: core y migración coinciden', () => {
  it('mismas provincias, mismo dueño y mismo rastreo', () => {
    const sql = readFileSync(
      fileURLToPath(new URL('../../../supabase/migrations/20261016120300_semilla_oficina.sql', import.meta.url)),
      'utf8',
    );
    const enSql = [...sql.matchAll(/\('([^']+)', '(guzman|hugo|dani)', (true|false)\)/g)]
      .map((m) => ({ nombre: m[1], dueno: m[2], rastreo: m[3] === 'true' }))
      .sort((a, b) => a.nombre!.localeCompare(b.nombre!));
    const enCore = [...TERRITORIO].sort((a, b) => a.nombre.localeCompare(b.nombre));
    expect(enSql).toEqual(enCore);
    expect(enCore).toHaveLength(50);
  });
});
