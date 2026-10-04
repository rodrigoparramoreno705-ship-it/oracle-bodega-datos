-- DIMENSION SUCURSAL: responde ¿donde se vende?
CREATE TABLE dim_sucursal (
  id_sucursal      NUMBER(4) GENERATED ALWAYS AS IDENTITY,
  codigo_sucursal  VARCHAR2(10)   NOT NULL,
  nombre_sucursal  VARCHAR2(100)  NOT NULL,
  ciudad           VARCHAR2(50)   NOT NULL,
  CONSTRAINT pk_dim_sucursal PRIMARY KEY (id_sucursal),
  CONSTRAINT uq_dim_sucursal_codigo UNIQUE (codigo_sucursal)
);
