-- VALIDACION 2: duplicados, nulos, catalogos, fechas, claves huerfanas y coherencia de metricas
SELECT 'Lineas duplicadas en FACT_VENTAS' AS control,
       TO_CHAR(COUNT(*)) AS resultado
  FROM (SELECT numero_factura, id_producto FROM fact_ventas GROUP BY numero_factura, id_producto HAVING COUNT(*) > 1)
UNION ALL
SELECT 'Fechas o sexo nulos en staging limpio',
       TO_CHAR(COUNT(*)) FROM stg_ventas_limpia WHERE fecha_factura IS NULL OR sexo IS NULL
UNION ALL
SELECT 'Valores distintos de SEXO', LISTAGG(DISTINCT sexo, ', ') FROM dim_cliente
UNION ALL
SELECT 'Valores distintos de FORMA_PAGO', LISTAGG(DISTINCT forma_pago, ', ') FROM fact_ventas
UNION ALL
SELECT 'Rango de fechas', TO_CHAR(MIN(fecha), 'YYYY-MM-DD') || ' a ' || TO_CHAR(MAX(fecha), 'YYYY-MM-DD') FROM dim_tiempo
UNION ALL
SELECT 'Ventas huerfanas (sin cliente)',
       TO_CHAR(COUNT(*)) FROM fact_ventas f LEFT JOIN dim_cliente c ON c.id_cliente = f.id_cliente WHERE c.id_cliente IS NULL
UNION ALL
SELECT 'Ventas huerfanas (sin producto)',
       TO_CHAR(COUNT(*)) FROM fact_ventas f LEFT JOIN dim_producto p ON p.id_producto = f.id_producto WHERE p.id_producto IS NULL
UNION ALL
SELECT 'Total en staging limpio (cantidad x precio)', TO_CHAR(SUM(cantidad * precio_unitario), 'FM999G999G999') FROM stg_ventas_limpia
UNION ALL
SELECT 'Total en FACT_VENTAS (valor_total)', TO_CHAR(SUM(valor_total), 'FM999G999G999') FROM fact_ventas;
