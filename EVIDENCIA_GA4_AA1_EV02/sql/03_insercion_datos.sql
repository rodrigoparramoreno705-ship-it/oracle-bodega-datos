-- =====================================================================
-- Evidencia GA4-210602033-AA1-EV02 - Caso de estudio TECH TRANSITION
-- Script 03: insercion de datos de prueba (informacion FICTICIA)
-- Ejecutar conectado como TECH_TRANSITION a FREEPDB1
-- Nota: todos los nombres, documentos, telefonos y correos son inventados
--       (dominio reservado example.com); no corresponden a personas reales.
-- =====================================================================
set echo on
set feedback on
set linesize 150
set pagesize 60
alter session set nls_date_format = 'YYYY-MM-DD';

show user

-- ---------------- CLIENTES (10) ----------------
insert into clientes (id_cliente, tipo_documento, numero_documento, nombre_cliente, telefono, correo, direccion, ciudad, fecha_registro)
  values (1, 'NIT', '900000001', 'Comercializadora Andina Delta S.A.S.', '3000000001', 'compras@andinadelta.example.com', 'Calle 100 # 10-20', 'Bogotá', date '2026-01-15');
insert into clientes (id_cliente, tipo_documento, numero_documento, nombre_cliente, telefono, correo, direccion, ciudad, fecha_registro)
  values (2, 'CC', '1000000002', 'Laura Marcela Ríos Peña', '3000000002', 'laura.rios@correo.example.com', 'Carrera 15 # 85-30', 'Bogotá', date '2026-02-03');
insert into clientes (id_cliente, tipo_documento, numero_documento, nombre_cliente, telefono, correo, direccion, ciudad, fecha_registro)
  values (3, 'NIT', '900000003', 'Soluciones Educativas Horizonte S.A.S.', '3000000003', 'facturacion@horizonte.example.com', 'Calle 50 # 45-12', 'Medellín', date '2026-02-20');
insert into clientes (id_cliente, tipo_documento, numero_documento, nombre_cliente, telefono, correo, direccion, ciudad, fecha_registro)
  values (4, 'CC', '1000000004', 'Andrés Felipe Cárdenas Mora', '3000000004', 'andres.cardenas@correo.example.com', 'Carrera 70 # 30-15', 'Medellín', date '2026-03-11');
insert into clientes (id_cliente, tipo_documento, numero_documento, nombre_cliente, telefono, correo, direccion, ciudad, fecha_registro)
  values (5, 'NIT', '900000005', 'Clínica Veterinaria Patitas Felices Ltda.', '3000000005', 'admin@patitasfelices.example.com', 'Avenida 6N # 20-40', 'Cali', date '2026-03-25');
insert into clientes (id_cliente, tipo_documento, numero_documento, nombre_cliente, telefono, correo, direccion, ciudad, fecha_registro)
  values (6, 'CE', '500000006', 'Sofía Valentina Marín Torres', '3000000006', 'sofia.marin@correo.example.com', 'Calle 5 # 38-22', 'Cali', date '2026-04-08');
insert into clientes (id_cliente, tipo_documento, numero_documento, nombre_cliente, telefono, correo, direccion, ciudad, fecha_registro)
  values (7, 'NIT', '900000007', 'Constructora Sendero Verde S.A.S.', '3000000007', 'tesoreria@senderoverde.example.com', 'Avenida 68 # 24-10', 'Bogotá', date '2026-04-30');
insert into clientes (id_cliente, tipo_documento, numero_documento, nombre_cliente, telefono, correo, direccion, ciudad, fecha_registro)
  values (8, 'CC', '1000000008', 'Juan Esteban Ospina Ruiz', '3000000008', 'juan.ospina@correo.example.com', 'Calle 10 # 43-60', 'Medellín', date '2026-05-14');
insert into clientes (id_cliente, tipo_documento, numero_documento, nombre_cliente, telefono, correo, direccion, ciudad, fecha_registro)
  values (9, 'NIT', '900000009', 'Distribuidora Café del Valle S.A.S.', '3000000009', 'pagos@cafedelvalle.example.com', 'Carrera 1 # 70-15', 'Cali', date '2026-06-02');
insert into clientes (id_cliente, tipo_documento, numero_documento, nombre_cliente, telefono, correo, direccion, ciudad, fecha_registro)
  values (10, 'CC', '1000000010', 'María José Quintero Lozano', '3000000010', 'mariajose.quintero@correo.example.com', 'Calle 140 # 19-05', 'Bogotá', date '2026-06-19');

-- ---------------- SUCURSALES (3) ----------------
insert into sucursales (id_sucursal, nombre_sucursal, ciudad, direccion, telefono)
  values (1, 'TT Bogotá Norte', 'Bogotá', 'Autopista Norte # 120-45 Local 3', '6010000001');
insert into sucursales (id_sucursal, nombre_sucursal, ciudad, direccion, telefono)
  values (2, 'TT Medellín El Poblado', 'Medellín', 'Carrera 43A # 10-25 Local 8', '6040000002');
insert into sucursales (id_sucursal, nombre_sucursal, ciudad, direccion, telefono)
  values (3, 'TT Cali Granada', 'Cali', 'Avenida 9N # 15-30 Local 2', '6020000003');

