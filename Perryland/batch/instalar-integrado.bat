@echo off
title Perryland - Instalador

mode con: cols=63 lines=17

cd /d %~dp0

chcp 65001 >nul

setlocal

rem Obtener la ruta actual
set "ruta_actual=%cd%"

call :completa

endlocal

REM Función completa

:completa

REM Acyualizando skins en silencio
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

        pause >nul
        exit
    ) else (
        cls
        echo     ┌─────┬─────┬─────┬─────┬──┬──┬──┐  ┌─────┬───┬─┬────╮
        echo     │  ─  │   ──┤ ──  │ ──  │  │  │  │  │  ─  │   │ │  │ │
        echo     │  ┌──┤   ──┤    ─┤    ─┼─┐ ┌─┤  └──┤     │ │ │ │  │ │
        echo     └──┘  └─────┴──┴──┴──┴──┘ └─┘ └─────┴──┴──┴─┴───┴────╯ 
        echo ┌─────────────────────────────────────────────────────────────┐
        echo │                                                             │
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

        cls
        echo     ┌─────┬─────┬─────┬─────┬──┬──┬──┐  ┌─────┬───┬─┬────╮
        echo     │  ─  │   ──┤ ──  │ ──  │  │  │  │  │  ─  │   │ │  │ │
        echo     │  ┌──┤   ──┤    ─┤    ─┼─┐ ┌─┤  └──┤     │ │ │ │  │ │
        echo     └──┘  └─────┴──┴──┴──┴──┘ └─┘ └─────┴──┴──┴─┴───┴────╯
        echo ┌─────────────────────────────────────────────────────────────┐
        echo │                                                             │
        echo │  Comprobando actualizaciones... OK                          │
        echo │                                                             │
        echo │  ¡TIENES LA VERSIÓN MÁS RECIENTE INSTALADA!                 │
        echo │                                                             │
        echo │                                                             │
        echo │                                                             │
        echo │                                                             │
        echo │  Ya puedes cerrar esta ventana.                             │
        echo │                                                             │
        echo └─────────────────────────────────────────────────────────────┘
        del control
        pause >nul
        exit
    )
) else (


    call :instalar
    call :actualizar

    pause >nul
    exit
)


