togglesuspend:
  if A_IsSuspended {
    menu, tray, rename, %enable%, %disable%
    menu, tray, tip, %name%
    menu, tray, icon, %ResourceFolder%\neo_enabled.ico,,1
    Gosub, SaveNumLockState
    SetNumLockState Off
    suspend, off ; Schaltet Suspend aus -> NEO
  } else {
    menu, tray, rename, %disable%, %enable%
    menu, tray, tip, %name% : Deaktiviert
    menu, tray, icon, %ResourceFolder%\neo_disabled.ico,,1
    SetNumLockState, %SavedNumLockState%
    suspend, on  ; Schaltet Suspend ein -> QWERTZ
  }
return

help:
  Run, %A_WinDir%\hh mk:@MSITStore:autohotkey.chm
return

about:
  msgbox, 64, %name%  Ergonomische Tastaturbelegung, 
  (
  %name% 
  `nDas Neo-Layout ersetzt das übliche deutsche 
  Tastaturlayout mit der Alternative Neo, 
  beschrieben auf http://neo-layout.org/. 
  `nDazu sind keine Administratorrechte nötig. 
  `nWenn Autohotkey aktiviert ist, werden alle Tastendrucke 
  abgefangen und statt dessen eine Übersetzung weitergeschickt. 
  `nDies geschieht transparent für den Anwender, 
  es muss nichts installiert werden. 
  `nDie Zeichenübersetzung kann leicht über das Icon im 
  Systemtray deaktiviert werden.  `n
  )
return

neo:
  run http://neo-layout.org/
return

autohotkey:
  run http://autohotkey.com/
return

open:
  ListLines ; shows the Autohotkey window
return

edit:
  edit
return

reload:
  Reload
return

hide:
  menu, tray, noicon
return

exitprogram:
  SetNumLockState, %SavedNumLockState%
  exitapp
return

SaveNumLockState:
  if GetKeyState("NumLock","T")
    SavedNumLockState = On
  else
    SavedNumLockState = Off
return

