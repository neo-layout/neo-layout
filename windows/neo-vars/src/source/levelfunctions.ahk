EbeneAktualisieren() {
  global
  Modstate := IsMod4Active() . IsMod3Active()
  Ebene7 := 0
  Ebene8 := 0
  if        (Modstate == "00") { ; Ebene 1 oder 2
    if (IsShiftActive())         ; Ebene 2: Shift oder CapsLock
      EbeneC := 2
    else                         ; Ebene 1: Ohne Mod oder CapsLock mit Shift
      EbeneC := 1
    if (IsShiftPressed)          ; NC: Ebene 2: Shift (ignoriert CapsLock)
      EbeneNC := 2
    else                         ; NC: Ebene 1: Ohne Mod (ignoriert CapsLock)
      EbeneNC := 1
  } else if (Modstate == "01") { ; Ebene 3 oder 5 (ignoriert CapsLock)
    if (IsShiftPressed)          ; Ebene 5: Shift+Mod3
      EbeneC := 5
    else                         ; Ebene 3: Mod3
      EbeneC := 3
    EbeneNC := EbeneC            ; NC: gleich
  } else if (Modstate == "10") { ; Ebene 4 (Mit Shift: Auch Ebene 7) (ignoriert CapsLock)
    EbeneC := 4
    if (IsShiftPressed)          ; Ebene 7: Shift+Mod4
      Ebene7 := 1
    EbeneNC := EbeneC            ; NC: gleich
  } else if (ModState == "11") { ; Ebene 6 (Mit Shift Xoder CapsLock: Auch Ebene 8)
    EbeneC := 6
    if (IsShiftPressed)          ; Ebene 8: Shift (ignoriert CapsLock)
      Ebene8 := 1
    EbeneNC := EbeneC            ; NC: gleich
  }
  if (guiErstellt) {
    if (striktesMod2Lock)
      BSTSwitch(EbeneC)
    else if ((EbeneNC < 3) and (EbeneNC != EbeneC))
      BSTSwitch(EbeneNC . "C")
    else
      BSTSwitch(EbeneNC)
  }
}

IsShiftActive() {
  global
  if (isMod2Locked)
    if (isShiftPressed)
      return 0
    else
      return 1
  else
    if (isShiftPressed)
      return 1
    else
      return 0
}

IsMod3Active() {
   global
   return isMod3Pressed
}

IsMod4Active() {
  global
  if (isMod4Locked)
    if (isMod4Pressed)
      return 0
    else
      return 1
  else
    if (isMod4Pressed)
      return 1
    else
      return 0
}

ToggleMod2Lock() {
  global
  if (isMod2Locked)
  {
    isMod2Locked := 0
    KeyboardLED(4,"off")
  }
  else
  {
    isMod2Locked := 1
    KeyBoardLED(4,"on")
  }
}


ToggleMod4Lock() {
  global
  if (IsMod4Locked) {
    IsMod4Locked := 0
    if (UseMod4Light)
      KeyboardLED(1,"off")
    if (zeigeLockBox)
      TrayTip,Mod4-Feststellung,Die Feststellung wurde aufgehoben.,3,1
  } else {
    IsMod4Locked := 1
    if (UseMod4Light)
      KeyboardLED(1,"on")
    if (zeigeLockBox)
      TrayTip,Mod4-Feststellung,Um Mod4 wieder zu lösen`, drücke beide Mod4-Tasten gleichzeitig!,3,1
  }
}

