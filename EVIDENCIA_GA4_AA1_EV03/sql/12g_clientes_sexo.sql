-- CONSULTA 6b: ventas por sexo del cliente
SELECT DECODE(c.sexo, 'F', 'Femenino', 'M', 'Masculino') AS sexo,
       COUNT(DISTINCT c.id_cliente)     AS clientes,
       COUNT(DISTINCT f.numero_factura) AS compras,
       SUM(f.valor_total)               AS ventas,
       ROUND(100 * SUM(f.valor_total) / SUM(SUM(f.valor_total)) OVER (), 1) AS participacion_pct
  FROM fact_ventas f
  JOIN dim_cliente c ON c.id_cliente = f.id_cliente
 GROUP BY c.sexo
 ORDER BY ventas DESC;
