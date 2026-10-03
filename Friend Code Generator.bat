@echo off
setlocal EnableExtensions EnableDelayedExpansion
:start
cls
call settings.cmd
title Friend Code Generator - 1.2.0
echo Last Update: 31st March 2019
echo -----------------------
echo  1 - 3ds/Wii-U FC generator
echo  2 - Switch FC Generator
echo  3 - Clear Codes.txt
echo  4 - Settings
echo -----------------------

set "choose="
set /p "choose=Type 1, 2, 3 or 4 then press ENTER: "
if "!choose!"=="1" goto 3ds
if "!choose!"=="2" goto Switch
if "!choose!"=="3" goto Clear
if "!choose!"=="4" goto settings
echo Invalid Input.
pause
goto start

:Clear
copy /y nul "Codes.txt" >nul
cls
echo Cleared!
timeout /t 1 /nobreak >nul
cls
goto start

:badAmount
echo Invalid amount. Enter a whole number from 1 to 2147483647.
pause
goto start

:3ds
cls
set "amount="
set /p "amount= Amount of codes you want: "
call :validateAmount
if errorlevel 1 goto badAmount
copy /y nul "Codes.txt" >nul
cls
echo Generating...
set "loop=0"
set "amt=0"
:loop3ds
set /a num1=%random% %%8999 +1000
set /a num2=%random% %%8999 +1000
set /a num3=%random% %%8999 +1000
>>"Codes.txt" echo !num1!-!num2!-!num3!
set /a amt+=1
title !amt! generated.
set /a loop+=1
if !loop! EQU !amount! goto done3ds
goto loop3ds
:done3ds
set /p "p= Process Done. Press enter to close"
exit

:Switch
cls
set "amount="
set /p "amount= Amount of codes you want: "
call :validateAmount
if errorlevel 1 goto badAmount
copy /y nul "Codes.txt" >nul
cls
echo Generating...
set "loop=0"
set "amt=0"
:loopSw
set /a num1=%random% %%8999 +1000
set /a num2=%random% %%8999 +1000
set /a num3=%random% %%8999 +1000
>>"Codes.txt" echo SW-!num1!-!num2!-!num3!
set /a amt+=1
title !amt! generated.
set /a loop+=1
if !loop! EQU !amount! goto donesw
goto loopSw
:donesw
set /p "p= Process Done. Press enter to close"
exit

:settings
cls
echo Settings is in beta. Some functions may not work properly!
echo.
echo ------------------------------------
echo  1 - Change the color of the program!
echo  2 - Go back to generator.
echo ------------------------------------
echo.
set "choose="
set /p "choose=Type 1 or 2 then press ENTER: "
if "!choose!"=="1" goto colorchange
if "!choose!"=="2" goto start
echo Invalid.
timeout /t 1 /nobreak >nul
cls
goto settings

:colorchange
cls
echo What color do you want to change it to?
echo.
echo 1: Blue
echo 2: Green
echo 3: Aqua
echo 4: Red
echo 5: Purple
echo 6: Yellow
echo 7: White
echo 8: Gray/Grey
echo 9: Light Blue
echo a: Light Green
echo b: Light Aqua
echo c: Light Red
echo d: Light Purple
echo e: Light Yellow
echo f: Light White
echo.
set "choose="
set /p "choose=Type a color-id then press enter: "
set "colorOk="
for %%C in (1 2 3 4 5 6 7 8 9 a b c d e f) do (
  if /i "!choose!"=="%%C" set "colorOk=1"
)
if not defined colorOk (
  echo Invalid color.
  timeout /t 1 /nobreak >nul
  goto settings
)
>"settings.cmd" echo color !choose!
cls
goto start

rem Amount must be a decimal integer set /a can count to. Anything else
rem used to spin forever and keep appending to Codes.txt.
:validateAmount
if "!amount!"=="" exit /b 1
set "rest=!amount!"
set "pos=0"
:checkChar
if "!rest!"=="" goto digitsChecked
if !pos! GEQ 10 exit /b 1
set "ch=!rest:~0,1!"
set "rest=!rest:~1!"
set "digitOk="
if !pos! EQU 0 for %%D in (1 2 3 4 5 6 7 8 9) do if "!ch!"=="%%D" set "digitOk=1"
if !pos! GTR 0 for %%D in (0 1 2 3 4 5 6 7 8 9) do if "!ch!"=="%%D" set "digitOk=1"
if not defined digitOk exit /b 1
set /a pos+=1
goto checkChar
:digitsChecked
if !pos! EQU 0 exit /b 1
set "amountNum="
ver >nul
set /a "amountNum=amount" 2>nul
if errorlevel 1 exit /b 1
if not "!amountNum!"=="!amount!" exit /b 1
if !amountNum! LEQ 0 exit /b 1
exit /b 0
