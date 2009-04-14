; äöü

; Römische Zahlen
CMS__Comp := 1
CMS__CompU000072 := 1
CMS__CompU000052 := 1
CDS__CompU000072U000072 := "P_Rom1"
CDS__CompU000072U000031 := "P_Rom1"
CDS__CompU000052U000031 := "P_Rom1"
CDS__CompU000072U000052 := "P_Rom2"
CDS__CompU000072U000032 := "P_Rom2"
CDS__CompU000052U000032 := "P_Rom2"
CDS__CompU000052U000072 := "P_Rom3"
CDS__CompU000072U000033 := "P_Rom3"
CDS__CompU000052U000033 := "P_Rom3"
CDS__CompU000052U000052 := "P_Rom4"
CDS__CompU000072U000034 := "P_Rom4"
CDS__CompU000052U000034 := "P_Rom4"

CharProc_Rom1() {
  global
  ; starte groß geschriebene römische Zahlen, verwende U2160++
  PressHookProc := "Roman"
  RomanMode := 1
  RomanSum := 0
}

CharProc_Rom2() {
  global
  ; starte klein geschriebene römische Zahlen, verwende U2160++
  PressHookProc := "Roman"
  RomanMode := 2
  RomanSum := 0
}

CharProc_Rom3() {
  global
  ; starte groß geschriebene römische Zahlen, verwende Buchstaben
  PressHookProc := "Roman"
  RomanMode := 3
  RomanSum := 0
}

CharProc_Rom4() {
  global
  ; starte klein geschriebene römische Zahlen, verwende Buchstaben
  PressHookProc := "Roman"
  RomanMode := 4
  RomanSum := 0
}

GenRomanDigit(Pos, DigitIs, DigitTest, str0, str1, str2, str3, str4, str5) {
  res := ""
  if (DigitIs == DigitTest)
    res := str%Pos%
  return res
}

