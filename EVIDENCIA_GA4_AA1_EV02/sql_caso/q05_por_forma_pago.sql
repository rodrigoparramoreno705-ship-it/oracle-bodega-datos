SELECT fp.descripcion AS forma_pago, fp.dias_plazo,
       COUNT(f.numero_factura)    AS cantidad_facturas,
       NVL(SUM(f.valor_total), 0) AS total_facturado
  FROM formas_pago fp
  LEFT JOIN facturas f ON f.id_forma_pago = fp.id_forma_pago
 GROUP BY fp.descripcion, fp.dias_plazo
 ORDER BY cantidad_facturas DESC, total_facturado DESC;
