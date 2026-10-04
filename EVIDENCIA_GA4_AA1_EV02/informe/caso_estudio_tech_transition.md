# 9. Caso de estudio TECH TRANSITION

TECH TRANSITION es una empresa que comercializa equipos de cómputo, periféricos, elementos de red y servicios técnicos a través de tres sucursales ubicadas en Bogotá, Medellín y Cali. La empresa requiere una solución de datos para su **departamento de facturación** que le permita registrar, controlar y consultar las facturas emitidas a sus clientes, como base para la futura construcción de una bodega de datos.

De acuerdo con las pautas de la guía, el aprendiz debe crear la información del caso. Por esta razón, **todos los datos utilizados fueron creados con fines académicos**: los nombres de clientes, números de documento, teléfonos, direcciones y correos electrónicos son ficticios (los correos usan el dominio reservado *example.com*) y no corresponden a personas ni empresas reales.

Para dar respuesta al caso se desarrollaron las siguientes actividades:

1. Elaborar una lista de chequeo con los requerimientos que se deben solucionar.
2. Verificar si la información estaba recopilada y organizada.
3. Crear la base de datos del caso en Oracle por medio de SQL Developer.
4. Crear las tablas con las columnas, tipos de datos y relaciones necesarias para almacenar: número de factura, fecha de factura, fecha de vencimiento, cliente, sucursal, valor total, forma de pago, valor pagado, artículo, cantidad y valor unitario.
5. Emitir una conclusión de lo realizado.

# 10. Lista de chequeo

La lista de chequeo se diligenció al finalizar el trabajo, con base en los resultados obtenidos en Oracle.

**Tabla 1.** Lista de chequeo de requerimientos del caso TECH TRANSITION

| N.º | Requerimiento | Cumple / No cumple | Observaciones |
|---|---|---|---|
| 1 | Motor Oracle disponible para el caso | Cumple | Se trabajó sobre Oracle Database Free, base de datos conectable FREEPDB1. |
| 2 | Usuario/esquema del caso creado | Cumple | Usuario TECH_TRANSITION con privilegios y cuota de 200 MB. |
| 3 | Conexión desde SQL Developer | Cumple | La prueba de conexión del usuario TECH_TRANSITION mostró "Status: Success". |
| 4 | Información de clientes | Cumple | Tabla CLIENTES con 10 registros. |
| 5 | Información de sucursales | Cumple | Tabla SUCURSALES con 3 registros. |
| 6 | Información de formas de pago | Cumple | Tabla FORMAS_PAGO con 6 registros. |
| 7 | Información de artículos | Cumple | Tabla ARTICULOS con 15 registros. |
| 8 | Información de facturas (número, fecha, vencimiento, cliente, sucursal, forma de pago, valor total, valor pagado) | Cumple | Tabla FACTURAS con 20 registros. |
| 9 | Detalle de factura (artículo, cantidad, valor unitario) | Cumple | Tabla DETALLE_FACTURA con 52 registros. |
| 10 | Claves primarias en todas las tablas | Cumple | 6 claves primarias. |
| 11 | Relaciones entre tablas | Cumple | 5 claves foráneas verificadas en Oracle y en SQL Developer. |
| 12 | Integridad de los datos | Cumple | Restricciones NOT NULL, UNIQUE y CHECK; las operaciones inválidas fueron rechazadas. |
| 13 | Datos de prueba confirmados | Cumple | 106 registros guardados con COMMIT. |
| 14 | Consultas de comprobación | Cumple | Consultas de clientes, facturas, JOIN, totales, saldos y artículos más vendidos. |
| 15 | Consistencia del valor total | Cumple | El valor total de cada factura coincide con la suma de su detalle (0 inconsistencias). |

# 11. Verificación de la información y análisis del caso

## 11.1 ¿La información estaba recopilada y organizada?

Al revisar el caso se determinó que la información **no estaba recopilada ni organizada** para ser administrada en una base de datos. Como escenario de trabajo se planteó que la facturación se llevaba en hojas de cálculo independientes por sucursal, en las que cada fila repetía los datos del cliente, del artículo y de la forma de pago. Por ello fue necesario crear la información y organizarla en entidades.

## 11.2 Problema inicial

