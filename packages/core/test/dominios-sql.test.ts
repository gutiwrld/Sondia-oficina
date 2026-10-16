import { readFileSync } from 'node:fs';
import { fileURLToPath } from 'node:url';
import { describe, expect, it } from 'vitest';
import { HOSTS_COMPARTIDOS, PLATAFORMAS_SIN_DOMINIO } from '../src';

// Las barreras de la base de datos y las del worker deben normalizar igual.
describe('dominios: core y migración coinciden', () => {
  const sql = readFileSync(
    fileURLToPath(new URL('../../../supabase/migrations/20261016120000_oficina_agentes.sql', import.meta.url)),
    'utf8',
  );
  const lista = (fn: string) => {
    const bloque = sql.slice(sql.indexOf(`function agents.${fn}()`));
    const desde = bloque.slice(bloque.indexOf('array['));
    const arr = desde.slice(0, desde.indexOf(']'));
    return [...arr.matchAll(/'([^']+)'/g)].map((m) => m[1]);
  };
  it('hosts compartidos', () => expect(lista('hosts_compartidos')).toEqual([...HOSTS_COMPARTIDOS]));
  it('plataformas sin dominio', () => expect(lista('plataformas_sin_dominio')).toEqual([...PLATAFORMAS_SIN_DOMINIO]));
});
