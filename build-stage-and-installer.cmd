@echo off
setlocal
title MulletaFlix - Build Stage e Instalador

cd /d "%~dp0.."

if not exist "logs" mkdir "logs"
set "LOG_FILE=%CD%\logs\build-stage-and-installer.log"

echo ==================================================
echo    MulletaFlix - Build Stage e Instalador
echo ==================================================
echo.
echo O log completo sera gravado em:
echo %LOG_FILE%
echo.

powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& { try { & '%CD%\build-stage-and-installer.ps1' -NoPause %*; exit 0 } catch { exit 1 } } *>&1 | Tee-Object -FilePath '%LOG_FILE%'"

set "EXIT_CODE=%ERRORLEVEL%"
echo.
echo ==================================================
if "%EXIT_CODE%"=="0" (
    echo Build finalizado com sucesso.
) else (
    echo Build falhou. Codigo de erro: %EXIT_CODE%
    echo Veja o log acima ou em:
    echo %LOG_FILE%
)
echo ==================================================
echo.
pause
exit /b %EXIT_CODE%
