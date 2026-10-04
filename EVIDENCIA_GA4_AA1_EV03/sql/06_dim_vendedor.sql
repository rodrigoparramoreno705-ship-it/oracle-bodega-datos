-- DIMENSION VENDEDOR: responde ¿quien vende?
CREATE TABLE dim_vendedor (
  id_vendedor      NUMBER(6) GENERATED ALWAYS AS IDENTITY,
  codigo_vendedor  VARCHAR2(10)   NOT NULL,
  nombre_vendedor  VARCHAR2(100)  NOT NULL,
  CONSTRAINT pk_dim_vendedor PRIMARY KEY (id_vendedor),
  CONSTRAINT uq_dim_vendedor_codigo UNIQUE (codigo_vendedor)
);
