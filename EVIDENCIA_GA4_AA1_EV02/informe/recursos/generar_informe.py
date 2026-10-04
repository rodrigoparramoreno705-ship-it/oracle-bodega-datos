"""
Construye el informe de la evidencia GA4-210602033-AA1-EV02.

1. Lee informe/recursos/plantilla_informe.md y reemplaza los marcadores:
     {{LOG:archivo.log:ini-fin}}  -> bloque de codigo con esas lineas LITERALES de logs/
     {{FILE:ruta}}                -> contenido completo del archivo (scripts SQL, Mermaid)
     {{DICC:TABLA}}               -> tabla Markdown construida desde resultados/diccionario_datos.csv
   y escribe informe/informe_evidencia.md (documento fuente).
2. Convierte el Markdown a HTML y genera el PDF con Chromium (Playwright).
   La tabla de contenido se numera en dos pasadas leyendo el PDF con pypdf.

Uso: python3 generar_informe.py [ruta_chromium]
"""
import csv, html, os, re, sys
import markdown
from pypdf import PdfReader
from playwright.sync_api import sync_playwright

RAIZ = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
INFORME = os.path.join(RAIZ, "informe")
PDF = os.path.join(RAIZ, "GA4-210602033-AA1-EV02_Instalacion_Oracle.pdf")
CHROMIUM = sys.argv[1] if len(sys.argv) > 1 else "/opt/pw-browsers/chromium-1194/chrome-linux/chrome"


def leer(ruta):
    with open(os.path.join(RAIZ, ruta), encoding="utf-8") as f:
        return f.read()


def log(m):
    archivo, rango = m.group(1), m.group(2)
    ini, fin = map(int, rango.split("-"))
    lineas = leer("logs/" + archivo).split("\n")[ini - 1:fin]
    cuerpo = "\n".join(l.replace("\t", "    ") for l in lineas).rstrip()
    return f"*Extracto literal de `logs/{archivo}` (líneas {ini}–{fin}):*\n\n```text\n{cuerpo}\n```"


def diccionario(m):
    tabla = m.group(1)
    with open(os.path.join(RAIZ, "resultados/diccionario_datos.csv"), encoding="utf-8") as f:
        filas = [r for r in csv.DictReader(f) if r.get("TABLA") == tabla]
    out = ["| Tabla | Columna | Descripción | Tipo de dato | Longitud | Permite NULL | PK | FK | Tabla relacionada |",
           "|---|---|---|---|---|:---:|:---:|:---:|---|"]
    for r in filas:
        desc = r["DESCRIPCION"].strip() + (" (columna virtual)" if r["VIRTUAL"] == "YES" and "virtual" not in r["DESCRIPCION"].lower() else "")
        out.append(f"| {r['TABLA']} | {r['COLUMNA']} | {desc} | {r['TIPO_DATO']} | {r['LONGITUD']} | "
                   f"{r['PERMITE_NULL']} | {r['PK']} | {r['FK']} | {r['TABLA_RELACIONADA']} |")
    return "\n".join(out)


def construir_md():
    md = leer("informe/recursos/plantilla_informe.md")
    md = re.sub(r"\{\{LOG:([\w.\-]+):(\d+-\d+)\}\}", log, md)
    md = re.sub(r"\{\{FILE:([\w./\-]+)\}\}", lambda m: leer(m.group(1)).rstrip(), md)
    md = re.sub(r"\{\{DICC:(\w+)\}\}", diccionario, md)
    return md


