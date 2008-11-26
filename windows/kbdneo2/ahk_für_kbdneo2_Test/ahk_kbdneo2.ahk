;Inititalisierung
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



~F24::return


; alle Modifier werden gehookt

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


;Welcher Modifier ist aktiv und CapsLock und Mod4Lock

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
    isMod4Locked := 0
  else
   isMod4Locked := 1
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


;Fehlende Funktionstasten

~4:: 
if (isMod4Active and !isMod3Pressed)  
Sendinput {Blind}{PGUP} 
return 
 
~l:: 
if (isMod4Active and !isMod3Pressed) 
Sendinput {Blind}{UP} 
return 
 
~c:: 
if (isMod4Active and !isMod3Pressed) 
Sendinput {Blind}{DEL} 
return 
 
~w:: 
if (isMod4Active and !isMod3Pressed) 
Sendinput {Blind}{INS} 
return 
 
~u:: 
if (isMod4Active and !isMod3Pressed) 
Sendinput {Blind}{HOME} 
return 
 
~i:: 
if (isMod4Active and !isMod3Pressed) 
Sendinput {Blind}{LEFT} 
return 
 
~a:: 
if (isMod4Active and !isMod3Pressed) 
Sendinput {Blind}{DOWN} 
return 
 
~e:: 
if (isMod4Active and !isMod3Pressed) 
Sendinput {Blind}{RIGHT} 
return 
 
~o:: 
if (isMod4Active and !isMod3Pressed) 
Sendinput {Blind}{END} 
return 
 
~':: 
if (isMod4Active and !isMod3Pressed) 
Sendinput {Blind}{PGDN} 
return 