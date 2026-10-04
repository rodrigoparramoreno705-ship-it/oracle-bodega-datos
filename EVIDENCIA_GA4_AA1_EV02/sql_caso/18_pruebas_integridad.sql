-- Pruebas de integridad: Oracle debe rechazar estas operaciones
-- a) Eliminar un cliente que tiene facturas (clave foranea)
DELETE FROM clientes WHERE id_cliente = 1;

-- b) Factura para un cliente que no existe (clave foranea)
INSERT INTO facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  VALUES (1021, DATE '2026-10-01', DATE '2026-10-01', 999, 1, 1);

-- c) Cantidad negativa en el detalle (restriccion CHECK)
INSERT INTO detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario)
  VALUES (1001, 4, 2, -3, 4500000);
