-- Antes y despues: nombres, ciudades, codigos y fechas
SELECT s.numero_factura, '[' || s.fecha_factura || ']' AS fecha_cruda, l.fecha_factura AS fecha_limpia,
       '[' || s.codigo_cliente || ']' AS codigo_crudo, l.codigo_cliente AS codigo_limpio,
       '[' || s.nombre_cliente || ']' AS nombre_crudo, l.nombre_cliente AS nombre_limpio,
       '[' || s.ciudad_cliente || ']' AS ciudad_cruda, l.ciudad_cliente AS ciudad_limpia
  FROM stg_ventas s
  JOIN stg_ventas_limpia l ON l.numero_factura = UPPER(TRIM(s.numero_factura))
                          AND l.codigo_producto = UPPER(TRIM(s.codigo_producto))
 WHERE s.numero_factura BETWEEN 'FV-10001' AND 'FV-10008'
 ORDER BY s.numero_factura;
