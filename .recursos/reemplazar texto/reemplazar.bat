@echo off
setlocal EnableDelayedExpansion

set "texto_a_buscar=ejemplo"
set "nuevo_texto=ejemplo: linea modificada"
set "archivo=ejemplo.txt"
set "archivo_temporal=temp.txt"

REM Iterar sobre cada línea del archivo
for /f "tokens=*" %%A in ('type "%archivo%"') do (
    REM Verificar si la línea contiene el texto a buscar
    echo %%A | findstr /C:"%texto_a_buscar%" >nul
    if !errorlevel! equ 0 (
        REM Si la línea contiene el texto, reemplazarla con el nuevo texto
        echo %nuevo_texto%>>"%archivo_temporal%"
    ) else (
        REM De lo contrario, conservar la línea original
        echo %%A>>"%archivo_temporal%"
    )
)

REM Reemplazar el archivo original con el archivo temporal
move /y "%archivo_temporal%" "%archivo%"

echo Modificación completa.


pause