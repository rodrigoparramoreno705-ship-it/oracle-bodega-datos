SELECT f.numero_factura, f.fecha_factura, f.fecha_vencimiento, c.nombre_cliente,
       s.nombre_sucursal, fp.descripcion AS forma_pago, f.valor_total, f.valor_pagado
  FROM facturas f
  JOIN clientes c     ON c.id_cliente = f.id_cliente
  JOIN sucursales s   ON s.id_sucursal = f.id_sucursal
  JOIN formas_pago fp ON fp.id_forma_pago = f.id_forma_pago
 ORDER BY f.numero_factura;
