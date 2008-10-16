VKA1SC136 & VKA0SC02A:: ; RShift, dann LShift
VKA0SC02A & VKA1SC136:: ; LShift, dann RShift
  if GetKeyState("VKA1SC136", "P") and GetKeyState("VKA0SC02A", "P") {
    if isMod2Locked {
      isMod2Locked = 0
    } else {
      isMod2Locked = 1
    }
  }
return

IsMod4Locked := 0
*VKA5SC138::
*VKE2SC056::
  if GetKeyState("VKA5SC138", "P") and GetKeyState("VKE2SC056", "P") {
    if IsMod4Locked {
      if zeigeLockBox
        MsgBox Mod4-Feststellung aufgebehoben!
       IsMod4Locked = 0
    } else {
      if zeigeLockBox
        MsgBox Mod4 festgestellt: Um Mod4 wieder zu lösen, drücke beide Mod4-Tasten gleichzeitig!
      IsMod4Locked = 1
    }
  }
return

EbeneAktualisieren() {
  global
  Modstate := IsMod4Pressed() . IsMod3Pressed() . IsShiftPressed()
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
  else if (Modstate = "101") { ; Ebene 7: Shift+Mod4 impliziert Ebene 4
    Ebene = 4
    Ebene7 = 1
  } else if (Modstate = "111") { ; Ebene 8: Shift+Mod3+Mod4 impliziert Ebene 6
    Ebene = 6
    Ebene8 = 1
  } Ebene12 := ((Ebene = 1) or (Ebene = 2))
}

IsMod4Pressed()
{
  global
    if IsMod4Locked
      return !(GetKeyState("<","P") or GetKeyState("SC138","P"))
    else
      return (GetKeyState("<","P") or GetKeyState("SC138","P"))
}

OutputChar(val1,val2) {
  global
    send % "{blind}" . val1
}

OutputChar12(val1,val2,val3,val4) {
  global
  if (Ebene = 1)
    c := val1
  else c := val2
  if (Ebene = 1)
    d := val3
  else d := val4
  if GetKeyState("Shift","P") and isMod2Locked
      send % "{blind}{Shift Up}" . c . "{Shift Down}"
  else send % "{blind}" . c
}

SendUnicodeChar(charCode1, charCode2) {

  global
  IfWinActive,ahk_class gdkWindowToplevel
  {
    StringLower,charCode1,charCode1
    send % "^+u" . SubStr(charCode1,3) . " "
  } else {
    VarSetCapacity(ki,28*2,0)
    EncodeInteger(&ki+0,1)
    EncodeInteger(&ki+6,charCode1)
    EncodeInteger(&ki+8,4)
    EncodeInteger(&ki+28,1)
    EncodeInteger(&ki+34,charCode1)
    EncodeInteger(&ki+36,4|2)
    DllCall("SendInput","UInt",2,"UInt",&ki,"Int",28)
  }
}

EncodeInteger(ref,val) {
  DllCall("ntdll\RtlFillMemoryUlong","Uint",ref,"Uint",4,"Uint",val)
}

IsShiftPressed()
{
  global
  if !(NoCaps and GetKeyState("Shift", "P") and (GetKeyState("Alt", "P") or GetKeyState("Strg", "P"))) {
    if GetKeyState("Shift","P")
      if isMod2Locked and !noCaps
        return 0
      else return 1
    else if isMod2Locked and !noCaps
      return 1
    else return 0
  }
}

IsMod3Pressed()
{
  global
  return (GetKeyState("VKBFSC02B","P") or GetKeyState("VK14SC03A","P"))
}


*VK34SC005::goto neo_4
*VK56SC02F::
  goto neo_v
*VK4CSC026::
  goto neo_l
*VK43SC02E::
  goto neo_c
*VK57SC011::
  goto neo_w
*VK55SC016::
  goto neo_u
*VK49SC017::
  goto neo_i
*VK41SC01E::
  goto neo_a
*VK45SC012::
  goto neo_e
*VK4FSC018::
  goto neo_o
*VKDESC028::
  goto neo_ä

neo_4:
  EbeneAktualisieren()
  if (Ebene = 1)
    OutputChar(4,4)
  else if (Ebene = 2)
    SendUnicodeChar(0x00BB, "guillemotright") ; Double guillemot right
  else if (Ebene = 3)
    OutputChar("›", "U230A") ; Single guillemot right
  else if (Ebene = 4)
    OutputChar("{PgUp}", "Prior") ; Bild auf
  else if (Ebene = 5)
    SendUnicodeChar(0x2113, "U2213") ; Script small L
  else if (Ebene = 6)
    SendUnicodeChar(0x22A5, "uptack") ; Senkrecht
return