-- ---------------- FORMAS_PAGO (6) ----------------
insert into formas_pago (id_forma_pago, descripcion, dias_plazo) values (1, 'Efectivo', 0);
insert into formas_pago (id_forma_pago, descripcion, dias_plazo) values (2, 'Tarjeta débito', 0);
insert into formas_pago (id_forma_pago, descripcion, dias_plazo) values (3, 'Tarjeta crédito', 0);
insert into formas_pago (id_forma_pago, descripcion, dias_plazo) values (4, 'Transferencia bancaria', 0);
insert into formas_pago (id_forma_pago, descripcion, dias_plazo) values (5, 'Crédito 30 días', 30);
insert into formas_pago (id_forma_pago, descripcion, dias_plazo) values (6, 'Crédito 60 días', 60);

-- ---------------- ARTICULOS (15) ----------------
insert into articulos (id_articulo, codigo_articulo, nombre_articulo, categoria, precio_unitario, estado)
  values (1, 'TT-LAP-001', 'Portátil 14 pulgadas Core i5 16 GB RAM', 'Computadores', 3200000, 'A');
insert into articulos (id_articulo, codigo_articulo, nombre_articulo, categoria, precio_unitario, estado)
  values (2, 'TT-LAP-002', 'Portátil 15.6 pulgadas Ryzen 7 32 GB RAM', 'Computadores', 4500000, 'A');
insert into articulos (id_articulo, codigo_articulo, nombre_articulo, categoria, precio_unitario, estado)
  values (3, 'TT-MON-001', 'Monitor 24 pulgadas Full HD', 'Monitores', 650000, 'A');
insert into articulos (id_articulo, codigo_articulo, nombre_articulo, categoria, precio_unitario, estado)
  values (4, 'TT-MON-002', 'Monitor 27 pulgadas 2K', 'Monitores', 1150000, 'A');
insert into articulos (id_articulo, codigo_articulo, nombre_articulo, categoria, precio_unitario, estado)
  values (5, 'TT-TEC-001', 'Teclado mecánico inalámbrico', 'Periféricos', 280000, 'A');
insert into articulos (id_articulo, codigo_articulo, nombre_articulo, categoria, precio_unitario, estado)
  values (6, 'TT-MOU-001', 'Mouse ergonómico inalámbrico', 'Periféricos', 95000, 'A');
insert into articulos (id_articulo, codigo_articulo, nombre_articulo, categoria, precio_unitario, estado)
  values (7, 'TT-AUD-001', 'Diadema con micrófono USB', 'Periféricos', 180000, 'A');
insert into articulos (id_articulo, codigo_articulo, nombre_articulo, categoria, precio_unitario, estado)
  values (8, 'TT-IMP-001', 'Impresora multifuncional láser', 'Impresión', 1350000, 'A');
insert into articulos (id_articulo, codigo_articulo, nombre_articulo, categoria, precio_unitario, estado)
  values (9, 'TT-TON-001', 'Tóner negro para impresora láser', 'Consumibles', 210000, 'A');
insert into articulos (id_articulo, codigo_articulo, nombre_articulo, categoria, precio_unitario, estado)
  values (10, 'TT-RED-001', 'Router Wi-Fi 6 doble banda', 'Redes', 420000, 'A');
insert into articulos (id_articulo, codigo_articulo, nombre_articulo, categoria, precio_unitario, estado)
  values (11, 'TT-RED-002', 'Switch 24 puertos gigabit', 'Redes', 890000, 'A');
insert into articulos (id_articulo, codigo_articulo, nombre_articulo, categoria, precio_unitario, estado)
  values (12, 'TT-ALM-001', 'Disco SSD externo 1 TB', 'Almacenamiento', 390000, 'A');
insert into articulos (id_articulo, codigo_articulo, nombre_articulo, categoria, precio_unitario, estado)
  values (13, 'TT-ALM-002', 'Memoria USB 64 GB', 'Almacenamiento', 35000, 'A');
insert into articulos (id_articulo, codigo_articulo, nombre_articulo, categoria, precio_unitario, estado)
  values (14, 'TT-ENE-001', 'UPS 1500 VA', 'Energía', 760000, 'A');
insert into articulos (id_articulo, codigo_articulo, nombre_articulo, categoria, precio_unitario, estado)
  values (15, 'TT-SER-001', 'Servicio de instalación y configuración (hora)', 'Servicios', 120000, 'A');

commit;

