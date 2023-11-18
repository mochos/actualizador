@echo off

REM Eliminar la carpeta "prueba2" si existe
if exist prueba2 (
    rmdir /s /q prueba2
)

REM Verifica si la carpeta existe
if exist "prueba" (
    pushd "prueba"

    REM Identificar y mover los archivos que comienzan con "NB_" a una carpeta temporal
    mkdir temp
    for %%F in (NB_*) do (
        move "%%F" temp\
    )

    REM Eliminar todos los archivos restantes en la carpeta
    del /q *

    REM Mover de vuelta los archivos que habían comenzado con "NB_"
    move temp\* .
    rmdir /q /s temp

    popd
)

REM Descargar el archivo ZIP del repositorio
REM curl -L -o repo.zip https://github.com/lorspi/FirmasLatin/archive/main.zip

REM Descomprimir el archivo ZIP en la carpeta temporal
REM tar -xf repo.zip --strip-components=1

REM Eliminar archivos temporales
REM del /q repo.zip


REM Falta: Que lea el txt local y el txt del github y compare las versiones. Segun eso decide si actualizar o no.

pause