El manejo de la facturación en hojas de cálculo presentaba los siguientes problemas:

- Los datos de un mismo cliente se repetían en cada factura, con riesgo de errores de digitación e información contradictoria.
- No existía un catálogo único de artículos, sucursales ni formas de pago.
- El número de factura no estaba controlado como identificador único.
- El valor total y el saldo pendiente se calculaban manualmente.
- No había forma de impedir datos inválidos, como cantidades negativas o un valor pagado mayor que el valor de la factura.
- Un archivo alterado o eliminado podía significar la pérdida de la información de ventas.

## 11.3 Necesidad de organizar la información en tablas relacionadas

Una tabla única con todos los datos repetiría la información del cliente, la sucursal y el artículo en cada línea vendida. Por eso se organizó la información en tablas relacionadas: cada dato se almacena una sola vez y se vincula con los demás mediante claves. Así se reduce la redundancia, se facilita la actualización y el motor de base de datos puede validar la integridad de la información.

**Tabla 2.** Ubicación de los datos exigidos por el caso

| Dato exigido | Tabla | Columna |
|---|---|---|
| Número de factura | FACTURAS | numero_factura |
| Fecha de factura | FACTURAS | fecha_factura |
| Fecha de vencimiento | FACTURAS | fecha_vencimiento |
| Cliente | CLIENTES (relacionada con FACTURAS) | id_cliente |
| Sucursal | SUCURSALES (relacionada con FACTURAS) | id_sucursal |
| Valor total | FACTURAS | valor_total |
| Forma de pago | FORMAS_PAGO (relacionada con FACTURAS) | id_forma_pago |
| Valor pagado | FACTURAS | valor_pagado |
| Artículo | ARTICULOS (relacionada con DETALLE_FACTURA) | id_articulo |
| Cantidad | DETALLE_FACTURA | cantidad |
| Valor unitario | DETALLE_FACTURA | valor_unitario |

# 12. Diseño de la base de datos

El diseño se normalizó hasta la tercera forma normal (3FN). Se definieron cuatro tablas maestras, que almacenan la información básica, una tabla de encabezado de factura y una tabla de detalle, que registra los artículos vendidos en cada factura y resuelve la relación de muchos a muchos entre facturas y artículos.

**Tabla 3.** Tablas de la base de datos

| Tabla | Tipo | Contenido |
|---|---|---|
| CLIENTES | Maestra | Datos de identificación y contacto de los clientes. |
| SUCURSALES | Maestra | Sucursales que emiten facturas. |
| FORMAS_PAGO | Maestra | Formas de pago y días de plazo. |
| ARTICULOS | Maestra | Catálogo de artículos con código, categoría y precio. |
| FACTURAS | Encabezado | Número, fechas, cliente, sucursal, forma de pago, valor total y valor pagado. |
| DETALLE_FACTURA | Detalle | Artículo, cantidad, valor unitario y subtotal de cada línea. |

Las relaciones son las siguientes:

- Un **cliente** puede tener muchas **facturas**, y cada factura pertenece a un solo cliente.
- Una **sucursal** emite muchas **facturas**, y cada factura es emitida por una sola sucursal.
- Una **forma de pago** puede usarse en muchas **facturas**, y cada factura tiene una sola forma de pago.
- Una **factura** contiene una o varias líneas de **detalle**.
- Un **artículo** puede venderse en muchas líneas de **detalle**.

Algunas decisiones del diseño fueron:

- Los valores monetarios usan el tipo NUMBER con dos decimales.
- El subtotal del detalle es una columna virtual calculada por Oracle como cantidad × valor unitario, por lo que no puede quedar desactualizado.
- El detalle guarda su propio valor unitario para conservar el precio de la venta aunque cambie el precio del artículo.

[Insertar imagen: modelo_relacional.png]

**Figura 1.** Modelo entidad-relación de la base de datos de facturación

En la figura se observa el modelo entidad-relación del caso TECH TRANSITION, elaborado en notación Mermaid a partir de la estructura definida. Se aprecian las seis tablas con sus columnas, tipos de datos y claves (PK y FK), así como la cardinalidad de cada relación: cliente, sucursal y forma de pago se relacionan con muchas facturas, y cada factura se relaciona con varias líneas de detalle vinculadas a los artículos. Este modelo sirvió como guía para crear las tablas en Oracle.

