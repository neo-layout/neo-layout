#MaxThreadsPerHotKey 4

/*
CM* == 1: Await more compose chars after this sequence? 
CD*     : Replace compose sequence by this character
CPx*    : Key press for * in Ebene x
CPNx*   : Key press for numpad * in Ebene x
CS*     : shortcut to output instead of *
PP*     : repeat code for key *
PR*     : release code for key *
*/

; ein wenig COMPOSE
#Include %a_scriptdir%\en_us.ahk
#Include %a_scriptdir%\neocomp.ahk
#Include %a_scriptdir%\neovarscomp.ahk

#Include %a_scriptdir%\keydefinitions.ahk
#Include %a_scriptdir%\shortcuts.ahk
#Include %a_scriptdir%\recycle.ahk

AllStar(This_HotKey) {
  global
  PhysKey := This_HotKey
  EbeneAktualisieren()
  if (SubStr(PhysKey,1,1) == "*")
    PhysKey := SubStr(PhysKey,2)
  if (SubStr(PhysKey,-2) == " up") {
    PhysKey := SubStr(PhysKey,1,StrLen(PhysKey)-3)
    IsDown := 0
  } else
    IsDown := 1
;  ActKey := Transform(PhysKey)
  ActKey := PhysKey
  if Ebene7 and (CP7%ActKey% != "")
    Char := CP7%ActKey%
  else if Ebene8 and (CP8%ActKey% != "")
    Char := CP8%ActKey%
  else
    Char := CP%Ebene%%ActKey%
  if (IsPressHooked == 1) {
    if (IsDown == 1)
      PressHookProc(PressHookRoutine, PhysKey, ActKey, Char)
  } else if (IsDown == 1)
    CharStarDown(PhysKey, ActKey, Char)
  else
    CharStarUp(PhysKey)
}

CharStarDown(PhysKey, ActKey, char) {
  global
  CompEntry := Comp
  if (PP%PhysKey% != "")
    Comp := PP%PhysKey%     ; resulting from key repeat
  else
    Comp := Comp . char  ; normal compositum

  tosend := ""
  PP%PhysKey% := ""
  PR%PhysKey% := ""

  if (CD%Comp% != "") {
    tosend := CD%Comp%
    PP%PhysKey% := Comp
    Comp := ""
  } else if (CM%Comp% != 1) {
    Comp := ""
    if (CompEntry == "") {
      tosend := char
      PP%PhysKey% := char
    }
  }

  if (strlen(tosend) > 5) { ; multiple chars
    PP%PhysKey% := ""
    loop {
      if (tosend == "") 
        break                ; erledigt
      if (SubStr(tosend,1,1)=="P") {
        CharProc(SubStr(tosend,2,4))
      } else {
        CharOut(SubStr(tosend,1,5))
      }
      tosend := SubStr(tosend,6)
    }
  } else if (tosend != "")
    if (SubStr(tosend,1,1)=="P") {
      PP%PhysKey% := ""
      CharProc(SubStr(tosend,2))
    } else {
      PR%PhysKey% := tosend
      CharOutDown(tosend)
    }
}

CharStarUp(PhysKey) {
  global
  if (PR%PhysKey% != "")
    CharOutUp(PR%PhysKey%)     ; resulting from key repeat

  PR%PhysKey% := ""
  PP%PhysKey% := ""
}


CharOut(char) {
  global
  if (DNCS%char% != "") {
    seq := DNCS%char% . UPCS%char%
    if (GetKeyState("Shift","P") and (isMod2Locked or (char == "U00B4")))
      seq := "{Shift Up}" . seq . "{Shift Down}"
    send % "{blind}" . seq
  } else if (CS%char% != "") {
    seq := "{" . CS%char% . "}"
    if (GetKeyState("Shift","P") and (isMod2Locked or (char == "U20AC")))
      seq := "{Shift Up}" . seq . "{Shift Down}"
    send % "{blind}" . seq
  } else
    SendUnicodeChar("0x" . SubStr(char,2))
}

CharOutDown(char) {
  global
  if (DNCS%char% != "") {
    seq := DNCS%char%
    if (GetKeyState("Shift","P") and (isMod2Locked or (char == "U00B4")))
      seq := "{Shift Up}" . seq . "{Shift Down}"
    send % "{blind}" . seq
  } else if (CS%char% != "") {
    seq := CS%char%
    seq := "{". seq . " down}"
    if (GetKeyState("Shift","P") and (isMod2Locked or (char == "U20AC")))
      seq := "{Shift Up}" . seq . "{Shift Down}"
    send % "{blind}" . seq
  } else
    SendUnicodeCharDown("0x" . SubStr(char,2))
}

