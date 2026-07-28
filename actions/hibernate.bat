@echo off

::=============================================================
:: Hibernating the computer
::=============================================================

cls
mode con: cols=90 lines=10

:: Displaying the current power operation to the user
echo ------------------------
echo %ESC%[1;93mHibernating Windows%ESC%[0m
echo ------------------------

:: Enabling hibernation before entering the hibernate state
powercfg -hibernate on

if errorlevel 1 (
    set "errorName=Admin Privileges Error"
    set "errMsg=Cannot enable hibernation. Run the application as Administrator."
    call "%baselocation%\functions\exception.bat"
)

:: Placing the computer into hibernation
shutdown /h

if errorlevel 1 (
    set "errorName=Hibernate Error"
    set "errMsg=Unable to hibernate Windows."
    call "%baselocation%\functions\exception.bat"
)

:: Displaying a message after the system resumes
echo ------------------------
echo %ESC%[1;92mSystem has resumed from hibernation%ESC%[0m
echo ------------------------
echo.
echo.
echo %ESC%[1;92mPress any key to exit%ESC%[0m

pause >nul

exit /b