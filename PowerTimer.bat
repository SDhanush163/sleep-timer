@echo off

::=============================================================
:: Setting the Escape sequence character to the variable "ESC"
::=============================================================
setlocal
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do ( 
  set ESC=%%b
)
cls

::=============================================================
:: Check for Administrator privileges
::=============================================================
net session >nul 2>&1

if %errorlevel% neq 0 (
    cls
    echo -----------------------------------------------------------
    echo %ESC%[1;92m                    Windows Power Timer %ESC%[0m
    echo            An easy way to turn off the computer
    echo -----------------------------------------------------------
    echo.
    echo  %ESC%[1;91mERROR:%ESC%[0m Administrator privileges are required.
    echo.
    echo  Please run this application as Administrator.
    echo.
    echo -----------------------------------------------------------
    echo %ESC%[1;91mPress any key to exit%ESC%[0m
    pause >nul
    exit /b 1
)

::==================================================================
:: Taking user input and separating it to time and format specifiers
::==================================================================
set baselocation=%~dp0
call "%baselocation%\functions\ui.bat"

if /I %action%==exit (
    exit 0
)

cls
mode con: cols=70 lines=30

call "%baselocation%\functions\instructions.bat"
set /p timerInput=Enter time :

call "%baselocation%\functions\parser.bat"

if /I "%parserError%"=="true" (
    set errorName=Input Error
    set errMsg=Time entered is not in the correct format. Please try again.
    call "%baselocation%\functions\exception.bat"
    goto :eof
)


::=============================
:: Starting the timeout counter
::=============================
set count=%totalSeconds%
set initialCount=%totalSeconds%
call "%baselocation%\functions\countdown.bat"
call "%baselocation%\actions\%action%.bat"
