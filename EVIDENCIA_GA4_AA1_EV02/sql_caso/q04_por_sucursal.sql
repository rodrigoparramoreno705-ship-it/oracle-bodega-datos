SELECT s.nombre_sucursal, s.ciudad,
       COUNT(*)           AS cantidad_facturas,
       SUM(f.valor_total) AS total_facturado
  FROM facturas f
  JOIN sucursales s ON s.id_sucursal = f.id_sucursal
 GROUP BY s.nombre_sucursal, s.ciudad
 ORDER BY total_facturado DESC;
