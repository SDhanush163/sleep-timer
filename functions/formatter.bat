@echo off

if "%~1"==":formatSummary" goto :formatSummary
if "%~1"==":formatCountdown" goto :formatCountdown

exit /b

::=============================================================
:: Formatting the supplied duration into a human-readable format
:: and HH:MM:SS for the summary screen
::=============================================================
:formatSummary

call :calculateTime
for /f %%A in (
    'powershell -NoProfile -Command "(Get-Date).AddSeconds(%count%).ToString(\"HH:mm:ss\")"'
) do set "executeTime=%%A"

setlocal EnableDelayedExpansion

set "formattedDuration="

if %hours% GTR 0 (
    set "formattedDuration=!hours! hour"
    if %hours% NEQ 1 set "formattedDuration=!formattedDuration!s"
)

if %minutes% GTR 0 (
    if defined formattedDuration set "formattedDuration=!formattedDuration! "
    set "formattedDuration=!formattedDuration!!minutes! minute"
    if %minutes% NEQ 1 set "formattedDuration=!formattedDuration!s"
)

if %seconds% GTR 0 (
    if defined formattedDuration set "formattedDuration=!formattedDuration! "
    set "formattedDuration=!formattedDuration!!seconds! second"
    if %seconds% NEQ 1 set "formattedDuration=!formattedDuration!s"
)

if not defined formattedDuration (
    set "formattedDuration=0 seconds"
)

endlocal & set "formattedDuration=%formattedDuration%"

call :formatClock

exit /b


::=============================================================
:: Formatting the supplied duration as HH:MM:SS for the live
:: countdown display
::=============================================================
:formatCountdown

call :calculateTime
call :formatClock

exit /b

:: Formatting the supplied duration as HH:MM:SS
:formatClock

set "displayHours=%hours%"
set "displayMinutes=%minutes%"
set "displaySeconds=%seconds%"

if %displayHours% LSS 10 set "displayHours=0%displayHours%"
if %displayMinutes% LSS 10 set "displayMinutes=0%displayMinutes%"
if %displaySeconds% LSS 10 set "displaySeconds=0%displaySeconds%"

set "formattedTime=%displayHours%:%displayMinutes%:%displaySeconds%"

exit /b

::=============================================================
:: Converting the supplied duration into hours, minutes and
:: seconds
::=============================================================
:calculateTime

set /a hours=count/3600
set /a minutes=(count%%3600)/60
set /a seconds=count%%60

exit /b