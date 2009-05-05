NEOEbeneAktualisieren() {
  global
  Ebene7 := 0
  Ebene8 := 0

  ModPos  := 1 + (isMod4Locked   << 4)  ; plus 1, da SubStr() bei 1 beginnt
               + (isMod4Pressed  << 3)
               + (isMod3Pressed  << 2)
               + (isMod2Locked   << 1)
               + (isShiftPressed << 0)

  ; isMod4Locked     00000000000000001111111111111111
  ; isMod4Pressed    00000000111111110000000011111111
  ; isMod3Pressed    00001111000011110000111100001111
  ; isMod2Locked     00110011001100110011001100110011
  ; isShiftPressed   01010101010101010101010101010101

  EbeneNC := SubStr("12123535444466664444353512126666",ModPos,1) ; Für normale Tasten (reagieren nicht auf CapsLock)
  EbeneC  := SubStr("12213535444466664444353512216666",ModPos,1) ; Für Buchstaben     (reagieren       auf CapsLock)
  Ebene7  := SubStr("00000000010100000101000000000000",ModPos,1)
  Ebene8  := SubStr("00000000000001010000000000000101",ModPos,1)

  if (BSTguiErstellt) {
    if (striktesMod2Lock)
      BSTSwitch(EbeneC)
    else if (EbeneNC != EbeneC)
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

