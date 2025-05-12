#!/usr/bin/env bash
echo "Instalando dependencias necesarias..."
apt-get update && apt-get install -y apt-transport-https
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
apt-get update && ACCEPT_EULA=Y apt-get install -y msodbcsql17 unixodbc-dev
echo "Instalación completada."