-- ---------------- FACTURAS (20) ----------------
-- Se registran con valor_total y valor_pagado en 0; luego se calculan a partir del detalle.
-- La fecha de vencimiento corresponde a la fecha de la factura mas los dias de plazo de la forma de pago.
insert into facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  values (1001, date '2026-07-02', date '2026-08-01', 1, 1, 5);
insert into facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  values (1002, date '2026-07-04', date '2026-07-04', 2, 1, 3);
insert into facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  values (1003, date '2026-07-08', date '2026-09-06', 3, 2, 6);
insert into facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  values (1004, date '2026-07-11', date '2026-07-11', 4, 2, 1);
insert into facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  values (1005, date '2026-07-15', date '2026-07-15', 5, 3, 4);
insert into facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  values (1006, date '2026-07-19', date '2026-07-19', 6, 3, 2);
insert into facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  values (1007, date '2026-07-23', date '2026-08-22', 7, 1, 5);
insert into facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  values (1008, date '2026-07-28', date '2026-07-28', 8, 2, 3);
insert into facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  values (1009, date '2026-08-03', date '2026-09-02', 9, 3, 5);
insert into facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  values (1010, date '2026-08-06', date '2026-08-06', 10, 1, 2);
insert into facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  values (1011, date '2026-08-10', date '2026-10-09', 1, 1, 6);
insert into facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  values (1012, date '2026-08-14', date '2026-08-14', 3, 2, 4);
insert into facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  values (1013, date '2026-08-19', date '2026-08-19', 5, 3, 1);
insert into facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  values (1014, date '2026-08-24', date '2026-09-23', 7, 1, 5);
insert into facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  values (1015, date '2026-08-29', date '2026-08-29', 2, 1, 3);
insert into facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  values (1016, date '2026-09-03', date '2026-11-02', 9, 3, 6);
insert into facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  values (1017, date '2026-09-08', date '2026-09-08', 4, 2, 2);
insert into facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  values (1018, date '2026-09-14', date '2026-10-14', 3, 2, 5);
insert into facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  values (1019, date '2026-09-21', date '2026-09-21', 6, 3, 4);
insert into facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)
  values (1020, date '2026-09-28', date '2026-10-28', 1, 1, 5);

-- ---------------- DETALLE_FACTURA ----------------
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1001, 1, 1, 5, 3200000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1001, 2, 3, 5, 650000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1001, 3, 6, 5, 95000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1002, 1, 2, 1, 4500000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1002, 2, 6, 1, 95000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1003, 1, 1, 10, 3200000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1003, 2, 7, 10, 180000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1003, 3, 15, 8, 120000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1004, 1, 13, 4, 35000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1004, 2, 6, 1, 95000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1005, 1, 8, 1, 1350000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1005, 2, 9, 3, 210000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1006, 1, 12, 1, 390000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1006, 2, 5, 1, 280000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1007, 1, 11, 2, 890000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1007, 2, 10, 3, 420000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1007, 3, 14, 2, 760000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1007, 4, 15, 6, 120000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1008, 1, 4, 2, 1150000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1008, 2, 5, 1, 280000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1008, 3, 6, 1, 95000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1009, 1, 1, 3, 3200000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1009, 2, 8, 1, 1350000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1009, 3, 9, 2, 210000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1010, 1, 3, 1, 650000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1010, 2, 7, 1, 180000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1011, 1, 2, 4, 4500000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1011, 2, 4, 4, 1150000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1011, 3, 14, 4, 760000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1012, 1, 13, 30, 35000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1012, 2, 12, 5, 390000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1013, 1, 9, 2, 210000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1013, 2, 13, 2, 35000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1014, 1, 1, 6, 3200000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1014, 2, 3, 6, 650000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1014, 3, 5, 6, 280000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1014, 4, 6, 6, 95000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1015, 1, 12, 1, 390000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1015, 2, 10, 1, 420000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1016, 1, 11, 1, 890000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1016, 2, 10, 2, 420000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1016, 3, 15, 4, 120000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1017, 1, 7, 1, 180000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1017, 2, 13, 2, 35000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1018, 1, 1, 8, 3200000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1018, 2, 15, 10, 120000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1019, 1, 5, 1, 280000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1019, 2, 6, 1, 95000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1019, 3, 3, 1, 650000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1020, 1, 8, 2, 1350000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1020, 2, 9, 6, 210000);
insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values (1020, 3, 14, 1, 760000);
-- Total de lineas de detalle insertadas: 52

-- ---------------- CALCULO DEL VALOR TOTAL ----------------
-- El valor total de cada factura es la suma de los subtotales de su detalle.
update facturas f
   set valor_total = (select nvl(sum(d.subtotal), 0)
                        from detalle_factura d
                       where d.numero_factura = f.numero_factura);

-- ---------------- REGISTRO DE PAGOS ----------------
-- Formas de contado (1 a 4): pago total. Creditos: segun el estado de cartera.
update facturas set valor_pagado = valor_total where numero_factura in (1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1010, 1012, 1013, 1014, 1015, 1017, 1019);
update facturas set valor_pagado = round(valor_total * 0.5, 2) where numero_factura in (1009, 1011, 1018);
-- Las facturas restantes quedan con valor_pagado = 0 (saldo pendiente total).

commit;

-- ---------------- CONTEO DE REGISTROS ----------------
select 'CLIENTES' tabla, count(*) registros from clientes
union all select 'SUCURSALES', count(*) from sucursales
union all select 'FORMAS_PAGO', count(*) from formas_pago
union all select 'ARTICULOS', count(*) from articulos
union all select 'FACTURAS', count(*) from facturas
union all select 'DETALLE_FACTURA', count(*) from detalle_factura;
exit
