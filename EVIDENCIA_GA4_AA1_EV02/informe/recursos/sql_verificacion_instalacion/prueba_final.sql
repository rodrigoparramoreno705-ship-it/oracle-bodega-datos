set echo on feedback on linesize 150
select sys_context('USERENV','CON_NAME') as contenedor, user as usuario,
       to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') as fecha from dual;
select (select count(*) from clientes) clientes, (select count(*) from sucursales) sucursales,
       (select count(*) from formas_pago) formas_pago, (select count(*) from articulos) articulos,
       (select count(*) from facturas) facturas, (select count(*) from detalle_factura) detalles
  from dual;
select sum(valor_total) total_facturado, sum(valor_pagado) total_pagado,
       sum(valor_total - valor_pagado) saldo_pendiente from facturas;
exit
