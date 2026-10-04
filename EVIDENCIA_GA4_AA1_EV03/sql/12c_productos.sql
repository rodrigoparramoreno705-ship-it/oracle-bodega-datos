-- CONSULTA 3: productos con mayores ventas
SELECT p.codigo_producto, p.nombre_producto, p.categoria,
       SUM(f.cantidad)    AS unidades,
       SUM(f.valor_total) AS ventas,
       RANK() OVER (ORDER BY SUM(f.valor_total) DESC) AS posicion
  FROM fact_ventas f
  JOIN dim_producto p ON p.id_producto = f.id_producto
 GROUP BY p.codigo_producto, p.nombre_producto, p.categoria
 ORDER BY ventas DESC;