# 13. Creación de las tablas

## 13.1 Creación del usuario o esquema TECH_TRANSITION

En Oracle, cada usuario es propietario de un esquema en el que se almacenan sus tablas. Por ello, crear la base de datos del caso consistió en crear el usuario **TECH_TRANSITION** dentro de la base de datos conectable FREEPDB1. El usuario se creó con el tablespace USERS, una cuota de 200 MB y únicamente los privilegios necesarios: CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE SEQUENCE y CREATE TRIGGER.

[Insertar imagen: captura_09_creacion_usuario.png]

**Figura 2.** Creación del usuario TECH_TRANSITION

En la figura se observa la ejecución del script de creación del usuario, conectado como SYSTEM. Se aprecian las sentencias CREATE USER y GRANT, con sus mensajes "User TECH_TRANSITION created" y "Grant succeeded", y las consultas de verificación. Como resultado, el usuario quedó en estado OPEN, con tablespace USERS, cinco privilegios de sistema y una cuota de 200 MB, listo para alojar las tablas del caso.

[Insertar imagen: captura_09b_conexion_tech_transition.png]

**Figura 3.** Conexión del usuario TECH_TRANSITION en SQL Developer

En la figura se observa el cuadro "New / Select Database Connection" de SQL Developer, diligenciado con el nombre de conexión TECH_TRANSITION, el usuario tech_transition, el host localhost, el puerto 1521 y el nombre de servicio FREEPDB1. Al presionar el botón Test, la herramienta mostró el mensaje "Status : Success", lo que confirma que el usuario del caso puede conectarse a Oracle. Desde esta conexión se trabajó el esquema de facturación.

## 13.2 Creación de las tablas

Las tablas se crearon con un script SQL ejecutado con el usuario TECH_TRANSITION. Primero se crearon las tablas maestras y luego las que dependen de ellas mediante claves foráneas. También se crearon cinco índices sobre las claves foráneas y la fecha de factura, y se agregaron comentarios a cada tabla y columna para documentarlas.

**Tabla 4.** Resumen de tipos de datos y claves

| Tabla | Clave primaria | Claves foráneas | Tipos de datos principales |
|---|---|---|---|
| CLIENTES | id_cliente | — | NUMBER(6), VARCHAR2(3–120), DATE |
| SUCURSALES | id_sucursal | — | NUMBER(4), VARCHAR2(15–120) |
| FORMAS_PAGO | id_forma_pago | — | NUMBER(2), VARCHAR2(40), NUMBER(3) |
| ARTICULOS | id_articulo | — | NUMBER(6), VARCHAR2(20–100), NUMBER(12,2), CHAR(1) |
| FACTURAS | numero_factura | id_cliente, id_sucursal, id_forma_pago | NUMBER(10), DATE, NUMBER(14,2) |
| DETALLE_FACTURA | numero_factura + numero_linea | numero_factura, id_articulo | NUMBER(6), NUMBER(12,2), NUMBER(14,2) virtual |

**Tabla 5.** Restricciones de integridad más importantes

| Tabla | Restricción | Regla |
|---|---|---|
| CLIENTES | UNIQUE | El tipo y número de documento no se repiten. |
| CLIENTES | CHECK | El tipo de documento solo puede ser CC, CE o NIT. |
| ARTICULOS | UNIQUE / CHECK | El código del artículo es único y el precio debe ser mayor que cero. |
| FORMAS_PAGO | CHECK | Los días de plazo están entre 0 y 180. |
| FACTURAS | CHECK | La fecha de vencimiento no puede ser anterior a la fecha de factura. |
| FACTURAS | CHECK | El valor pagado está entre 0 y el valor total. |
| DETALLE_FACTURA | CHECK | La cantidad debe ser mayor que cero. |
| DETALLE_FACTURA | UNIQUE | Un artículo aparece una sola vez por factura. |
| Todas | NOT NULL | Los campos obligatorios no admiten valores vacíos (32 restricciones). |

En total, el esquema quedó con 6 claves primarias, 5 claves foráneas, 5 restricciones UNIQUE, 10 restricciones CHECK y 32 restricciones NOT NULL.

