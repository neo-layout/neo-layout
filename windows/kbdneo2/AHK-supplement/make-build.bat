@echo off

echo Setting default local path variables
set  ahkpath=C:\Tools\Development\AutoHotkey
if not exist "%ahkpath%" set ahkpath=C:\Program Files\AutoHotkey
set  Ahk2Exe=%ahkpath%\Compiler\Ahk2Exe.exe

set bindir=.\bin

if NOT EXIST %bindir% mkdir %bindir%

echo Removing old versions of Neo AHK Exe files
del "%bindir%\kbd*.exe" 2> nul

set srcdir=.\neo
set fnahk=%srcdir%\kbdneo.ahk
set fnexe=%bindir%\kbdneo.exe

echo Compiling kbdneo supplemental driver using AutoHotkey
"%Ahk2Exe%" /in "%fnahk%" /out "%fnexe%" /icon "%srcdir%\neo_enabled.ico" /bin "%ahkpath%\Compiler\Unicode 32-bit.bin"

set srcdir=.\bone
set fnahk=%srcdir%\kbdbone.ahk
set fnexe=%bindir%\kbdbone.exe

echo Compiling kbdbone supplemental driver using AutoHotkey
"%Ahk2Exe%" /in "%fnahk%" /out "%fnexe%" /icon "%srcdir%\neo_enabled.ico" /bin "%ahkpath%\Compiler\Unicode 32-bit.bin"

set srcdir=.\qwertz
set fnahk=%srcdir%\kbdqwertz.ahk
set fnexe=%bindir%\kbdqwertz.exe

echo Compiling kbdqwertz supplemental driver using AutoHotkey
"%Ahk2Exe%" /in "%fnahk%" /out "%fnexe%" /icon "%srcdir%\neo_enabled.ico" /bin "%ahkpath%\Compiler\Unicode 32-bit.bin"


echo Driver update complete! You can now close this log window.
pause