CharOutUp(char) {
  global
  if (DNCS%char% != "") {
    seq := UPCS%char%
    if GetKeyState("Shift","P") and isMod2Locked
      seq := "{Shift Up}" . seq . "{Shift Down}"
    send % "{blind}" . seq
  } else if (CS%char% != "") {
    seq := CS%char%
    seq := "{". seq . " up}"
    if (GetKeyState("Shift","P") and (isMod2Locked or (char == "U20AC")))
      seq := "{Shift Up}" . seq . "{Shift Down}"
    send % "{blind}" . seq
  } else
    SendUnicodeCharUp("0x" . SubStr(char,2))
}

CharProc(subroutine) {
  global
  if (subroutine == "_Rom") {
    IsPressHooked := 1
    PressHookRoutine := "Roman"
    RomanSum := 0
  } else if (subroutine == "_rom") {
    IsPressHooked := 1
    PressHookRoutine := "roman"
    RomanSum := 0
  } else if (subroutine == "_Uni") {
    IsPressHooked := 1
    PressHookRoutine := "Uni"
    UniSum := ""
  } else if (subroutine == "DUni") {
    IsPressHooked := 1
    PressHookRoutine := "DUni"
  }  else if (subroutine == "Rlod")
    reload
  else if (subroutine == "LnSt") {
    ;Lang-s-Tastatur:
    LangSTastatur := !(LangSTastatur)
    if (LangSTastatur)
      CharProc("LnS1")
    else
      CharProc("LnS0")
  } else if (subroutine == "LnS1") {
    ED("VKBASC01A","U0073","U1E9E","U00DF",""     ,"U03C2","U2218") ; ß
    ED("VK48SC023","U017F","U0053","U003F","U00BF","U03C3","U03A3","U0073") ; s
    KeyboardLED(2,"on")
  } else if (subroutine == "LnS0") {
    ED("VKBASC01A","U00DF","U1E9E","U017F",""     ,"U03C2","U2218") ; ß
    ED("VK48SC023","U0073","U0053","U003F","U00BF","U03C3","U03A3","U017F") ; s
    KeyboardLED(2,"off")
  } else if (subroutine == "_VMt") {
    ; Belegungsvariante VM
    isVM := !(isVM)
    if (isVM)
      CharProc("_VM1")
    else
      CharProc("_VM0")
  } else if (subroutine == "_VM1") {
    ED("VK51SC010","U0079","U0059","U2026","U22EE","U03C5","U2207") ; y
    ED("VK57SC011","U006F","U004F","U005F","U0008","U03BF","U2208") ; o
    ED("VK45SC012","U0061","U0041","U005B","S__Up","U03B1","U2200") ; a
    ED("VK52SC013","U0070","U0050","U005D","S_Del","U03C0","U03A0") ; p
    ED("VK41SC01E","U0069","U0049","U005C","SHome","U03B9","U222B") ; i
    ED("VK53SC01F","U0075","U0055","U002F","SLeft","P_Uni","U222E") ; u
    ED("VK44SC020","U0065","U0045","U007B","SDown","U03B5","U2203") ; e
    ED("VK46SC021","U0063","U0043","U007D","SRght","U03C7","U2102") ; c
    ED("VK47SC022","U006C","U004C","U002A","S_End","U03BB","U039B") ; l
    ED("VKDESC028","U0078","U0058","U0040","U002E","U03BE","U039E") ; x
    ED("VK56SC02F","U0076","U0056","U007E","U000D",""     ,"U2259") ; v
  } else if (subroutine == "_VM0") {
    ED("VK51SC010","U0078","U0058","U2026","U22EE","U03BE","U039E") ; x
    ED("VK57SC011","U0076","U0056","U005F","U0008",""     ,"U2259") ; v
    ED("VK45SC012","U006C","U004C","U005B","S__Up","U03BB","U039B") ; l
    ED("VK52SC013","U0063","U0043","U005D","S_Del","U03C7","U2102") ; c
    ED("VK41SC01E","U0075","U0055","U005C","SHome","P_Uni","U222E") ; u
    ED("VK53SC01F","U0069","U0049","U002F","SLeft","U03B9","U222B") ; i
    ED("VK44SC020","U0061","U0041","U007B","SDown","U03B1","U2200") ; a
    ED("VK46SC021","U0065","U0045","U007D","SRght","U03B5","U2203") ; e
    ED("VK47SC022","U006F","U004F","U002A","S_End","U03BF","U2208") ; o
    ED("VKDESC028","U0079","U0059","U0040","U002E","U03C5","U2207") ; y
    ED("VK56SC02F","U0070","U0050","U007E","U000D","U03C0","U03A0") ; p
  }
}

