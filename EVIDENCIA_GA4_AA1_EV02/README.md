# Evidencia GA4-210602033-AA1-EV02 – Instalación de motor de base de datos Oracle

Programa: **Implementación y gestión de bases de datos (228130)** – SENA
Competencia 210602033 – Alimentar base de datos de acuerdo con procedimientos técnicos.

**Entregable:** [`GA4-210602033-AA1-EV02_Instalacion_Oracle.pdf`](GA4-210602033-AA1-EV02_Instalacion_Oracle.pdf) (54 páginas).
Los campos de la portada (aprendiz, programa, instructor, ficha, centro, ciudad y fecha) son **campos de formulario rellenables**: se pueden diligenciar con cualquier lector de PDF (Adobe Acrobat Reader, navegador web, etc.) antes de entregar.

## Resumen

| Elemento | Resultado real |
|---|---|
| Entorno | Máquina virtual cloud Ubuntu 24.04.4 LTS, x86_64, 4 vCPU, 15 GiB RAM, 30 GB libres (el equipo personal no tiene recursos suficientes) |
| Motor instalado | **Oracle AI Database 26ai Free Release 23.26.3.0.0** en contenedor Docker (`gvenzl/oracle-free:23-slim`) |
| Herramientas cliente | Oracle SQL Developer 24.3.1 (interfaz gráfica sobre Xvfb), SQLcl 26.3, SQL*Plus 23.26, python-oracledb 26.0.1 |
| Esquema del caso | `TECH_TRANSITION` en la PDB `FREEPDB1` |
| Tablas | CLIENTES, SUCURSALES, FORMAS_PAGO, ARTICULOS, FACTURAS, DETALLE_FACTURA |
| Restricciones | 6 PK, 5 FK, 5 UNIQUE, 10 CHECK, 32 NOT NULL (58) y 16 índices |
| Datos ficticios | 10 clientes, 3 sucursales, 6 formas de pago, 15 artículos, 20 facturas, 52 detalles (106 registros) |
| Totales | Facturado $172.415.000 · Pagado $133.580.000 (77,48 %) · Saldo $38.835.000 |
| Pruebas | 11 consultas, 7 pruebas de integridad rechazadas por Oracle, reinicio del servicio con datos persistentes |

## Estructura

```
EVIDENCIA_GA4_AA1_EV02/
├── README.md
├── GA4-210602033-AA1-EV02_Instalacion_Oracle.pdf   ← informe final
├── informe/
│   ├── informe_evidencia.md        ← documento fuente del informe (generado desde la plantilla)
│   └── recursos/
│       ├── plantilla_informe.md          texto del informe con marcadores de logs/diccionario/scripts
│       ├── generar_informe.py            genera informe_evidencia.md y el PDF (Chromium + pypdf)
│       ├── render_capturas_terminal.py   genera las capturas de terminal desde los logs reales
│       ├── render_mermaid.py             dibuja el modelo entidad-relación (Mermaid → PNG)
│       ├── modelo_relacional.mmd / .png  modelo relacional
│       ├── diccionario_datos.sql         extrae el diccionario de datos desde Oracle
│       ├── generador_03_insercion_datos.py  genera (de forma determinista) el script 03
│       └── sql_verificacion_instalacion/    SQL y Python usados para verificar la instalación
├── capturas/      33 imágenes (captura_01 … captura_14e)
├── sql/
│   ├── 01_creacion_usuario.sql
│   ├── 02_creacion_tablas.sql
│   ├── 03_insercion_datos.sql
│   ├── 04_consultas.sql
│   └── 05_verificacion.sql
├── logs/          salida real de cada comando (run.sh registra fecha, comando y salida)
└── resultados/
    ├── diccionario_datos.csv       exportado desde las vistas del diccionario de Oracle
    └── consultas_csv/              contenido de cada tabla exportado con SQLcl
```

## Sobre las capturas

- **Capturas gráficas reales (8):** `captura_07b`, `08`, `08b`, `09b`, `10b`, `12`, `13`, `14c`. Son capturas de pantalla de Oracle SQL Developer ejecutándose en un display virtual (Xvfb) de la máquina cloud, tomadas con `import` (ImageMagick) y recortadas al tamaño de la ventana.
- **Capturas de terminal (25):** el entorno no tiene escritorio, así que se generaron con `render_capturas_terminal.py` a partir de **extractos literales** de los archivos de `logs/`. Cada imagen indica en su barra superior el log y las líneas de origen; las líneas omitidas se marcan con `[... lineas X-Y omitidas ...]`.
- No se generó ninguna interfaz gráfica ficticia.

## Cómo reproducir la práctica

