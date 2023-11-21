@echo off

chcp 65001 >nul

setlocal

set "carpeta=.minecraft"

rem Obtener la ruta actual
set "ruta_actual=%cd%"

rem Verificar si estamos dentro de la carpeta .minecraft
if "%ruta_actual:~-11%"=="\%carpeta%" (

    call :completa

) else (
    echo -----------------------------------------------------------------------------------------------------------
    echo   ¡ADVERTENCIA!:
    echo    Para que el modpack funcione correctamente debes ejecutar este archivo dentro de la carpeta %carpeta%.
    echo    No estás ejecutando este archivo en la carpeta correcta.
    echo -----------------------------------------------------------------------------------------------------------
    choice /C SN /M " ¿Deseas continuar en esta carpeta de todos modos? (S/N)"
    if errorlevel 2 (
        echo Has elegido no continuar. Cerrando...
        timeout /nobreak /t 3 >nul
        exit /b 1
    ) else (
        
        REM Ejecuta el código despues de darle si a continuar
        call :completa

    )
)

endlocal

REM Función completa

:completa
REM Descargar el archivo remoto "version.txt"
curl -s -o version_remote.txt https://raw.githubusercontent.com/mochos/actualizador/main/actualizar/version.txt

REM Verificar si existe el archivo local version.txt
if exist version.txt (
    REM Comparar el archivo remoto con el archivo local
    fc /b "version.txt" "version_remote.txt" > nul
    REM Verificar el código de error de fc (0 si son idénticos, 1 si son diferentes)
    if errorlevel 1 (
        echo ------------------------------
        echo   Iniciando actualización...
        echo ------------------------------
        timeout /nobreak /t 3 >nul

        call :actualizar

        pause
        exit
    ) else (
        echo -----------------------------------------------
        echo   Tienes la versión mas reciente del modpack.
        echo -----------------------------------------------
        del /q version_remote.txt
        pause
        exit
    )
) else (

    echo ----------------------------
    echo   Iniciando instalación...
    echo ----------------------------
    timeout /nobreak /t 3 >nul

    call :instalar
    call :actualizar

    pause
    exit
)


REM Función instalar
:instalar
REM -----------------------------------------------

    echo Descargando archivos iniciales...

    REM Descargar el archivo ZIP del repositorio
    curl -s -L -o instalar.zip https://raw.githubusercontent.com/mochos/actualizador/main/instalar/instalar.zip

    echo Extrayendo archivos...

    REM Descomprimir el archivo ZIP en la carpeta temporal
    tar -xf instalar.zip --strip-components=0

    timeout /nobreak /t 3 >nul

    echo Eliminando temporales...

    REM Eliminar archivos temporales
    del /q instalar.zip

    echo Archivos iniciales instalados!

    exit /b


REM Función actualizar
:actualizar
REM -----------------------------------------------

    REM Eliminar la carpeta "prueba2" si existe

    if exist cachedImages (
        rmdir /s /q cachedImages
    )

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
    curl -s -L -o actualizar.zip https://raw.githubusercontent.com/mochos/actualizador/main/actualizar/actualizar.zip

    echo Extrayendo archivos...

    REM Descomprimir el archivo ZIP en la carpeta temporal
    tar -xf actualizar.zip --strip-components=0

    timeout /nobreak /t 3 >nul

    echo Eliminando temporales...

    REM Eliminar archivos temporales
    del /q actualizar.zip
    del /q version_remote.txt
    echo --------------------------
    echo   ¡Instalación completa!
    echo --------------------------

    exit /b
