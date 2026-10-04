-- TRANSFORMACION: limpieza y estandarizacion de los datos de staging
-- TRIM quita espacios, UPPER/INITCAP unifican mayusculas, CASE normaliza catalogos,
-- TO_DATE convierte los tres formatos de fecha y DISTINCT elimina las filas duplicadas.
CREATE TABLE stg_ventas_limpia AS
SELECT DISTINCT
       UPPER(TRIM(numero_factura))                                   AS numero_factura,
       CASE
         WHEN REGEXP_LIKE(TRIM(fecha_factura), '^\d{4}-\d{2}-\d{2}$') THEN TO_DATE(TRIM(fecha_factura), 'YYYY-MM-DD')
         WHEN REGEXP_LIKE(TRIM(fecha_factura), '^\d{2}/\d{2}/\d{4}$') THEN TO_DATE(TRIM(fecha_factura), 'DD/MM/YYYY')
         WHEN REGEXP_LIKE(TRIM(fecha_factura), '^\d{2}-\d{2}-\d{4}$') THEN TO_DATE(TRIM(fecha_factura), 'DD-MM-YYYY')
       END                                                           AS fecha_factura,
       UPPER(TRIM(codigo_cliente))                                   AS codigo_cliente,
       INITCAP(TRIM(nombre_cliente))                                 AS nombre_cliente,
       CASE
         WHEN UPPER(TRIM(sexo)) IN ('M', 'MASCULINO', 'HOMBRE') THEN 'M'
         WHEN UPPER(TRIM(sexo)) IN ('F', 'FEMENINO', 'FEM', 'MUJER') THEN 'F'
       END                                                           AS sexo,
       INITCAP(TRIM(ciudad_cliente))                                 AS ciudad_cliente,
       UPPER(TRIM(codigo_producto))                                  AS codigo_producto,
       UPPER(TRIM(nombre_producto))                                  AS nombre_producto,
       UPPER(TRIM(categoria))                                        AS categoria,
       UPPER(TRIM(codigo_vendedor))                                  AS codigo_vendedor,
       INITCAP(TRIM(nombre_vendedor))                                AS nombre_vendedor,
       UPPER(TRIM(codigo_sucursal))                                  AS codigo_sucursal,
       INITCAP(TRIM(nombre_sucursal))                                AS nombre_sucursal,
       INITCAP(TRIM(ciudad_sucursal))                                AS ciudad_sucursal,
       CASE
         WHEN UPPER(TRIM(forma_pago)) LIKE 'EFECT%'                                 THEN 'Efectivo'
         WHEN UPPER(TRIM(forma_pago)) LIKE '%CR_DITO%' OR UPPER(TRIM(forma_pago)) = 'TC' THEN 'Tarjeta crédito'
         WHEN UPPER(TRIM(forma_pago)) LIKE '%D_BITO%'  OR UPPER(TRIM(forma_pago)) = 'TD' THEN 'Tarjeta débito'
         WHEN UPPER(TRIM(forma_pago)) LIKE 'TRANSF%'   OR UPPER(TRIM(forma_pago)) = 'PSE' THEN 'Transferencia'
         ELSE 'SIN DEFINIR'
       END                                                           AS forma_pago,
       TO_NUMBER(TRIM(cantidad))                                     AS cantidad,
       TO_NUMBER(TRIM(precio_unitario))                              AS precio_unitario
  FROM stg_ventas;