```bash
# 1. Servicio Docker (el entorno no tiene systemd)
nohup dockerd > logs/dockerd.log 2>&1 &

# 2. Instalación y arranque de Oracle Database Free
docker volume create oracle_free_data
docker run -d --name oracle-free -p 1521:1521 -e ORACLE_PASSWORD=Sena2026Oracle \
  -v oracle_free_data:/opt/oracle/oradata gvenzl/oracle-free:23-slim
docker logs -f oracle-free        # esperar "DATABASE IS READY TO USE!"

# 3. Scripts del caso (SQLcl en /opt/oracle-tools/sqlcl)
sql system/Sena2026Oracle@//localhost:1521/FREEPDB1        @sql/01_creacion_usuario.sql
sql tech_transition/TechT2026@//localhost:1521/FREEPDB1     @sql/02_creacion_tablas.sql
sql tech_transition/TechT2026@//localhost:1521/FREEPDB1     @sql/03_insercion_datos.sql
sql tech_transition/TechT2026@//localhost:1521/FREEPDB1     @sql/04_consultas.sql
sql system/Sena2026Oracle@//localhost:1521/FREEPDB1        @sql/05_verificacion.sql

# 4. Informe (requiere markdown, pypdf, playwright y Chromium)
python3 informe/recursos/render_capturas_terminal.py
python3 informe/recursos/generar_informe.py
```

> Las contraseñas (`Sena2026Oracle`, `TechT2026`) son académicas y solo válidas para este entorno de práctica.

## Limitaciones y decisiones documentadas

1. **No se ejecutó el instalador oficial nativo de Oracle.** La política de red del entorno cloud bloquea con HTTP 403 `edelivery.oracle.com` (destino de las descargas de los RPM de Oracle Database Free y XE 21c) y `container-registry.oracle.com`. Se usó la imagen de Docker Hub `gvenzl/oracle-free:23-slim` (proyecto *oci-oracle-free*). Evidencia: `logs/03_descarga.log`.
2. La guía muestra Oracle XE 11g/21c; se instaló **Oracle Database Free**, la edición gratuita vigente que sucede a XE. El motor se reporta como *Oracle AI Database 26ai Free Release 23.26.3.0.0*.
3. Los scripts SQL se ejecutaron con **SQLcl** (la herramienta de línea de comandos de la familia SQL Developer) para conservar logs de texto; SQL Developer se usó para las conexiones, consultas y el modelo de relaciones (capturas reales).
4. Errores reales conservados: `ORA-00911` (escape de `$` en Bash, `logs/07_version_intento_fallido_escapado.log`) y `ORA-00937` (consulta 7, `logs/12_script04_consultas_intento1_error_ORA-00937.log`), ambos corregidos.
5. En los logs de SQLcl se eliminaron con `sed` los códigos de color ANSI y se filtró con `grep -v` la línea `Picked up JAVA_TOOL_OPTIONS` (configuración del proxy del entorno); el resto de la salida es literal.
6. No fue posible generar una versión DOCX: LibreOffice del entorno falla al abrir cualquier HTML ("source file could not be loaded"). Por eso la portada del PDF se dejó con campos rellenables.

## Control de calidad frente a la guía

| Requisito | Cumplido | Ubicación en el informe | Observación |
|---|:---:|---|---|
| Instalar el motor de base de datos Oracle | Sí | Secciones 5–6, Figuras 2–5 | En contenedor; instalador nativo bloqueado por la red |
| Informe detallado del proceso de instalación | Sí | Secciones 3–8 | Paso a paso con logs y figuras |
| Características del entorno utilizado | Sí | Sección 4, Tabla 2, Figura 1 | Se aclara el uso del entorno cloud |
| Lista de chequeo de requerimientos | Sí | Sección 10, Tabla 4 | Cumple / No cumple / Observaciones |
| Verificar si la información está recopilada y organizada | Sí | Sección 11.1, Tabla 5 | Escenario supuesto, información creada |
| Crear la información del caso | Sí | Secciones 9 y 15 | 106 registros ficticios |
| Base de datos en Oracle por medio de SQL Developer | Sí | Secciones 8, 14, 16, 17 | Capturas reales de SQL Developer |
| Tablas con los 11 datos exigidos (factura, fechas, cliente, sucursal, valores, forma de pago, artículo, cantidad, valor unitario) | Sí | Secciones 11.1, 12–14 | Modelo normalizado (3FN) |
| Columnas, tipos de datos y relaciones | Sí | Secciones 12, 13, 16 | Diccionario extraído de Oracle, diagrama Mermaid |
| Pruebas | Sí | Secciones 17–18 | Consultas, integridad, reinicio |
| Conclusiones | Sí | Sección 20 | 7 conclusiones |
| PDF de mínimo 10 páginas | Sí | Archivo PDF | 54 páginas |
| Capturas con número y explicación | Sí | Figuras 1–27 | Párrafo explicativo bajo cada figura |
| Portada con campos editables, tabla de contenido, referencias y anexos | Sí | Portada, pág. 2, secciones 21–22 | Campos rellenables en el PDF |
