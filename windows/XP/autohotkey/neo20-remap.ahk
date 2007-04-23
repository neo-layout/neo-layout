/*
  Umbelegung von AltGr auf CapsLock und #,
  dafür Mod5 auf AltGr und <
*/

;#InstallKeybdHook
#usehook on
#singleinstance force

;SendMode InputThenPlay - geht nicht

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
; CapsLock und # (SC02B) werden zu AltGr (SC138)
; ----------------------------------------------
; http://www.autohotkey.com/forum/topic181.html

*CapsLock::
Send {SC138 Down}
Loop
{
   Sleep, 10
   GetKeyState, state, CapsLock, P
   if state = U  ; The key has been released, so break out of the loop.
      break
}
Send {SC138 Up} 
return


*SC02B::
Send {SC138 Down}
Loop
{
   Sleep, 10
   GetKeyState, state, SC02B, P
   if state = U  ; The key has been released, so break out of the loop.
      break
}
Send {SC138 Up} 
return


; 5. und 6. Ebene:
; < (SC056) und AltGr werden zu Win + Ctrl
; --------------------------------------------
  ; < funktioniert, aber bei AltGr kommt (manchmal/immer?) nur 
  ; Control Down an, aber nicht das Up, dann bleibt Control aktiv 
  ; - Lösung ist dann, einmal die normale Controltaste zu drücken.


*SC056::
Send {RWin Down}
Send {Control Down}
Loop
{
   Sleep, 10
   GetKeyState, state, SC056, P
   if state = U  ; The key has been released, so break out of the loop.
      break
}
Send {RWin Up} 
Send {Control Up} 
return


*SC138::
Send {RWin Down}
Send {Control Down}
Loop
{
   Sleep, 10
   GetKeyState, state, SC138, P
   if state = U  ; The key has been released, so break out of the loop.
      break
}
Send {RWin Up} 
Send {Control Up} 
return


;-----------------------------------------------

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