[Insertar imagen: captura_10_creacion_tablas.png]

**Figura 4.** Creación de las tablas del caso TECH TRANSITION

En la figura se observa el registro de ejecución del script de creación de tablas. Se aprecian los mensajes "Table CLIENTES created", "Table SUCURSALES created", "Table FORMAS_PAGO created" y "Table ARTICULOS created", la sentencia completa de la tabla FACTURAS, que almacena el número de factura, las fechas, el cliente, la sucursal, la forma de pago, el valor total y el valor pagado, y el mensaje "Table DETALLE_FACTURA created". La consulta final a USER_TABLES lista las seis tablas, lo que confirma que la estructura de facturación se creó sin errores.

[Insertar imagen: captura_10b_tablas_sqldeveloper.png]

**Figura 5.** Tablas creadas y columnas de FACTURAS en SQL Developer

En la figura se observa el árbol de la conexión TECH_TRANSITION en SQL Developer, donde aparecen las seis tablas creadas: ARTICULOS, CLIENTES, DETALLE_FACTURA, FACTURAS, FORMAS_PAGO y SUCURSALES. A la derecha se muestra la pestaña Columns de la tabla FACTURAS con el nombre, el tipo de dato, la obligatoriedad, el valor por defecto y el comentario de cada columna. Esta vista confirma que la estructura definida quedó registrada correctamente en Oracle.

# 14. Inserción de registros

Para comprobar el funcionamiento de la base de datos se insertaron **datos de prueba ficticios**, creados con fines académicos. La carga se realizó en el siguiente orden:

1. Registro de las tablas maestras (clientes, sucursales, formas de pago y artículos) y COMMIT.
2. Registro de 20 facturas, numeradas de la 1001 a la 1020, con fechas entre julio y septiembre de 2026. La fecha de vencimiento corresponde a la fecha de la factura más los días de plazo de la forma de pago.
3. Registro de 52 líneas de detalle, de dos a cuatro artículos por factura.
4. Cálculo del valor total de cada factura mediante una sentencia UPDATE que suma los subtotales de su detalle.
5. Registro del valor pagado mediante sentencias UPDATE: pago total en 15 facturas, pago del 50 % en 3 facturas a crédito y sin pago en 2 facturas a crédito. Al final se ejecutó COMMIT.

**Tabla 6.** Registros insertados por tabla

| Tabla | Registros |
|---|---|
| CLIENTES | 10 |
| SUCURSALES | 3 |
| FORMAS_PAGO | 6 |
| ARTICULOS | 15 |
| FACTURAS | 20 |
| DETALLE_FACTURA | 52 |
| **Total** | **106** |

[Insertar imagen: captura_11_insercion_datos.png]

**Figura 6.** Inserción de datos de prueba

En la figura se observa el registro de ejecución del script de inserción. Se aprecian el COMMIT de las tablas maestras, la inserción de la factura 1001 y de sus líneas de detalle con el mensaje "1 row inserted", y la sentencia UPDATE que calculó el valor total de las 20 facturas ("20 rows updated"). También aparecen las actualizaciones de pagos ("15 rows updated" y "3 rows updated"), el COMMIT final y el conteo de registros por tabla: 10, 3, 6, 15, 20 y 52. Esto confirma que los datos de prueba quedaron almacenados de forma permanente.

# 15. Relaciones entre tablas

Las relaciones se implementaron mediante **claves primarias (PK)**, que identifican de forma única cada registro, y **claves foráneas (FK)**, que obligan a que el valor referenciado exista en la tabla relacionada.

**Tabla 7.** Relaciones implementadas

| Clave foránea | Tabla hija (columna) | Tabla padre (PK) | Cardinalidad |
|---|---|---|---|
| FK_FACTURAS_CLIENTES | FACTURAS (id_cliente) | CLIENTES (id_cliente) | 1 : N |
| FK_FACTURAS_SUCURSALES | FACTURAS (id_sucursal) | SUCURSALES (id_sucursal) | 1 : N |
| FK_FACTURAS_FORMAS_PAGO | FACTURAS (id_forma_pago) | FORMAS_PAGO (id_forma_pago) | 1 : N |
| FK_DETALLE_FACTURAS | DETALLE_FACTURA (numero_factura) | FACTURAS (numero_factura) | 1 : N |
| FK_DETALLE_ARTICULOS | DETALLE_FACTURA (id_articulo) | ARTICULOS (id_articulo) | 1 : N |

