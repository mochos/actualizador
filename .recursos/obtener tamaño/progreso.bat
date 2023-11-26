@echo off

set "url=https://raw.githubusercontent.com/mochos/actualizador/main/instalar/instalar.zip"
set "filename=instalar.zip"

bitsadmin /transfer myDownloadJob /download /priority normal "%url%" "%CD%\%filename%"

echo Descarga completada.

pause