neo_v:
  EbeneAktualisieren()
  if Ebene12
    OutputChar12("v","V","v","V")
  else if (Ebene = 3)
    OutputChar("_","underscore")
  else if (Ebene = 4) and (!lernModus or lernModus_neo_Backspace)
    OutputChar("{Backspace}", "BackSpace")
  else if (Ebene = 6)
    SendUnicodeChar(0x2259, "U2259") ; estimates/entspricht
return

neo_l:
  EbeneAktualisieren()
  if Ebene12
    OutputChar12("l","L","l","L")
  else if (Ebene = 3)
    OutputChar("[", "bracketleft")
  else if (Ebene = 4)
    OutputChar("{Up}", "Up")
  else if (Ebene = 5)
    SendUnicodeChar(0x03BB, "Greek_lambda") ; lambda
  else if (Ebene = 6)
    SendUnicodeChar(0x039B, "Greek_LAMBDA") ; Lambda
return

neo_c:
  EbeneAktualisieren()
  if Ebene12
    OutputChar12("c","C","c","C")
  else if (Ebene = 3)
    OutputChar("]", "bracketright")
  else if (Ebene = 4)
    OutputChar("{Del}", "Delete")
  else if (Ebene = 5)
    SendUnicodeChar(0x03C7, "Greek_chi") ; chi
  else if (Ebene = 6)
    SendUnicodeChar(0x2102, "U2102") ; C (Komplexe Zahlen)]
return

neo_w:
  EbeneAktualisieren()
  if Ebene12
    OutputChar12("w","W","w","W")
  else if (Ebene = 3)
    SendUnicodeChar(0x005E, "asciicircum") ; Zirkumflex
  else if (Ebene = 4)
    OutputChar("{Insert}", "Insert") ; Einfg
  else if (Ebene = 5)
    SendUnicodeChar(0x03C9, "Greek_omega") ; omega
  else if (Ebene = 6)
    SendUnicodeChar(0x03A9, "Greek_OMEGA") ; Omega
return

neo_u:
  EbeneAktualisieren()
  if Ebene12
    OutputChar12("u","U","u","U")
  else if (Ebene = 3)
    OutputChar("\", "backslash")
  else if (Ebene = 4)
    OutputChar("{Home}", "Home")
  else if (Ebene = 6)
    SendUnicodeChar(0x222E, "U222E") ; contour integral
return

neo_i:
  EbeneAktualisieren()
  if Ebene12
    OutputChar12("i","I","i","I")
  else if (Ebene = 3)
    OutputChar("`/", "slash")
  else if (Ebene = 4)
    OutputChar("{Left}", "Left")
  else if (Ebene = 5)
    SendUnicodeChar(0x03B9, "Greek_iota") ; iota
  else if (Ebene = 6)
    SendUnicodeChar(0x222B, "integral") ; integral
return

neo_a:
  EbeneAktualisieren()
  if Ebene12
    OutputChar12("a","A","a","A")
  else if (Ebene = 3)
    OutputChar("{{}", "braceleft")
  else if (Ebene = 4)
    OutputChar("{Down}", "Down")
  else if (Ebene = 5)
    SendUnicodeChar(0x03B1, "Greek_alpha") ; alpha
  else if (Ebene = 6)
    SendUnicodeChar(0x2200, "U2200") ; für alle
return

neo_e:
  EbeneAktualisieren()
  if Ebene12
    OutputChar12("e","E","e","E")
  else if (Ebene = 3)
    OutputChar("{}}", "braceright")
  else if (Ebene = 4)
    OutputChar("{Right}", "Right")
  else if (Ebene = 5)
    SendUnicodeChar(0x03B5, "Greek_epsilon") ; epsilon
  else if (Ebene = 6)
    SendUnicodeChar(0x2203, "U2203") ; es existiert
return

neo_o:
  EbeneAktualisieren()
  if Ebene12
    OutputChar12("o","O","o","O")
  else if (Ebene = 3)
    OutputChar("*", "asterisk")
  else if (Ebene = 4)
    OutputChar("{End}", "End")
  else if (Ebene = 5)
    SendUnicodeChar(0x03BF, "Greek_omicron") ; omicron
  else if (Ebene = 6)
    SendUnicodeChar(0x2208, "elementof") ; element of
return

neo_ä:
  EbeneAktualisieren()
  if Ebene12
    OutputChar12("ä","Ä","adiaeresis","Adiaeresis")
  else if (Ebene = 3)
    OutputChar("|", "bar")
  else if (Ebene = 4)
    OutputChar("{PgDn}", "Next")
  else if (Ebene = 5)
    SendUnicodeChar(0x03B7, "Greek_eta") ; eta
  else if (Ebene = 6)
    SendUnicodeChar(0x211C, "U221C") ; Fraktur R
return