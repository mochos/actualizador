@echo off
setlocal EnableDelayedExpansion

set "url=https://raw.githubusercontent.com/mochos/actualizador/main/instalar/instalar.zip"

for /f %%A in ('powershell -command "(Invoke-WebRequest '%url%').Headers['Content-Length']"') do (
    set "size=%%A"
)

echo El tamaño del archivo ZIP es: !size! bytes

pause