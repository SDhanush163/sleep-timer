@echo off

::=============================================================
:: Logging off the current Windows user
::=============================================================

cls
mode con: cols=90 lines=10

:: Displaying the current power operation to the user
echo ------------------------
echo %ESC%[1;93mLogging off Windows%ESC%[0m
echo ------------------------

:: Logging off the currently signed-in user
shutdown /l

:: Displaying an error if Windows fails to log off
if errorlevel 1 (
    set "errorName=Log Off Error"
    set "errMsg=Unable to log off Windows."
    call "%baselocation%\functions\exception.bat"
)

exit /b