@echo off

::=============================================================
:: Restarting the computer immediately
::=============================================================

cls
mode con: cols=90 lines=10

:: Displaying the current power operation to the user
echo ------------------------
echo %ESC%[1;93mRestarting Windows%ESC%[0m
echo ------------------------

:: Initiating an immediate system restart
shutdown /r /t 0

:: Displaying an error if Windows fails to restart
if errorlevel 1 (
    set "errorName=Restart Error"
    set "errMsg=Unable to restart Windows."
    call "%baselocation%\functions\exception.bat"
)

exit /b