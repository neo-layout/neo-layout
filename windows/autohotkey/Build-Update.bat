@echo off



echo Setting local path variables
REM The path to the Auto Hotkeyprogram
set ahk=C:\Programme\AutoHotkey
REM The path to the authohotkey directory in the local svn copy
set svn=.
REM Just some usefull shortcuts:
set scr="%svn%\Source"
set fn=neo20-all-in-one



echo Killing the old (AHK)Driver
tskill neo20-all-in-one



echo Creating a new Driver from the Source code
REM The order *is* important!
copy "%scr%\Warning.ahk" + "%scr%\Changelog-and-Todo.ahk" + "%scr%\Global-Part.ahk" + "%scr%\Methods-Layers.ahk" + "%scr%\Keys-Qwert-to-Neo.ahk" + "%scr%\Keys-Neo.ahk" + "%scr%\Methods-Lights.ahk" + "%scr%\Methods-Other.ahk" "%svn%\%fn%.ahk"



echo Compiling the new Driver using Autohotkey
"%ahk%\Compiler\Ahk2Exe.exe" /in "%svn%\%fn%.ahk" /out "%svn%\%fn%.exe" /icon "%svn%\neo.ico"



echo Driver Update complete! You can now close this log-window.
REM Start the new Driver
%fn%.exe
exit