cls
mode con: cols=100 lines=10


echo -----------------------------------------------------------
echo %ESC%[1;91m%errorName% : %ESC%[0m%errMsg%
echo -----------------------------------------------------------
echo.
echo %ESC%[1;91mPress any key to exit%ESC%[0m

pause >nul
exit /b 0