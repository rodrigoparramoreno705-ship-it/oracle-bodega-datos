SELECT c.table_name AS tabla, c.constraint_name AS restriccion,
       DECODE(c.constraint_type, 'P', 'PRIMARY KEY', 'R', 'FOREIGN KEY') AS tipo,
       cc.column_name AS columna, r.table_name AS tabla_referenciada
  FROM user_constraints c
  JOIN user_cons_columns cc ON cc.constraint_name = c.constraint_name
  LEFT JOIN user_constraints r ON r.constraint_name = c.r_constraint_name
 WHERE c.constraint_type IN ('P', 'R')
 ORDER BY c.constraint_type, c.table_name, cc.position;
