@echo off
@cls
@echo if It prints nothing when ends its because password was not found!
echo. 
echo.
echo.

REM -- Sum credits to ebola man 
set zip="C:\Program Files\7-Zip\7z.exe"
if not exist "C:\Program Files\7-Zip" (
	echo 7zip not installed! Please install it before running this app.
	pause 
	exit
)

REM -- SETUP (ARCHIVE)
set /p archive="Enter Archive: "

REM -- SETUP (WORDLIST)
set /p wordlist="Enter Wordlist (default for normal wordlist): "

REM -- CHECK EXISTENCE (ARCHIVE)
if not exist "%archive%" (
	echo File not found! 
	pause
	exit 
)



REM -- CHECK EXISTENCE (WORDLIST)
if not exist  "%wordlist%" (
	echo Wordlist not found! 
	pause
	exit 
)

REM -- FILE LOGIC (WORDLIST)
:custom
for /f %%a in (%wordlist%) do (
	set pass=%%a 
	call :attempt
)
REM -- ATTEMPT LOGIC (7ZIP)
:attempt 
echo [ATTEMPT]: %pass%
%zip% x -p%pass% "%archive%" -o"cracked" -y >nul 2>&1
if	/I  %errorlevel% EQU 0 (
	echo Password found! %pass%  
	echo And extracted zip content to 'cracked'
	pause 
	exit
) 
