"""Renderiza informe/recursos/modelo_relacional.mmd a PNG con mermaid.js y Chromium (Playwright).
Uso: python3 render_mermaid.py <ruta_mermaid.min.js> <ruta_chromium>"""
import os, sys
from playwright.sync_api import sync_playwright
aqui = os.path.dirname(os.path.abspath(__file__))
codigo = open(os.path.join(aqui, "modelo_relacional.mmd"), encoding="utf-8").read()
js = open(sys.argv[1], encoding="utf-8").read()
html = f"""<html><body style="margin:0;background:white"><pre class="mermaid">{codigo}</pre>
<script>{js}</script><script>mermaid.initialize({{startOnLoad:true, theme:'neutral', er:{{fontSize:14}}}});</script></body></html>"""
with sync_playwright() as p:
    b = p.chromium.launch(executable_path=sys.argv[2])
    pg = b.new_page(device_scale_factor=2, viewport={"width": 1300, "height": 900})
    pg.set_content(html); pg.wait_for_selector("pre.mermaid svg")
    pg.locator("pre.mermaid svg").screenshot(path=os.path.join(aqui, "modelo_relacional.png"))
    b.close()
print("modelo_relacional.png generado")
