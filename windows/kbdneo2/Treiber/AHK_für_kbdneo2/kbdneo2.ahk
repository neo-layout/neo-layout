;*********************
; Anfangsbedingungen *
;*********************
name=Neo 2.0 (Erweiterung für nativen Treiber)
enable=Aktiviere %name%
disable=Deaktiviere %name%
#usehook on
#LTrim

; *** Benutze Bilder wennsie im aktuellen Verzeichnis vorhanden sind ***
if (FileExist("ebene1.png")&&FileExist("ebene2.png")&&FileExist("ebene3.png")&&FileExist("ebene4.png")&&FileExist("ebene5.png")&&FileExist("ebene6.png"))
  zeigeBildschirmTastatur = 1
if (FileExist("neo_enabled.ico")&&FileExist("neo_disabled.ico"))
  iconBenutzen=1

  
;*************************
; Menü des Systray-Icons *
;*************************
if (iconBenutzen)
  menu,tray,icon,neo_enabled.ico,,1
menu,tray,nostandard
menu,tray,add,AHK öffnen,open
  menu,helpmenu,add,Info,about
  menu,helpmenu,add
  menu,helpmenu,add,http://autohotkey.com/,autohotkey
  menu,helpmenu,add,http://www.neo-layout.org/,neo
menu,tray,add,Hilfe,:helpmenu
menu,tray,add
menu,tray,add,%disable%,togglesuspend
menu,tray,add
menu,tray,add,Skript Bearbeiten,edit
menu,tray,add,Neu Laden,reload
menu,tray,add
menu,tray,add,Nicht im Systray anzeigen,hide
menu,tray,add,%name% beenden,exitprogram
menu,tray,default,%disable%
menu,tray,tip,%name%


;******************
; Initialisierung *
;******************
isShiftRPressed := 0
isShiftLPressed := 0
isShiftPressed := 0
isMod2Locked := 0
isMod3RPressed := 0
isMod3LPressed := 0
isMod3Pressed := 0
isMod4RPressed := 0
isMod4LPressed := 0
isMod4Pressed := 0
isMod4Locked := 0
isMod4Active := 0


;***********************
; Fehlende Funktionen  *
;***********************
; *** benötigte Modifier werden gehookt ***
~*SC136::
  if (isShiftLPressed and !isShiftRPressed)
  ToggleMod2Lock()
  isShiftRPressed := 1
  isShiftPressed := 1
return

~*SC136 up::
  isShiftRPressed := 0
  isShiftPressed := isShiftLPressed
return

~*SC02A::
  if (isShiftRPressed and !isShiftLPressed)
  ToggleMod2Lock()
  isShiftLPressed := 1
  isShiftPressed := 1
return

~*SC02A up::
  isShiftLPressed := 0
  isShiftPressed := isShiftRPressed
return

~*SC02B::
  isMod3RPressed := 1
  isMod3Pressed := 1
return

~*SC02B up::
  isMod3RPressed := 0
  isMod3Pressed := isMod3LPressed
return

~*SC03A::
  isMod3LPressed := 1
  isMod3Pressed := 1
return

~*SC03A up::
  isMod3LPressed := 0
  isMod3Pressed := isMod3RPressed
return

~*SC138::
  if (isMod4LPressed and !isMod4RPressed)
   ToggleMod4Lock()
  isMod4RPressed := 1
  isMod4Pressed := 1
  doMod4()
return

~*SC138 up::
  isMod4RPressed := 0
  isMod4Pressed := isMod4LPressed
  doMod4()
return

~*SC056::
  if (isMod4RPressed and !isMod4LPressed)
   ToggleMod4Lock()
  isMod4LPressed := 1
  isMod4Pressed := 1
  doMod4()
return
	
~*SC056 up::
  isMod4LPressed := 0
  isMod4Pressed := isMod4RPressed
  doMod4()
return

; *** Welcher Modifier ist aktiv und CapsLock und Mod4Lock ***
ToggleMod2Lock() {
  global
  if (isMod2Locked)
  {
    isMod2Locked := 0
    SetCapslockState off
  }
  else
  {
    isMod2Locked := 1
    SetCapslockState on
  }
}

ToggleMod4Lock() {
  global
  if (isMod4Locked)
  {
   isMod4Locked := 0
   send {vk15}
  }
  else
  {
   isMod4Locked := 1
   send {vk15}
  }
}

doMod4() {
  global
  if (isMod4Locked)
  {
    if (isMod4Pressed)
      isMod4Active := 0
    else
      isMod4Active := 1
  }
  else
  {
    if (isMod4Pressed)
      isMod4Active := 1
    else
      isMod4Active := 0
  }
}

; *** Funktionstasten ***
~*4::
if (isMod4Active and !isMod3Pressed)
Send {Blind}{PGUP}
return

~*v::
if (isMod4Active and !isMod3Pressed) 
Send {Blind}{BACKSPACE}
return
 
~*l::
if (isMod4Active and !isMod3Pressed)
Send {Blind}{UP}
return

~*c::
if (isMod4Active and !isMod3Pressed)
Send {Blind}{DEL}
return

~*w::
if (isMod4Active and !isMod3Pressed)
Send {Blind}{INS}
return

~*u::
if (isMod4Active and !isMod3Pressed)
Send {Blind}{HOME}
return

