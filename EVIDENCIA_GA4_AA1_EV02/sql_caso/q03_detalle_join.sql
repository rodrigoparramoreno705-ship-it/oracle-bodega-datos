SELECT d.numero_factura, d.numero_linea, a.codigo_articulo, a.nombre_articulo,
       d.cantidad, d.valor_unitario, d.subtotal
  FROM detalle_factura d
  JOIN articulos a ON a.id_articulo = d.id_articulo
 WHERE d.numero_factura IN (1001, 1002, 1003)
 ORDER BY d.numero_factura, d.numero_linea;
