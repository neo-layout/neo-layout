/*
   Mod3: Umbelegung von Win+Ctrl auf CapsLock und #,
   Mod5: Zweites AltGr auf <
   Version vom 25.05.2007
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



; Mod3 (3. und 4. Ebene)
; CapsLock und # werden zu Win + Ctrl
; # + CapsLock = CapsLock
; --------------------------------------------


*CapsLock::
   Send {RWin Down}
   Send {Control Down}
   GetKeyState, capsstate, #, P
   If capsstate = D  
      {
      keywait, Capslock
      GetKeyState, state, CapsLock, T 
         ; D if CapsLock is ON or U otherwise.
      if state = D
         setcapslockstate, off
      else
         setcapslockstate, on
      }
   Else 
      {
      Loop
         {
         Sleep, 10
         GetKeyState, keystate, CapsLock, P
         if keystate = U
            {
            Send {RWin Up} 
            Send {Control Up} 
            break
            }
         }
      }
return


*#::
   Send {RWin Down}
   Send {Control Down}
   Loop
   {
      Sleep, 10
      GetKeyState, keystate, #, P
      if keystate = U  
         break
   }
   Send {RWin Up} 
   Send {Control Up} 
return


; Mod5 (5. und 6. Ebene)
; < wird zu zweitem AltGr (SC138)
; < + AltGr = NumpadDot
; --------------------------------
; 

*SC138:: 
   Send {Blind}{LCtrl Up}{SC138 DownTemp}
   GetKeyState, dotstate, <, P
   If dotstate = D  
      {
      keywait, SC138
      Send {numpaddot}
      Send {Blind}{LCtrl Up}{SC138 DownTemp}
      }
   Else
      {
      Loop
         {
         Sleep, 10
         GetKeyState, keystate, SC138, P
         If keystate = U  
            {   
            Send {Blind}{SC138 Up}
            break
            }
         }
      }
return

*<::
   Send {SC138 DownTemp}
   Loop
   {
      Sleep, 10
      GetKeyState, keystate, <, P
      if keystate = U  
         break
   }
   Send {SC138 Up}
return


; Funktionen des Systray-Menüs
; ----------------------------

toggleneo:
   If suspendstate <>
   {
      suspendstate =
      menu, tray, rename, %enable%, %disable%
   }
   Else
   {
      suspendstate = : Deaktiviert
      menu, tray, rename, %disable%, %enable%
   }
   menu, tray, tip, %name%%suspendstate%
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
