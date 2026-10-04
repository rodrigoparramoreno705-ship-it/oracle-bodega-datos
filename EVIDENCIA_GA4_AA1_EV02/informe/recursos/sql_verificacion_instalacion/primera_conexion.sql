set echo on linesize 160 pagesize 50
show user
show con_name
column servicio format a10
column bd format a10
select sys_context('USERENV','SERVICE_NAME') servicio, sys_context('USERENV','DB_NAME') bd, to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') fecha_servidor from dual;
select 'Conexion exitosa a Oracle' as mensaje from dual;
exit
