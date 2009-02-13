; äöü

; Römische Zahlen

CMSCompU0072 := 1
CMSCompU0052 := 1
CDSCompU0072U0072 := "PRom1"
CDSCompU0072U0031 := "PRom1"
CDSCompU0052U0031 := "PRom1"
CDSCompU0072U0052 := "PRom2"
CDSCompU0072U0032 := "PRom2"
CDSCompU0052U0032 := "PRom2"
CDSCompU0052U0072 := "PRom3"
CDSCompU0072U0033 := "PRom3"
CDSCompU0052U0033 := "PRom3"
CDSCompU0052U0052 := "PRom4"
CDSCompU0072U0034 := "PRom4"
CDSCompU0052U0034 := "PRom4"

CharProcRom1() {
  global
  ; starte groß geschriebene römische Zahlen, verwende U2160++
  PressHookProc := "Roman"
  RomanMode := 1
  RomanSum := 0
}

CharProcRom2() {
  global
  ; starte klein geschriebene römische Zahlen, verwende U2160++
  PressHookProc := "Roman"
  RomanMode := 2
  RomanSum := 0
}

CharProcRom3() {
  global
  ; starte groß geschriebene römische Zahlen, verwende Buchstaben
  PressHookProc := "Roman"
  RomanMode := 3
  RomanSum := 0
}

CharProcRom4() {
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
  else if ((Char == "U0030") or (Char == "SN__0"))
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
    if (RomanMode == 1)
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
    else if (RomanMode == 2)
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
    else if (RomanMode == 3)
      loop {
        RomanDigit := mod(RomanSum,10)
        RomanSum := RomanSum//10
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,1,"U0069","U0078","U0063","U006D","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,2,"U0069U0069","U0078U0078","U0063U0063","U006DU006D","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,3,"U0069U0069U0069","U0078U0078U0078","U0063U0063U0063","U006DU006DU006D","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,4,"U0069U0076","U0078U006C","U0063U0064","","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,5,"U0076","U006C","U0064","","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,6,"U0076U0069","U006CU0078","U0064U0063","","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,7,"U0076U0069U0069","U006CU0078U0078","U0064U0063U0063","","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,8,"U0076U0069U0069U0069","U006CU0078U0078U0078","U0064U0063U0063U0063","","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,9,"U0069U0078","U0078U0063","U0063U006D","","","") . RomanStr
        if (RomanSum == 0)
          break
        RomanPos := RomanPos + 1
      }
    else if (RomanMode == 4)
      loop {
        RomanDigit := mod(RomanSum,10)
        RomanSum := RomanSum//10
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,1,"U0049","U0058","U0043","U004D","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,2,"U0049U0049","U0058U0058","U0043U0043","U004DU004D","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,3,"U0049U0049U0049","U0058U0058U0058","U0043U0043U0043","U004DU004DU004D","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,4,"U0049U0056","U0058U004C","U0043U0044","","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,5,"U0056","U004C","U0044","","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,6,"U0056U0049","U004CU0058","U0044U0043","","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,7,"U0056U0049U0049","U004CU0058U0058","U0044U0043U0043","","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,8,"U0056U0049U0049U0049","U004CU0058U0058U0058","U0044U0043U0043U0043","","","") . RomanStr
        RomanStr := GenRomanDigit(RomanPos,RomanDigit,9,"U0049U0058","U0058U0043","U0043U004D","","","") . RomanStr
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
    PressHookProc := ""
  } else
    PressHookProc := ""
}

CMSCompU0075 := 1
CMSCompU0055 := 1
CDSCompU0075U0075 := "P_Uni"
CDSCompU0075U0055 := "P_Uni"
CDSCompU0055U0075 := "P_Uni"
CDSCompU0055U0055 := "P_Uni"
CMSCompU0064 := 1
CMSCompU0044 := 1
CDSCompU0064U0064 := "PDUni"
CDSCompU0064U0044 := "PDUni"
CDSCompU0044U0064 := "PDUni"
CDSCompU0044U0044 := "PDUni"

CP5VK41SC01E := "P_Uni"

CharProc_Uni() {
  global
  ; starte Unicode-Hex-in-Zeichen-Umwandlung
  PressHookProc := "Uni"
  UniSum := ""
}

CharProcDUni() {
  global
  ; starte Unicode-Zeichen-in-Hex-Umwandlung
  CharOutFilterProc := "DUni"
}

