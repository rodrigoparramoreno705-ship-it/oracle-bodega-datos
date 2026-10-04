"""
Genera el archivo plano de ventas CRUDAS de Spring Valley (datos ficticios, con fines academicos).

Simula la exportacion del sistema transaccional (OLTP) de ventas 2023-2025 e introduce a proposito
los problemas de calidad explicados en las sesiones:
  - espacios adicionales al inicio y al final;
  - mayusculas y minusculas inconsistentes en nombres, ciudades y codigos;
  - fechas en tres formatos distintos (AAAA-MM-DD, DD/MM/AAAA y DD-MM-AAAA);
  - sexo escrito de varias formas (M, m, Masculino, FEMENINO, fem...);
  - forma de pago escrita de varias formas (EFECTIVO, Efect., T. Credito, TC, transf, PSE...);
  - filas duplicadas (la misma linea exportada dos veces).
La semilla es fija, por lo que el archivo se puede regenerar exactamente igual.
"""
import csv
import random
from datetime import date, timedelta

random.seed(2026)

CLIENTES = [  # codigo, nombre, sexo, ciudad
    ("C001", "Andrea Milena Rojas", "F", "Bogotá"), ("C002", "Carlos Andrés Mejía", "M", "Bogotá"),
    ("C003", "Diana Patricia Gómez", "F", "Medellín"), ("C004", "Jorge Luis Herrera", "M", "Medellín"),
    ("C005", "Luisa Fernanda Castro", "F", "Cali"), ("C006", "Miguel Ángel Ramírez", "M", "Cali"),
    ("C007", "Paola Andrea Vargas", "F", "Barranquilla"), ("C008", "Ricardo José Peña", "M", "Barranquilla"),
    ("C009", "Sandra Liliana Torres", "F", "Bogotá"), ("C010", "Felipe Antonio Ruiz", "M", "Medellín"),
    ("C011", "Natalia Sofía Cárdenas", "F", "Cali"), ("C012", "Hernán Darío Ospina", "M", "Barranquilla"),
    ("C013", "Valentina Moreno Díaz", "F", "Bogotá"), ("C014", "Sebastián Álvarez Gil", "M", "Medellín"),
    ("C015", "Camila Andrea Suárez", "F", "Cali"), ("C016", "Óscar Iván Londoño", "M", "Bogotá"),
    ("C017", "Mariana López Quintero", "F", "Barranquilla"), ("C018", "Julián David Pardo", "M", "Cali"),
    ("C019", "Laura Cristina Mesa", "F", "Medellín"), ("C020", "Andrés Felipe Silva", "M", "Bogotá"),
]
PRODUCTOS = [  # codigo, nombre (catalogo en MAYUSCULAS), categoria, precio
    ("P001", "AGUA MANANTIAL 600 ML", "AGUAS", 2500), ("P002", "AGUA MANANTIAL 1.5 L", "AGUAS", 4200),
    ("P003", "AGUA CON GAS 600 ML", "AGUAS", 3000), ("P004", "JUGO NATURAL NARANJA 1 L", "JUGOS", 7800),
    ("P005", "JUGO NATURAL MANGO 1 L", "JUGOS", 7500), ("P006", "TE VERDE FRIO 500 ML", "TES", 4500),
    ("P007", "TE NEGRO LIMON 500 ML", "TES", 4300), ("P008", "BEBIDA ISOTONICA 600 ML", "BEBIDAS FUNCIONALES", 5200),
    ("P009", "BEBIDA PROTEICA 330 ML", "BEBIDAS FUNCIONALES", 9800), ("P010", "BARRA DE CEREAL X6", "SNACKS SALUDABLES", 12500),
    ("P011", "MIX DE FRUTOS SECOS 200 G", "SNACKS SALUDABLES", 15900), ("P012", "GALLETAS INTEGRALES X12", "SNACKS SALUDABLES", 8900),
]
VENDEDORES = [  # codigo, nombre, sucursal
    ("V01", "Martha Elena Ríos", "S01"), ("V02", "Juan Pablo Arango", "S01"), ("V03", "Claudia Marcela Henao", "S02"),
    ("V04", "Daniel Esteban Correa", "S02"), ("V05", "Gloria Inés Muñoz", "S03"), ("V06", "Fabián Alberto Rincón", "S03"),
    ("V07", "Yesenia Paola Barrios", "S04"), ("V08", "Álvaro José Montes", "S04"),
]
SUCURSALES = [  # codigo, nombre, ciudad
    ("S01", "Spring Valley Bogotá Centro", "Bogotá"), ("S02", "Spring Valley Medellín Laureles", "Medellín"),
    ("S03", "Spring Valley Cali Norte", "Cali"), ("S04", "Spring Valley Barranquilla Prado", "Barranquilla"),
]
FORMAS = ["Efectivo", "Tarjeta crédito", "Tarjeta débito", "Transferencia"]
SEXO_SUCIO = {"M": ["M", "m", "Masculino", "MASCULINO", " hombre"], "F": ["F", "f", "Femenino", "FEMENINO", "fem "]}
PAGO_SUCIO = {
    "Efectivo": ["Efectivo", "EFECTIVO", " efectivo", "Efect."],
    "Tarjeta crédito": ["Tarjeta Crédito", "tarjeta credito", "T. Credito", "TC"],
    "Tarjeta débito": ["Tarjeta Débito", "tarjeta debito", "T. Debito", "TD"],
    "Transferencia": ["Transferencia", "TRANSFERENCIA", "transf", "PSE"],
}
# volumen de facturas por anio: refleja un crecimiento del negocio
FACTURAS_POR_ANIO = {2023: 70, 2024: 85, 2025: 100}


