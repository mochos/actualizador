@echo off

REM Descargar el archivo remoto "version.txt"
curl -s -o version_remote.txt https://raw.githubusercontent.com/mochos/actualizador/main/actualizar/version.txt

REM Verificar si existe el archivo local version.txt
if exist version.txt (
    REM Comparar el archivo remoto con el archivo local
    fc /b "version.txt" "version_remote.txt" > nul
    REM Verificar el código de error de fc (0 si son idénticos, 1 si son diferentes)
    if errorlevel 1 (
        echo --------------------------------------
        echo   Necesitas actualizar. Iniciando...
        echo --------------------------------------
        timeout /nobreak /t 3 >nul

        call :actualizar

        pause
        exit
    ) else (
        echo ---------------------------
        echo   No necesitas actualizar.
        echo ---------------------------
        del /q version_remote.txt
        pause
        exit
    )
) else (

    echo -----------------
    echo   Instalando...
    echo -----------------
    timeout /nobreak /t 3 >nul

    call :instalar
    call :actualizar

    pause
    exit

)


REM Función instalar
:instalar
REM -----------------------------------------------

    REM Descargar el archivo ZIP del repositorio
    curl -L -o instalar.zip https://raw.githubusercontent.com/mochos/actualizador/main/instalar/instalar.zip

    REM Descomprimir el archivo ZIP en la carpeta temporal
    tar -xf instalar.zip --strip-components=0

    timeout /nobreak /t 3 >nul

    REM Eliminar archivos temporales
    del /q instalar.zip
    echo Inicial ok

    exit /b


REM Función actualizar
:actualizar
REM -----------------------------------------------

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
            move "%%F" temp\ > nul 2>&1
        )

        REM Eliminar todos los archivos restantes en la carpeta
        del /q *

        REM Mover de vuelta los archivos que habían comenzado con "NB_"
        move temp\* . > nul 2>&1
        rmdir /q /s temp

        popd
    )

    REM Descargar el archivo ZIP del repositorio
    curl -L -o actualizar.zip https://raw.githubusercontent.com/mochos/actualizador/main/actualizar/actualizar.zip

    REM Descomprimir el archivo ZIP en la carpeta temporal
    tar -xf actualizar.zip --strip-components=0

    timeout /nobreak /t 3 >nul

    REM Eliminar archivos temporales
    del /q actualizar.zip
    del /q version_remote.txt
    echo ---------------------------------
    echo   Instalado satisfactoriamente!
    echo ---------------------------------

    exit /b