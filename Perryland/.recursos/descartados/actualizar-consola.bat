@echo off


cd /d %~dp0

chcp 65001 >nul

setlocal

set "carpeta=.minecraft"
set crear_acceso=0

rem Obtener la ruta actual
set "ruta_actual=%cd%"


call :completa

endlocal

REM Función completa

:completa

REM Acyualizando skins en silencio
echo Actualizando skins
curl -s -o skins.zip -L http://mochos.sytes.net:8000/offlineskins/skins.zip
tar -xf skins.zip --strip-components=0
del skins.zip

REM Descargar el archivo remoto "version.txt"
curl -s -o version_remote.txt https://raw.githubusercontent.com/mochos/actualizador/main/Perryland/actualizar/version.txt

REM Verificar si existe el archivo local version.txt
if exist version.txt (
    REM Comparar el archivo remoto con el archivo local
    fc /b "version.txt" "version_remote.txt" > nul
    REM Verificar el código de error de fc (0 si son idénticos, 1 si son diferentes)
    if errorlevel 1 (

        call :actualizar
        exit

    ) else (
        echo Comprobando actualizaciones...
        del /q version_remote.txt
        echo ¡TIENES LA VERSIÓN MÁS RECIENTE INSTALADA!
        exit
    )
) else (

    call :instalar
    call :actualizar
    exit

)


REM Función instalar
:instalar
REM -----------------------------------------------

    echo Iniciando instalación...
    echo Descargando archivos base...

    REM Descargar el archivo ZIP del repositorio
    curl -s -L -o instalar.zip http://mochos.sytes.net:8000/perryland/instalar.zip

    echo Extrayendo archivos...

    REM Descomprimir el archivo ZIP en la carpeta temporal
    tar -xf instalar.zip --strip-components=0

    echo Eliminando temporales...

    REM Eliminar archivos temporales
    del /q instalar.zip

    exit /b

REM Función actualizar
:actualizar
REM -----------------------------------------------

    echo Comprobando actualizaciones...

    REM Verifica si la carpeta existe
    if exist "mods" (
        pushd "mods"
        echo Eliminando versiones antiguas...

        REM Identificar y mover los archivos que comienzan con "NB_" a una carpeta temporal
        mkdir temp
        for %%F in (NB_*) do (
            move "%%F" temp\ > nul 2>&1
        )

        REM Eliminar todos los archivos restantes en la carpeta
        del /q *

        REM Mover de vuelta los archivos que habían comenzado con "NB_"
        move temp\* . > nul 2>&1
        rmdir /q /s temp

        popd
    )

    echo Descargando mods...

    REM Descargar el archivo ZIP del repositorio
    curl -s -L -o actualizar.zip http://mochos.sytes.net:8000/perryland/actualizar.zip


    echo Extrayendo archivos...

    REM Descomprimir el archivo ZIP en la carpeta temporal
    tar -xf actualizar.zip --strip-components=0

    echo Eliminando temporales...

    REM Eliminar archivos temporales
    del /q actualizar.zip
    del /q version_remote.txt

    echo ¡INSTALACIÓN TERMINADA!

    exit /b