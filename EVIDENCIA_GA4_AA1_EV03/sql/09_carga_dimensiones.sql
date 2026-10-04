-- CARGA 1: DIMENSIONES PRIMERO (sin duplicados, desde los datos ya limpios)
INSERT INTO dim_tiempo (id_tiempo, fecha, anio, trimestre, mes, nombre_mes, dia, dia_semana)
SELECT DISTINCT TO_NUMBER(TO_CHAR(fecha_factura, 'YYYYMMDD')), fecha_factura,
       EXTRACT(YEAR FROM fecha_factura), TO_NUMBER(TO_CHAR(fecha_factura, 'Q')),
       EXTRACT(MONTH FROM fecha_factura),
       INITCAP(TO_CHAR(fecha_factura, 'FMMONTH', 'NLS_DATE_LANGUAGE=SPANISH')),
       EXTRACT(DAY FROM fecha_factura),
       INITCAP(TO_CHAR(fecha_factura, 'FMDAY', 'NLS_DATE_LANGUAGE=SPANISH'))
  FROM stg_ventas_limpia;

INSERT INTO dim_cliente (codigo_cliente, nombre_cliente, sexo, ciudad)
SELECT DISTINCT codigo_cliente, nombre_cliente, sexo, ciudad_cliente
  FROM stg_ventas_limpia ORDER BY codigo_cliente;

INSERT INTO dim_producto (codigo_producto, nombre_producto, categoria, precio_lista)
SELECT codigo_producto, nombre_producto, categoria, MAX(precio_unitario)
  FROM stg_ventas_limpia GROUP BY codigo_producto, nombre_producto, categoria ORDER BY codigo_producto;

INSERT INTO dim_vendedor (codigo_vendedor, nombre_vendedor)
SELECT DISTINCT codigo_vendedor, nombre_vendedor
  FROM stg_ventas_limpia ORDER BY codigo_vendedor;

INSERT INTO dim_sucursal (codigo_sucursal, nombre_sucursal, ciudad)
SELECT DISTINCT codigo_sucursal, nombre_sucursal, ciudad_sucursal
  FROM stg_ventas_limpia ORDER BY codigo_sucursal;

COMMIT;