La relación entre FACTURAS y DETALLE_FACTURA tiene la regla ON DELETE CASCADE, porque una línea de detalle no tiene sentido sin su factura. Las demás claves foráneas impiden eliminar un cliente, una sucursal, una forma de pago o un artículo que tenga movimientos registrados.

[Insertar imagen: captura_13_relaciones.png]

**Figura 7.** Modelo de relaciones de la tabla FACTURAS en SQL Developer

En la figura se observa la pestaña Model de la tabla FACTURAS en SQL Developer. La herramienta leyó las claves foráneas definidas en Oracle y dibujó las tablas relacionadas: FACTURAS se vincula con CLIENTES, SUCURSALES y FORMAS_PAGO mediante FK_FACTURAS_CLIENTES, FK_FACTURAS_SUCURSALES y FK_FACTURAS_FORMAS_PAGO, y DETALLE_FACTURA se vincula con FACTURAS mediante FK_DETALLE_FACTURAS. Esta vista demuestra que las relaciones existen en la base de datos y no solo en el diseño.

[Insertar imagen: captura_13b_claves_foraneas.png]

**Figura 8.** Claves primarias y foráneas consultadas en el diccionario de Oracle

En la figura se observan las consultas realizadas sobre el diccionario de datos de Oracle para listar las claves del esquema TECH_TRANSITION. Se aprecian las seis claves primarias, incluida la clave compuesta de DETALLE_FACTURA (numero_factura y numero_linea), y las cinco claves foráneas con su tabla referenciada y su regla de borrado. Esta consulta permite comprobar también la relación FK_DETALLE_ARTICULOS entre el detalle y los artículos, que no aparece en la vista de la Figura 7 porque esa vista solo muestra las tablas vecinas de FACTURAS.

# 16. Consultas de comprobación

Para comprobar el funcionamiento de la base de datos se ejecutaron consultas SQL con las cláusulas JOIN, GROUP BY, SUM, COUNT y ORDER BY. La Tabla 8 resume las consultas y sus resultados.

**Tabla 8.** Consultas de comprobación realizadas

| N.º | Consulta | Resultado obtenido |
|---|---|---|
| 1 | Todos los clientes | 10 clientes |
| 2 | Todas las facturas | 20 facturas |
| 3 | Facturas con su cliente (JOIN) | 20 filas |
| 4 | Facturas por sucursal | Bogotá Norte: 8 facturas por $86.950.000; Medellín El Poblado: 6 por $67.720.000; Cali Granada: 6 por $17.745.000 |
| 5 | Facturas por forma de pago | La más usada es Crédito 30 días: 6 facturas por $93.245.000 |
| 6 | Detalle de las facturas | 52 líneas |
| 7 | Total facturado | $172.415.000, igual a la suma del detalle (diferencia 0) |
| 8 | Total pagado | $133.580.000 (77,48 % de recaudo) |
| 9 | Saldos pendientes | 5 facturas con saldo, por un total de $38.835.000; una factura vencida |
| 10 | Artículos más vendidos | Memoria USB 64 GB (38 unidades) y Portátil 14 pulgadas Core i5 (32 unidades) |

Además de las consultas, se realizaron pruebas reales de modificación de datos. Las sentencias UPDATE de la carga calcularon el valor total y el valor pagado de las facturas. También se intentaron operaciones inválidas que Oracle rechazó correctamente, entre ellas la eliminación (DELETE) de un cliente con facturas y la actualización (UPDATE) de un valor pagado mayor que el total de la factura. Al finalizar las pruebas se ejecutó ROLLBACK y se comprobó que los datos no cambiaron.

[Insertar imagen: captura_12_consulta_datos.png]

**Figura 9.** Consulta de facturas con cliente, sucursal y forma de pago en SQL Developer

