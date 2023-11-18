@echo off

REM Descargar el archivo remoto "version.txt"
curl -s -o version_remote.txt https://raw.githubusercontent.com/mochos/actualizador/main/version.txt

REM Comparar el archivo remoto con el archivo local
fc /b "version.txt" "version_remote.txt" > nul

REM Verificar el código de error de fc (0 si son idénticos, 1 si son diferentes)
if errorlevel 1 (
    echo ----------------------------------
    echo Necesitas actualizar. Iniciando...
    echo ----------------------------------
    timeout /nobreak /t 3 >nul
    REM Aquí va el resto de tu script para la actualización

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
    curl -L -o repo.zip https://github.com/mochos/actualizador/archive/main.zip

    REM Descomprimir el archivo ZIP en la carpeta temporal
    tar -xf repo.zip --strip-components=1

    REM Eliminar archivos temporales
    del /q repo.zip
    del /q version_remote.txt

    echo -------------------------------
    echo Actualizado satisfactoriamente!


    REM -----------------------------------------------


    pause
    exit
) else (
    echo -----------------------
    echo No necesitas actualizar.
    echo -----------------------
    del /q version_remote.txt
    pause
    exit
)