::==================
:: Hibernate PC
::==================

cls
mode con: cols=90 lines=10

echo ------------------------
echo %ESC%[1;93mHibernating Windows%ESC%[0m
echo ------------------------

powercfg -hibernate on

if %errorlevel% neq 0 (
    set errorName=Admin Privileges Error
    set errMsg=Cannot enable Hibernate. Batch file should be run with Admin privileges
    call "%baselocation%\functions\exception.bat"
)

shutdown /h

if %errorlevel% neq 0 (
    set errorName=Hibernate Error
    set errMsg=Unable to hibernate Windows
    call "%baselocation%\functions\exception.bat"
)

echo ------------------------
echo %ESC%[1;92mSystem has resumed from hibernation%ESC%[0m
echo ------------------------
echo.
echo.
echo %ESC%[1;92mPress any key to exit%ESC%[0m

pause >nul

exit /b