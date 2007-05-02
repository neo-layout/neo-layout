/*
  Umbelegung von Win+Ctrl auf CapsLock und #,
  Zweites AltGr auf <
  Version vom 02.05.2007
*/

;#InstallKeybdHook
#usehook on
#singleinstance force

SendMode Input ;ThenPlay - geht nicht

name = NEO-Remap
enable  = Aktiviere %name%
disable = Deaktiviere %name%

; Menü des Systray-Icons 
; ----------------------

menu, tray, nostandard
menu, tray, add, Öffnen, open
menu, tray, add
menu, tray, add, %disable%, toggleneo
menu, tray, default, %disable%
menu, tray, add
menu, tray, add, Edit, edit
menu, tray, add, Reload, reload
menu, tray, add
menu, tray, add, Nicht im Systray anzeigen, hide
menu, tray, add, %name% beenden, exitprogram
menu, tray, tip, %name%


; 3. und 4. Ebene:
; CapsLock und # werden zu Win + Ctrl
; --------------------------------------------


*CapsLock::
Send {RWin Down}
Send {Control Down}
Loop
{
   Sleep, 10
   GetKeyState, state, CapsLock, P
   if state = U  
   break
   ; The key has been released, so break out of the loop.
}
Send {RWin Up} 
Send {Control Up} 
return


*#::
Send {RWin Down}
Send {Control Down}
Loop
{
   Sleep, 10
   GetKeyState, state, #, P
   if state = U  
   break
   ; The key has been released, so break out of the loop.
}
Send {RWin Up} 
Send {Control Up} 
return


; 5. und 6. Ebene:
; < wird zu zweiter AltGr (SC138)
; --------------------------------



*<::
Send {SC138 Down}
Loop
{
   Sleep, 10
   GetKeyState, state, <, P
   if state = U  
   break
   ; The key has been released, so break out of the loop.
}
Send {SC138 Up}
return



; Funktionen des Systray-Menüs
; ----------------------------

toggleneo:
   if state <>
   {
      state =
      menu, tray, rename, %enable%, %disable%
   }
   else
   {
      state = : Deaktiviert
      menu, tray, rename, %disable%, %enable%
   }
   menu, tray, tip, %name%%state%
   suspend
return

open:
   ListLines ; shows the Autohotkey window
return

edit:
   edit
return

reload:
   reload
return

hide:
   menu, tray, noicon
return

exitprogram:
   exitapp
return
