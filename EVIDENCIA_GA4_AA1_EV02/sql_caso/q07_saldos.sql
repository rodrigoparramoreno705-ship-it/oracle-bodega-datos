SELECT f.numero_factura, c.nombre_cliente, f.fecha_vencimiento,
       f.valor_total, f.valor_pagado,
       f.valor_total - f.valor_pagado AS saldo,
       CASE WHEN f.fecha_vencimiento < DATE '2026-10-04' THEN 'VENCIDA' ELSE 'AL DIA' END AS estado
  FROM facturas f
  JOIN clientes c ON c.id_cliente = f.id_cliente
 WHERE f.valor_total - f.valor_pagado > 0
 ORDER BY saldo DESC;