PressHookRoman(PhysKey, ActKey, Char) {
  global
  if (SubStr(Char,1,1) == "P")
    CharStarDown(PhysKey, ActKey, Char)
  else if ((Char == "U000030") or (Char == "S__N__0"))
    RomanSum := 10*RomanSum
  else if ((Char == "U000031") or (Char == "S__N__1"))
    RomanSum := 10*RomanSum + 1
  else if ((Char == "U000032") or (Char == "S__N__2"))
    RomanSum := 10*RomanSum + 2
  else if ((Char == "U000033") or (Char == "S__N__3"))
    RomanSum := 10*RomanSum + 3
  else if ((Char == "U000034") or (Char == "S__N__4"))
    RomanSum := 10*RomanSum + 4
  else if ((Char == "U000035") or (Char == "S__N__5"))
    RomanSum := 10*RomanSum + 5
  else if ((Char == "U000036") or (Char == "S__N__6"))
    RomanSum := 10*RomanSum + 6
  else if ((Char == "U000037") or (Char == "S__N__7"))
    RomanSum := 10*RomanSum + 7
  else if ((Char == "U000038") or (Char == "S__N__8"))
    RomanSum := 10*RomanSum + 8
  else if ((Char == "U000039") or (Char == "S__N__9"))
    RomanSum := 10*RomanSum + 9
  else if ((Char == "U00000D") or (Char == "U000020")) {
    RomanSum := mod(RomanSum,400000)
    RomanStr := ""
    RomanPos := 0
    if (RomanMode == 1)
      loop {
        RomanDigit := mod(RomanSum,10)
        RomanSum := RomanSum//10
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,1,"U002170","U002179","U00217D","U00217F","U002182","U002188") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,2,"U002170U002170","U002179U002179","U00217DU00217D","U00217FU00217F","U002182U002182","U002188U002188") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,3,"U002170U002170U002170","U002179U002179U002179","U00217DU00217DU00217D","U00217FU00217FU00217F","U002182U002182U002182","U002188U002188U002188") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,4,"U002170U002174","U002179U00217C","U00217DU00217E","U002180U002181","U002182U002187","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,5,"U002174","U00217C","U00217E","U002181","U002187","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,6,"U002174U002170","U00217CU002179","U00217EU00217D","U002181U002180","U002187U002182","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,7,"U002174U002170U002170","U00217CU002179U002179","U00217EU00217DU00217D","U002181U002180U002180","U002187U002182U002182","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,8,"U002174U002170U002170U002170","U00217CU002179U002179U002179","U00217EU00217DU00217DU00217D","U002181U002180U002180U002180","U002187U002182U002182U002182","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,9,"U002178","U002179U00217D","U00217DU00217F","U002180U002182","U002182U002188","") . RomanStr
        if (RomanSum == 0)
          break
        RomanPos := RomanPos + 1
      }
    else if (RomanMode == 2)
      loop {
        RomanDigit := mod(RomanSum,10)
        RomanSum := RomanSum//10
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,1,"U002160","U002169","U00216D","U00216F","U002182","U002188") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,2,"U002160U002160","U002169U002169","U00216DU00216D","U00216FU00216F","U002182U002182","U002188U002188") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,3,"U002160U002160U002160","U002169U002169U002169","U00216DU00216DU00216D","U00216FU00216FU00216F","U002182U002182U002182","U002188U002188U002188") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,4,"U002160U002164","U002169U00216C","U00216DU00216E","U002180U002181","U002182U002187","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,5,"U002164","U00216C","U00216E","U002181","U002187","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,6,"U002164U002160","U00216CU002169","U00216EU00216D","U002181U002180","U002187U002182","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,7,"U002164U002160U002160","U00216CU002169U002169","U00216EU00216DU00216D","U002181U002180U002180","U002187U002182U002182","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,8,"U002164U002160U002160U002160","U00216CU002169U002169U002169","U00216EU00216DU00216DU00216D","U002181U002180U002180U002180","U002187U002182U002182U002182","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,9,"U002160U002169","U002169U00216D","U00216DU00216F","U002180U002182","U002182U002188","") . RomanStr
        if (RomanSum == 0)
          break
        RomanPos := RomanPos + 1
      }
    else if (RomanMode == 3)
      loop {
        RomanDigit := mod(RomanSum,10)
        RomanSum := RomanSum//10
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,1,"U000069","U000078","U000063","U00006D","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,2,"U000069U000069","U000078U000078","U000063U000063","U00006DU00006D","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,3,"U000069U000069U000069","U000078U000078U000078","U000063U000063U000063","U00006DU00006DU00006D","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,4,"U000069U000076","U000078U00006C","U000063U000064","","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,5,"U000076","U00006C","U000064","","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,6,"U000076U000069","U00006CU000078","U000064U000063","","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,7,"U000076U000069U000069","U00006CU000078U000078","U000064U000063U000063","","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,8,"U000076U000069U000069U000069","U00006CU000078U000078U000078","U000064U000063U000063U000063","","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,9,"U000069U000078","U000078U000063","U000063U00006D","","","") . RomanStr
        if (RomanSum == 0)
          break
        RomanPos := RomanPos + 1
      }
    else if (RomanMode == 4)
      loop {
        RomanDigit := mod(RomanSum,10)
        RomanSum := RomanSum//10
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,1,"U000049","U000058","U000043","U00004D","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,2,"U000049U000049","U000058U000058","U000043U000043","U00004DU00004D","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,3,"U000049U000049U000049","U000058U000058U000058","U000043U000043U000043","U00004DU00004DU00004D","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,4,"U000049U000056","U000058U00004C","U000043U000044","","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,5,"U000056","U00004C","U000044","","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,6,"U000056U000049","U00004CU000058","U000044U000043","","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,7,"U000056U000049U000049","U00004CU000058U000058","U000044U000043U000043","","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,8,"U000056U000049U000049U000049","U00004CU000058U000058U000058","U000044U000043U000043U000043","","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,9,"U000049U000058","U000058U000043","U000043U00004D","","","") . RomanStr
        if (RomanSum == 0)
          break
        RomanPos := RomanPos + 1
      }
    loop {
      if (RomanStr == "") 
        break ; erledigt
      CharOut(SubStr(RomanStr,1,7))
      RomanStr := SubStr(RomanStr,8)
    }
    PressHookProc := ""
  } else
    PressHookProc := ""
}

