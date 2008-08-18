; LShift+RShift == CapsLock (simuliert)
; Es werden nur die beiden Tastenkombinationen abgefragt,
; daher kommen LShift und RShift ungehindert bis in die
; Applikation. Dies ist aber merkwürdig, da beide Shift-
; Tasten nun /modifier keys/ werden und, wie in der AHK-
; Hilfe beschrieben, eigentlich nicht mehr bis zur App
; durchkommen sollten.
; KeyboardLED(4,"switch") hatte ich zuerst genommen, aber
; das schaltet, oh Wunder, die LED nicht wieder aus.

isMod2Locked = 0
VKA1SC136 & VKA0SC02A:: ; RShift, dann LShift
VKA0SC02A & VKA1SC136:: ; LShift, dann RShift
  if (GetKeyState("VKA1SC136", "P") and GetKeyState("VKA0SC02A", "P"))
  {
    if isMod2Locked
    {
      isMod2Locked = 0
      KeyboardLED(4,"off")
    }
    else
    {
      isMod2Locked = 1
      KeyBoardLED(4,"on")
    }
  }
return

;Mod3-Tasten (Wichtig, sie werden sonst nicht verarbeitet!)
*VKBFSC02B:: ; #
*VK14SC03A:: ; CapsLock
return

;Mod4+Mod4 == Mod4-Lock
; Im Gegensatz zu LShift+RShift werden die beiden Tasten
; _nicht_ zur Applikation weitergeleitet, und nur bei
; gleichzeitigem Drücken wird der Mod4-Lock aktiviert und
; angezeigt.

IsMod4Locked := 0
*VKA5SC138::
*VKE2SC056::
  if (GetKeyState("VKA5SC138", "P") and GetKeyState("VKE2SC056", "P"))
  {
    if IsMod4Locked
    {
      if zeigeLockBox
        MsgBox Mod4-Feststellung aufgebehoben!
       IsMod4Locked = 0
      if UseMod4Light
        KeyboardLED(1,"off")
    }
    else
    {
      if zeigeLockBox
        MsgBox Mod4 festgestellt: Um Mod4 wieder zu lösen, drücke beide Mod4-Tasten gleichzeitig!
      IsMod4Locked = 1
      if UseMod4Light
        KeyboardLED(1,"on")
    }
  }
return

Ebene12 := 0
Ebene7 := 0
Ebene8 := 0

EbeneAktualisieren()
{
  global
  PriorDeadKey := DeadKey
  PriorCompKey := CompKey
  DeadKey := ""
  CompKey := ""
  Modstate := IsMod4Pressed() . IsMod3Pressed() . IsShiftPressed()
  if ahkTreiberKombi
    if ( Modstate = "001")
      Ebene = 6
    else
      Ebene = -1
  else
    if      (Modstate = "000") ; Ebene 1: Ohne Mod
      Ebene = 1
    else if (Modstate = "001") ; Ebene 2: Shift
      Ebene = 2
    else if (Modstate = "010") ; Ebene 3: Mod3
      Ebene = 3
    else if (Modstate = "100") ; Ebene 4: Mod4
      Ebene = 4
    else if (Modstate = "011") ; Ebene 5: Shift+Mod3
      Ebene = 5
    else if (Modstate = "110") ; Ebene 6: Mod3+Mod4
      Ebene = 6
    else if (Modstate = "101") ; Ebene 7: Shift+Mod4 impliziert Ebene 4
    {
      Ebene = 4
      Ebene7 = 1
    }
    else if (Modstate = "111") ; Ebene 8: Shift+Mod3+Mod4 impliziert Ebene 6
    {
      Ebene = 6
      Ebene8 = 1
    }
  Ebene12 := ((Ebene = 1) or (Ebene = 2))
  Ebene14 := ((Ebene = 1) or (Ebene = 4))
  GetKeyState("NumLock","T")
}


IsShiftPressed()
{
  global
  return ((GetKeyState("Shift","P")) = !(isMod2Locked)) ;xor
}

IsMod3Pressed()
{
   global
   return ((GetKeyState("CapsLock","P")) or (GetKeyState("#","P")))
}

IsMod4Pressed()
{
   global
   if( not(einHandNeo) or not(spacepressed))
     if IsMod4Locked
         return (not ( GetKeyState("<","P") or GetKeyState("SC138","P")))
     else
         return ( GetKeyState("<","P") or GetKeyState("SC138","P"))
   else
     if IsMod4Lock
       return (not ( GetKeyState("<","P") or GetKeyState("SC138","P") or GetKeyState("ä","P")))
     else
       return ( GetKeyState("<","P") or GetKeyState("SC138","P") or GetKeyState("ä","P"))
}


