# Evidencia GA4-210602033-AA1-EV03 – Realización de caso estudio bodega de datos (Spring Valley, ventas)

Entregables:
- `GA4-210602033-AA1-EV03_Bodega_Datos_Spring_Valley.pdf` – informe final (APA 7)
- `GA4-210602033-AA1-EV03_Bodega_Datos_Spring_Valley.docx` – mismo informe en Word, editable

Estructura:
- `datos/` – archivo crudo de ventas (ficticio, con errores intencionales) y su generador
- `sql/` – scripts ejecutados: esquema, staging, transformación, modelo estrella, carga, validación y consultas
- `capturas/` – 38 figuras (recortadas); `capturas/originales/` pantallas completas
- `logs/` – salida real de los comandos (Docker, SQLcl LOAD, validación y consultas)
- `informe/recursos/` – generador del informe y diagrama Mermaid del modelo estrella

Entorno: Oracle AI Database 26ai Free 23.26.3 (Docker), CloudBeaver 26.2.1 (DBeaver web), SQL Developer 24.3.1, SQLcl 26.3.
DBeaver de escritorio no pudo descargarse (dbeaver.io, GitHub y PPA bloqueados con HTTP 403 en el entorno cloud).
