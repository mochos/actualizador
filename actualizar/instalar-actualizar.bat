@echo off

mode con: cols=63 lines=15

cd /d %~dp0

chcp 65001 >nul

setlocal

set "carpeta=.minecraft"
set crear_acceso=0

rem Obtener la ruta actual
set "ruta_actual=%cd%"

rem Verificar si estamos dentro de la carpeta .minecraft
if "%ruta_actual:~-11%"=="\%carpeta%" (

    call :completa

) else (
    echo ┌─────────────────────────────────────────────────────────────┐
    echo │ Modpack - Instalador                                        │
    echo ╞═════════════════════════════════════════════════════════════╡
    echo │                                                             │
    echo │  ¡ADVERTENCIA!:                                             │
    echo │  Para que el modpack funcione correctamente debes           │
    echo │  ejecutar este archivo dentro de la carpeta .minecraft.     │
    echo │  No estás ejecutando este archivo en la carpeta correcta.   │
    echo │                                                             │
    echo │  ¿Deseas continuar en esta carpeta de todos modos?          │
    echo │                                                             │
    echo │  Pulsa S o N                                                │
    echo │                                                             │
    echo └─────────────────────────────────────────────────────────────┘
    choice /C SN /M "Escribe S o N" >nul

    if errorlevel 2 (
        cls
        echo ┌─────────────────────────────────────────────────────────────┐
        echo │ Modpack - Instalador                                        │
        echo ╞═════════════════════════════════════════════════════════════╡
        echo │                                                             │
        echo │  Cerrando...                                                │
        echo │                                                             │
        echo │                                                             │
        echo │                                                             │
        echo │                                                             │
        echo │                                                             │
        echo │                                                             │
        echo │                                                             │
        echo │                                                             │
        echo └─────────────────────────────────────────────────────────────┘
        timeout /nobreak /t 2 >nul
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
        

        call :actualizar

        pause >nul
        exit
    ) else (
        cls
        echo ┌─────────────────────────────────────────────────────────────┐
        echo │ Modpack - Instalador                                        │
        echo ╞═════════════════════════════════════════════════════════════╡
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
        echo ┌─────────────────────────────────────────────────────────────┐
        echo │ Modpack - Instalador                                        │
        echo ╞═════════════════════════════════════════════════════════════╡
        echo │                                                             │
        echo │  Comprobando actualizaciones... OK                          │
        echo │                                                             │
        echo │  ¡TIENES LA VERSIÓN MÁS RECIENTE INSTALADA!                 │
        echo │                                                             │
        echo │                                                             │
        echo │                                                             │
        echo │                                                             │
        echo │  Pulsa cualquier tecla para cerrar...                       │
        echo │                                                             │
        echo └─────────────────────────────────────────────────────────────┘
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
    echo ┌─────────────────────────────────────────────────────────────┐
    echo │ Modpack - Instalador                                        │
    echo ╞═════════════════════════════════════════════════════════════╡
    echo │                                                             │
    echo │  ¿Quieres crear un acceso directo del actualizador          │
    echo │  en tu escritorio?                                          │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │                                                             │
    echo │  Pulsa S o N                                                │
    echo │                                                             │
    echo └─────────────────────────────────────────────────────────────┘
    choice /C SN /M "Escribe S o N" >nul

    if errorlevel 2 (
        set crear_acceso=0
    ) else (
        set crear_acceso=1
    )

    timeout /nobreak /t 1 >nul

    cls
    echo ┌─────────────────────────────────────────────────────────────┐
    echo │ Modpack - Instalador                                        │
    echo ╞═════════════════════════════════════════════════════════════╡
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
    echo ┌─────────────────────────────────────────────────────────────┐
    echo │ Modpack - Instalador                                        │
    echo ╞═════════════════════════════════════════════════════════════╡
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
    curl -s -L -o instalar.zip https://raw.githubusercontent.com/mochos/actualizador/main/instalar/instalar.zip

    cls
    echo ┌─────────────────────────────────────────────────────────────┐
    echo │ Modpack - Instalador                                        │
    echo ╞═════════════════════════════════════════════════════════════╡
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

    set "target=%~dp0instalar-actualizar.bat"
    set "shortcut=%USERPROFILE%\Desktop\Actualizar Modpack.lnk"
    set "iconPath=%~dp0instalar-actualizar.ico" REM Ruta al archivo .ico en la misma carpeta que el batch

    if "%crear_acceso%" EQU "1" (
        start powershell -Command "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%shortcut%'); $s.TargetPath = '%target%'; $s.IconLocation = '%iconPath%'; $s.Save()"
    )

    cls
    echo ┌─────────────────────────────────────────────────────────────┐
    echo │ Modpack - Instalador                                        │
    echo ╞═════════════════════════════════════════════════════════════╡
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
    echo ┌─────────────────────────────────────────────────────────────┐
    echo │ Modpack - Instalador                                        │
    echo ╞═════════════════════════════════════════════════════════════╡
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
    echo ┌─────────────────────────────────────────────────────────────┐
    echo │ Modpack - Instalador                                        │
    echo ╞═════════════════════════════════════════════════════════════╡
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

    REM Eliminar la carpeta "prueba2" si existe

    if exist cachedImages (
        rmdir /s /q cachedImages
    )

    REM Verifica si la carpeta existe
    if exist "mods" (
        pushd "mods"
        cls
        echo ┌─────────────────────────────────────────────────────────────┐
        echo │ Modpack - Instalador                                        │
        echo ╞═════════════════════════════════════════════════════════════╡
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
    echo ┌─────────────────────────────────────────────────────────────┐
    echo │ Modpack - Instalador                                        │
    echo ╞═════════════════════════════════════════════════════════════╡
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
    curl -s -L -o actualizar.zip https://raw.githubusercontent.com/mochos/actualizador/main/actualizar/actualizar.zip

    timeout /nobreak /t 1 >nul

    cls
    echo ┌─────────────────────────────────────────────────────────────┐
    echo │ Modpack - Instalador                                        │
    echo ╞═════════════════════════════════════════════════════════════╡
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
    echo ┌─────────────────────────────────────────────────────────────┐
    echo │ Modpack - Instalador                                        │
    echo ╞═════════════════════════════════════════════════════════════╡
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
    echo ┌─────────────────────────────────────────────────────────────┐
    echo │ Modpack - Instalador                                        │
    echo ╞═════════════════════════════════════════════════════════════╡
    echo │                                                             │
    echo │  Comprobando actualizaciones... OK                          │
    echo │  Eliminando versiones antiguas... OK                        │
    echo │  Descargando mods... OK                                     │
    echo │  Extrayendo archivos...   OK                                │
    echo │  Eliminando temporales... OK                                │
    echo │                                                             │
    echo │  ¡INSTALACIÓN TERMINADA!                                    │
    echo │  Pulsa cualquier tecla para cerrar...                       │
    echo │                                                             │
    echo └─────────────────────────────────────────────────────────────┘

    exit /b