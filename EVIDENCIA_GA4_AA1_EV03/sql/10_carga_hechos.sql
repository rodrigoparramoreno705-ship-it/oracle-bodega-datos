-- CARGA 2: TABLA DE HECHOS DESPUES (cada llave foranea se resuelve con JOIN a su dimension)
INSERT INTO fact_ventas (numero_factura, id_tiempo, id_cliente, id_producto, id_vendedor, id_sucursal,
                         forma_pago, cantidad, precio_unitario, valor_total)
SELECT l.numero_factura, t.id_tiempo, c.id_cliente, p.id_producto, v.id_vendedor, s.id_sucursal,
       l.forma_pago, l.cantidad, l.precio_unitario, l.cantidad * l.precio_unitario
  FROM stg_ventas_limpia l
  JOIN dim_tiempo   t ON t.fecha = l.fecha_factura
  JOIN dim_cliente  c ON c.codigo_cliente = l.codigo_cliente
  JOIN dim_producto p ON p.codigo_producto = l.codigo_producto
  JOIN dim_vendedor v ON v.codigo_vendedor = l.codigo_vendedor
  JOIN dim_sucursal s ON s.codigo_sucursal = l.codigo_sucursal;

COMMIT;
