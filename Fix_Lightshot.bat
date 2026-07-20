@echo off
title Fix Lightshot FnLock
echo Applicazione del fix per Lightshot...
echo.

:: 1. Crea il file VBScript invisibile nella cartella AppData
echo CreateObject("WScript.Shell").Run "powershell -Command ""Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{PRTSC}')""", 0 > "%APPDATA%\lightshot_fix.vbs"

:: 2. Registra il protocollo ms-screensketch nel Registro
reg add "HKCU\Software\Classes\ms-screensketch" /v "URL Protocol" /t REG_SZ /d "" /f >nul

:: 3. Associa il protocollo allo script VBScript usando il percorso completo espanso
reg add "HKCU\Software\Classes\ms-screensketch\shell\open\command" /ve /t REG_SZ /d "wscript.exe \"%APPDATA%\lightshot_fix.vbs\"" /f >nul

echo.
echo =========================================
echo  Fix applicato con successo!
echo =========================================
echo.
pause