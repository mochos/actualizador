@echo off

set "target=%~dp0prueba.bat"
set "shortcut=%USERPROFILE%\Desktop\Actualizar Modpack.lnk"
set "iconPath=%~dp0icono.ico" REM Ruta al archivo .ico en la misma carpeta que el batch

powershell -Command "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%shortcut%'); $s.TargetPath = '%target%'; $s.IconLocation = '%iconPath%'; $s.Save()"

pause
