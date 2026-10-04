-- CONSULTA 7: distribucion de las ventas por forma de pago
SELECT f.forma_pago,
       COUNT(DISTINCT f.numero_factura) AS facturas,
       SUM(f.valor_total)               AS ventas,
       ROUND(100 * SUM(f.valor_total) / SUM(SUM(f.valor_total)) OVER (), 1) AS participacion_pct,
       ROUND(SUM(f.valor_total) / COUNT(DISTINCT f.numero_factura)) AS ticket_promedio
  FROM fact_ventas f
 GROUP BY f.forma_pago
 ORDER BY ventas DESC;
