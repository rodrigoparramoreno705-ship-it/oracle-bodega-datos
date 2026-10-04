-- DIMENSION CLIENTE: responde ¿quien compra?
CREATE TABLE dim_cliente (
  id_cliente      NUMBER(6) GENERATED ALWAYS AS IDENTITY,
  codigo_cliente  VARCHAR2(10)   NOT NULL,
  nombre_cliente  VARCHAR2(100)  NOT NULL,
  sexo            CHAR(1)        NOT NULL,
  ciudad          VARCHAR2(50)   NOT NULL,
  CONSTRAINT pk_dim_cliente PRIMARY KEY (id_cliente),
  CONSTRAINT uq_dim_cliente_codigo UNIQUE (codigo_cliente),
  CONSTRAINT ck_dim_cliente_sexo CHECK (sexo IN ('M', 'F'))
);
