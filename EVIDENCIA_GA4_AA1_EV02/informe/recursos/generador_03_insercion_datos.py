from datetime import date, timedelta
clientes = [
 (1,'NIT','900000001','Comercializadora Andina Delta S.A.S.','3000000001','compras@andinadelta.example.com','Calle 100 # 10-20','Bogotá','2026-01-15'),
 (2,'CC','1000000002','Laura Marcela Ríos Peña','3000000002','laura.rios@correo.example.com','Carrera 15 # 85-30','Bogotá','2026-02-03'),
 (3,'NIT','900000003','Soluciones Educativas Horizonte S.A.S.','3000000003','facturacion@horizonte.example.com','Calle 50 # 45-12','Medellín','2026-02-20'),
 (4,'CC','1000000004','Andrés Felipe Cárdenas Mora','3000000004','andres.cardenas@correo.example.com','Carrera 70 # 30-15','Medellín','2026-03-11'),
 (5,'NIT','900000005','Clínica Veterinaria Patitas Felices Ltda.','3000000005','admin@patitasfelices.example.com','Avenida 6N # 20-40','Cali','2026-03-25'),
 (6,'CE','500000006','Sofía Valentina Marín Torres','3000000006','sofia.marin@correo.example.com','Calle 5 # 38-22','Cali','2026-04-08'),
 (7,'NIT','900000007','Constructora Sendero Verde S.A.S.','3000000007','tesoreria@senderoverde.example.com','Avenida 68 # 24-10','Bogotá','2026-04-30'),
 (8,'CC','1000000008','Juan Esteban Ospina Ruiz','3000000008','juan.ospina@correo.example.com','Calle 10 # 43-60','Medellín','2026-05-14'),
 (9,'NIT','900000009','Distribuidora Café del Valle S.A.S.','3000000009','pagos@cafedelvalle.example.com','Carrera 1 # 70-15','Cali','2026-06-02'),
 (10,'CC','1000000010','María José Quintero Lozano','3000000010','mariajose.quintero@correo.example.com','Calle 140 # 19-05','Bogotá','2026-06-19'),
]
sucursales = [
 (1,'TT Bogotá Norte','Bogotá','Autopista Norte # 120-45 Local 3','6010000001'),
 (2,'TT Medellín El Poblado','Medellín','Carrera 43A # 10-25 Local 8','6040000002'),
 (3,'TT Cali Granada','Cali','Avenida 9N # 15-30 Local 2','6020000003'),
]
formas = [(1,'Efectivo',0),(2,'Tarjeta débito',0),(3,'Tarjeta crédito',0),(4,'Transferencia bancaria',0),(5,'Crédito 30 días',30),(6,'Crédito 60 días',60)]
articulos = [
 (1,'TT-LAP-001','Portátil 14 pulgadas Core i5 16 GB RAM','Computadores',3200000),
 (2,'TT-LAP-002','Portátil 15.6 pulgadas Ryzen 7 32 GB RAM','Computadores',4500000),
 (3,'TT-MON-001','Monitor 24 pulgadas Full HD','Monitores',650000),
 (4,'TT-MON-002','Monitor 27 pulgadas 2K','Monitores',1150000),
 (5,'TT-TEC-001','Teclado mecánico inalámbrico','Periféricos',280000),
 (6,'TT-MOU-001','Mouse ergonómico inalámbrico','Periféricos',95000),
 (7,'TT-AUD-001','Diadema con micrófono USB','Periféricos',180000),
 (8,'TT-IMP-001','Impresora multifuncional láser','Impresión',1350000),
 (9,'TT-TON-001','Tóner negro para impresora láser','Consumibles',210000),
 (10,'TT-RED-001','Router Wi-Fi 6 doble banda','Redes',420000),
 (11,'TT-RED-002','Switch 24 puertos gigabit','Redes',890000),
 (12,'TT-ALM-001','Disco SSD externo 1 TB','Almacenamiento',390000),
 (13,'TT-ALM-002','Memoria USB 64 GB','Almacenamiento',35000),
 (14,'TT-ENE-001','UPS 1500 VA','Energía',760000),
 (15,'TT-SER-001','Servicio de instalación y configuración (hora)','Servicios',120000),
]
precio = {a[0]:a[4] for a in articulos}
plazo = {f[0]:f[2] for f in formas}
# numero, fecha, cliente, sucursal, forma, pago ('T' total, 'P' 50 %, 'N' nada), lineas [(articulo, cantidad)]
facturas = [
 (1001,'2026-07-02',1,1,5,'T',[(1,5),(3,5),(6,5)]),
 (1002,'2026-07-04',2,1,3,'T',[(2,1),(6,1)]),
 (1003,'2026-07-08',3,2,6,'T',[(1,10),(7,10),(15,8)]),
 (1004,'2026-07-11',4,2,1,'T',[(13,4),(6,1)]),
 (1005,'2026-07-15',5,3,4,'T',[(8,1),(9,3)]),
 (1006,'2026-07-19',6,3,2,'T',[(12,1),(5,1)]),
 (1007,'2026-07-23',7,1,5,'T',[(11,2),(10,3),(14,2),(15,6)]),
 (1008,'2026-07-28',8,2,3,'T',[(4,2),(5,1),(6,1)]),
 (1009,'2026-08-03',9,3,5,'P',[(1,3),(8,1),(9,2)]),
 (1010,'2026-08-06',10,1,2,'T',[(3,1),(7,1)]),
 (1011,'2026-08-10',1,1,6,'P',[(2,4),(4,4),(14,4)]),
 (1012,'2026-08-14',3,2,4,'T',[(13,30),(12,5)]),
 (1013,'2026-08-19',5,3,1,'T',[(9,2),(13,2)]),
 (1014,'2026-08-24',7,1,5,'T',[(1,6),(3,6),(5,6),(6,6)]),
 (1015,'2026-08-29',2,1,3,'T',[(12,1),(10,1)]),
 (1016,'2026-09-03',9,3,6,'N',[(11,1),(10,2),(15,4)]),
 (1017,'2026-09-08',4,2,2,'T',[(7,1),(13,2)]),
 (1018,'2026-09-14',3,2,5,'P',[(1,8),(15,10)]),
 (1019,'2026-09-21',6,3,4,'T',[(5,1),(6,1),(3,1)]),
 (1020,'2026-09-28',1,1,5,'N',[(8,2),(9,6),(14,1)]),
]
q=lambda s:"'"+s.replace("'","''")+"'"
o=[]
o.append("""-- =====================================================================
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
""")
o.append("-- ---------------- CLIENTES (10) ----------------")
for c in clientes:
    o.append(f"insert into clientes (id_cliente, tipo_documento, numero_documento, nombre_cliente, telefono, correo, direccion, ciudad, fecha_registro)\n  values ({c[0]}, {q(c[1])}, {q(c[2])}, {q(c[3])}, {q(c[4])}, {q(c[5])}, {q(c[6])}, {q(c[7])}, date '{c[8]}');")