PressHookProc(HookRoutine, PhysKey, ActKey, Char) {
  global
  if ((HookRoutine == "Roman") or (HookRoutine == "roman")) {
    if ((Char == "U0030") or (Char == "SN__0"))
      RomanSum := 10*RomanSum
    else if ((Char == "U0031") or (Char == "SN__1"))
      RomanSum := 10*RomanSum + 1
    else if ((Char == "U0032") or (Char == "SN__2"))
      RomanSum := 10*RomanSum + 2
    else if ((Char == "U0033") or (Char == "SN__3"))
      RomanSum := 10*RomanSum + 3
    else if ((Char == "U0034") or (Char == "SN__4"))
      RomanSum := 10*RomanSum + 4
    else if ((Char == "U0035") or (Char == "SN__5"))
      RomanSum := 10*RomanSum + 5
    else if ((Char == "U0036") or (Char == "SN__6"))
      RomanSum := 10*RomanSum + 6
    else if ((Char == "U0037") or (Char == "SN__7"))
      RomanSum := 10*RomanSum + 7
    else if ((Char == "U0038") or (Char == "SN__8"))
      RomanSum := 10*RomanSum + 8
    else if ((Char == "U0039") or (Char == "SN__9"))
      RomanSum := 10*RomanSum + 9
    else if ((Char == "U000D") or (Char == "U0020")) {
      RomanSum := mod(RomanSum,400000)
      RomanStr := ""
      RomanPos := 0
      if (HookRoutine == "Roman")
        loop {
          RomanDigit := mod(RomanSum,10)
          RomanSum := RomanSum//10
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,1,"U2160","U2169","U216D","U216F","U2182","U2188") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,2,"U2160U2160","U2169U2169","U216DU216D","U216FU216F","U2182U2182","U2188U2188") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,3,"U2160U2160U2160","U2169U2169U2169","U216DU216DU216D","U216FU216FU216F","U2182U2182U2182","U2188U2188U2188") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,4,"U2160U2164","U2169U216C","U216DU216E","U2180U2181","U2182U2187","") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,5,"U2164","U216C","U216E","U2181","U2187","") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,6,"U2164U2160","U216CU2169","U216EU216D","U2181U2180","U2187U2182","") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,7,"U2164U2160U2160","U216CU2169U2169","U216EU216DU216D","U2181U2180U2180","U2187U2182U2182","") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,8,"U2164U2160U2160U2160","U216CU2169U2169U2169","U216EU216DU216DU216D","U2181U2180U2180U2180","U2187U2182U2182U2182","") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,9,"U2160U2169","U2169U216D","U216DU216F","U2180U2182","U2182U2188","") . RomanStr
          if (RomanSum == 0)
            break
          RomanPos := RomanPos + 1
        }
      else
        loop {
          RomanDigit := mod(RomanSum,10)
          RomanSum := RomanSum//10
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,1,"U2170","U2179","U217D","U217F","U2182","U2188") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,2,"U2170U2170","U2179U2179","U217DU217D","U217FU217F","U2182U2182","U2188U2188") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,3,"U2170U2170U2170","U2179U2179U2179","U217DU217DU217D","U217FU217FU217F","U2182U2182U2182","U2188U2188U2188") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,4,"U2170U2174","U2179U217C","U217DU217E","U2180U2181","U2182U2187","") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,5,"U2174","U217C","U217E","U2181","U2187","") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,6,"U2174U2170","U217CU2179","U217EU217D","U2181U2180","U2187U2182","") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,7,"U2174U2170U2170","U217CU2179U2179","U217EU217DU217D","U2181U2180U2180","U2187U2182U2182","") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,8,"U2174U2170U2170U2170","U217CU2179U2179U2179","U217EU217DU217DU217D","U2181U2180U2180U2180","U2187U2182U2182U2182","") . RomanStr
          RomanStr := GenRomanDigit(RomanPos,RomanDigit,9,"U2178","U2179U217D","U217DU217F","U2180U2182","U2182U2188","") . RomanStr
          if (RomanSum == 0)
            break
          RomanPos := RomanPos + 1
        }
      loop {
        if (RomanStr == "") 
          break ; erledigt
        CharOut(SubStr(RomanStr,1,5))
        RomanStr := SubStr(RomanStr,6)
      }
      IsPressHooked := 0
    } else
      IsPressHooked := 0
  } else if (HookRoutine == "Uni") {
    if ((Char == "U0030") or (Char == "SN__0"))
      UniSum := UniSum . "0"
    else if ((Char == "U0031") or (Char == "SN__1"))
      UniSum := UniSum . "1"
    else if ((Char == "U0032") or (Char == "SN__2"))
      UniSum := UniSum . "2"
    else if ((Char == "U0033") or (Char == "SN__3"))
      UniSum := UniSum . "3"
    else if ((Char == "U0034") or (Char == "SN__4"))
      UniSum := UniSum . "4"
    else if ((Char == "U0035") or (Char == "SN__5"))
      UniSum := UniSum . "5"
    else if ((Char == "U0036") or (Char == "SN__6"))
      UniSum := UniSum . "6"
    else if ((Char == "U0037") or (Char == "SN__7"))
      UniSum := UniSum . "7"
    else if ((Char == "U0038") or (Char == "SN__8"))
      UniSum := UniSum . "8"
    else if ((Char == "U0039") or (Char == "SN__9"))
      UniSum := UniSum . "9"
    else if ((Char == "U0041") or (Char == "U0061"))
      UniSum := UniSum . "A"
    else if ((Char == "U0042") or (Char == "U0062"))
      UniSum := UniSum . "B"
    else if ((Char == "U0043") or (Char == "U0063"))
      UniSum := UniSum . "C"
    else if ((Char == "U0044") or (Char == "U0064"))
      UniSum := UniSum . "D"
    else if ((Char == "U0045") or (Char == "U0065"))
      UniSum := UniSum . "E"
    else if ((Char == "U0046") or (Char == "U0066"))
      UniSum := UniSum . "F"
    else if ((Char == "U000D") or (Char == "U0020")) {
      UniSum := "U" . SubStr("0000" . UniSum, -3)
      PP%PhysKey% := UniSum
      PR%PhysKey% := UniSum
      CharOutDown(UniSum)
      IsPressHooked := 0
    } else
      IsPressHooked := 0
  } else if (HookRoutine == "DUni") {
    OutStr := EncodeUni(Char)
    loop {
      if (OutStr == "") 
        break ; erledigt
      CharOut(SubStr(OutStr,1,5))
      OutStr := SubStr(OutStr,6)
    }
    IsPressHooked := 0
  } else
    IsPressHooked := 0
}