CMS__CompU000075 := 1
CMS__CompU000055 := 1
CDS__CompU000075U000075 := "P___Uni"
CDS__CompU000075U000055 := "P___Uni"
CDS__CompU000055U000075 := "P___Uni"
CDS__CompU000055U000055 := "P___Uni"
CMS__CompU000064 := 1
CMS__CompU000044 := 1
CDS__CompU000064U000064 := "P__DUni"
CDS__CompU000064U000044 := "P__DUni"
CDS__CompU000044U000064 := "P__DUni"
CDS__CompU000044U000044 := "P__DUni"

CP5VK41SC01E := "P___Uni"

CharProc___Uni() {
  global
  ; starte Unicode-Hex-in-Zeichen-Umwandlung
  PressHookProc := "Uni"
  UniSum := ""
}

CharProc__DUni() {
  global
  ; starte Unicode-Zeichen-in-Hex-Umwandlung
  CharOutFilterProc := "DUni"
}

PressHookUni(PhysKey, ActKey, Char) {
  global
  if (SubStr(Char,1,1) == "P")
    CharStarDown(PhysKey, ActKey, Char)
  else if ((Char == "U000030") or (Char == "S__N__0"))
    UniSum := UniSum . "0"
  else if ((Char == "U000031") or (Char == "S__N__1"))
    UniSum := UniSum . "1"
  else if ((Char == "U000032") or (Char == "S__N__2"))
    UniSum := UniSum . "2"
  else if ((Char == "U000033") or (Char == "S__N__3"))
    UniSum := UniSum . "3"
  else if ((Char == "U000034") or (Char == "S__N__4"))
    UniSum := UniSum . "4"
  else if ((Char == "U000035") or (Char == "S__N__5"))
    UniSum := UniSum . "5"
  else if ((Char == "U000036") or (Char == "S__N__6"))
    UniSum := UniSum . "6"
  else if ((Char == "U000037") or (Char == "S__N__7"))
    UniSum := UniSum . "7"
  else if ((Char == "U000038") or (Char == "S__N__8"))
    UniSum := UniSum . "8"
  else if ((Char == "U000039") or (Char == "S__N__9"))
    UniSum := UniSum . "9"
  else if ((Char == "U000041") or (Char == "U000061"))
    UniSum := UniSum . "A"
  else if ((Char == "U000042") or (Char == "U000062"))
    UniSum := UniSum . "B"
  else if ((Char == "U000043") or (Char == "U000063"))
    UniSum := UniSum . "C"
  else if ((Char == "U000044") or (Char == "U000064"))
    UniSum := UniSum . "D"
  else if ((Char == "U000045") or (Char == "U000065"))
    UniSum := UniSum . "E"
  else if ((Char == "U000046") or (Char == "U000066"))
    UniSum := UniSum . "F"
  else if ((Char == "U00000D") or (Char == "U000020")) {
    UniSum := "U" . SubStr("000000" . UniSum, -5)
    PP%PhysKey% := UniSum
    PR%PhysKey% := UniSum
    CharOutDown(UniSum)
    PressHookProc := ""
  } else
    PressHookProc := ""
}

CharOutFilterDUni(char,down,up) {
  global
  if (!down or char == "S__L_M2" or char == "S__R_M2")
    return char
  CharOutFilterProc := ""
  dchar := char
  if (substr(dchar,1,3) == "U00")
    dchar := "U" . substr(dchar,4)
  TrayTip,Unicode-Zeichen,%dchar%,10,1
  return char
}

