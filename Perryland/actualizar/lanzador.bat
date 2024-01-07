@echo off
echo Archivo de control creado > control
start cmd /k instalar-integrado.bat

:LOOP
if not exist control (
    exit /b
)
goto LOOP