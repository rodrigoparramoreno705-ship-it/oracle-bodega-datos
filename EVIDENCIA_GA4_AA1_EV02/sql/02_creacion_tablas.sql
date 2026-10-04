-- =====================================================================
-- Evidencia GA4-210602033-AA1-EV02 - Caso de estudio TECH TRANSITION
-- Script 02: creacion de tablas, restricciones, indices y comentarios
-- Ejecutar conectado como TECH_TRANSITION a FREEPDB1
--   sql tech_transition/<clave>@//localhost:1521/FREEPDB1 @02_creacion_tablas.sql
-- Modelo normalizado (3FN):
--   CLIENTES, SUCURSALES, FORMAS_PAGO, ARTICULOS  (tablas maestras)
--   FACTURAS                                       (encabezado)
--   DETALLE_FACTURA                                (lineas de la factura)
-- =====================================================================
set echo on
set feedback on
set linesize 150
set pagesize 50

show user

-- ---------------------------------------------------------------------
-- 1. CLIENTES
-- ---------------------------------------------------------------------
create table clientes (
  id_cliente        number(6)      not null,
  tipo_documento    varchar2(3)    not null,
  numero_documento  varchar2(15)   not null,
  nombre_cliente    varchar2(100)  not null,
  telefono          varchar2(15),
  correo            varchar2(100),
  direccion         varchar2(120),
  ciudad            varchar2(50)   not null,
  fecha_registro    date           default sysdate not null,
  constraint pk_clientes primary key (id_cliente),
  constraint uq_clientes_documento unique (tipo_documento, numero_documento),
  constraint ck_clientes_tipo_doc check (tipo_documento in ('CC', 'CE', 'NIT')),
  constraint ck_clientes_correo check (correo is null or correo like '%_@_%._%')
);

-- ---------------------------------------------------------------------
-- 2. SUCURSALES
-- ---------------------------------------------------------------------
create table sucursales (
  id_sucursal      number(4)      not null,
  nombre_sucursal  varchar2(60)   not null,
  ciudad           varchar2(50)   not null,
  direccion        varchar2(120)  not null,
  telefono         varchar2(15),
  constraint pk_sucursales primary key (id_sucursal),
  constraint uq_sucursales_nombre unique (nombre_sucursal)
);

-- ---------------------------------------------------------------------
-- 3. FORMAS_PAGO
-- ---------------------------------------------------------------------
create table formas_pago (
  id_forma_pago  number(2)     not null,
  descripcion    varchar2(40)  not null,
  dias_plazo     number(3)     default 0 not null,
  constraint pk_formas_pago primary key (id_forma_pago),
  constraint uq_formas_pago_desc unique (descripcion),
  constraint ck_formas_pago_dias check (dias_plazo between 0 and 180)
);

-- ---------------------------------------------------------------------
-- 4. ARTICULOS
-- ---------------------------------------------------------------------
create table articulos (
  id_articulo      number(6)      not null,
  codigo_articulo  varchar2(20)   not null,
  nombre_articulo  varchar2(100)  not null,
  categoria        varchar2(40)   not null,
  precio_unitario  number(12,2)   not null,
  estado           char(1)        default 'A' not null,
  constraint pk_articulos primary key (id_articulo),
  constraint uq_articulos_codigo unique (codigo_articulo),
  constraint ck_articulos_precio check (precio_unitario > 0),
  constraint ck_articulos_estado check (estado in ('A', 'I'))
);

-- ---------------------------------------------------------------------
-- 5. FACTURAS (encabezado)
-- ---------------------------------------------------------------------
create table facturas (
  numero_factura     number(10)     not null,
  fecha_factura      date           not null,
  fecha_vencimiento  date           not null,
  id_cliente         number(6)      not null,
  id_sucursal        number(4)      not null,
  id_forma_pago      number(2)      not null,
  valor_total        number(14,2)   default 0 not null,
  valor_pagado       number(14,2)   default 0 not null,
  constraint pk_facturas primary key (numero_factura),
  constraint fk_facturas_clientes foreign key (id_cliente)
    references clientes (id_cliente),
  constraint fk_facturas_sucursales foreign key (id_sucursal)
    references sucursales (id_sucursal),
  constraint fk_facturas_formas_pago foreign key (id_forma_pago)
    references formas_pago (id_forma_pago),
  constraint ck_facturas_fechas check (fecha_vencimiento >= fecha_factura),
  constraint ck_facturas_total check (valor_total >= 0),
  constraint ck_facturas_pagado check (valor_pagado >= 0 and valor_pagado <= valor_total)
);