CSS = """
@page { size: A4; margin: 2.2cm 2.2cm 2.2cm 2.5cm; }
body { font-family: 'Liberation Sans', Arial, sans-serif; font-size: 11pt; line-height: 1.45; color: #1d1d1d; }
h2 { font-size: 15pt; color: #0b4f6c; border-bottom: 2px solid #39a935; padding-bottom: 3px; margin-top: 26px; break-after: avoid; }
h3 { font-size: 12.5pt; color: #0b4f6c; margin-top: 18px; break-after: avoid; }
h4 { font-size: 11pt; margin-top: 14px; break-after: avoid; }
p { text-align: justify; margin: 6px 0; }
table { border-collapse: collapse; width: 100%; font-size: 8.8pt; margin: 6px 0 12px; }
th { background: #0b4f6c; color: white; padding: 4px 5px; text-align: left; }
td { border: 1px solid #c9d3da; padding: 3px 5px; vertical-align: top; }
tr { break-inside: avoid; }
tr:nth-child(even) td { background: #f3f7f9; }
code { font-family: 'DejaVu Sans Mono', monospace; font-size: 8.6pt; background: #f1f3f5; padding: 0 2px; }
pre { background: #f6f8fa; border: 1px solid #d5dbe0; border-left: 4px solid #39a935; padding: 7px 9px; font-size: 7.4pt;
      line-height: 1.3; white-space: pre-wrap; word-break: break-all; }
pre code { background: none; font-size: 7.4pt; padding: 0; }
img { display: block; max-width: 100%; max-height: 20.5cm; margin: 12px auto 4px; border: 1px solid #b8c2ca; break-inside: avoid; }
p:has(> img) { break-inside: avoid; break-after: avoid; }
p:has(> img) + p { text-align: center; font-size: 10pt; margin-bottom: 4px; }
.portada { height: 24.5cm; text-align: center; break-after: page; display: flex; flex-direction: column; justify-content: center; }
.portada .entidad { font-size: 15pt; font-weight: bold; color: #39a935; letter-spacing: 1px; }
.portada .programa { font-size: 12pt; margin: 8px 0 60px; }
.portada .titulo { font-size: 24pt; font-weight: bold; color: #0b4f6c; }
.portada .subtitulo { font-size: 18pt; font-weight: bold; margin-top: 10px; }
.portada .subtitulo2 { font-size: 13pt; margin: 6px 0 60px; color: #444; }
.datos-portada { width: 80%; margin: 0 auto; font-size: 11.5pt; }
.datos-portada td { padding: 7px 10px; border: 1px solid #9fb1bd; text-align: left; background: white !important; }
.datos-portada td:first-child { font-weight: bold; width: 38%; background: #eef4f7 !important; }
.nota-portada { margin-top: 50px; font-size: 9.5pt; color: #555; }
.tdc { break-after: page; }
h3[id^="anexo"] { break-before: page; }
p:has(+ table) { break-after: avoid; }
h2#22-anexos + h3 { break-before: avoid; }
.tdc ul { list-style: none; padding-left: 0; margin: 0; }
.tdc li { margin: 2px 0; }
.tdc li.h3 { padding-left: 22px; font-size: 10pt; }
.tdc a { color: #1d1d1d; text-decoration: none; display: flex; }
.tdc a .t { flex: 0 1 auto; }
.tdc a .dots { flex: 1; border-bottom: 1px dotted #888; margin: 0 4px 4px; }
"""


def html_de(md, paginas):
    cuerpo = markdown.markdown(md, extensions=["tables", "fenced_code", "attr_list", "toc", "md_in_html"])
    # Tabla de contenido con numero de pagina
    items = []
    for nivel, hid, texto in re.findall(r'<h([23]) id="([^"]+)">(.*?)</h\1>', cuerpo):
        if "Tabla de contenido" in texto:
            continue
        plano = html.unescape(re.sub("<[^>]+>", "", texto))
        pag = paginas.get(plano, "")
        items.append(f'<li class="h{nivel}"><a href="#{hid}"><span class="t">{html.escape(plano)}</span>'
                     f'<span class="dots"></span><span>{pag}</span></a></li>')
    cuerpo = cuerpo.replace("<p>{{TOC}}</p>", "<ul>" + "\n".join(items) + "</ul>")
    return (f"<!doctype html><html lang='es'><head><meta charset='utf-8'><base href='file://{INFORME}/'>"
            f"<title>GA4-210602033-AA1-EV02</title><style>{CSS}</style></head><body>{cuerpo}</body></html>")


def imprimir(html_txt, destino):
    ruta_html = os.path.join(INFORME, "recursos", "_informe_tmp.html")
    with open(ruta_html, "w", encoding="utf-8") as f:
        f.write(html_txt)
    with sync_playwright() as p:
        b = p.chromium.launch(executable_path=CHROMIUM)
        pg = b.new_page()
        pg.goto("file://" + ruta_html, wait_until="networkidle")
        pg.pdf(path=destino, format="A4", print_background=True, display_header_footer=True,
               header_template="<div style='font-size:7.5pt;width:100%;text-align:right;margin-right:2.2cm;color:#777'>"
                               "GA4-210602033-AA1-EV02 – Instalación de motor de base de datos Oracle</div>",
               footer_template="<div style='font-size:8pt;width:100%;text-align:center;color:#555'>"
                               "Página <span class='pageNumber'></span> de <span class='totalPages'></span></div>",
               margin={"top": "2.2cm", "bottom": "2.2cm", "left": "2.5cm", "right": "2.2cm"})
        b.close()
    os.remove(ruta_html)


def paginas_de_titulos(md, pdf):
    textos = [re.sub(r"\s+", " ", (pg.extract_text() or "")) for pg in PdfReader(pdf).pages]
    titulos = [re.sub(r"\s*\{[^}]*\}\s*$", "", t).strip() for t in re.findall(r"^#{2,3} (.+)$", md, re.M)]
    res, desde = {}, 2  # se busca despues de la portada y la tabla de contenido
    for t in titulos:
        if "Tabla de contenido" in t:
            continue
        plano = re.sub(r"[`*]", "", t)
        for i in range(desde, len(textos)):
            if plano in textos[i]:
                res[plano] = i + 1
                desde = i
                break
    return res