EncodeUni(str) {
SetFormat, Integer, hex
;  MsgBox % Asc(SubStr(str,1,1)) . Asc(SubStr(str,2,1))
  result := ""
  loop {
    char := asc(SubStr(str,1,1))
    str  := SubStr(str,2)
    if (char < 0x80)
      result .= "U" . SubStr("000000" . SubStr(char,3),-5)
    else if (char < 0xC0) {
      ; error
    } else if (char < 0xE0) {
       char2 := asc(Substr(str,1,1))
       str   := SubStr(str,2)
       if ((char2 < 0x80) or (char2 > 0xBF)) {
         ; error
       } else {
         result .= "U" . SubStr("000000" . SubStr((((char & 0x1F) << 6) + (char2 & 0x3F)),3),-5)
       }
    } else if (char < 0xF8) {
       char2 := asc(SubStr(str,1,1))
       char3 := asc(SubStr(str,2,1))
       str   := SubStr(str,3)
       if ((char2 < 0x80) or (char2 > 0xBF)
           or (char3 < 0x80) or (char3 > 0xBF)) {
         ; error
       } else {
         result .= "U" . SubStr("000000" . SubStr((((char & 0x0F) << 12) + ((char2 & 0x3F) << 6) + (char3 & 0x3F)),3),-5)
       }
    } else if (char < 0xFC) {
       char2 := asc(SubStr(str,1,1))
       char3 := asc(SubStr(str,2,1))
       char3 := asc(SubStr(str,3,1))
       str   := SubStr(str,4)
       if (   (char2 < 0x80) or (char2 > 0xBF)
           or (char3 < 0x80) or (char3 > 0xBF)
           or (char4 < 0x80) or (char4 > 0xBF)) {
         ; error
       } else {
         result .= "U" . SubStr("000000" . SubStr((((char & 0x07) << 18) + ((char2 & 0x3F) << 12) + ((char3 & 0x3F) << 6) + (char4 & 0x3F)),3),-5)
       }
    }
    if (str == "")
      break
  }
  SetFormat, Integer, d
  StringUpper,result,result
  return result
}


; Simple calculator

CDS__CompU000075U000063 := "P__Cal1"
CDS__CompU000055U000043 := "P__Cal2"

CharProc__Cal1() {
  global
  ; starte Calculator ohne Echo
  PressHookProc := "Calc"
  CalcEcho := 0
  CalcVar1 := ""
  CalcVar2 := ""
  CalcOp := ""
  CalcPhase := 0
  CalcHexOut := 0
}

CharProc__Cal2() {
  global
  ; starte Calculator mit Echo
  PressHookProc := "Calc"
  CalcEcho := 1
  CalcVar1 := ""
  CalcVar2 := ""
  CalcOp := ""
  CalcPhase := 0
  CalcHexOut := 0
}

