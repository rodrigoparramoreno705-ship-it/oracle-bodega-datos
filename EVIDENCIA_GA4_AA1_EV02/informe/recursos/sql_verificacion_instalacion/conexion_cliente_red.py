# Prueba de conexion por red TCP (puerto 1521) desde el host, como lo haria un cliente externo.
import oracledb
dsn = "localhost:1521/FREEPDB1"
with oracledb.connect(user="system", password="Sena2026Oracle", dsn=dsn) as con:
    print("Cliente python-oracledb", oracledb.__version__, "(modo thin)")
    print("DSN:", dsn)
    print("Version del servidor:", con.version)
    cur = con.cursor()
    cur.execute("select sys_context('USERENV','CON_NAME'), user, to_char(sysdate,'YYYY-MM-DD HH24:MI:SS') from dual")
    print("Contenedor / usuario / fecha:", cur.fetchone())
