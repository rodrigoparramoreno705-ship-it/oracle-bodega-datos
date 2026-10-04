"""
Genera las capturas de terminal de la evidencia a partir de los logs REALES.

Cada imagen es un extracto literal (rangos de lineas) de un archivo de logs/.
No se modifica el texto: solo se seleccionan lineas, se marca con "[...]" donde
se omiten lineas intermedias y se recortan con "..." las lineas mas largas que
el ancho de la imagen. La barra superior indica el log de origen y las lineas.
"""
import os
from PIL import Image, ImageDraw, ImageFont

BASE = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
LOGS = os.path.join(BASE, "logs")
OUT = os.path.join(BASE, "capturas")
FONT = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSansMono.ttf", 15)
FONT_B = ImageFont.truetype("/usr/share/fonts/truetype/dejavu/DejaVuSansMono-Bold.ttf", 15)
MAX_COLS = 132
CW, LH, PAD, BAR = 9, 20, 14, 30

BG, FG, DIM = (24, 26, 33), (220, 223, 228), (120, 126, 140)
GREEN, CYAN, RED, YELLOW = (120, 220, 120), (110, 190, 240), (245, 110, 110), (240, 200, 90)

# nombre de archivo -> (titulo, log, [(linea_inicio, linea_fin), ...])
CAPTURAS = {
    "captura_01_entorno.png": ("Caracteristicas del entorno cloud", "01_entorno.log",
                               [(1, 68), (70, 77)]),
    "captura_02_preparacion.png": ("Preparacion: inicio del servicio Docker", "02_preparacion.log", [(1, 29)]),
    "captura_03_descarga_oracle.png": ("Descarga: intentos oficiales y descarga de la imagen", "03_descarga.log",
                                       [(1, 8), (19, 23), (34, 36), (53, 62), (64, 68)]),
    "captura_04_instalacion.png": ("Instalacion: creacion del volumen y del contenedor", "04_instalacion.log", [(1, 15)]),
    "captura_05_configuracion.png": ("Configuracion e inicializacion de la base de datos", "05_configuracion.log",
                                     [(1, 7), (13, 19), (39, 53), (57, 67), (79, 81)]),
    "captura_06_oracle_iniciado.png": ("Servicio iniciado: procesos, listener y puerto", "06_servicio_procesos_puertos.log",
                                       [(1, 5), (17, 31), (34, 46), (49, 70)]),
    "captura_07_version_oracle.png": ("Version de Oracle (SQL*Plus como SYSDBA)", "07_version.log", [(1, 27)]),
    "captura_08c_conexion_sqlplus.png": ("Primera conexion SQL (SQL*Plus y cliente de red)", "08_primera_conexion.log", [(1, 48)]),
    "captura_09_creacion_usuario.png": ("Script 01: creacion del usuario TECH_TRANSITION", "09_script01_creacion_usuario.log",
                                        [(1, 3), (24, 59), (66, 74), (78, 91)]),
    "captura_10_creacion_tablas.png": ("Script 02: creacion de las tablas", "10_script02_creacion_tablas.log",
                                       [(1, 3), (38, 38), (54, 54), (69, 69), (88, 88), (94, 115), (138, 138), (346, 359)]),
    "captura_11_insercion_datos.png": ("Script 03: insercion de datos", "11_script03_insercion_datos.log",
                                       [(1, 3), (195, 205), (305, 312), (517, 559)]),
    "captura_12b_consultas_agregadas.png": ("Script 04: consultas de comprobacion (agrupaciones)", "12_script04_consultas.log",
                                            [(124, 160), (228, 254)]),
    "captura_12c_saldos_y_mas_vendidos.png": ("Script 04: saldos pendientes y articulos mas vendidos", "12_script04_consultas.log",
                                              [(255, 319)]),
    "captura_13b_claves_foraneas.png": ("Script 05: claves primarias y foraneas", "13_script05_verificacion.log",
                                        [(128, 168)]),
    "captura_14_prueba_final.png": ("Prueba final: reinicio del servicio y persistencia de datos", "15_prueba_final_reinicio.log",
                                    [(1, 18), (24, 56)]),
    "captura_14b_pruebas_integridad.png": ("Script 05: pruebas de integridad a-d (deben ser rechazadas)", "13_script05_verificacion.log",
                                           [(263, 313)]),
    "captura_14e_pruebas_integridad_2.png": ("Script 05: pruebas de integridad e-g y comprobacion final", "13_script05_verificacion.log",
                                             [(314, 370)]),
    "captura_14d_validacion_general.png": ("Script 05: validacion de servicio, conexiones, tablas y registros", "13_script05_verificacion.log",
                                           [(42, 125)]),
}


def color_de(linea):
    if linea.startswith("###"):
        return DIM, FONT
    if linea.startswith("root@cloud-vm"):
        return GREEN, FONT_B
    if linea.startswith("SQL>") or linea[:5].strip().isdigit() and linea[3:5] == "  ":
        return CYAN, FONT
    if "ORA-" in linea or "Error" in linea or "403" in linea or "not found" in linea:
        return RED, FONT
    if linea.startswith("[...]"):
        return YELLOW, FONT
    return FG, FONT


def render(nombre, titulo, log, rangos):
    with open(os.path.join(LOGS, log), encoding="utf-8") as f:
        todas = f.read().split("\n")
    lineas, anterior = [], None
    for ini, fin in rangos:
        if anterior is not None and ini > anterior + 1:
            lineas.append(f"[... lineas {anterior + 1}-{ini - 1} omitidas en esta imagen; ver log completo ...]")
        lineas.extend(todas[ini - 1:fin])
        anterior = fin
    lineas = [l.replace("\t", "    ") for l in lineas]
    lineas = [l if len(l) <= MAX_COLS else l[:MAX_COLS - 3] + "..." for l in lineas]
    while lineas and not lineas[-1].strip():
        lineas.pop()
    cols = max(90, max(len(l) for l in lineas))
    w = PAD * 2 + cols * CW
    h = BAR + PAD * 2 + LH * len(lineas)
    img = Image.new("RGB", (w, h), BG)
    d = ImageDraw.Draw(img)
    d.rectangle([0, 0, w, BAR], fill=(52, 56, 68))
    for i, c in enumerate([(237, 106, 94), (245, 191, 79), (98, 197, 84)]):
        d.ellipse([12 + i * 20, 9, 24 + i * 20, 21], fill=c)
    fuente = f"{titulo}  |  logs/{log} (lineas {', '.join(f'{a}-{b}' for a, b in rangos)})"
    d.text((80, 7), fuente[:cols + 2], font=FONT, fill=(200, 204, 214))
    y = BAR + PAD
    for l in lineas:
        col, fnt = color_de(l)
        d.text((PAD, y), l, font=fnt, fill=col)
        y += LH
    img.save(os.path.join(OUT, nombre))
    print(f"{nombre}: {len(lineas)} lineas, {w}x{h}px")


if __name__ == "__main__":
    os.makedirs(OUT, exist_ok=True)
    for nombre, (titulo, log, rangos) in CAPTURAS.items():
        render(nombre, titulo, log, rangos)
