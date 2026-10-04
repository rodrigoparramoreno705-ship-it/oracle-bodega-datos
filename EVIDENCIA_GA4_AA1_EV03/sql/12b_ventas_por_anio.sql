-- CONSULTA 2: evolucion de las ventas por año
SELECT t.anio,
       COUNT(DISTINCT f.numero_factura) AS facturas,
       SUM(f.cantidad)                  AS unidades,
       SUM(f.valor_total)               AS ventas,
       ROUND(AVG(f.valor_total))        AS promedio_por_linea,
       ROUND(100 * (SUM(f.valor_total) / LAG(SUM(f.valor_total)) OVER (ORDER BY t.anio) - 1), 1) AS crecimiento_pct
  FROM fact_ventas f
  JOIN dim_tiempo t ON t.id_tiempo = f.id_tiempo
 GROUP BY t.anio
 ORDER BY t.anio;
