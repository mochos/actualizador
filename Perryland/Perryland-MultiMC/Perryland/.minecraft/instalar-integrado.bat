@echo off
title Perryland - Instalador

mode con: cols=63 lines=18

cd /d %~dp0

chcp 65001 >nul

setlocal

rem Obtener la ruta actual
set "ruta_actual=%cd%"
set MODPACK=https://mochos.xyz/perryland/modpack/
set SKINS=https://mochos.xyz/offlineskins/skins.zip

call :completa

endlocal

REM Función completa

:completa

rem Verificar conexión con el servidor
call :cabecera
echo │  Verificando conexión...                                    │
echo │                                                             │
echo │                                                             │
echo │                                                             │
echo │                                                             │
echo │                                                             │
echo │                                                             │
echo │                                                             │
echo │                                                             │
echo └─────────────────────────────────────────────────────────────┘
timeout /nobreak /t 1 >nul

set "archivo=activo"
set "verificar_texto=activo"

curl -s -o %archivo% -L %MODPACK%%archivo%
for /f "delims=" %%i in (%archivo%) do (set contenido=%%i)

if /i "%contenido%" equ "%verificar_texto%" (

    REM Acyualizando skins en silencio
    curl -s -o skins.zip -L %SKINS%
    tar -xf skins.zip --strip-components=0
    del skins.zip

    REM Descargar el archivo remoto "version.txt"
    curl -s -o version_remote.txt %MODPACK%version.txt

    REM Verificar si existe el archivo local version.txt
    if exist version.txt (
        REM Comparar el archivo remoto con el archivo local
        fc /b "version.txt" "version_remote.txt" > nul
        REM Verificar el código de error de fc (0 si son idénticos, 1 si son diferentes)
        if errorlevel 1 (
            

            call :actualizar

            REM Cerrando ventana en 7 secs...
            timeout /nobreak /t 7 >nul
            exit
        ) else (
            call :cabecera
            echo │  Comprobando actualizaciones...                             │
            echo │                                                             │
            echo │                                                             │
            echo │                                                             │
            echo │                                                             │
            echo │                                                             │
            echo │                                                             │
            echo │                                                             │
            echo │                                                             │
            echo └─────────────────────────────────────────────────────────────┘
            del /q version_remote.txt

            timeout /nobreak /t 2 >nul

            call :cabecera
            echo │  Comprobando actualizaciones... OK                          │
            echo │                                                             │
            echo │  ¡TIENES LA VERSIÓN MÁS RECIENTE INSTALADA!                 │
            echo │                                                             │
            echo │                                                             │
            echo │                                                             │
            echo │                                                             │
            echo │  Iniciando el juego...                                      │
            echo │                                                             │
            echo └─────────────────────────────────────────────────────────────┘
            del control
            REM Cerrando ventana en 7 secs...
            timeout /nobreak /t 7 >nul
            exit
        )
    ) else (


        call :instalar
        call :actualizar

        REM Cerrando ventana en 7 secs...
        timeout /nobreak /t 7 >nul
        exit
    )

) else (
    call :cabecera
    echo │  Verificando conexión... :(                                 │
    echo │                                                             │
    echo │  ¡IMPOSIBLE CONECTAR AL SERVIDOR!                           │
    echo │  Por favor intenta más tarde.                               │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │  Ya puedes cerrar esta ventana.                             │
    echo │                                                             │
    echo └─────────────────────────────────────────────────────────────┘
    del /Q %archivo% > nul 2>&1
    pause >nul
    exit
)


REM Función instalar
:instalar
REM -----------------------------------------------

    call :cabecera
    echo │  Iniciando instalación...                                   │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo └─────────────────────────────────────────────────────────────┘    

    call :cabecera
    echo │  Iniciando instalación... OK                                │
    echo │  Descargando archivos base...                               │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo └─────────────────────────────────────────────────────────────┘

    REM Descargar el archivo ZIP del repositorio
    curl -o instalar.zip --progress-bar %MODPACK%instalar.zip

    call :cabecera
    echo │  Iniciando instalación... OK                                │
    echo │  Descargando archivos base... OK                            │
    echo │  Extrayendo archivos...                                     │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo └─────────────────────────────────────────────────────────────┘

    REM Descomprimir el archivo ZIP en la carpeta temporal
    tar -xf instalar.zip --strip-components=0

    timeout /nobreak /t 3 >nul

    call :cabecera
    echo │  Iniciando instalación... OK                                │
    echo │  Descargando archivos base... OK                            │
    echo │  Extrayendo archivos... OK                                  │
    echo │  Eliminando temporales...                                   │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo └─────────────────────────────────────────────────────────────┘

    REM Eliminar archivos temporales
    del /q instalar.zip

    call :cabecera
    echo │  Iniciando instalación... OK                                │
    echo │  Descargando archivos base... OK                            │
    echo │  Extrayendo archivos... OK                                  │
    echo │  Eliminando temporales... OK                                │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo └─────────────────────────────────────────────────────────────┘

    timeout /nobreak /t 2 >nul

    exit /b


REM Función actualizar
:actualizar
REM -----------------------------------------------

    call :cabecera
    echo │  Comprobando actualizaciones...                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo └─────────────────────────────────────────────────────────────┘
    timeout /nobreak /t 1 >nul

    REM Verifica si la carpeta existe
    if exist "mods" (
        pushd "mods"
        call :cabecera
        echo │  Comprobando actualizaciones... OK                          │
        echo │  Eliminando versiones antiguas...                           │
        echo │                                                             │
        echo │                                                             │
        echo │                                                             │
        echo │                                                             │
        echo │                                                             │
        echo │                                                             │
        echo │                                                             │
        echo └─────────────────────────────────────────────────────────────┘

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
    
    timeout /nobreak /t 1 >nul

    call :cabecera
    echo │  Comprobando actualizaciones... OK                          │
    echo │  Eliminando versiones antiguas... OK                        │
    echo │  Descargando mods...                                        │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo └─────────────────────────────────────────────────────────────┘

    REM Descargar el archivo ZIP del repositorio
    curl -o actualizar.zip --progress-bar %MODPACK%actualizar.zip

    timeout /nobreak /t 1 >nul

    call :cabecera
    echo │  Comprobando actualizaciones... OK                          │
    echo │  Eliminando versiones antiguas... OK                        │
    echo │  Descargando mods... OK                                     │
    echo │  Extrayendo archivos...                                     │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo └─────────────────────────────────────────────────────────────┘

    REM Descomprimir el archivo ZIP en la carpeta temporal
    tar -xf actualizar.zip --strip-components=0

    timeout /nobreak /t 1 >nul

    call :cabecera
    echo │  Comprobando actualizaciones... OK                          │
    echo │  Eliminando versiones antiguas... OK                        │
    echo │  Descargando mods... OK                                     │
    echo │  Extrayendo archivos...   OK                                │
    echo │  Eliminando temporales...                                   │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo └─────────────────────────────────────────────────────────────┘

    REM Eliminar archivos temporales
    del /q actualizar.zip
    del /q version_remote.txt
    call :cabecera
    echo │  Comprobando actualizaciones... OK                          │
    echo │  Eliminando versiones antiguas... OK                        │
    echo │  Descargando mods... OK                                     │
    echo │  Extrayendo archivos...   OK                                │
    echo │  Eliminando temporales... OK                                │
    echo │                                                             │
    echo │  ¡INSTALACIÓN TERMINADA!                                    │
    echo │  Iniciando el juego...                                      │
    echo │                                                             │
    echo └─────────────────────────────────────────────────────────────┘

    del control
    exit /b

REM -----------------------------------------------

REM Cabecera
:cabecera
cls
echo     ┌─────┬─────┬─────┬─────┬──┬──┬──┐  ┌─────┬───┬─┬────╮
echo     │  ─  │   ──┤ ──  │ ──  │  │  │  │  │  ─  │   │ │  │ │
echo     │  ┌──┤   ──┤    ─┤    ─┼─┐ ┌─┤  └──┤     │ │ │ │  │ │
echo     └──┘  └─────┴──┴──┴──┴──┘ └─┘ └─────┴──┴──┴─┴───┴────╯
echo ┌─────────────────────────────────────────────────────────────┐
echo │                                                             │