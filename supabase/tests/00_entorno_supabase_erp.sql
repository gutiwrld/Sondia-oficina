-- Entorno local mínimo para probar las migraciones sin Supabase:
--   · lo que Supabase da hecho (roles, auth.uid(), Vault, publicación de Realtime)
--   · el esquema del ERP que ya existe en el proyecto `sondia-erp` (members, clients, client_events)
-- Las definiciones del ERP están copiadas del proyecto real (16-oct-2026).

create extension if not exists pgcrypto;

do $$ begin
  if not exists (select 1 from pg_roles where rolname = 'anon') then create role anon nologin; end if;
  if not exists (select 1 from pg_roles where rolname = 'authenticated') then create role authenticated nologin; end if;
  if not exists (select 1 from pg_roles where rolname = 'service_role') then create role service_role nologin bypassrls; end if;
end $$;

create schema if not exists auth;
create table if not exists auth.users (id uuid primary key default gen_random_uuid(), email text);
create or replace function auth.uid() returns uuid language sql stable as $$
  select nullif(current_setting('request.jwt.claim.sub', true), '')::uuid
$$;
grant usage on schema auth to anon, authenticated, service_role;
grant execute on function auth.uid() to public;

create schema if not exists vault;
create table if not exists vault.secrets (
  id uuid primary key default gen_random_uuid(),
  name text unique,
  description text default '',
  secret text not null,
  updated_at timestamptz default now()
);
create or replace view vault.decrypted_secrets as select id, name, description, secret as decrypted_secret from vault.secrets;
create or replace function vault.create_secret(new_secret text, new_name text default null, new_description text default '')
returns uuid language sql as $$
  insert into vault.secrets (secret, name, description) values (new_secret, new_name, new_description) returning id
$$;
create or replace function vault.update_secret(secret_id uuid, new_secret text default null, new_name text default null, new_description text default null)
returns void language sql as $$
  update vault.secrets set secret = coalesce(new_secret, secret), name = coalesce(new_name, name),
    description = coalesce(new_description, description), updated_at = now() where id = secret_id
$$;
revoke all on schema vault from public;

do $$ begin
  if not exists (select 1 from pg_publication where pubname = 'supabase_realtime') then
    create publication supabase_realtime;
  end if;
end $$;

-- ===== ERP (copiado del proyecto real) =====
create extension if not exists pg_trgm;

create type public.client_stage as enum ('lead','contactado','respondio','reunion','maqueta_enviada','propuesta_enviada','negociacion','ganado','perdido');
create type public.pricing_model as enum ('fijo','fijo_comision','solo_comision');
create type public.client_event_type as enum ('nota','cambio_etapa','email','llamada','reunion','maqueta','propuesta','cobro','importacion','no_contactar');

