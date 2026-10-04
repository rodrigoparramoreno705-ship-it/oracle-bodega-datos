-- =====================================================================
-- Evidencia GA4-210602033-AA1-EV02 - Caso de estudio TECH TRANSITION
-- Script 04: consultas de comprobacion
-- Ejecutar conectado como TECH_TRANSITION a FREEPDB1
-- =====================================================================
set echo on
set feedback on
set linesize 200
set pagesize 100
alter session set nls_date_format = 'YYYY-MM-DD';
column nombre_cliente format a42
column nombre_sucursal format a24
column forma_pago format a24
column nombre_articulo format a46
column ciudad format a10
column correo format a38
column tipo_documento heading TIPO format a4
column numero_documento heading DOCUMENTO format a11
column valor_total format 999,999,990
column valor_pagado format 999,999,990
column saldo format 999,999,990
column total_facturado format 9,999,999,990
column total_pagado format 9,999,999,990
column saldo_pendiente format 9,999,999,990
column valor_unitario format 99,999,990
column subtotal format 999,999,990
column ventas format 9,999,999,990
column total_segun_detalle format 9,999,999,990
column diferencia format 9,999,990

-- 1. Todos los clientes
select id_cliente, tipo_documento, numero_documento, nombre_cliente, ciudad, correo
  from clientes
 order by id_cliente;

-- 2. Todas las facturas
select numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal,
       id_forma_pago, valor_total, valor_pagado
  from facturas
 order by numero_factura;

-- 3. Facturas con su cliente (JOIN)
select f.numero_factura, f.fecha_factura, c.nombre_cliente, f.valor_total
  from facturas f
  join clientes c on c.id_cliente = f.id_cliente
 order by f.numero_factura;

-- 4. Facturas por sucursal (JOIN + GROUP BY + COUNT + SUM)
select s.nombre_sucursal, s.ciudad,
       count(*)           as cantidad_facturas,
       sum(f.valor_total) as total_facturado
  from facturas f
  join sucursales s on s.id_sucursal = f.id_sucursal
 group by s.nombre_sucursal, s.ciudad
 order by total_facturado desc;

-- 5. Facturas por forma de pago (LEFT JOIN para incluir formas sin uso)
select fp.descripcion as forma_pago, fp.dias_plazo,
       count(f.numero_factura)      as cantidad_facturas,
       nvl(sum(f.valor_total), 0)   as total_facturado
  from formas_pago fp
  left join facturas f on f.id_forma_pago = fp.id_forma_pago
 group by fp.descripcion, fp.dias_plazo
 order by cantidad_facturas desc, forma_pago;

-- 6. Detalle de las facturas (JOIN de tres tablas)
select d.numero_factura, d.numero_linea, a.codigo_articulo, a.nombre_articulo,
       d.cantidad, d.valor_unitario, d.subtotal
  from detalle_factura d
  join articulos a on a.id_articulo = d.id_articulo
 order by d.numero_factura, d.numero_linea;

-- 7. Total facturado (general y validacion contra el detalle)
-- Correccion: la primera version mezclaba una subconsulta escalar con funciones de
-- agregado y Oracle respondio ORA-00937; ahora cada total se calcula en su subconsulta.
select f.facturas, f.total_facturado, d.total_segun_detalle,
       f.total_facturado - d.total_segun_detalle as diferencia
  from (select count(*) as facturas, sum(valor_total) as total_facturado from facturas) f
 cross join (select sum(subtotal) as total_segun_detalle from detalle_factura) d;

-- 8. Total pagado
select sum(valor_pagado) as total_pagado,
       round(100 * sum(valor_pagado) / sum(valor_total), 2) as porcentaje_recaudo
  from facturas;

-- 9. Saldos pendientes por factura (solo las que tienen saldo)
select f.numero_factura, c.nombre_cliente, f.fecha_vencimiento,
       f.valor_total, f.valor_pagado,
       f.valor_total - f.valor_pagado as saldo,
       case when f.fecha_vencimiento < date '2026-10-04' then 'VENCIDA'
            else 'AL DIA' end as estado_cartera
  from facturas f
  join clientes c on c.id_cliente = f.id_cliente
 where f.valor_total - f.valor_pagado > 0
 order by saldo desc;

-- 9b. Saldo pendiente total por cliente
select c.nombre_cliente,
       sum(f.valor_total - f.valor_pagado) as saldo_pendiente
  from facturas f
  join clientes c on c.id_cliente = f.id_cliente
 group by c.nombre_cliente
having sum(f.valor_total - f.valor_pagado) > 0
 order by saldo_pendiente desc;

-- 10. Articulos mas vendidos (por unidades)
select a.codigo_articulo, a.nombre_articulo,
       sum(d.cantidad)  as unidades_vendidas,
       count(distinct d.numero_factura) as facturas,
       sum(d.subtotal)  as ventas
  from detalle_factura d
  join articulos a on a.id_articulo = d.id_articulo
 group by a.codigo_articulo, a.nombre_articulo
 order by unidades_vendidas desc, ventas desc
 fetch first 10 rows only;
exit
