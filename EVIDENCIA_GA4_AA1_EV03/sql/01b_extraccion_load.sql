-- EXTRACCION: carga del archivo plano crudo en la tabla de staging, sin modificar los valores
set loadformat csv
set load batch_rows 100
load stg_ventas datos/ventas_crudas_spring_valley.csv
select count(*) as filas_en_staging from stg_ventas;
exit
