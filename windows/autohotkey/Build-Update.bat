@echo off
cd Source
set fn=neo20

rem echo Killing the old (AHK)Driver
REM tskill neo20-all-in-one

echo Creating a new Driver from the Source code
REM The order *is* important!
copy "Warning.ahk" + "Global-Part.ahk" + "Methods-Layers.ahk" + "Keys-Qwert-to-Neo.ahk" + "Keys-Neo.ahk" + "Methods-Lights.ahk" + "Methods-Other.ahk" + "Compose.ahk" + "Methods-Unicode.ahk" + "Methods-ScreenKeyboard.ahk" "..\%fn%.ahk"
REM if exist "..\Compose\Compose-all-in-one.ahk" copy "..\%fn%.ahk" + "..\Compose\Compose-all-in-one.ahk" "..\%fn%.ahk"

echo Compiling the new Driver using AutoHotkey...
"C:\Programme\AutoHotkey\Compiler\Ahk2Exe.exe" /in "..\%fn%.ahk" /out "..\%fn%.exe" /icon "..\neo.ico"
echo Driver Update complete! You can now close this log-window.

REM Start the new Driver
rem %fn%.exe

rem wie kann man hier mit der Skriptabarbeitung weitermachen?
rem Unter Windows XP scheint es nicht möglich zu sein, dies mit "Bordmitteln" zu erreichen, es gibt hierfür jedoch extere Programme, etwa
REM echo Start the new driver asynchronously, using "Hidden Start" (hstart.exe) from http://www.ntwind.com/software/utilities/hstart/
REM hstart.exe /NOCONSOLE /D="." "%fn%.exe"