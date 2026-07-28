@echo off

::=============================================================
:: Locking the current Windows session
::=============================================================

cls
mode con: cols=90 lines=10

:: Displaying the current power operation to the user
echo ------------------------
echo %ESC%[1;93mLocking Windows%ESC%[0m
echo ------------------------

:: Locking the current workstation
rundll32.exe user32.dll,LockWorkStation

:: Displaying an error if Windows fails to lock
if errorlevel 1 (
    set "errorName=Lock Error"
    set "errMsg=Unable to lock Windows."
    call "%baselocation%\functions\exception.bat"
)

:: Waiting for the user after unlocking the workstation
echo ------------------------
echo %ESC%[1;92mSystem has been unlocked%ESC%[0m
echo ------------------------
echo.
echo.
echo %ESC%[1;92mPress any key to exit%ESC%[0m

pause >nul

exit /b