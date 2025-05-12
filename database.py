import pyodbc

# Configuración de la conexión a SQL Server
conexion = pyodbc.connect(
    "DRIVER={ODBC Driver 17 for SQL Server};"
    "SERVER=DESKTOP-TVTIM2S\\SQLEXPRESS;"
    "DATABASE=ListaDeTareas;"
    "UID=sa;"
    "PWD=AMPUERO20#;"
)

# cursor para ejecutar consultas SQL
cursor = conexion.cursor()

# Comprobación simple
print("Conexión exitosa a SQL Server")

# Función para leer los datos
def leer_tareas():
    cursor.execute("SELECT * FROM Tareas")
    tareas = cursor.fetchall()
    
    print("\n📌 Listado de Tareas:")
    for tarea in tareas:
        estado = "Completada ✅" if tarea.completado else "Pendiente ⏳"
        print(f"- {tarea.id}: {tarea.descripcion} → {estado}")

# Llamada a la función
leer_tareas()