o.append("\n-- ---------------- SUCURSALES (3) ----------------")
for s in sucursales:
    o.append(f"insert into sucursales (id_sucursal, nombre_sucursal, ciudad, direccion, telefono)\n  values ({s[0]}, {q(s[1])}, {q(s[2])}, {q(s[3])}, {q(s[4])});")
o.append("\n-- ---------------- FORMAS_PAGO (6) ----------------")
for f in formas:
    o.append(f"insert into formas_pago (id_forma_pago, descripcion, dias_plazo) values ({f[0]}, {q(f[1])}, {f[2]});")
o.append("\n-- ---------------- ARTICULOS (15) ----------------")
for a in articulos:
    o.append(f"insert into articulos (id_articulo, codigo_articulo, nombre_articulo, categoria, precio_unitario, estado)\n  values ({a[0]}, {q(a[1])}, {q(a[2])}, {q(a[3])}, {a[4]}, 'A');")
o.append("\ncommit;\n")
o.append("-- ---------------- FACTURAS (20) ----------------")
o.append("-- Se registran con valor_total y valor_pagado en 0; luego se calculan a partir del detalle.")
o.append("-- La fecha de vencimiento corresponde a la fecha de la factura mas los dias de plazo de la forma de pago.")
for f in facturas:
    d=date.fromisoformat(f[1]); v=d+timedelta(days=plazo[f[4]])
    o.append(f"insert into facturas (numero_factura, fecha_factura, fecha_vencimiento, id_cliente, id_sucursal, id_forma_pago)\n  values ({f[0]}, date '{f[1]}', date '{v.isoformat()}', {f[2]}, {f[3]}, {f[4]});")
o.append("\n-- ---------------- DETALLE_FACTURA ----------------")
n=0
for f in facturas:
    for i,(a,c) in enumerate(f[6],1):
        n+=1
        o.append(f"insert into detalle_factura (numero_factura, numero_linea, id_articulo, cantidad, valor_unitario) values ({f[0]}, {i}, {a}, {c}, {precio[a]});")
o.append(f"-- Total de lineas de detalle insertadas: {n}")
o.append("""
-- ---------------- CALCULO DEL VALOR TOTAL ----------------
-- El valor total de cada factura es la suma de los subtotales de su detalle.
update facturas f
   set valor_total = (select nvl(sum(d.subtotal), 0)
                        from detalle_factura d
                       where d.numero_factura = f.numero_factura);

-- ---------------- REGISTRO DE PAGOS ----------------
-- Formas de contado (1 a 4): pago total. Creditos: segun el estado de cartera.""")
tot=[x[0] for x in facturas if x[5]=='T']; par=[x[0] for x in facturas if x[5]=='P']
o.append(f"update facturas set valor_pagado = valor_total where numero_factura in ({', '.join(map(str,tot))});")
o.append(f"update facturas set valor_pagado = round(valor_total * 0.5, 2) where numero_factura in ({', '.join(map(str,par))});")
o.append("-- Las facturas restantes quedan con valor_pagado = 0 (saldo pendiente total).")
o.append("""
commit;

-- ---------------- CONTEO DE REGISTROS ----------------
select 'CLIENTES' tabla, count(*) registros from clientes
union all select 'SUCURSALES', count(*) from sucursales
union all select 'FORMAS_PAGO', count(*) from formas_pago
union all select 'ARTICULOS', count(*) from articulos
union all select 'FACTURAS', count(*) from facturas
union all select 'DETALLE_FACTURA', count(*) from detalle_factura;
exit""")
open('/home/user/oracle-bodega-datos/EVIDENCIA_GA4_AA1_EV02/sql/03_insercion_datos.sql','w',encoding='utf-8').write("\n".join(o)+"\n")
print(n,"lineas")