~*i::
if (isMod4Active and !isMod3Pressed)
Send {Blind}{LEFT}
return

~*a::
if (isMod4Active and !isMod3Pressed)
Send {Blind}{DOWN}
return

~*e::
if (isMod4Active and !isMod3Pressed)
Send {Blind}{RIGHT}
return

~*o::
if (isMod4Active and !isMod3Pressed)
Send {Blind}{END}
return

~*ü::
if (isMod4Active and !isMod3Pressed)
Send {esc}
return

~*ö::
if (isMod4Active and !isMod3Pressed)
Send {Blind}{TAB}
return

~*ä::
if (isMod4Active and !isMod3Pressed)
Send {Blind}{PGDN}
return

~*p::
if (isMod4Active and !isMod3Pressed)
Send {ENTER}
return


;*****************
; Menüfunktionen *
;*****************
togglesuspend:
  if A_IsSuspended {
    menu,tray,rename,%enable%,%disable%
    menu,tray,tip,%name%
    if (iconBenutzen)
      menu,tray,icon,neo_enabled.ico,,1
    suspend,off ; Schaltet Suspend aus
  } else {
    menu,tray,rename,%disable%, %enable%
    menu,tray,tip,%name% : Deaktiviert
    if (iconBenutzen)
      menu,tray,icon,neo_disabled.ico,,1
    suspend,on ; Schaltet Suspend ein
  } return

about:
  msgbox, 64, NEO 2.0 – Ergonomische Tastaturbelegung, 
  (
  %name% 
  `nDas Neo-Layout ist ein alternatives deutsches Tastaturlayout
  Näheres finden Sie unter http://neo-layout.org/. 
  `nDieses Skript erweitert den nativen Tastaturtreiber um 
  einige fehlende Funktionen.
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
  exitapp
return


;*********************
; BildschirmTastatur *
;*********************
guiErstellt = 0
alwaysOnTop = 1

*F1::
  if (isMod4Pressed&&zeigeBildschirmTastatur)
    goto Switch1
  else send {blind}{F1}
return

*F2::
  if (isMod4Pressed&&zeigeBildschirmTastatur)
    goto Switch2
  else send {blind}{F2}
return

*F3::
  if (isMod4Pressed&&zeigeBildschirmTastatur)
    goto Switch3
  else send {blind}{F3}
return

*F4::
  if (isMod4Pressed&&zeigeBildschirmTastatur)
    goto Switch4
  else send {blind}{F4}
return

*F5::
  if (isMod4Pressed&&zeigeBildschirmTastatur)
    goto Switch5
  else send {blind}{F5}
return

*F6::
  if (isMod4Pressed&&zeigeBildschirmTastatur)
    goto Switch6
  else send {blind}{F6}
return

*F7::
  if (isMod4Pressed&&zeigeBildschirmTastatur)
    goto Show
  else send {blind}{F7}
return

*F8::
  if (isMod4Pressed&&zeigeBildschirmTastatur)
    goto ToggleAlwaysOnTop
  else send {blind}{F8}
return

Switch1:
  tImage := "ebene1.png"
  goto Switch
Return

Switch2:
  tImage := "ebene2.png"
  goto Switch
Return

Switch3:
  tImage := "ebene3.png"
  goto Switch
Return

Switch4:
  tImage := "ebene4.png"
  goto Switch
Return

Switch5:
  tImage := "ebene5.png"
  goto Switch
Return

Switch6:
  tImage := "ebene6.png"
  goto Switch
Return

Switch:
  if guiErstellt {
    if (Image = tImage)
       goto Close
    else {
      Image := tImage
      SetTimer, Refresh
    }
  } else {
    Image := tImage
    goto Show    
  }
Return

Show:
  if guiErstellt {
     goto Close
  } else {
    if (Image = "") {
      Image := "ebene1.png"
    }     
    yPosition := A_ScreenHeight -270
    Gui,Color,FFFFFF
    Gui,Add,Button,xm+5 gSwitch1,F1
    Gui,Add,Button,xm+5 gSwitch2,F2
    Gui,Add,Button,xm+5 gSwitch3,F3
    Gui,Add,Button,xm+5 gSwitch4,F4
    Gui,Add,Button,xm+5 gSwitch5,F5
    Gui,Add,Button,xm+5 gSwitch6,F6
    Gui,Add,Button,xm+5 gShow,F7
    Gui,Add,Text,x+5,An /
    Gui,Add,Text,y+3,Aus
    Gui,Add,Button,x+10 y+-30 gShow,F8
    Gui,Add,Text,x+5,OnTop
    Gui,Add,Picture,AltSubmit ys w729 h199 vPicture,%Image%
    Gui,+AlwaysOnTop
    Gui,Show,y%yposition% Autosize
    guiErstellt = 1
  } 
Return

Close:
  guiErstellt = 0
  Gui,Destroy
Return

Refresh:
  If (Image != OldImage) {
    GuiControl,,Picture,%Image%
    OldImage := Image
  }
Return

ToggleAlwaysOnTop:
  if alwaysOnTop {
    Gui, -AlwaysOnTop
    alwaysOnTop = 0    
  } else {
    Gui, +AlwaysOnTop
    alwaysOnTop = 1
  }
Return