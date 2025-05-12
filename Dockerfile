FROM python:3.11-slim

# Variables necesarias para aceptar la licencia de Microsoft
ENV ACCEPT_EULA=Y
ENV DEBIAN_FRONTEND=noninteractive

# Instala dependencias necesarias
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    curl \
    gnupg2 \
    unixodbc \
    unixodbc-dev \
    build-essential \
    gcc \
    g++ \
    libpq-dev

# Agrega la llave y repositorio de Microsoft para el driver ODBC 18
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/12/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql18

# Verificación de la instalación
RUN if [ -f /opt/microsoft/msodbcsql18/lib64/libmsodbcsql-18.2.so.1.1 ]; then \
        echo "ODBC Driver 18 instalado correctamente"; \
    else \
        echo "Error al instalar ODBC Driver"; \
        exit 1; \
    fi

# Crear el directorio de la app
WORKDIR /app

# Copiar los archivos al contenedor
COPY . .

# Instalar dependencias de Python
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Exponer el puerto de la aplicación
EXPOSE 5000

# Comando para iniciar la app
CMD ["gunicorn", "-b", "0.0.0.0:5000", "app:app"]
