-- DIMENSION TIEMPO: responde ¿cuando? (una fila por fecha)
CREATE TABLE dim_tiempo (
  id_tiempo    NUMBER(8)     NOT NULL,   -- llave AAAAMMDD
  fecha        DATE          NOT NULL,
  anio         NUMBER(4)     NOT NULL,
  trimestre    NUMBER(1)     NOT NULL,
  mes          NUMBER(2)     NOT NULL,
  nombre_mes   VARCHAR2(15)  NOT NULL,
  dia          NUMBER(2)     NOT NULL,
  dia_semana   VARCHAR2(15)  NOT NULL,
  CONSTRAINT pk_dim_tiempo PRIMARY KEY (id_tiempo),
  CONSTRAINT uq_dim_tiempo_fecha UNIQUE (fecha),
  CONSTRAINT ck_dim_tiempo_trim CHECK (trimestre BETWEEN 1 AND 4),
  CONSTRAINT ck_dim_tiempo_mes CHECK (mes BETWEEN 1 AND 12)
);
