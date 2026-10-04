SELECT a.codigo_articulo, a.nombre_articulo,
       SUM(d.cantidad)                  AS unidades_vendidas,
       COUNT(DISTINCT d.numero_factura) AS facturas,
       SUM(d.subtotal)                  AS ventas
  FROM detalle_factura d
  JOIN articulos a ON a.id_articulo = d.id_articulo
 GROUP BY a.codigo_articulo, a.nombre_articulo
 ORDER BY unidades_vendidas DESC, ventas DESC
 FETCH FIRST 10 ROWS ONLY;
