@echo off

echo Setting local path variables
REM The path to the Auto Hotkeyprogram:
set ahk=C:\Programme\AutoHotkey
REM The path to the authohotkey directory in the local svn copy:
set svn=.
REM The filename of the joined script:
set fn=neo20

rem echo Killing the old (AHK)Driver
rem tskill %fn%

echo Creating a new joined script from the Source code
cd "%svn%\Source"
REM The order *is* important!
copy "Warning.ahk" + "Global-Part.ahk" + "Methods-Layers.ahk" + "Keys-Qwert-to-Neo.ahk" + "Keys-Neo.ahk" + "Keys-Numbers.ahk" + "Keys-Special.ahk" + "Keys-Numpad.ahk" + "Keys-DeadKeys.ahk" + "Methods-Lights.ahk" + "Methods-Other.ahk" + "Compose.ahk" + "Methods-Unicode.ahk" + "Methods-ScreenKeyboard.ahk" "..\%fn%.ahk"
cd..

echo Compiling the new Driver using Autohotkey
"%ahk%\Compiler\Ahk2Exe.exe" /in "%svn%\%fn%.ahk" /out "%svn%\%fn%.exe" /icon "%svn%\neo.ico"

echo Driver Update complete! You can now close this log-window.

REM Start the new Driver
rem %fn%.exe

REM wie kann man hier mit der Skriptabarbeitung weitermachen? Unter Windows XP scheint es nicht möglich zu sein, dies mit "Bordmitteln" zu erreichen, es gibt hierfür jedoch extere Programme, etwa:
REM  Start the new driver asynchronously, using "Hidden Start" (hstart.exe) from http://www.ntwind.com/software/utilities/hstart/
REM hstart.exe /NOCONSOLE /D="." "%fn%.exe"