-- =====================================================================
-- Evidencia GA4-210602033-AA1-EV02 - Caso de estudio TECH TRANSITION
-- Script 05: verificacion de la instalacion y del esquema
-- Ejecutar conectado como SYSTEM a FREEPDB1 (requiere vistas DBA_ y V$)
-- =====================================================================
set echo on
set feedback on
set linesize 200
set pagesize 100
column banner_full format a85
column instance_name format a10
column host_name format a14
column table_name format a16
column constraint_name format a26
column tipo format a12
column columnas format a32
column tabla_referenciada format a16
column search_condition_vc format a60
column username format a16
column machine format a14
column program format a32
column index_name format a22

-- V1. Version de Oracle
select banner_full from v$version;

-- V2. Estado de la instancia y del servicio (base de datos conectable)
select instance_name, version_full, status, database_status,
       to_char(startup_time, 'YYYY-MM-DD HH24:MI:SS') as inicio
  from v$instance;
select name as pdb, open_mode from v$pdbs where name = 'FREEPDB1';
select name as servicio, network_name from v$active_services where con_id = 3;

-- V3. Conexiones (sesiones de usuario abiertas en este momento)
select username, status, machine, program
  from v$session
 where username in ('SYSTEM', 'TECH_TRANSITION')
 order by username;

-- V4. Cantidad de tablas creadas en el esquema TECH_TRANSITION
select count(*) as cantidad_tablas from dba_tables where owner = 'TECH_TRANSITION';
select table_name from dba_tables where owner = 'TECH_TRANSITION' order by table_name;

-- V5. Cantidad de registros por tabla (conteo exacto)
select 'CLIENTES' as tabla, count(*) as registros from tech_transition.clientes
union all select 'SUCURSALES',      count(*) from tech_transition.sucursales
union all select 'FORMAS_PAGO',     count(*) from tech_transition.formas_pago
union all select 'ARTICULOS',       count(*) from tech_transition.articulos
union all select 'FACTURAS',        count(*) from tech_transition.facturas
union all select 'DETALLE_FACTURA', count(*) from tech_transition.detalle_factura;

-- V6. Claves primarias
select c.table_name, c.constraint_name,
       listagg(cc.column_name, ', ') within group (order by cc.position) as columnas
  from dba_constraints c
  join dba_cons_columns cc on cc.owner = c.owner and cc.constraint_name = c.constraint_name
 where c.owner = 'TECH_TRANSITION' and c.constraint_type = 'P'
 group by c.table_name, c.constraint_name
 order by c.table_name;

-- V7. Claves foraneas y tabla referenciada
select c.table_name, c.constraint_name,
       listagg(cc.column_name, ', ') within group (order by cc.position) as columnas,
       r.table_name as tabla_referenciada, c.delete_rule
  from dba_constraints c
  join dba_cons_columns cc on cc.owner = c.owner and cc.constraint_name = c.constraint_name
  join dba_constraints r on r.owner = c.r_owner and r.constraint_name = c.r_constraint_name
 where c.owner = 'TECH_TRANSITION' and c.constraint_type = 'R'
 group by c.table_name, c.constraint_name, r.table_name, c.delete_rule
 order by c.table_name, c.constraint_name;

-- V8. Resumen de restricciones por tipo (P=PK, R=FK, U=UNIQUE, C=CHECK/NOT NULL)
select table_name,
       sum(case when constraint_type = 'P' then 1 else 0 end) as pk,
       sum(case when constraint_type = 'R' then 1 else 0 end) as fk,
       sum(case when constraint_type = 'U' then 1 else 0 end) as uniq,
       sum(case when constraint_type = 'C' and search_condition_vc not like '%IS NOT NULL' then 1 else 0 end) as checks,
       sum(case when constraint_type = 'C' and search_condition_vc like '%IS NOT NULL' then 1 else 0 end) as not_null,
       count(*) as total
  from dba_constraints
 where owner = 'TECH_TRANSITION'
 group by rollup(table_name)
 order by table_name;

-- V9. Restricciones CHECK de negocio (sin las NOT NULL)
select table_name, constraint_name, search_condition_vc, status
  from dba_constraints
 where owner = 'TECH_TRANSITION' and constraint_type = 'C'
   and search_condition_vc not like '%IS NOT NULL'
 order by table_name, constraint_name;

-- V10. Indices del esquema
select table_name, index_name, uniqueness
  from dba_indexes
 where owner = 'TECH_TRANSITION'
 order by table_name, index_name;

-- V11. Consistencia: valor_total de cada factura = suma de su detalle
select count(*) as facturas_inconsistentes
  from tech_transition.facturas f
 where f.valor_total <> (select nvl(sum(d.subtotal), 0)
                           from tech_transition.detalle_factura d
                          where d.numero_factura = f.numero_factura);

-- =====================================================================
-- V12. Pruebas de integridad: cada sentencia DEBE ser rechazada por Oracle
-- =====================================================================
whenever sqlerror continue

-- a) Clave primaria duplicada (se espera ORA-00001)
insert into tech_transition.clientes (id_cliente, tipo_documento, numero_documento, nombre_cliente, ciudad)
values (1, 'CC', '1999999999', 'Cliente de prueba duplicado', 'Bogota');

-- b) Factura con cliente inexistente (se espera ORA-02291)
insert into tech_transition.facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
values (9999, date '2026-10-01', date '2026-10-01', 999, 1, 1);

-- c) Borrar un cliente que tiene facturas (se espera ORA-02292)
delete from tech_transition.clientes where id_cliente = 1;

-- d) Cantidad negativa en el detalle (se espera ORA-02290)
insert into tech_transition.detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario)
values (1001, 99, 2, -3, 4500000);

-- e) Fecha de vencimiento anterior a la fecha de factura (se espera ORA-02290)
insert into tech_transition.facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
values (9998, date '2026-10-01', date '2026-09-01', 1, 1, 1);

-- f) Valor pagado mayor que el valor total (se espera ORA-02290)
update tech_transition.facturas set valor_pagado = valor_total + 1 where numero_factura = 1001;

-- g) Campo obligatorio vacio (se espera ORA-01400)
insert into tech_transition.articulos (id_articulo, codigo_articulo, nombre_articulo, categoria, precio_unitario)
values (99, 'TT-PRB-099', null, 'Pruebas', 1000);

rollback;

-- Comprobacion final: los conteos no cambiaron despues de las pruebas
select (select count(*) from tech_transition.clientes) as clientes,
       (select count(*) from tech_transition.facturas) as facturas,
       (select count(*) from tech_transition.detalle_factura) as detalles
  from dual;
exit
