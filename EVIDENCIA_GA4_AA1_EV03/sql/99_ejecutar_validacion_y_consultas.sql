set sqlformat ansiconsole
set linesize 220
set echo on
@sql/11a_validacion_conteos.sql
@sql/11b_validacion_calidad.sql
@sql/11c_validacion_llaves.sql
@sql/11d_prueba_integridad.sql
@sql/12a_indicadores_generales.sql
@sql/12b_ventas_por_anio.sql
@sql/12c_productos.sql
@sql/12d_sucursales.sql
@sql/12e_vendedores.sql
@sql/12f_clientes.sql
@sql/12g_clientes_sexo.sql
@sql/12h_forma_pago.sql
select count(*) as fact_ventas_despues_de_prueba from fact_ventas;
exit
