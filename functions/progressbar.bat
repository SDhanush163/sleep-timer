@echo off

::=============================================================
:: Calculating the progress bar based on the remaining time
::=============================================================

set /a elapsed=initialCount-count
if %elapsed% LSS 0 set elapsed=0

set /a percent=(elapsed*100)/initialCount
if %percent% GTR 100 set percent=100

set /a filled=(percent*40)/100

set "progressBar="

for /L %%i in (1,1,40) do (
    if %%i LEQ %filled% (
        call set "progressBar=%%progressBar%%#"
    ) else (
        call set "progressBar=%%progressBar%%-"
    )
)

exit /b