PressHookUni(PhysKey, ActKey, Char) {
  global
  if (SubStr(Char,1,1) == "P")
    CharStarDown(PhysKey, ActKey, Char)
  else if ((Char == "U0030") or (Char == "SN__0"))
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
    PressHookProc := ""
  } else
    PressHookProc := ""
}

CharOutFilterDUni(char,down,up) {
  global
  if (!down or char == "SL_M2" or char == "SR_M2")
    return char
  CharOutFilterProc := ""
  TrayTip,Unicode-Zeichen,%char%,10,1
  return char
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


; Simple calculator

CDSCompU0075U0063 := "PCal1"
CDSCompU0055U0043 := "PCal2"

CharProcCal1() {
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

CharProcCal2() {
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
    if      ((Char == "U0030") or (Char == "SN__0"))
      CalcVar1 := CalcVar1 . "0"
    else if ((Char == "U0031") or (Char == "SN__1"))
      CalcVar1 := CalcVar1 . "1"
    else if ((Char == "U0032") or (Char == "SN__2"))
      CalcVar1 := CalcVar1 . "2"
    else if ((Char == "U0033") or (Char == "SN__3"))
      CalcVar1 := CalcVar1 . "3"
    else if ((Char == "U0034") or (Char == "SN__4"))
      CalcVar1 := CalcVar1 . "4"
    else if ((Char == "U0035") or (Char == "SN__5"))
      CalcVar1 := CalcVar1 . "5"
    else if ((Char == "U0036") or (Char == "SN__6"))
      CalcVar1 := CalcVar1 . "6"
    else if ((Char == "U0037") or (Char == "SN__7"))
      CalcVar1 := CalcVar1 . "7"
    else if ((Char == "U0038") or (Char == "SN__8"))
      CalcVar1 := CalcVar1 . "8"
    else if ((Char == "U0039") or (Char == "SN__9"))
      CalcVar1 := CalcVar1 . "9"
    else if ((Char == "U0039") or (Char == "SN__9"))
      CalcVar1 := CalcVar1 . "9"
    else if ((Char == "U0041") or (Char == "U0061"))
      CalcVar1 := CalcVar1 . "A"
    else if ((Char == "U0042") or (Char == "U0062"))
      CalcVar1 := CalcVar1 . "B"
    else if ((Char == "U0043") or (Char == "U0063"))
      CalcVar1 := CalcVar1 . "C"
    else if ((Char == "U0044") or (Char == "U0064"))
      CalcVar1 := CalcVar1 . "D"
    else if ((Char == "U0045") or (Char == "U0065"))
      CalcVar1 := CalcVar1 . "E"
    else if ((Char == "U0046") or (Char == "U0066"))
      CalcVar1 := CalcVar1 . "F"
    else if ((Char == "U002E") or (Char == "U002C") or (Char=="SNDot"))
      CalcVar1 := CalcVar1 . "."
    else if ((Char == "U0078") or (Char == "U0058")) {
      CalcVar1 := CalcVar1 . "x"
      CalcHexOut := 1
    } else if ((Char == "U002B") or (Char == "SNAdd")) {
      CalcOp := "+"
      CalcPhase := 1
    } else if ((Char == "U002D") or (Char == "SNSub")) {
      CalcOp := "-"
      CalcPhase := 1
    } else if ((Char == "U002A") or (Char == "SNMul")) {
      CalcOp := "*"
      CalcPhase := 1
    } else if ((Char == "U002F") or (Char == "SNDiv")) {
      CalcOp := "/"
      CalcPhase := 1
    } else if (Char == "U0026") {
      CalcOp := "&"
      CalcPhase := 1
    } else if (Char == "U007C") {
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
    if      ((Char == "U0030") or (Char == "SN__0"))
      CalcVar2 := CalcVar2 . "0"
    else if ((Char == "U0031") or (Char == "SN__1"))
      CalcVar2 := CalcVar2 . "1"
    else if ((Char == "U0032") or (Char == "SN__2"))
      CalcVar2 := CalcVar2 . "2"
    else if ((Char == "U0033") or (Char == "SN__3"))
      CalcVar2 := CalcVar2 . "3"
    else if ((Char == "U0034") or (Char == "SN__4"))
      CalcVar2 := CalcVar2 . "4"
    else if ((Char == "U0035") or (Char == "SN__5"))
      CalcVar2 := CalcVar2 . "5"
    else if ((Char == "U0036") or (Char == "SN__6"))
      CalcVar2 := CalcVar2 . "6"
    else if ((Char == "U0037") or (Char == "SN__7"))
      CalcVar2 := CalcVar2 . "7"
    else if ((Char == "U0038") or (Char == "SN__8"))
      CalcVar2 := CalcVar2 . "8"
    else if ((Char == "U0039") or (Char == "SN__9"))
      CalcVar2 := CalcVar2 . "9"
    else if ((Char == "U0041") or (Char == "U0061"))
      CalcVar2 := CalcVar2 . "A"
    else if ((Char == "U0042") or (Char == "U0062"))
      CalcVar2 := CalcVar2 . "B"
    else if ((Char == "U0043") or (Char == "U0063"))
      CalcVar2 := CalcVar2 . "C"
    else if ((Char == "U0044") or (Char == "U0064"))
      CalcVar2 := CalcVar2 . "D"
    else if ((Char == "U0045") or (Char == "U0065"))
      CalcVar2 := CalcVar2 . "E"
    else if ((Char == "U0046") or (Char == "U0066"))
      CalcVar2 := CalcVar2 . "F"
    else if ((Char == "U002E") or (Char == "U002C") or (Char=="SNDot"))
      CalcVar2 := CalcVar2 . "."
    else if ((Char == "U0078") or (Char == "U0058")) {
      CalcVar2 := CalcVar2 . "x"
      CalcHexOut := 1
    } else if ((Char == "U000D") or (Char == "SNEnt") or (Char=="U0020") or (Char=="U003D")) {
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
        Char := "U003D"
        PP%PhysKey% := Char
        PR%PhysKey% := Char
        CharOutDown(Char)
      }
      loop {
        if (SubStr(tosend,1,1)=="P") {
          SubProc := SubStr(tosend,2,4)
          CharProc%SubProc%()
        } else {
          CharOut(SubStr(tosend,1,5))
        }
        tosend := SubStr(tosend,6)
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

CDSCompU0055U0057 := "P_WMN"
CDSCompU0075U0077 := "P_WMN"

CharProc_WMN() {
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

  DllCall("GlobalUnlock","uint",uclph)
  DllCall("CloseClipboard")

SetFormat,Integer,h
    a += 256*b
SetFormat,Integer,d
  a := "U" . substr("0000" . substr(a,3),-3)

  wmn := "Das Zeichen " . a . " kann wie folgt eingegeben werden:`r`n"
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
      this_char5 := substr(this_wtt,1,5)
      this_char  := this_char5
      this_wtt := substr(this_wtt,6)
      if (CB%this_char% != "")
        this_char := CB%this_char%
      else if (CS%this_char% != "")
        this_char := CS%this_char%
      ; this_char will contain Uxxxx if no shortcut is present. Fix this here.
      this_wmn .= " <" . this_char . ">"
      if (CRK%this_char5% == "") {
        nthis := 1
        this_wmnk .= " <" . this_char5 . ">"
      } else
        this_wmnk .= " " . KeyLong(CRK%this_char5%)
    }
    if (this_wmn != "")
      this_wmn := SubStr(this_wmn,2)
    if (this_wmnk != "")
      this_wmnk := SubStr(this_wmnk,2)
    if (nthis == 1)
      wmn .= "Wegen fehlender Tastenbelegung: Nicht als Compose:`r`n"
    else
      wmn .= "Als Compose:`r`n"
    wmn .= this_wmn . "`r`noder`r`n" . this_wmnk . "`r`n`r`n"
  }

  wmnk := KeyLong(CRK%a%)
  if (wmnk != "")
    wmn .= "Als Tastendruck:`r`n" . wmnk
  else
    wmn .= "Als Tastendruck nicht verfügbar!"

  if (wmn != "")
    MsgBox,0,Wie mit NEO,% wmn
  else
    TrayTip,Wie mit NEO,Keine Information über %a% gefunden,10,1
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
    if (CB%base_key% != "")
      base_key := CB%base_key%
    else if (CS%base_key% != "")
      base_key := CS%base_key%

    twmnk .= "/<" . CBS__M%tis_layer% . base_key . ">"
    num := num + 1
  }
  if (num == 0)
    return ""
  else if (num == 1)
    return SubStr(twmnk,2)
  else
    return "(" . SubStr(twmnk,2) . ")"
}
