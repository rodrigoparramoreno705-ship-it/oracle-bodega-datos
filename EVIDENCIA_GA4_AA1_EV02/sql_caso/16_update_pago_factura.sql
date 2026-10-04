-- UPDATE: se registra el pago del saldo pendiente de la factura vencida 1009
UPDATE facturas
   SET valor_pagado = valor_total
 WHERE numero_factura = 1009;

COMMIT;
