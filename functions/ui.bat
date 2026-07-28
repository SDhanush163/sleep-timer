@echo off

::===================
:: Display Main Menu
::===================
:menu

cls
mode con: cols=70 lines=20
call "%baselocation%\functions\validator.bat"

echo -----------------------------------------------------------
echo %ESC%[1;92m                 Windows Power Timer%ESC%[0m
echo -----------------------------------------------------------
echo.
if /I "%sleepSupported%"=="true" (
    echo   [1] Sleep
)

if /I "%sleepSupported%"=="false" (
    echo   [1] Sleep - %ESC%[90mNot Supported%ESC%[0m
)
echo   [2] Hibernate
echo   [3] Shutdown
echo   [4] Restart
echo   [5] Lock
echo   [6] Log Off
echo.
echo   [0] Exit
echo.
echo -----------------------------------------------------------
echo.

set /p option=Select an option : 

if "%option%"=="1" (

    if /I "%sleepSupported%"=="false" (
        set errorName=Unsupported Power State
        set errMsg=Sleep is not supported on this computer. This device uses Modern Standby.
        call "%baselocation%\functions\exception.bat"
        goto :menu
    )

    set action=sleep
    goto :valid
)

if "%option%"=="2" (
    set action=hibernate
    goto :valid
)

if "%option%"=="3" (
    set action=shutdown
    goto :valid
)

if "%option%"=="4" (
    set action=restart
    goto :valid
)

if "%option%"=="5" (
    set action=lock
    goto :valid
)

if "%option%"=="6" (
    set action=logoff
    goto :valid
)

if "%option%"=="0" (
    set action=exit
    exit /b
)

set errorName=Menu Selection Error
set errMsg=Invalid menu option selected. Please try again
call "%baselocation%\functions\exception.bat"
goto :menu

:valid
exit /b