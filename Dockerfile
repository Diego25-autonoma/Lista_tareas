# Usar una imagen base de Python
FROM python:3.11-slim

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y apt-transport-https curl gnupg2 unixodbc-dev

# Instalar Microsoft ODBC Driver 18 para SQL Server
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql18

# Crear el directorio de la app
WORKDIR /app

# Copiar los archivos al contenedor
COPY . /app

# Instalar dependencias de Python
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Exponer el puerto
EXPOSE 5000

# Comando para ejecutar la aplicación
CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:5000"]