PressHookCalc(PhysKey, ActKey, Char) {
  global
  if (SubStr(Char,1,1) == "P")
    CharStarDown(PhysKey, ActKey, Char)
  else if (CalcPhase == 0) {
    if      ((Char == "U000030") or (Char == "S__N__0"))
      CalcVar1 := CalcVar1 . "0"
    else if ((Char == "U000031") or (Char == "S__N__1"))
      CalcVar1 := CalcVar1 . "1"
    else if ((Char == "U000032") or (Char == "S__N__2"))
      CalcVar1 := CalcVar1 . "2"
    else if ((Char == "U000033") or (Char == "S__N__3"))
      CalcVar1 := CalcVar1 . "3"
    else if ((Char == "U000034") or (Char == "S__N__4"))
      CalcVar1 := CalcVar1 . "4"
    else if ((Char == "U000035") or (Char == "S__N__5"))
      CalcVar1 := CalcVar1 . "5"
    else if ((Char == "U000036") or (Char == "S__N__6"))
      CalcVar1 := CalcVar1 . "6"
    else if ((Char == "U000037") or (Char == "S__N__7"))
      CalcVar1 := CalcVar1 . "7"
    else if ((Char == "U000038") or (Char == "S__N__8"))
      CalcVar1 := CalcVar1 . "8"
    else if ((Char == "U000039") or (Char == "S__N__9"))
      CalcVar1 := CalcVar1 . "9"
    else if ((Char == "U000039") or (Char == "S__N__9"))
      CalcVar1 := CalcVar1 . "9"
    else if ((Char == "U000041") or (Char == "U000061"))
      CalcVar1 := CalcVar1 . "A"
    else if ((Char == "U000042") or (Char == "U000062"))
      CalcVar1 := CalcVar1 . "B"
    else if ((Char == "U000043") or (Char == "U000063"))
      CalcVar1 := CalcVar1 . "C"
    else if ((Char == "U000044") or (Char == "U000064"))
      CalcVar1 := CalcVar1 . "D"
    else if ((Char == "U000045") or (Char == "U000065"))
      CalcVar1 := CalcVar1 . "E"
    else if ((Char == "U000046") or (Char == "U000066"))
      CalcVar1 := CalcVar1 . "F"
    else if ((Char == "U00002E") or (Char == "U00002C") or (Char=="S__NDot"))
      CalcVar1 := CalcVar1 . "."
    else if ((Char == "U000078") or (Char == "U000058")) {
      CalcVar1 := CalcVar1 . "x"
      CalcHexOut := 1
    } else if ((Char == "U00002B") or (Char == "S__NAdd")) {
      CalcOp := "+"
      CalcPhase := 1
    } else if ((Char == "U00002D") or (Char == "S__NSub")) {
      CalcOp := "-"
      CalcPhase := 1
    } else if ((Char == "U00002A") or (Char == "S__NMul")) {
      CalcOp := "*"
      CalcPhase := 1
    } else if ((Char == "U00002F") or (Char == "S__NDiv")) {
      CalcOp := "/"
      CalcPhase := 1
    } else if (Char == "U000026") {
      CalcOp := "&"
      CalcPhase := 1
    } else if (Char == "U00007C") {
      CalcOp := "|"
      CalcPhase := 1
    } else
      PressHookProc := ""
    if (CalcEcho) {
      PP%PhysKey% := Char
      PR%PhysKey% := Char
      CharOutDown(Char)
    }
  } else if (CalcPhase == 1) {
    if      ((Char == "U000030") or (Char == "S__N__0"))
      CalcVar2 := CalcVar2 . "0"
    else if ((Char == "U000031") or (Char == "S__N__1"))
      CalcVar2 := CalcVar2 . "1"
    else if ((Char == "U000032") or (Char == "S__N__2"))
      CalcVar2 := CalcVar2 . "2"
    else if ((Char == "U000033") or (Char == "S__N__3"))
      CalcVar2 := CalcVar2 . "3"
    else if ((Char == "U000034") or (Char == "S__N__4"))
      CalcVar2 := CalcVar2 . "4"
    else if ((Char == "U000035") or (Char == "S__N__5"))
      CalcVar2 := CalcVar2 . "5"
    else if ((Char == "U000036") or (Char == "S__N__6"))
      CalcVar2 := CalcVar2 . "6"
    else if ((Char == "U000037") or (Char == "S__N__7"))
      CalcVar2 := CalcVar2 . "7"
    else if ((Char == "U000038") or (Char == "S__N__8"))
      CalcVar2 := CalcVar2 . "8"
    else if ((Char == "U000039") or (Char == "S__N__9"))
      CalcVar2 := CalcVar2 . "9"
    else if ((Char == "U000041") or (Char == "U000061"))
      CalcVar2 := CalcVar2 . "A"
    else if ((Char == "U000042") or (Char == "U000062"))
      CalcVar2 := CalcVar2 . "B"
    else if ((Char == "U000043") or (Char == "U000063"))
      CalcVar2 := CalcVar2 . "C"
    else if ((Char == "U000044") or (Char == "U000064"))
      CalcVar2 := CalcVar2 . "D"
    else if ((Char == "U000045") or (Char == "U000065"))
      CalcVar2 := CalcVar2 . "E"
    else if ((Char == "U000046") or (Char == "U000066"))
      CalcVar2 := CalcVar2 . "F"
    else if ((Char == "U00002E") or (Char == "U00002C") or (Char=="S__NDot"))
      CalcVar2 := CalcVar2 . "."
    else if ((Char == "U000078") or (Char == "U000058")) {
      CalcVar2 := CalcVar2 . "x"
      CalcHexOut := 1
    } else if ((Char == "U00000D") or (Char == "S__NEnt") or (Char=="U000020") or (Char=="U00003D")) {
      if      (CalcOp == "+")
        CalcResult := CalcVar1 + CalcVar2
      else if (CalcOp == "-")
        CalcResult := CalcVar1 - CalcVar2
      else if (CalcOp == "*")
        CalcResult := CalcVar1 * CalcVar2
      else if (CalcOp == "/")
        CalcResult := CalcVar1 / CalcVar2
      else if (CalcOp == "&")
        CalcResult := CalcVar1 & CalcVar2
      else if (CalcOp == "|")
        CalcResult := CalcVar1 | CalcVar2
      else
        CalcResult := "Invalid"
      if (CalcHexOut and (CalcResult != "")) {
        SetFormat,Integer,h
        CalcResult := CalcResult + 0
        SetFormat,Integer,d
      }
      tosend := EncodeUni(CalcResult)
      if (CalcEcho) {
        Char := "U00003D"
        PP%PhysKey% := Char
        PR%PhysKey% := Char
        CharOutDown(Char)
      }
      loop {
        if (SubStr(tosend,1,1)=="P") {
          SubProc := SubStr(tosend,2,6)
          CharProc%SubProc%()
        } else {
          CharOut(SubStr(tosend,1,7))
        }
        tosend := SubStr(tosend,8)
        if (tosend == "") 
          break                ; erledigt
      }
      PressHookProc := ""
      return ; vermeide, bei CharEcho das aktuelle Zeichen nach dem Ergebnis noch einmal auszugeben
    } else
      PressHookProc := ""
    if (CalcEcho) {
      PP%PhysKey% := Char
      PR%PhysKey% := Char
      CharOutDown(Char)
    }
  } else {
    PressHookProc := ""
    if (CalcEcho) {
      PP%PhysKey% := Char
      PR%PhysKey% := Char
      CharOutDown(Char)
    }
  }
}

