-- CONSULTA 1: indicadores generales de la bodega (primera consulta analitica)
SELECT COUNT(DISTINCT f.numero_factura)                      AS facturas,
       COUNT(*)                                              AS lineas_vendidas,
       SUM(f.cantidad)                                       AS unidades,
       SUM(f.valor_total)                                    AS ventas_totales,
       ROUND(SUM(f.valor_total) / COUNT(DISTINCT f.numero_factura)) AS ticket_promedio,
       COUNT(DISTINCT f.id_cliente)                          AS clientes,
       MIN(t.fecha)                                          AS primera_venta,
       MAX(t.fecha)                                          AS ultima_venta
  FROM fact_ventas f
  JOIN dim_tiempo t ON t.id_tiempo = f.id_tiempo;
