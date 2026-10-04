SELECT COUNT(*)                        AS facturas,
       SUM(valor_total)                AS total_facturado,
       SUM(valor_pagado)               AS total_pagado,
       SUM(valor_total - valor_pagado) AS saldo_pendiente,
       ROUND(100 * SUM(valor_pagado) / SUM(valor_total), 2) AS porcentaje_recaudo
  FROM facturas;
