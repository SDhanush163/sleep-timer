cls
mode con: cols=100 lines=10


echo -----------------------------------------------------------
echo %ESC%[1;91m%errorName% : %ESC%[0m%errMsg%
echo -----------------------------------------------------------
echo.
echo %ESC%[1;91mPress any key to exit

pause >nul
exit 0