REM Función instalar
:instalar
REM -----------------------------------------------

    cls
    echo     ┌─────┬─────┬─────┬─────┬──┬──┬──┐  ┌─────┬───┬─┬────╮
    echo     │  ─  │   ──┤ ──  │ ──  │  │  │  │  │  ─  │   │ │  │ │
    echo     │  ┌──┤   ──┤    ─┤    ─┼─┐ ┌─┤  └──┤     │ │ │ │  │ │
    echo     └──┘  └─────┴──┴──┴──┴──┘ └─┘ └─────┴──┴──┴─┴───┴────╯
    echo ┌─────────────────────────────────────────────────────────────┐
    echo │                                                             │
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

    cls
    echo     ┌─────┬─────┬─────┬─────┬──┬──┬──┐  ┌─────┬───┬─┬────╮
    echo     │  ─  │   ──┤ ──  │ ──  │  │  │  │  │  ─  │   │ │  │ │
    echo     │  ┌──┤   ──┤    ─┤    ─┼─┐ ┌─┤  └──┤     │ │ │ │  │ │
    echo     └──┘  └─────┴──┴──┴──┴──┘ └─┘ └─────┴──┴──┴─┴───┴────╯
    echo ┌─────────────────────────────────────────────────────────────┐
    echo │                                                             │
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
    curl -s -L -o instalar.zip http://mochos.sytes.net:8000/perryland/instalar.zip

    cls
    echo     ┌─────┬─────┬─────┬─────┬──┬──┬──┐  ┌─────┬───┬─┬────╮
    echo     │  ─  │   ──┤ ──  │ ──  │  │  │  │  │  ─  │   │ │  │ │
    echo     │  ┌──┤   ──┤    ─┤    ─┼─┐ ┌─┤  └──┤     │ │ │ │  │ │
    echo     └──┘  └─────┴──┴──┴──┴──┘ └─┘ └─────┴──┴──┴─┴───┴────╯
    echo ┌─────────────────────────────────────────────────────────────┐
    echo │                                                             │
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

    cls
    echo     ┌─────┬─────┬─────┬─────┬──┬──┬──┐  ┌─────┬───┬─┬────╮
    echo     │  ─  │   ──┤ ──  │ ──  │  │  │  │  │  ─  │   │ │  │ │
    echo     │  ┌──┤   ──┤    ─┤    ─┼─┐ ┌─┤  └──┤     │ │ │ │  │ │
    echo     └──┘  └─────┴──┴──┴──┴──┘ └─┘ └─────┴──┴──┴─┴───┴────╯
    echo ┌─────────────────────────────────────────────────────────────┐
    echo │                                                             │
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

    cls
    echo     ┌─────┬─────┬─────┬─────┬──┬──┬──┐  ┌─────┬───┬─┬────╮
    echo     │  ─  │   ──┤ ──  │ ──  │  │  │  │  │  ─  │   │ │  │ │
    echo     │  ┌──┤   ──┤    ─┤    ─┼─┐ ┌─┤  └──┤     │ │ │ │  │ │
    echo     └──┘  └─────┴──┴──┴──┴──┘ └─┘ └─────┴──┴──┴─┴───┴────╯
    echo ┌─────────────────────────────────────────────────────────────┐
    echo │                                                             │
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

    cls
    echo     ┌─────┬─────┬─────┬─────┬──┬──┬──┐  ┌─────┬───┬─┬────╮
    echo     │  ─  │   ──┤ ──  │ ──  │  │  │  │  │  ─  │   │ │  │ │
    echo     │  ┌──┤   ──┤    ─┤    ─┼─┐ ┌─┤  └──┤     │ │ │ │  │ │
    echo     └──┘  └─────┴──┴──┴──┴──┘ └─┘ └─────┴──┴──┴─┴───┴────╯
    echo ┌─────────────────────────────────────────────────────────────┐
    echo │                                                             │
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
        cls
        echo     ┌─────┬─────┬─────┬─────┬──┬──┬──┐  ┌─────┬───┬─┬────╮
        echo     │  ─  │   ──┤ ──  │ ──  │  │  │  │  │  ─  │   │ │  │ │
        echo     │  ┌──┤   ──┤    ─┤    ─┼─┐ ┌─┤  └──┤     │ │ │ │  │ │
        echo     └──┘  └─────┴──┴──┴──┴──┘ └─┘ └─────┴──┴──┴─┴───┴────╯
        echo ┌─────────────────────────────────────────────────────────────┐
        echo │                                                             │
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

    cls
    echo     ┌─────┬─────┬─────┬─────┬──┬──┬──┐  ┌─────┬───┬─┬────╮
    echo     │  ─  │   ──┤ ──  │ ──  │  │  │  │  │  ─  │   │ │  │ │
    echo     │  ┌──┤   ──┤    ─┤    ─┼─┐ ┌─┤  └──┤     │ │ │ │  │ │
    echo     └──┘  └─────┴──┴──┴──┴──┘ └─┘ └─────┴──┴──┴─┴───┴────╯
    echo ┌─────────────────────────────────────────────────────────────┐
    echo │                                                             │
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
    curl -s -L -o actualizar.zip http://mochos.sytes.net:8000/perryland/actualizar.zip

    timeout /nobreak /t 1 >nul

    cls
    echo     ┌─────┬─────┬─────┬─────┬──┬──┬──┐  ┌─────┬───┬─┬────╮
    echo     │  ─  │   ──┤ ──  │ ──  │  │  │  │  │  ─  │   │ │  │ │
    echo     │  ┌──┤   ──┤    ─┤    ─┼─┐ ┌─┤  └──┤     │ │ │ │  │ │
    echo     └──┘  └─────┴──┴──┴──┴──┘ └─┘ └─────┴──┴──┴─┴───┴────╯
    echo ┌─────────────────────────────────────────────────────────────┐
    echo │                                                             │
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

    cls
    echo     ┌─────┬─────┬─────┬─────┬──┬──┬──┐  ┌─────┬───┬─┬────╮
    echo     │  ─  │   ──┤ ──  │ ──  │  │  │  │  │  ─  │   │ │  │ │
    echo     │  ┌──┤   ──┤    ─┤    ─┼─┐ ┌─┤  └──┤     │ │ │ │  │ │
    echo     └──┘  └─────┴──┴──┴──┴──┘ └─┘ └─────┴──┴──┴─┴───┴────╯
    echo ┌─────────────────────────────────────────────────────────────┐
    echo │                                                             │
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
    cls
    echo     ┌─────┬─────┬─────┬─────┬──┬──┬──┐  ┌─────┬───┬─┬────╮
    echo     │  ─  │   ──┤ ──  │ ──  │  │  │  │  │  ─  │   │ │  │ │
    echo     │  ┌──┤   ──┤    ─┤    ─┼─┐ ┌─┤  └──┤     │ │ │ │  │ │
    echo     └──┘  └─────┴──┴──┴──┴──┘ └─┘ └─────┴──┴──┴─┴───┴────╯
    echo ┌─────────────────────────────────────────────────────────────┐
    echo │                                                             │
    echo │  Comprobando actualizaciones... OK                          │
    echo │  Eliminando versiones antiguas... OK                        │
    echo │  Descargando mods... OK                                     │
    echo │  Extrayendo archivos...   OK                                │
    echo │  Eliminando temporales... OK                                │
    echo │                                                             │
    echo │  ¡INSTALACIÓN TERMINADA!                                    │
    echo │  Ya puedes cerrar esta ventana.                             │
    echo │                                                             │
    echo └─────────────────────────────────────────────────────────────┘

    del control
    exit /b