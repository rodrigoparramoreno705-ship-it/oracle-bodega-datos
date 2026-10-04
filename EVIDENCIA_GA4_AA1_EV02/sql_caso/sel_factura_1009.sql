SELECT numero_factura, fecha_vencimiento, valor_total, valor_pagado,
       valor_total - valor_pagado AS saldo
  FROM facturas
 WHERE numero_factura = 1009;
