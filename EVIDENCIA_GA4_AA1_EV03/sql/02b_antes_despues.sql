-- Antes y despues de la limpieza de catalogos: cada valor crudo y el valor estandarizado
SELECT 'SEXO' AS campo, '[' || s.sexo || ']' AS valor_crudo, l.sexo AS valor_limpio, COUNT(*) AS filas
  FROM stg_ventas s
  JOIN stg_ventas_limpia l ON l.numero_factura = UPPER(TRIM(s.numero_factura))
                          AND l.codigo_producto = UPPER(TRIM(s.codigo_producto))
 GROUP BY s.sexo, l.sexo
UNION ALL
SELECT 'FORMA_PAGO', '[' || s.forma_pago || ']', l.forma_pago, COUNT(*)
  FROM stg_ventas s
  JOIN stg_ventas_limpia l ON l.numero_factura = UPPER(TRIM(s.numero_factura))
                          AND l.codigo_producto = UPPER(TRIM(s.codigo_producto))
 GROUP BY s.forma_pago, l.forma_pago
 ORDER BY 1 DESC, 3, 2;
