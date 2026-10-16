#!/usr/bin/env bash
# Prueba las migraciones contra un Postgres local limpio (sin Docker ni Supabase CLI):
# crea una base de datos temporal, monta el entorno de Supabase + ERP, aplica las migraciones y pasa los tests.
# Uso: pnpm test:db   (variables opcionales: PGHOST, PGPORT, PGUSER)
set -euo pipefail
cd "$(dirname "$0")/.."

DB="oficina_test_$$"
export PGHOST="${PGHOST:-/var/run/postgresql}" PGUSER="${PGUSER:-postgres}"
PSQL=(psql -X -q -v ON_ERROR_STOP=1 -d "$DB")

cleanup() { dropdb --if-exists "$DB" >/dev/null 2>&1 || true; }
trap cleanup EXIT

createdb "$DB"
"${PSQL[@]}" -f tests/00_entorno_supabase_erp.sql
for f in migrations/*.sql; do
  echo "· migración $(basename "$f")"
  "${PSQL[@]}" -f "$f"
done
echo "· tests"
"${PSQL[@]}" -f tests/10_reglas_de_oro.sql 2>&1 | sed -n 's/^.*NOTICE:  ok/  ok/p; /ERROR/p; /FALLO/p'
