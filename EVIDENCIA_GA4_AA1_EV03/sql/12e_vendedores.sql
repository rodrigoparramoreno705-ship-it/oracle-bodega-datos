-- CONSULTA 5: ranking de vendedores
SELECT RANK() OVER (ORDER BY SUM(f.valor_total) DESC) AS ranking,
       v.nombre_vendedor, s.nombre_sucursal,
       COUNT(DISTINCT f.numero_factura) AS facturas,
       SUM(f.valor_total)               AS ventas,
       ROUND(SUM(f.valor_total) / COUNT(DISTINCT f.numero_factura)) AS ticket_promedio
  FROM fact_ventas f
  JOIN dim_vendedor v ON v.id_vendedor = f.id_vendedor
  JOIN dim_sucursal s ON s.id_sucursal = f.id_sucursal
 GROUP BY v.nombre_vendedor, s.nombre_sucursal
 ORDER BY ranking;
