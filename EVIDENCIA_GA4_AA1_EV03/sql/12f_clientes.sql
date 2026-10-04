-- CONSULTA 6: comportamiento de los clientes (los 10 que mas compran)
SELECT c.nombre_cliente, c.sexo, c.ciudad,
       COUNT(DISTINCT f.numero_factura) AS compras,
       SUM(f.valor_total)               AS valor_comprado,
       ROUND(SUM(f.valor_total) / COUNT(DISTINCT f.numero_factura)) AS ticket_promedio
  FROM fact_ventas f
  JOIN dim_cliente c ON c.id_cliente = f.id_cliente
 GROUP BY c.nombre_cliente, c.sexo, c.ciudad
 ORDER BY valor_comprado DESC
 FETCH FIRST 10 ROWS ONLY;