create table public.members (
  id uuid primary key default gen_random_uuid(),
  user_id uuid unique references auth.users(id),
  email text not null unique check (email = lower(btrim(email)) and email like '%@%'),
  name text not null,
  short_name text not null,
  initials text not null,
  weekly_hours_goal numeric not null default 25,
  active boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.clients (
  id uuid primary key default gen_random_uuid(),
  name text not null check (char_length(btrim(name)) between 1 and 200),
  sector text not null default '',
  city text not null default '',
  province text not null default '',
  website text not null default '',
  email text not null default '',
  phone text not null default '',
  contact_name text not null default '',
  stage public.client_stage not null default 'lead',
  service text not null default '',
  value_eur numeric check (value_eur is null or value_eur >= 0),
  pricing public.pricing_model,
  next_action text not null default '',
  next_action_date date,
  notes text not null default '',
  do_not_contact boolean not null default false,
  do_not_contact_reason text not null default '',
  do_not_contact_at timestamptz,
  lost_reason text not null default '',
  email_bounced boolean not null default false,
  source text not null default '',
  send_account text not null default '',
  email_subject text not null default '',
  batch text not null default '',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.client_events (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references public.clients(id),
  member_id uuid references public.members(id),
  type public.client_event_type not null,
  body text not null default '',
  from_stage public.client_stage,
  to_stage public.client_stage,
  occurred_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

create or replace function public.is_member() returns boolean language sql stable security definer set search_path to '' as $$
  select exists (select 1 from public.members m where m.user_id = (select auth.uid()) and m.active)
$$;
create or replace function public.current_member_id() returns uuid language sql stable security definer set search_path to '' as $$
  select m.id from public.members m where m.user_id = (select auth.uid()) and m.active
$$;
create or replace function public.set_updated_at() returns trigger language plpgsql as $$
begin new.updated_at := now(); return new; end; $$;

create or replace function public.enforce_client_rules() returns trigger language plpgsql as $$
begin
  if new.do_not_contact then
    if tg_op = 'INSERT' or not old.do_not_contact then
      new.stage := 'perdido';
      new.do_not_contact_at := coalesce(new.do_not_contact_at, now());
    elsif new.stage <> 'perdido' then
      raise exception 'NO_CONTACTAR: % está marcado como «No contactar» y no puede volver a %', new.name, new.stage
        using errcode = 'P0001', hint = 'Quita antes la marca «No contactar» si de verdad hay que reactivarlo.';
    end if;
  elsif tg_op = 'UPDATE' and old.do_not_contact then
    if new.stage <> old.stage then
      raise exception 'NO_CONTACTAR: quita la marca y cambia la etapa en dos pasos' using errcode = 'P0001';
    end if;
    new.do_not_contact_at := null;
  end if;
  return new;
end; $$;

create or replace function public.log_client_changes() returns trigger language plpgsql security definer set search_path to '' as $$
begin
  if new.stage is distinct from old.stage then
    insert into public.client_events (client_id, member_id, type, from_stage, to_stage)
    values (new.id, public.current_member_id(), 'cambio_etapa', old.stage, new.stage);
  end if;
  if new.do_not_contact is distinct from old.do_not_contact then
    insert into public.client_events (client_id, member_id, type, body)
    values (new.id, public.current_member_id(), 'no_contactar',
      case when new.do_not_contact
        then 'Marcado como «No contactar»' || coalesce(nullif(': ' || new.do_not_contact_reason, ': '), '')
        else 'Quitada la marca «No contactar»' end);
  end if;
  return new;
end; $$;

create trigger clients_enforce_rules before insert or update on public.clients for each row execute function public.enforce_client_rules();
create trigger clients_log_changes after update on public.clients for each row execute function public.log_client_changes();
create trigger clients_updated_at before update on public.clients for each row execute function public.set_updated_at();

alter table public.members enable row level security;
alter table public.clients enable row level security;
alter table public.client_events enable row level security;
create policy "solo miembros" on public.members for all to authenticated using ((select public.is_member())) with check ((select public.is_member()));
create policy "solo miembros" on public.clients for all to authenticated using ((select public.is_member())) with check ((select public.is_member()));
create policy "solo miembros" on public.client_events for all to authenticated using ((select public.is_member())) with check ((select public.is_member()));
grant usage on schema public to anon, authenticated, service_role;
grant all on all tables in schema public to authenticated, service_role;

-- Los tres socios, como en el proyecto real.
insert into auth.users (id, email) values
  ('00000000-0000-0000-0000-00000000000a', 'guzman@ejemplo.test'),
  ('00000000-0000-0000-0000-00000000000b', 'dani@ejemplo.test'),
  ('00000000-0000-0000-0000-00000000000c', 'hugo@ejemplo.test'),
  ('00000000-0000-0000-0000-0000000000ff', 'intruso@ejemplo.test');
insert into public.members (user_id, email, name, short_name, initials) values
  ('00000000-0000-0000-0000-00000000000a', 'guzman@ejemplo.test', 'Guzmán González', 'Guzmán', 'G'),
  ('00000000-0000-0000-0000-00000000000b', 'dani@ejemplo.test', 'Daniel', 'Dani', 'D'),
  ('00000000-0000-0000-0000-00000000000c', 'hugo@ejemplo.test', 'Hugo', 'Hugo', 'H');
