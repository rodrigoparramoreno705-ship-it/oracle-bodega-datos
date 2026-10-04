-- STAGING: recibe el archivo plano tal como llega (todo como texto, sin limpiar)
CREATE TABLE stg_ventas (
  numero_factura   VARCHAR2(50),
  fecha_factura    VARCHAR2(50),
  codigo_cliente   VARCHAR2(50),
  nombre_cliente   VARCHAR2(200),
  sexo             VARCHAR2(50),
  ciudad_cliente   VARCHAR2(100),
  codigo_producto  VARCHAR2(50),
  nombre_producto  VARCHAR2(200),
  categoria        VARCHAR2(100),
  codigo_vendedor  VARCHAR2(50),
  nombre_vendedor  VARCHAR2(200),
  codigo_sucursal  VARCHAR2(50),
  nombre_sucursal  VARCHAR2(200),
  ciudad_sucursal  VARCHAR2(100),
  forma_pago       VARCHAR2(50),
  cantidad         VARCHAR2(20),
  precio_unitario  VARCHAR2(20)
);
