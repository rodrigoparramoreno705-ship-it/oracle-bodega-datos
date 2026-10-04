-- Datos en staging ANTES de limpiar (los corchetes hacen visibles los espacios sobrantes)
SELECT numero_factura, fecha_factura,
       '[' || codigo_cliente || ']' AS codigo_cliente,
       '[' || nombre_cliente || ']' AS nombre_cliente,
       sexo, '[' || ciudad_cliente || ']' AS ciudad_cliente,
       codigo_producto, forma_pago, cantidad, precio_unitario
  FROM stg_ventas;
