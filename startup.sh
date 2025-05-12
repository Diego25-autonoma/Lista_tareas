#!/usr/bin/env bash
# Actualización de paquetes
apt-get update && apt-get install -y apt-transport-https curl

# Agregar llaves de Microsoft para SQL Server
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

# Agregar repositorios de Microsoft para Ubuntu 20.04
curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list

# Actualizar y aceptar el EULA de Microsoft
apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql17 unixodbc-dev

# Verificar instalación
if [ -f /opt/microsoft/msodbcsql17/lib64/libmsodbcsql-17.9.so.1.1 ]; then
    echo "ODBC Driver instalado correctamente."
else
    echo "Error al instalar ODBC Driver."
    exit 1
fi

