cls
mode con: cols=50 lines=5

:timeout
cls

if %count% GTR 60 ( 
    set /p =%ESC%[1mCountdown Timer : %ESC%[1;92m%count%%ESC%[0m seconds to sleep <nul 
) else if %count% GTR 20 ( 
    set /p =%ESC%[1mCountdown Timer : %ESC%[1;93m%count%%ESC%[0m seconds to sleep <nul 
) else (
    set /p =%ESC%[1mCountdown Timer : %ESC%[1;91m%count%%ESC%[0m seconds to sleep <nul 
)

ping -n 2 127.0.0.1 > nul 2>&1
set /a count-=1
IF %count% GTR 0 goto :timeout