-- ---------------------------------------------------------------------
-- 6. DETALLE_FACTURA (lineas de cada factura)
-- ---------------------------------------------------------------------
create table detalle_factura (
  numero_factura  number(10)    not null,
  numero_linea    number(3)     not null,
  id_articulo     number(6)     not null,
  cantidad        number(6)     not null,
  valor_unitario  number(12,2)  not null,
  subtotal        number(14,2)  generated always as (cantidad * valor_unitario) virtual,
  constraint pk_detalle_factura primary key (numero_factura, numero_linea),
  constraint fk_detalle_facturas foreign key (numero_factura)
    references facturas (numero_factura) on delete cascade,
  constraint fk_detalle_articulos foreign key (id_articulo)
    references articulos (id_articulo),
  constraint uq_detalle_articulo unique (numero_factura, id_articulo),
  constraint ck_detalle_cantidad check (cantidad > 0),
  constraint ck_detalle_valor check (valor_unitario >= 0)
);

-- ---------------------------------------------------------------------
-- Indices sobre las claves foraneas (mejoran los JOIN y evitan bloqueos)
-- ---------------------------------------------------------------------
create index ix_facturas_cliente   on facturas (id_cliente);
create index ix_facturas_sucursal  on facturas (id_sucursal);
create index ix_facturas_forma     on facturas (id_forma_pago);
create index ix_facturas_fecha     on facturas (fecha_factura);
create index ix_detalle_articulo   on detalle_factura (id_articulo);

-- ---------------------------------------------------------------------
-- Comentarios (documentan el diccionario de datos dentro de Oracle)
-- ---------------------------------------------------------------------
comment on table clientes is 'Clientes a quienes TECH TRANSITION emite facturas';
comment on column clientes.id_cliente is 'Identificador interno del cliente';
comment on column clientes.tipo_documento is 'Tipo de documento: CC, CE o NIT';
comment on column clientes.numero_documento is 'Numero del documento de identificacion';
comment on column clientes.nombre_cliente is 'Nombre o razon social del cliente';
comment on column clientes.telefono is 'Telefono de contacto';
comment on column clientes.correo is 'Correo electronico para envio de facturas';
comment on column clientes.direccion is 'Direccion del cliente';
comment on column clientes.ciudad is 'Ciudad del cliente';
comment on column clientes.fecha_registro is 'Fecha de registro del cliente';

comment on table sucursales is 'Sucursales de TECH TRANSITION que emiten facturas';
comment on column sucursales.id_sucursal is 'Identificador de la sucursal';
comment on column sucursales.nombre_sucursal is 'Nombre de la sucursal';
comment on column sucursales.ciudad is 'Ciudad donde opera la sucursal';
comment on column sucursales.direccion is 'Direccion de la sucursal';
comment on column sucursales.telefono is 'Telefono de la sucursal';

comment on table formas_pago is 'Catalogo de formas de pago aceptadas';
comment on column formas_pago.id_forma_pago is 'Identificador de la forma de pago';
comment on column formas_pago.descripcion is 'Nombre de la forma de pago';
comment on column formas_pago.dias_plazo is 'Dias de plazo para el pago (0 = contado)';

comment on table articulos is 'Catalogo de articulos que se facturan';
comment on column articulos.id_articulo is 'Identificador interno del articulo';
comment on column articulos.codigo_articulo is 'Codigo comercial (SKU) del articulo';
comment on column articulos.nombre_articulo is 'Descripcion del articulo';
comment on column articulos.categoria is 'Categoria del articulo';
comment on column articulos.precio_unitario is 'Precio de lista vigente en pesos colombianos';
comment on column articulos.estado is 'A = activo, I = inactivo';

comment on table facturas is 'Encabezado de las facturas de venta';
comment on column facturas.numero_factura is 'Numero consecutivo de la factura';
comment on column facturas.fecha_factura is 'Fecha de expedicion de la factura';
comment on column facturas.fecha_vencimiento is 'Fecha limite de pago';
comment on column facturas.id_cliente is 'Cliente facturado (FK a CLIENTES)';
comment on column facturas.id_sucursal is 'Sucursal que factura (FK a SUCURSALES)';
comment on column facturas.id_forma_pago is 'Forma de pago (FK a FORMAS_PAGO)';
comment on column facturas.valor_total is 'Valor total de la factura (suma de subtotales)';
comment on column facturas.valor_pagado is 'Valor abonado por el cliente';

comment on table detalle_factura is 'Lineas de articulos de cada factura';
comment on column detalle_factura.numero_factura is 'Factura a la que pertenece la linea (FK a FACTURAS)';
comment on column detalle_factura.numero_linea is 'Numero de linea dentro de la factura';
comment on column detalle_factura.id_articulo is 'Articulo vendido (FK a ARTICULOS)';
comment on column detalle_factura.cantidad is 'Cantidad de unidades vendidas';
comment on column detalle_factura.valor_unitario is 'Valor unitario aplicado en la venta';
comment on column detalle_factura.subtotal is 'Columna virtual: cantidad * valor_unitario';

-- Comprobacion rapida de las tablas creadas
column table_name format a20
select table_name, num_rows from user_tables order by table_name;
exit
