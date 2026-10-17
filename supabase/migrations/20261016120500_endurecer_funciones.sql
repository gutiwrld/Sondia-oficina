-- Aviso del linter de Supabase: search_path fijo también en el trigger genérico de updated_at.
alter function agents.set_updated_at() set search_path to '';
