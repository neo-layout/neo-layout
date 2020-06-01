; -*- encoding: utf-8 -*-

if (A_IsCompiled) {
; Revisionsinformation bereits verfügbar
} else {
; Revisionsinformation nicht verfügbar oder nicht zuverlässig, nicht neu generieren
  Revision := "<unknown>"
}

name=Neo 2.0 r%Revision%-r%CompRevision% (%A_ScriptName%)
enable=Aktiviere %name%
disable=Deaktiviere %name%
#LTrim ; Quelltext kann eingerückt werden

NEONumLockLEDState    := "Off"
NEOCapsLockLEDState   := "Off"
NEOScrollLockLEDState := "Off"
OnExit, exitprogram

ApplicationFolder := A_AppData . "\Neo2"
FileCreateDir, %ApplicationFolder%
ini := ApplicationFolder . "\Neo2.ini"

IniRead,zeigeLockBox,%ini%,Global,zeigeLockBox,1
IniRead,zeigeModusBox,%ini%,Global,zeigeModusBox,1
IniRead,UseMod4Light,%ini%,Global,UseMod4Light,1
IniRead,striktesMod2Lock,%ini%,Global,striktesMod2Lock,0
IniRead,dynamischesCompose,%ini%,Global,dynamischesCompose,0
IniRead,NumLockOff,%ini%,Global,NumLockOff,0
IniRead,customLayout,%ini%,Global,customLayout,%A_Space%

SetNEOLockStates()

regread,inputlocale,HKEY_CURRENT_USER,Keyboard Layout\Preload,1
regread,inputlocalealias,HKEY_CURRENT_USER,Keyboard Layout\Substitutes,%inputlocale%

if (inputlocalealias<>"")
  inputlocale:=inputlocalealias

if (inputlocale<>"00000407" and inputlocale<>"00000807" and inputlocale<>"00010407") {
  suspend   
  regread,inputlocale,HKEY_LOCAL_MACHINE,SYSTEM\CurrentControlSet\Control\Keyboard Layouts\%inputlocale%,Layout Text
  msgbox, 52, Warnung!,
    (
    Nicht kompatibles Tastaturlayout:   
    `t%inputlocale%   
    `nDas deutsche QWERTZ muss als Standardlayout eingestellt  
    sein, damit %name% wie erwartet funktioniert.   
    `nÄndern Sie die Tastatureinstellung unter 
    `tSystemsteuerung   
    `t-> Regions- und Sprachoptionen   
    `t-> Sprachen 
    `t-> Details...   `n
    Trotzdem fortfahren?`n
    )
  ifmsgbox, No
    exitapp
  ifmsgbox, Yes
    suspend
}

wasNonShiftKeyPressed := 0
isShiftRPressed := 0
isShiftLPressed := 0
isShiftPressed := 0
isMod2Locked := 0
IsMod3RPressed := 0
IsMod3LPressed := 0
IsMod3Pressed := 0
IsMod4RPressed := 0
IsMod4LPressed := 0
IsMod4Pressed := 0
IsMod4Locked := 0
EbeneAktualisieren := "NEOEbeneAktualisieren"

SetNEOLockStates() {
  global
  SavedNumLockState := GetKeyState("NumLock","T")
  SavedScrollLockState := GetKeyState("ScrollLock","T")
  SavedCapsLockState := GetKeyState("CapsLock","T")
  SwitchIs0 := "Off"
  SwitchIs1 := "On"
  SavedNumLockState := SwitchIs%SavedNumLockState%
  SavedScrollLockState := SwitchIs%SavedScrollLockState%
  SavedCapsLockState := SwitchIs%SavedCapsLockState%
  if (NumLockOff == 1)
    SetNumLockState, Off
  else
    SetNumLockState, On
  SetScrollLockState, Off
  SetCapsLockState, Off
  Sleep,1
  UpdateNEOLEDS()
}

SetOldLockStates() {
  global
  UpdateOldLEDS()
  Sleep,1
  SetNumLockState,% SavedNumLockState
  SetScrollLockState,% SavedScrollLockState
  SetCapsLockState,% SavedCapsLockState
}

%EbeneAktualisieren%()

ActivateLayOut(inputlocale)

TheKeys()

if (dynamischesCompose)
  LoadCurrentCompose()
else
  LoadDefaultCompose()

ChangeCustomLayout()
