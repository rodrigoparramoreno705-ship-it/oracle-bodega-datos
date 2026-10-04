-- Extrae el diccionario de datos del esquema TECH_TRANSITION desde las vistas de Oracle
set feedback off
set sqlformat csv
select c.table_name as tabla, c.column_id as orden, c.column_name as columna,
       nvl(cm.comments, ' ') as descripcion,
       c.data_type as tipo_dato,
       case when c.data_type = 'NUMBER' and c.data_precision is not null
              then to_char(c.data_precision) || case when c.data_scale > 0 then ',' || c.data_scale end
            when c.data_type in ('VARCHAR2', 'CHAR') then to_char(c.char_length)
            else '-' end as longitud,
       case c.nullable when 'Y' then 'SI' else 'NO' end as permite_null,
       case when exists (select 1 from user_constraints k join user_cons_columns kc on kc.constraint_name = k.constraint_name
                          where k.constraint_type = 'P' and kc.table_name = c.table_name and kc.column_name = c.column_name)
            then 'SI' else 'NO' end as pk,
       case when exists (select 1 from user_constraints k join user_cons_columns kc on kc.constraint_name = k.constraint_name
                          where k.constraint_type = 'R' and kc.table_name = c.table_name and kc.column_name = c.column_name)
            then 'SI' else 'NO' end as fk,
       nvl((select max(r.table_name) from user_constraints k
              join user_cons_columns kc on kc.constraint_name = k.constraint_name
              join user_constraints r on r.constraint_name = k.r_constraint_name
             where k.constraint_type = 'R' and kc.table_name = c.table_name and kc.column_name = c.column_name), '-') as tabla_relacionada,
       c.virtual_column as virtual
  from user_tab_cols c
  left join user_col_comments cm on cm.table_name = c.table_name and cm.column_name = c.column_name
 where c.hidden_column = 'NO'
 order by decode(c.table_name,'CLIENTES',1,'SUCURSALES',2,'FORMAS_PAGO',3,'ARTICULOS',4,'FACTURAS',5,6), c.column_id;
exit
