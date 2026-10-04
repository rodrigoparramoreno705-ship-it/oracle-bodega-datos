-- TABLA DE HECHOS: grano = una linea de factura (un producto vendido en una factura)
CREATE TABLE fact_ventas (
  id_venta         NUMBER(10) GENERATED ALWAYS AS IDENTITY,
  numero_factura   VARCHAR2(15)   NOT NULL,      -- dimension degenerada
  id_tiempo        NUMBER(8)      NOT NULL,
  id_cliente       NUMBER(6)      NOT NULL,
  id_producto      NUMBER(6)      NOT NULL,
  id_vendedor      NUMBER(6)      NOT NULL,
  id_sucursal      NUMBER(4)      NOT NULL,
  forma_pago       VARCHAR2(20)   NOT NULL,
  cantidad         NUMBER(6)      NOT NULL,
  precio_unitario  NUMBER(12,2)   NOT NULL,
  valor_total      NUMBER(14,2)   NOT NULL,
  CONSTRAINT pk_fact_ventas PRIMARY KEY (id_venta),
  CONSTRAINT uq_fact_linea UNIQUE (numero_factura, id_producto),
  CONSTRAINT fk_fact_tiempo   FOREIGN KEY (id_tiempo)   REFERENCES dim_tiempo (id_tiempo),
  CONSTRAINT fk_fact_cliente  FOREIGN KEY (id_cliente)  REFERENCES dim_cliente (id_cliente),
  CONSTRAINT fk_fact_producto FOREIGN KEY (id_producto) REFERENCES dim_producto (id_producto),
  CONSTRAINT fk_fact_vendedor FOREIGN KEY (id_vendedor) REFERENCES dim_vendedor (id_vendedor),
  CONSTRAINT fk_fact_sucursal FOREIGN KEY (id_sucursal) REFERENCES dim_sucursal (id_sucursal),
  CONSTRAINT ck_fact_forma_pago CHECK (forma_pago IN ('Efectivo', 'Tarjeta crédito', 'Tarjeta débito', 'Transferencia')),
  CONSTRAINT ck_fact_cantidad CHECK (cantidad > 0),
  CONSTRAINT ck_fact_precio CHECK (precio_unitario > 0),
  CONSTRAINT ck_fact_total CHECK (valor_total = cantidad * precio_unitario)
);
