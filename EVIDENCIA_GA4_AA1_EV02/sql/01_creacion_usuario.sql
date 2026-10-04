-- =====================================================================
-- Evidencia GA4-210602033-AA1-EV02 - Caso de estudio TECH TRANSITION
-- Script 01: creacion del usuario/esquema TECH_TRANSITION
-- Ejecutar conectado como SYSTEM a la base de datos conectable FREEPDB1
--   sql system/<clave>@//localhost:1521/FREEPDB1 @01_creacion_usuario.sql
-- =====================================================================
set echo on
set feedback on
set linesize 150
set pagesize 50

show user
show con_name

-- Se elimina el esquema si ya existia (permite re-ejecutar la practica)
drop user if exists tech_transition cascade;

-- Creacion del usuario propietario del esquema de facturacion
create user tech_transition identified by "TechT2026"
  default tablespace users
  temporary tablespace temp
  quota 200m on users;

-- Privilegios minimos necesarios para el desarrollo del caso
grant create session  to tech_transition;
grant create table    to tech_transition;
grant create view     to tech_transition;
grant create sequence to tech_transition;
grant create trigger  to tech_transition;

-- Verificacion del usuario creado
column username format a16
column account_status format a14
column default_tablespace format a12
select username, account_status, default_tablespace, created
  from dba_users
 where username = 'TECH_TRANSITION';

column privilege format a20
select grantee, privilege
  from dba_sys_privs
 where grantee = 'TECH_TRANSITION'
 order by privilege;

column tablespace_name format a12
select tablespace_name, max_bytes/1024/1024 as cuota_mb
  from dba_ts_quotas
 where username = 'TECH_TRANSITION';
exit
