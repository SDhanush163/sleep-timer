@echo off

::=============================================================
:: Displaying the main menu and handling the user's selection
::=============================================================
:menu

cls
mode con: cols=70 lines=20

:: Validating the system's supported power states
call "%baselocation%\functions\validator.bat"

::=============================================================
:: Displaying the application title and available power options
::=============================================================
echo -----------------------------------------------------------
echo %ESC%[1;92m                 Windows Power Timer%ESC%[0m
echo -----------------------------------------------------------
echo.

if /I "%sleepSupported%"=="true" (
    echo   [1] Sleep
) else (
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

:: Reading the user's menu selection
set "action="
set /p option=Select an option :

:: Mapping the selected menu option to a power action
if "%option%"=="1" set "action=sleep"
if "%option%"=="2" set "action=hibernate"
if "%option%"=="3" set "action=shutdown"
if "%option%"=="4" set "action=restart"
if "%option%"=="5" set "action=lock"
if "%option%"=="6" set "action=logoff"

:: Exiting the application when the user selects Exit
if "%option%"=="0" (
    set "action=exit"
    exit /b
)

:: Displaying an error for an invalid menu selection
if not defined action (
    set "errorName=Menu Selection Error"
    set "errMsg=Invalid menu option selected. Please try again."
    call "%baselocation%\functions\exception.bat"
    goto :menu
)

:: Preventing Sleep when the system does not support it
if /I "%action%"=="sleep" if /I "%sleepSupported%"=="false" (
    set "errorName=Unsupported Power State"
    set "errMsg=Sleep is not supported on this computer. This device uses Modern Standby."
    call "%baselocation%\functions\exception.bat"
    goto :menu
)

:: Returning the selected power action to the calling script
:valid
exit /b