if __name__ == "__main__":
    md = construir_md()
    with open(os.path.join(INFORME, "informe_evidencia.md"), "w", encoding="utf-8") as f:
        f.write(md)
    print("informe/informe_evidencia.md generado")
    imprimir(html_de(md, {}), PDF)                 # pasada 1: ubicar titulos
    paginas = paginas_de_titulos(md, PDF)
    imprimir(html_de(md, paginas), PDF)            # pasada 2: tabla de contenido numerada
    print(f"PDF generado: {PDF} ({len(PdfReader(PDF).pages)} paginas); titulos ubicados: {len(paginas)}")


# ---------------------------------------------------------------------------
# Campos editables de la portada: se agregan campos de formulario (AcroForm)
# sobre los textos "[...]" de la tabla de la portada, ubicados con pdftotext -bbox.
# ---------------------------------------------------------------------------
def campos_portada():
    import subprocess
    from pypdf import PdfWriter
    from pypdf.generic import (ArrayObject, BooleanObject, DictionaryObject, FloatObject,
                               NameObject, NumberObject, TextStringObject)
    xml = subprocess.run(["pdftotext", "-bbox-layout", "-f", "1", "-l", "1", PDF, "-"],
                         capture_output=True, text=True, check=True).stdout
    lineas = []
    for attrs, cuerpo in re.findall(r"<line ([^>]*)>(.*?)</line>", xml, re.S):
        texto = " ".join(html.unescape(t) for t in re.findall(r">([^<]+)</word>", cuerpo))
        if texto.startswith("[") and texto.endswith("]"):
            caja = dict(re.findall(r'(\w+)="([\d.]+)"', attrs))
            lineas.append((texto, float(caja["xMin"]), float(caja["yMin"]), float(caja["yMax"])))
    etiquetas = ["Nombre del aprendiz", "Programa de formación", "Instructor", "Ficha",
                 "Centro de formación", "Ciudad", "Fecha"]
    assert len(lineas) == len(etiquetas), lineas
    w = PdfWriter(clone_from=PDF)
    pagina = w.pages[0]
    alto = float(pagina.mediabox.height)
    ancho_util = (21.0 - 2.5 - 2.2) / 2.54 * 72
    borde_der = 2.5 / 2.54 * 72 + ancho_util / 2 + ancho_util * 0.8 / 2 - 5   # tabla al 80 % centrada
    helv = DictionaryObject({NameObject("/Type"): NameObject("/Font"), NameObject("/Subtype"): NameObject("/Type1"),
                             NameObject("/BaseFont"): NameObject("/Helvetica"),
                             NameObject("/Encoding"): NameObject("/WinAnsiEncoding")})
    campos, anots = ArrayObject(), pagina.get("/Annots", ArrayObject())
    for etiqueta, (valor, x0, y0, y1) in zip(etiquetas, lineas):
        rect = [x0 - 3, alto - y1 - 5, borde_der, alto - y0 + 5]
        campo = DictionaryObject({
            NameObject("/Type"): NameObject("/Annot"), NameObject("/Subtype"): NameObject("/Widget"),
            NameObject("/FT"): NameObject("/Tx"), NameObject("/T"): TextStringObject(etiqueta),
            NameObject("/TU"): TextStringObject(etiqueta), NameObject("/V"): TextStringObject(valor),
            NameObject("/DA"): TextStringObject("/Helv 10 Tf 0 g"), NameObject("/F"): NumberObject(4),
            NameObject("/Rect"): ArrayObject([FloatObject(v) for v in rect]),
            NameObject("/MK"): DictionaryObject({NameObject("/BG"): ArrayObject([FloatObject(1)] * 3)}),
            NameObject("/P"): pagina.indirect_reference})
        ref = w._add_object(campo)
        campos.append(ref); anots.append(ref)
    pagina[NameObject("/Annots")] = anots
    w._root_object[NameObject("/AcroForm")] = DictionaryObject({
        NameObject("/Fields"): campos, NameObject("/NeedAppearances"): BooleanObject(True),
        NameObject("/DA"): TextStringObject("/Helv 10 Tf 0 g"),
        NameObject("/DR"): DictionaryObject({NameObject("/Font"): DictionaryObject({NameObject("/Helv"): w._add_object(helv)})})})
    w.write(PDF)
    print(f"Portada: {len(campos)} campos editables agregados")


if __name__ == "__main__":
    campos_portada()
