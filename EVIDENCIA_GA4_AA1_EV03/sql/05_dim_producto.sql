-- DIMENSION PRODUCTO: responde ¿que se vende?
CREATE TABLE dim_producto (
  id_producto      NUMBER(6) GENERATED ALWAYS AS IDENTITY,
  codigo_producto  VARCHAR2(10)   NOT NULL,
  nombre_producto  VARCHAR2(100)  NOT NULL,
  categoria        VARCHAR2(50)   NOT NULL,
  precio_lista     NUMBER(12,2)   NOT NULL,
  CONSTRAINT pk_dim_producto PRIMARY KEY (id_producto),
  CONSTRAINT uq_dim_producto_codigo UNIQUE (codigo_producto),
  CONSTRAINT ck_dim_producto_precio CHECK (precio_lista > 0)
);
