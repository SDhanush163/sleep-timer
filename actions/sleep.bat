@echo off

::=============================================================
:: Putting the computer into the sleep state
::=============================================================

cls
mode con: cols=90 lines=10

:: Displaying the current power operation to the user
echo ------------------------
echo %ESC%[1;93mPutting Windows to Sleep%ESC%[0m
echo ------------------------

:: Temporarily disabling hibernation to force the Sleep state
powercfg -hibernate off

if errorlevel 1 (
    set "errorName=Admin Privileges Error"
    set "errMsg=Cannot disable hibernation. Run the application as Administrator."
    call "%baselocation%\functions\exception.bat"
)

:: Placing the computer into Sleep mode
rundll32.exe powrprof.dll,SetSuspendState Standby

:: Re-enabling hibernation after the system resumes
powercfg -hibernate on

if errorlevel 1 (
    set "errorName=Admin Privileges Error"
    set "errMsg=Cannot enable hibernation. Run the application as Administrator."
    call "%baselocation%\functions\exception.bat"
)

:: Displaying a message after the system resumes from sleep
echo ------------------------
echo %ESC%[1;92mSystem has resumed from Sleep%ESC%[0m
echo ------------------------
echo.
echo.
echo %ESC%[1;92mPress any key to exit%ESC%[0m

pause >nul

exit /b