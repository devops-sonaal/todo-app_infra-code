#!/bin/bash

echo "------ Updating System ------"
sudo apt update -y
sudo apt upgrade -y

echo "------ Installing Python ------"
sudo apt install python3 -y
sudo apt install python3-pip -y
sudo apt install python3-venv -y

echo "------ Installing ODBC Dependencies ------"
sudo apt install unixodbc unixodbc-dev -y

echo "------ Installing Python Packages ------"
pip3 install pyodbc
pip3 install fastapi
pip3 install "uvicorn[standard]"
pip3 install pydantic
pip3 install azure-identity
pip3 install python-dotenv

echo "------ Installing SQL Server ODBC Driver ------"
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
curl https://packages.microsoft.com/config/ubuntu/22.04/prod.list | sudo tee /etc/apt/sources.list.d/mssql-release.list

sudo apt update -y
sudo ACCEPT_EULA=Y apt install msodbcsql18 -y

echo "------ Installation Complete ------"
echo "Python + FastAPI + ODBC + Azure dependencies ready!"
