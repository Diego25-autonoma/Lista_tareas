#!/usr/bin/env bash
# Instalar dependencias
apt-get update && apt-get install -y apt-transport-https curl
# Agregar las llaves de Microsoft para SQL Server
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
# Agregar los repositorios de Microsoft
curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
# Actualizar lista de paquetes
apt-get update
# Aceptar el EULA e instalar ODBC Driver y herramientas de UnixODBC
ACCEPT_EULA=Y apt-get install -y msodbcsql17 unixodbc-dev
# Verificar que se haya instalado correctamente
echo "ODBC Driver instalado correctamente."

