@echo off

::=============================================================
:: Shutting down the computer immediately
::=============================================================

cls
mode con: cols=90 lines=10

:: Displaying the current power operation to the user
echo ------------------------
echo %ESC%[1;93mShutting down Windows%ESC%[0m
echo ------------------------

:: Initiating an immediate system shutdown
shutdown /s /t 0

:: Displaying an error if Windows fails to shut down
if errorlevel 1 (
    set "errorName=Shutdown Error"
    set "errMsg=Unable to shut down Windows."
    call "%baselocation%\functions\exception.bat"
)

exit /b