CDS__CompU000055U000057 := "P___WMN"
CDS__CompU000075U000077 := "P___WMN"

CharProc___WMN() {
  global
  ok := DllCall("OpenClipboard")
  if (!ok) {
    TrayTip,Wie mit NEO,Fehler in OpenClipboard,10,1
    return
  }
  uclph:=DllCall("GetClipboardData","uint",CF_UNICODETEXT:=13)
  if (uclph == 0) {
    DllCall("CloseClipboard")
    TrayTip,Wie mit NEO,Fehler in GetClipboardData,10,1
    return
  }
  uclp := DllCall("GlobalLock","uint",uclph)
  if (uclp == 0) {
    DllCall("CloseClipboard")
    TrayTip,Wie mit NEO,Fehler in GlobalLock,10,1
    return
  }
  a := *(uclp+0)
  b := *(uclp+1)

  a += 256*b

  if ((a >= 0xD800) and (a <= 0xDBFF)) {
    c := *(uclp+2)
    d := *(uclp+3)

    c += 256*d
    if ((c >= 0xDC00) and (c <= 0xDFFF)) {
      a := (a & 0x3FF) * 1024 + (c & 0x3FF) + 65536
    }
  }

  DllCall("GlobalUnlock","uint",uclph)
  DllCall("CloseClipboard")

SetFormat,Integer,h
  a += 0
SetFormat,Integer,d
  if (a < 0x10000) {
    ap := "U" . substr("000000" . substr(a,3),-3)
    a  := "U" . substr("000000" . substr(a,3),-5)
  } else {
    ap := "U" . substr("000000" . substr(a,3),-5)
    a  := ap
  }

  Gui,2:Destroy
  Gui,2:Font,,DejaVu Sans
  Gui,2:Margin,10,0
  Gui,2:Add,Text,,% "`r`nDas Zeichen " . ap . " kann wie folgt eingegeben werden:"
  loop,parse,CRC%a%,%A_Space%
  {
    this_wmn := ""
    this_wmnk := ""
    nthis := 0
    this_wtt := A_LoopField
    if (this_wtt == "")
      continue ; probably at first or last entry
    loop {
      if (this_wtt == "")
        break
      this_char7 := substr(this_wtt,1,7)
      this_char  := this_char7
      this_wtt := substr(this_wtt,8)
      if (CB%this_char% != "")
        this_char := CB%this_char%
      else if (CS%this_char% != "")
        this_char := CS%this_char%
      ; this_char will contain Uxxxx if no shortcut is present. Fix this here.
      this_wmn .= " <" . this_char . ">"
      if (CRK%this_char7% == "") {
        nthis := 1
        this_wmnk .= " <" . this_char7 . ">"
      } else
        this_wmnk .= " " . KeyLong(CRK%this_char7%)
    }
    if (this_wmn != "")
      this_wmn := SubStr(this_wmn,2)
    if (this_wmnk != "")
      this_wmnk := SubStr(this_wmnk,2)
    Gui,2:Font,,Dejavu Sans Bold
    if (nthis == 1)
      Gui,2:Add,Text,,% "Wegen fehlender Tastenbelegung nicht als Compose:"
    else
      Gui,2:Add,Text,,% "Als Compose:"
    Gui,2:Font,,Dejavu Sans
    Gui,2:Add,Text,,% this_wmn . "`r`noder`r`n" . this_wmnk
  }

  wmnk := KeyLong(CRK%a%)
  Gui,2:Font,,Dejavu Sans Bold
  if (wmnk != "") {
    Gui,2:Add,Text,,% "Als Tastendruck:"
    Gui,2:Font,,Dejavu Sans
    Gui,2:Add,Text,,% wmnk
  } else
    Gui,2:Add,Text,,% "Als Tastendruck nicht verfügbar"

  Gui,2:Add, Button, Default xp+100 yp+40, OK
  Gui,2:Show
  return

  2ButtonOK:
  2GuiEscape:
    Gui,2:Destroy
    return
}

KeyLong(key) {
  global
  num := 0
  twmnk := ""
  loop,parse,key,%A_Space%
  {
    tis_wmn := ""
    tis_wtt := A_LoopField
    if (tis_wtt == "")
      continue ; probably at first or last entry
    tis_layer := substr(tis_wtt,3,1)
    base_key_pos := "CP1" . substr(tis_wtt,4)

    base_key := %base_key_pos%
    if (CB%base_key_pos% != "")
      base_key := CB%base_key_pos%
    else if (CB%base_key% != "")
      base_key := CB%base_key%
    else if (CS%base_key% != "")
      base_key := CS%base_key%

    twmnk .= "/<" . CBS____M%tis_layer% . base_key . ">"
    num := num + 1
  }
  if (num == 0)
    return ""
  else if (num == 1)
    return SubStr(twmnk,2)
  else
    return "(" . SubStr(twmnk,2) . ")"
}
