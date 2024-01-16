@echo off
setlocal EnableDelayedExpansion

chcp 65001 >nul

REM Solicitar al usuario que ingrese el nuevo texto
set /p nuevoTexto="Ingrese el nuevo texto: "

REM Cambiar el contenido del archivo con el nuevo texto y la fecha y hora actual
echo %nuevoTexto% > "actualizar/version.txt"

timeout /nobreak /t 1 >nul

echo Versión actualizada

REM Actualizar
cd /d "actualizar" || exit /b
"%ProgramFiles%\7-Zip\7z.exe" a -r "actualizar.zip" * > nul 2>&1
move "actualizar.zip" "../compilado" > nul

copy "version.txt" "../compilado" > nul

echo actualizar.zip compilado.

cd ..

timeout /nobreak /t 1 >nul

REM Instalar
cd /d "instalar" || exit /b
"%ProgramFiles%\7-Zip\7z.exe" a -r "instalar.zip" * > nul 2>&1
move "instalar.zip" "../compilado" > nul

echo instalar.zip compilado.

cd ..

REM Batch
cd /d "batch" || exit /b
"%ProgramFiles%\7-Zip\7z.exe" a -r "Perryland-Instalador.zip" "instalar-actualizar.bat" > nul 2>&1
move "Perryland-Instalador.zip" "../compilado" > nul

echo Perryland-Instalador.zip compilado.

del "../Perryland-MultiMC\Perryland\.minecraft\instalar-integrado.bat"

timeout /nobreak /t 1 >nul

copy "instalar-integrado.bat" "../Perryland-MultiMC\Perryland\.minecraft" > nul

echo Copiado instalar-integrado.bat a instancia.

cd ..

timeout /nobreak /t 1 >nul

REM Instancia
cd /d "Perryland-MultiMC" || exit /b
"%ProgramFiles%\7-Zip\7z.exe" a -r "Perryland.zip" * > nul 2>&1
move "Perryland.zip" "../compilado" > nul

echo Perryland.zip compilado.

cd ..

pause

endlocal
