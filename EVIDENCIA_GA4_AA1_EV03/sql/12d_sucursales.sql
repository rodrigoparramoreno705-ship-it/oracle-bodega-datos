-- CONSULTA 4: ventas por sucursal y participacion
SELECT s.nombre_sucursal, s.ciudad,
       COUNT(DISTINCT f.numero_factura) AS facturas,
       SUM(f.valor_total)               AS ventas,
       ROUND(100 * SUM(f.valor_total) / SUM(SUM(f.valor_total)) OVER (), 1) AS participacion_pct,
       ROUND(SUM(f.valor_total) / COUNT(DISTINCT f.numero_factura)) AS ticket_promedio
  FROM fact_ventas f
  JOIN dim_sucursal s ON s.id_sucursal = f.id_sucursal
 GROUP BY s.nombre_sucursal, s.ciudad
 ORDER BY ventas DESC;
