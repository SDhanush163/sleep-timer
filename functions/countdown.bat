@echo off

::=============================================================
:: Displaying the countdown until the selected power action is
:: executed
::=============================================================
cls
mode con: cols=70 lines=30
call "%baselocation%\functions\formatter.bat" :formatSummary

::=============================================================
:: Displaying the static countdown screen
::=============================================================
echo -----------------------------------------------------------
echo %ESC%[1;92m                    Windows Power Timer%ESC%[0m
echo            An easy way to turn off the computer
echo -----------------------------------------------------------
echo.
echo Action         : %ESC%[1;%actionColour%m%action%%ESC%[0m
echo Duration       : %formattedDuration%
echo Execute At     : %executeTime%
echo.
echo -----------------------------------------------------------
echo.
echo Remaining Time :
echo Progress       :
echo.
echo -----------------------------------------------------------
echo Press Ctrl+C to cancel.
echo -----------------------------------------------------------

:timeout
::=============================================================
:: Formatting the remaining time
::=============================================================
call "%baselocation%\functions\formatter.bat" :formatCountdown
call "%baselocation%\functions\progressbar.bat"

::=============================================================
:: Selecting the countdown colour
::=============================================================
set "timeColor=91"
if %count% GTR 20 set "timeColor=93"
if %count% GTR 60 set "timeColor=92"

::=============================================================
:: Updating the countdown
::=============================================================

<nul set /p "=%ESC%[13;1H%ESC%[2KRemaining Time : %ESC%[1;%timeColor%m%formattedTime%%ESC%[0m" 
<nul set /p "=%ESC%[14;1H%ESC%[2KProgress       : %progressBar% %percent%%%"
<nul set /p "=%ESC%[20;1H"

:: Wait one second
ping 127.0.0.1 -n 2 >nul

set /a count-=1

if %count% GTR 0 goto :timeout