En la figura se observa la hoja de trabajo de SQL Developer con la conexión TECH_TRANSITION, donde se ejecutó una consulta que une, mediante JOIN, las tablas FACTURAS, CLIENTES, SUCURSALES y FORMAS_PAGO. El panel de resultados indica "All Rows Fetched: 20" y muestra, por ejemplo, la factura 1001 del 2 de julio de 2026 de Comercializadora Andina Delta S.A.S., emitida en TT Bogotá Norte con forma de pago Crédito 30 días. Esta consulta comprueba que las relaciones permiten reconstruir la información completa de cada factura.

[Insertar imagen: captura_12b_consultas_agregadas.png]

**Figura 10.** Consultas de facturación por sucursal, por forma de pago y totales

En la figura se observan las consultas que agrupan la facturación con GROUP BY, COUNT y SUM. Por sucursal, TT Bogotá Norte registra la mayor facturación ($86.950.000). Por forma de pago, Crédito 30 días es la más utilizada. El total facturado es de $172.415.000 y coincide exactamente con la suma del detalle, y el total pagado es de $133.580.000, que equivale a un recaudo del 77,48 %. Estas consultas demuestran que la base de datos genera información útil para el departamento de facturación.

[Insertar imagen: captura_12c_saldos_y_mas_vendidos.png]

**Figura 11.** Saldos pendientes y artículos más vendidos

En la figura se observan la consulta de saldos pendientes por factura, la consulta de saldo pendiente por cliente y la de artículos más vendidos. Cinco facturas tienen saldo pendiente; la factura 1009 de Distribuidora Café del Valle S.A.S. aparece como VENCIDA, con un saldo de $5.685.000. Por cliente, Comercializadora Andina Delta S.A.S. concentra el mayor saldo ($17.540.000). El artículo más vendido en unidades es la Memoria USB 64 GB (38 unidades), y el Portátil 14 pulgadas Core i5 genera el mayor valor de ventas ($102.400.000).

[Insertar imagen: captura_14c_reconexion_sqldeveloper.png]

**Figura 12.** Facturación y saldo pendiente por cliente en SQL Developer

En la figura se observa una consulta ejecutada en SQL Developer que agrupa las facturas por cliente y calcula la cantidad de facturas, el total facturado, el total pagado y el saldo pendiente de cada uno. El resultado muestra los 10 clientes y confirma que solo tres de ellos tienen saldo pendiente. El aviso en pantalla, "Your database connection has been reset", apareció porque la consulta se ejecutó después de reiniciar el servicio de Oracle; SQL Developer se reconectó y mostró los mismos datos, lo que evidencia que la información se conserva.

[Insertar imagen: captura_14b_pruebas_integridad.png]

**Figura 13.** Pruebas de integridad de los datos

En la figura se observan las sentencias inválidas que se ejecutaron para comprobar las restricciones del esquema y el error con que Oracle rechazó cada una: un cliente con clave primaria repetida (ORA-00001), una factura con un cliente inexistente (ORA-02291), la eliminación de un cliente que tiene facturas (ORA-02292) y una línea de detalle con cantidad negativa (ORA-02290). Estas pruebas demuestran que la base de datos impide el ingreso de información incorrecta y protege la integridad de la facturación.

# 17. Conclusión

El desarrollo del caso TECH TRANSITION permitió transformar una información de facturación dispersa y sin control en una base de datos relacional en Oracle, organizada en seis tablas normalizadas: CLIENTES, SUCURSALES, FORMAS_PAGO, ARTICULOS, FACTURAS y DETALLE_FACTURA. Cada uno de los datos exigidos (número de factura, fecha de factura, fecha de vencimiento, cliente, sucursal, valor total, forma de pago, valor pagado, artículo, cantidad y valor unitario) quedó almacenado en un único lugar y vinculado con los demás mediante claves primarias y foráneas.

La lista de chequeo permitió verificar que se cumplieron todos los requerimientos del caso. Las restricciones de integridad demostraron su valor al rechazar las operaciones inválidas, algo que una hoja de cálculo no puede garantizar. Además, las consultas con JOIN, GROUP BY, SUM, COUNT y ORDER BY convirtieron los 106 registros de prueba en información útil para la toma de decisiones: un total facturado de $172.415.000, un recaudo del 77,48 %, la identificación de una factura vencida y de los artículos más vendidos.

La base de datos construida es consistente, confiable y fácil de consultar, y constituye un punto de partida sólido para la futura bodega de datos del departamento de facturación de TECH TRANSITION.