def ensuciar_texto(t):
    r = random.random()
    if r < 0.25:
        t = t.upper()
    elif r < 0.45:
        t = t.lower()
    if random.random() < 0.35:
        t = " " * random.randint(1, 3) + t + " " * random.randint(0, 2)
    return t


def ensuciar_codigo(c):
    r = random.random()
    if r < 0.2:
        return c.lower()
    if r < 0.35:
        return " " + c + " "
    return c


def fecha_sucia(d):
    r = random.random()
    if r < 0.5:
        return d.strftime("%Y-%m-%d")
    if r < 0.8:
        return d.strftime("%d/%m/%Y")
    return d.strftime("%d-%m-%Y")


filas = []
num = 10000
for anio, n in FACTURAS_POR_ANIO.items():
    inicio = date(anio, 1, 1)
    dias = sorted(random.randint(0, 364) for _ in range(n))
    for d in dias:
        num += 1
        f = inicio + timedelta(days=d)
        cli = random.choice(CLIENTES)
        suc = random.choice(SUCURSALES)
        ven = random.choice([v for v in VENDEDORES if v[2] == suc[0]])
        forma = random.choices(FORMAS, weights=[35, 30, 15, 20])[0]
        for prod in random.sample(PRODUCTOS, random.randint(1, 3)):
            cantidad = random.choice([1, 2, 3, 4, 5, 6, 8, 10, 12, 24])
            filas.append([
                f"FV-{num}", fecha_sucia(f),
                ensuciar_codigo(cli[0]), ensuciar_texto(cli[1]), random.choice(SEXO_SUCIO[cli[2]]), ensuciar_texto(cli[3]),
                ensuciar_codigo(prod[0]), ensuciar_texto(prod[1]), ensuciar_texto(prod[2]),
                ensuciar_codigo(ven[0]), ensuciar_texto(ven[1]),
                ensuciar_codigo(suc[0]), ensuciar_texto(suc[1]), ensuciar_texto(suc[2]),
                random.choice(PAGO_SUCIO[forma]), str(cantidad), str(prod[3]),
            ])

# duplicados controlados: 10 lineas exportadas dos veces
for i in sorted(random.sample(range(len(filas)), 10), reverse=True):
    filas.insert(i + 1, list(filas[i]))

ENC = ["NUMERO_FACTURA", "FECHA_FACTURA", "CODIGO_CLIENTE", "NOMBRE_CLIENTE", "SEXO", "CIUDAD_CLIENTE",
       "CODIGO_PRODUCTO", "NOMBRE_PRODUCTO", "CATEGORIA", "CODIGO_VENDEDOR", "NOMBRE_VENDEDOR",
       "CODIGO_SUCURSAL", "NOMBRE_SUCURSAL", "CIUDAD_SUCURSAL", "FORMA_PAGO", "CANTIDAD", "PRECIO_UNITARIO"]
with open("ventas_crudas_spring_valley.csv", "w", newline="", encoding="utf-8") as fh:
    w = csv.writer(fh, quoting=csv.QUOTE_ALL)
    w.writerow(ENC)
    w.writerows(filas)
print(f"Filas de datos: {len(filas)} (incluye 10 duplicados); facturas: {num - 10000}")
