from flask import Flask, render_template, request, redirect
import pyodbc
import os

# Configuración de la aplicación Flask
app = Flask(__name__)

# Conexión a SQL Server usando variables de entorno
conexion = pyodbc.connect(
    "DRIVER={ODBC Driver 18 for SQL Server};"
    "SERVER=DESKTOP-TVTIM2S\\SQLEXPRESS;"
    "DATABASE=ListaDeTareas;"
    "UID=sa;"
    "PWD=AMPUERO20#;"
)
cursor = conexion.cursor()

# Ruta principal
@app.route('/')
def index():
    cursor.execute("SELECT * FROM Tareas")
    tareas = cursor.fetchall()
    return render_template('index.html', tareas=tareas)

# Ruta para agregar una nueva tarea
@app.route('/agregar', methods=['POST'])
def agregar_tarea():
    descripcion = request.form['descripcion']
    cursor.execute("INSERT INTO Tareas (descripcion, completado) VALUES (?, ?)", (descripcion, 0))
    conexion.commit()
    return redirect('/')

# Ruta para marcar una tarea como completada
@app.route('/completar/<int:tarea_id>')
def completar_tarea(tarea_id):
    cursor.execute("UPDATE Tareas SET completado = 1 WHERE id = ?", (tarea_id,))
    conexion.commit()
    return redirect('/')

# Ruta para eliminar una tarea
@app.route('/eliminar/<int:tarea_id>')
def eliminar_tarea(tarea_id):
    cursor.execute("DELETE FROM Tareas WHERE id = ?", (tarea_id,))
    conexion.commit()
    return redirect('/')

# Ejecutar el servidor
if __name__ == '__main__':
    app.run(debug=True)


