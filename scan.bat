@echo off
chcp 65001 >nul
:: Проверка на права администратора
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

if '%errorlevel%' NEQ '0' (
    echo Запрос прав администратора...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
del "%temp%\getadmin.vbs"
exit /B

:gotAdmin
pushd "%CD%"
CD /D "%~dp0"

echo ========================================================
echo Запуск полного сканирования Windows Defender (Полная проверка)...
echo ========================================================

"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 2

echo.
echo Сканирование завершено!
pause