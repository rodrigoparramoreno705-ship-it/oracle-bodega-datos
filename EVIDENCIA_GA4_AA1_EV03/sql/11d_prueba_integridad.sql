-- VALIDACION 4: prueba controlada de integridad referencial
-- Se intenta registrar una venta para el cliente 9999, que NO existe en DIM_CLIENTE.
INSERT INTO fact_ventas (numero_factura, id_tiempo, id_cliente, id_producto, id_vendedor, id_sucursal,
                         forma_pago, cantidad, precio_unitario, valor_total)
VALUES ('FV-99999', 20250102, 9999, 1, 1, 1, 'Efectivo', 1, 2500, 2500);
