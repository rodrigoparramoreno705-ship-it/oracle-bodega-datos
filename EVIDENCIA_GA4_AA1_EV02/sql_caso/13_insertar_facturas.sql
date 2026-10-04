-- Insercion de registros en FACTURAS (datos ficticios con fines academicos)
-- valor_total y valor_pagado inician en 0; se calculan despues a partir del detalle
INSERT INTO facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  VALUES (1001, date '2026-07-02', date '2026-08-01', 1, 1, 5);

INSERT INTO facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  VALUES (1002, date '2026-07-04', date '2026-07-04', 2, 1, 3);

INSERT INTO facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  VALUES (1003, date '2026-07-08', date '2026-09-06', 3, 2, 6);

INSERT INTO facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  VALUES (1004, date '2026-07-11', date '2026-07-11', 4, 2, 1);

INSERT INTO facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  VALUES (1005, date '2026-07-15', date '2026-07-15', 5, 3, 4);

INSERT INTO facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  VALUES (1006, date '2026-07-19', date '2026-07-19', 6, 3, 2);

INSERT INTO facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  VALUES (1007, date '2026-07-23', date '2026-08-22', 7, 1, 5);

INSERT INTO facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  VALUES (1008, date '2026-07-28', date '2026-07-28', 8, 2, 3);

INSERT INTO facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  VALUES (1009, date '2026-08-03', date '2026-09-02', 9, 3, 5);

INSERT INTO facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  VALUES (1010, date '2026-08-06', date '2026-08-06', 10, 1, 2);

INSERT INTO facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  VALUES (1011, date '2026-08-10', date '2026-10-09', 1, 1, 6);

INSERT INTO facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  VALUES (1012, date '2026-08-14', date '2026-08-14', 3, 2, 4);

INSERT INTO facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  VALUES (1013, date '2026-08-19', date '2026-08-19', 5, 3, 1);

INSERT INTO facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  VALUES (1014, date '2026-08-24', date '2026-09-23', 7, 1, 5);

INSERT INTO facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  VALUES (1015, date '2026-08-29', date '2026-08-29', 2, 1, 3);

INSERT INTO facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  VALUES (1016, date '2026-09-03', date '2026-11-02', 9, 3, 6);

INSERT INTO facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  VALUES (1017, date '2026-09-08', date '2026-09-08', 4, 2, 2);

INSERT INTO facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  VALUES (1018, date '2026-09-14', date '2026-10-14', 3, 2, 5);

INSERT INTO facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  VALUES (1019, date '2026-09-21', date '2026-09-21', 6, 3, 4);

INSERT INTO facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  VALUES (1020, date '2026-09-28', date '2026-10-28', 1, 1, 5);

COMMIT;