GenRomanDigit(Pos, DigitIs, DigitTest, str0, str1, str2, str3, str4, str5) {
  res := ""
  if (DigitIs == DigitTest)
    res := str%Pos%
  return res
}

EncodeUni(str) {
SetFormat, Integer, hex
;  MsgBox % Asc(SubStr(str,1,1)) . Asc(SubStr(str,2,1))
  result := ""
  loop {
    char := SubStr(str,1,1)
    str  := SubStr(str,2)
    if (asc(char) < 0x80)
      result := result . "U00" . SubStr(asc(char),3)
    else if (asc(char) < 0xC0) {
      ; error
    } else if (asc(char) < 0xE0) {
       char2 := Substr(str,1,1)
       str   := SubStr(str,2)
       if ((asc(char2) < 0x80) or (asc(char2) > 0xBF)) {
         ; error
       } else {
         result := result . "U" . SubStr("0000" . SubStr((((asc(char) & 0x1F) << 6) + (asc(char2) & 0x3F)),3),-3)
       }
    } else if (asc(char) < 0xF8) {
       char2 := SubStr(str,1,1)
       char3 := SubStr(str,2,1)
       str   := SubStr(str,3)
;       MsgBox % "chars: " . char . ", " . char2 . ", " . char3 . ", str: " . str
       if ((asc(char2) < 0x80) or (asc(char2) > 0xBF)
           or (asc(char3) < 0x80) or (asc(char3) > 0xBF)) {
         ; error
       } else {
;         MsgBox % asc(char) . asc(char2) . asc(char3)
;         MsgBox % (((asc(char) & 0x0F) << 12) + ((asc(char2) & 0x3F) << 6) + (asc(char3) & 0x3F))
         result := result . "U" . SubStr("0000" . SubStr((((asc(char) & 0x0F) << 12) + ((asc(char2) & 0x3F) << 6) + (asc(char3) & 0x3F)),3),-3)
       }
    }
    if (str == "")
      break
  }
  SetFormat, Integer, d
  StringUpper,result,result
  return result
}

