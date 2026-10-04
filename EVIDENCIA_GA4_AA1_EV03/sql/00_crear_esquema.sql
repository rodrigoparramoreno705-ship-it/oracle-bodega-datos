-- Bodega de datos Spring Valley: creacion del esquema de trabajo (ejecutar como SYSTEM en FREEPDB1)
set echo on
drop user if exists spring_valley cascade;
create user spring_valley identified by "SpringV2026"
  default tablespace users temporary tablespace temp quota 500m on users;
grant create session, create table, create view, create sequence to spring_valley;
select username, account_status, default_tablespace from dba_users where username = 'SPRING_VALLEY';
exit
