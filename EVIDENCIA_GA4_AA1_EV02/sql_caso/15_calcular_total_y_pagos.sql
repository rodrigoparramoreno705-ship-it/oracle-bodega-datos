-- 1) Valor total de cada factura = suma de los subtotales de su detalle
update facturas f
   set valor_total = (select nvl(sum(d.subtotal), 0)
                        from detalle_factura d
                       where d.numero_factura = f.numero_factura);

-- 2) Registro de pagos: contado = pago total; credito = segun estado de cartera
update facturas set valor_pagado = valor_total where numero_factura in (1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1010, 1012, 1013, 1014, 1015, 1017, 1019);
update facturas set valor_pagado = round(valor_total * 0.5, 2) where numero_factura in (1009, 1011, 1018);

COMMIT;
