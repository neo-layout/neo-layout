#NoEnv

AllStar(This_HotKey) {
  global
  PhysKey := This_HotKey
  if (SubStr(PhysKey,1,1) == "*")
    PhysKey := SubStr(PhysKey,2)
  if (SubStr(PhysKey,-2) == " up") {
    PhysKey := SubStr(PhysKey,1,StrLen(PhysKey)-3)
    IsDown := 0
  } else
    IsDown := 1
  if (TransformProc != "")
    ActKey := Transform%TransformProc%(PhysKey)
  else
    ActKey := PhysKey
  if ((striktesMod2Lock == 0) && (NOC%ActKey% == 1))
    Ebene := EbeneNC
  else
    Ebene := EbeneC
  if (Ebene7 and (CP7%ActKey% != ""))
    Char := CP7%ActKey%
  else if (Ebene8 and (CP8%ActKey% != ""))
    Char := CP8%ActKey%
  else
    Char := CP%Ebene%%ActKey%
  if (PressHookProc != "") {
    if (IsDown == 1)
      PressHook%PressHookProc%(PhysKey, ActKey, Char)
    else
      CharStarUp(PhysKey)
  } else if (IsDown == 1)
    CharStarDown(PhysKey, ActKey, Char)
  else
    CharStarUp(PhysKey)
}

CharStarDown(PhysKey, ActKey, char) {
  global
  if (SubStr(char,1,1)=="P") {
    SubProc := SubStr(char,2,6)
    CharProc%SubProc%()
    return
  }
rerun:
  wasNonShiftKeyPressed := 1
  if (PP%PhysKey% != "")
    CompNew := PP%PhysKey%           ; Von Tastaturwiederholung
  else
    CompNew := Comp . char           ; H�ngen wir mal das neue Zeichen zum Compositum an

  if (CD%CompNew% != "") {           ; Compose hat getroffen: wird geschickt, Compose gel�scht
    tosend := CD%CompNew%
    PP%PhysKey% := CompNew
    Comp := ""
  } else if (CM%CompNew% == 1) {     ; Compose muss sich noch was merken: Jetzt noch nichts schicken.
    tosend := ""
    PP%PhysKey% := ""
    Comp := CompNew
  } else if (CF%Comp% != "") {
    tosend := CF%Comp%
    if (PR%PhysKey% != "") {         ; Eventuell vergessenen Key-Release aufr�umen
      CharOutUp(PR%PhysKey%)
      PR%PhysKey% := ""
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
    Comp := ""
    PP%PhysKey% := ""
    goto rerun
  } else if (Comp == "") {           ; noch kein Zeichen in der Compose-Queue: Ein einzelnes Zeichen wird geschickt
    tosend := char
    PP%PhysKey% := char
  } else {                           ; Compose hat verfehlt: nichts schicken, auch aktuelles Zeichen nicht schicken
    tosend := ""
    PP%PhysKey% := ""
    Comp := ""
  }



  if (strlen(tosend) > 7) {          ; Ausgabe mehrerer Zeichen
    if (PR%PhysKey% != "") {         ; Eventuell vergessenen Key-Release aufr�umen
      CharOutUp(PR%PhysKey%)
      PR%PhysKey% := ""
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
  } else if (tosend != "") {
    if (SubStr(tosend,1,1)=="P") {
      if (PR%PhysKey% != "") {
        CharOutUp(PR%PhysKey%)
        PR%PhysKey% := ""
      }
      SubProc := SubStr(tosend,2,6)
      CharProc%SubProc%()
    } else {
      if ((PR%PhysKey% != "") and (PR%PhysKey% != tosend))
        CharOutUp(PR%PhysKey%)
      PR%PhysKey% := tosend
      CharOutDown(tosend)
    }
  } else if (PR%PhysKey% != "") {
    CharOutUp(PR%PhysKey%)
    PR%PhysKey% := ""
  }
  if (BSTNguiErstellt)
    BSTNUpdate()
}

CharStarUp(PhysKey) {
  global
  if (PR%PhysKey% != "") {
    tosend := PR%PhysKey%
    PR%PhysKey% := ""
    if (SubStr(tosend,1,1)=="P") {
      SubProc := SubStr(tosend,2,6)
      CharProc%SubProc%()
    } else
      CharOutUp(tosend)
  }
  PP%PhysKey% := ""
}


CharOut(char) {
  global
  if (CharOutFilterProc != "") {
    char := CharOutFilter%CharOutFilterProc%(char,1,1)
    if (char == "")
      return
  }
  if (DNCS%char% != "")
    SendBlindShiftFixed(char, DNCS%char% . UPCS%char%)
  else if (CS%char% != "")
    SendBlindShiftFixed(char, "{" . CS%char% . "}")
  else
    SendUnicodeChar("0x" . SubStr(char,2))
}

CharOutDown(char) {
  global
  if (CharOutFilterProc != "") {
    char := CharOutFilter%CharOutFilterProc%(char,1,0)
    if (char == "")
      return
  }
  if (DNCS%char% != "")
    SendBlindShiftFixed(char, DNCS%char%)
  else if (CS%char% != "")
    SendBlindShiftFixed(char, "{" . CS%char% . " down}")
  else
    SendUnicodeCharDown("0x" . SubStr(char,2))
}

CharOutUp(char) {
  global
  if (CharOutFilterProc != "") {
    char := CharOutFilter%CharOutFilterProc%(char,0,1)
    if (char == "")
      return
  }
  if (DNCS%char% != "") {
    if (UPCS%char% != "")
      SendBlindShiftFixed(char, UPCS%char%)
  } else if (CS%char% != "")
    SendBlindShiftFixed(char, "{" . CS%char% . " up}")
  else
    SendUnicodeCharUp("0x" . SubStr(char,2))
}

SendBlindShiftFixed(char, theseq) {
  global
  if (UNSH%char%)
    if (IsShiftLPressed)
      if (IsShiftRPressed)
        send % "{blind}{RShift Up}{Shift Up}" . theseq . "{Shift Down}{RShift Down}"
      else
        send % "{blind}{Shift Up}" . theseq . "{Shift Down}"
    else
      if (IsShiftRPressed)
        send % "{blind}{RShift Up}" . theseq . "{RShift Down}"
      else
        send % "{blind}" . theseq
  else if (DOSH%char%)
    if (IsShiftLPressed)
      if (IsShiftRPressed)
        send % "{blind}" . theseq
      else
        send % "{blind}{RShift Down}" . theseq . "{RShift Up}"
    else
      if (IsShiftRPressed)
        send % "{blind}{Shift Down}" . theseq . "{Shift Up}"
      else
        send % "{blind}{Shift Down}" . theseq . "{Shift Up}"
  else
    send % "{blind}" . theseq
}

CharProc(name) {
  CharProc%name%()
}

CharProc__Rlod() {
  global
  ; Neustart des AHK-Skripts
  SetOldLockStates()
  reload
}

; Modifier
CharProc__M2LD() {
  global
  if (!isShiftLPressed) {
    if (isShiftRPressed and !wasNonShiftKeyPressed)
      ToggleMod2Lock()
    isShiftLPressed := 1
    isShiftPressed := 1
    wasNonShiftKeyPressed := 0
    %EbeneAktualisieren%()
    PR%PhysKey% := "P__M2LU"
  }
  CharOutDown("S__L_M2")
}

CharProc__M2LU() {
  global
  isShiftLPressed := 0
  isShiftPressed := isShiftRPressed
  %EbeneAktualisieren%()
  CharOutUp("S__L_M2")
}

CharProc__M2RD() {
  global
  if (!isShiftRPressed) {
    if (isShiftLPressed and !wasNonShiftKeyPressed)
      ToggleMod2Lock()
    isShiftRPressed := 1
    isShiftPressed := 1
    wasNonShiftKeyPressed := 0
    %EbeneAktualisieren%()
    PR%PhysKey% := "P__M2RU"
  }
  CharOutDown("S__R_M2")
}

CharProc__M2RU() {
  global
  isShiftRPressed := 0
  isShiftPressed := isShiftLPressed
  %EbeneAktualisieren%()
  CharOutUp("S__R_M2")
}

CharProc__M3LD() {
  global
  if (!isMod3LPressed) {
    if (isMod3RPressed and !wasNonShiftKeyPressed)
      CharStarDown("MOD3", "MOD3", "S__Comp")
    isMod3LPressed := 1
    isMod3Pressed := 1
    wasNonShiftKeyPressed := 0
    %EbeneAktualisieren%()
    PR%PhysKey% := "P__M3LU"
  }
}

CharProc__M3LU() {
  global
  if (isMod3RPressed)
    CharStarUp("MOD3")
  isMod3LPressed := 0
  isMod3Pressed := isMod3RPressed
  %EbeneAktualisieren%()
}

CharProc__M3RD() {
  global
  if (!Mod3RPressed) {
    if (isMod3LPressed and !wasNonShiftKeyPressed)
      CharStarDown("MOD3", "MOD3", "S__Comp")
    isMod3RPressed := 1
    isMod3Pressed := 1
    wasNonShiftKeyPressed := 0
    %EbeneAktualisieren%()
    PR%PhysKey% := "P__M3RU"
  }
}

CharProc__M3RU() {
  global
  if (isMod3LPressed)
    CharStarUp("MOD3")
  isMod3RPressed := 0
  isMod3Pressed := isMod3LPressed
  %EbeneAktualisieren%()
}

CharProc__M4LD() {
  global
  if (!isMod4LPressed) {
    isMod4LPressed := 1
    isMod4Pressed := 1
    %EbeneAktualisieren%()
    PR%PhysKey% := "P__M4LU"
    if (isMod4RPressed and !wasNonShiftKeyPressed) {
      wasNonShiftKeyPressed := 0
      ToggleMod4Lock()
    } else
      wasNonShiftKeyPressed := 0
  }
}

CharProc__M4LU() {
  global
  isMod4LPressed := 0
  isMod4Pressed := isMod4RPressed
  %EbeneAktualisieren%()
}

CharProc__M4RD() {
  global
  if (!isMod4RPressed) {
    isMod4RPressed := 1
    isMod4Pressed := 1
    %EbeneAktualisieren%()
    PR%PhysKey% := "P__M4RU"
    if (isMod4LPressed and !wasNonShiftKeyPressed) {
      wasNonShiftKeyPressed := 0
      ToggleMod4Lock()
    } else
      wasNonShiftKeyPressed := 0
  }
}

CharProc__M4RU() {
  global
  isMod4RPressed := 0
  isMod4Pressed := isMod4LPressed
  %EbeneAktualisieren%()
}

SendUnicodeChar(charCode){
  IfWinActive,ahk_class gdkWindowToplevel
  {
    StringLower,charCode,charCode
    send % "^+u" . SubStr(charCode,3) . " "
  } else IfWinActive,ahk_class Emacs
  {
    send % "^x8{Enter}" . SubStr(charCode,3) . "{Enter}"
  } else {
    static ki := "#"
    if (ki =="#") {
      VarSetCapacity(ki,28*4,0)
      DllCall("RtlFillMemory","uint",&ki+     0,"uint",1,"uint",1)
      DllCall("RtlFillMemory","uint",&ki+  28+0,"uint",1,"uint",1)
      DllCall("RtlFillMemory","uint",&ki+2*28+0,"uint",1,"uint",1)
      DllCall("RtlFillMemory","uint",&ki+3*28+0,"uint",1,"uint",1)
    }
    if (charCode < 0x10000) {
      DllCall("ntdll.dll\RtlFillMemoryUlong","uint",&ki+   6,"uint",4,"uint",0x40000|charCode) ;KEYEVENTF_UNICODE
      DllCall("ntdll.dll\RtlFillMemoryUlong","uint",&ki+28+6,"uint",4,"uint",0x60000|charCode) ;KEYEVENTF_KEYUP|KEYEVENTF_UNICODE
      DllCall("SendInput","UInt",2,"UInt",&ki,"Int",28)
    } else {
      hi_surrogate := 0xD800|((charCode-0x10000)/1024)
      lo_surrogate := 0xDC00|((charCode-0x10000)&0x3FF)
      DllCall("ntdll.dll\RtlFillMemoryUlong","uint",&ki+     6,"uint",4,"uint",0x40000|hi_surrogate) ;KEYEVENTF_UNICODE
      DllCall("ntdll.dll\RtlFillMemoryUlong","uint",&ki+  28+6,"uint",4,"uint",0x40000|lo_surrogate) ;KEYEVENTF_UNICODE
      DllCall("ntdll.dll\RtlFillMemoryUlong","uint",&ki+2*28+6,"uint",4,"uint",0x60000|hi_surrogate) ;KEYEVENTF_KEYUP|KEYEVENTF_UNICODE
      DllCall("ntdll.dll\RtlFillMemoryUlong","uint",&ki+3*28+6,"uint",4,"uint",0x60000|lo_surrogate) ;KEYEVENTF_KEYUP|KEYEVENTF_UNICODE
      DllCall("SendInput","UInt",4,"UInt",&ki,"Int",28)
    }
  }
}

SendUnicodeCharDown(charCode){
  IfWinActive,ahk_class gdkWindowToplevel
  {
    StringLower,charCode,charCode
    send % "^+u" . SubStr(charCode,3) . " "
  } else IfWinActive,ahk_class Emacs
  {
    send % "^x8{Enter}" . SubStr(charCode,3) . "{Enter}"
  } else {
    static ki := "#"
    if (ki =="#") {
      VarSetCapacity(ki,28*2,0)
      DllCall("RtlFillMemory","uint",&ki+     0,"uint",1,"uint",1)
      DllCall("RtlFillMemory","uint",&ki+  28+0,"uint",1,"uint",1)
    }
    if (charCode < 0x10000) {
      DllCall("ntdll.dll\RtlFillMemoryUlong","uint",&ki+   6,"uint",4,"uint",0x40000|charCode) ;KEYEVENTF_UNICODE
      DllCall("SendInput","UInt",1,"UInt",&ki,"Int",28)
    } else {
      hi_surrogate := 0xD800|((charCode-0x10000)/1024)
      lo_surrogate := 0xDC00|((charCode-0x10000) & 0x3FF)
      DllCall("ntdll.dll\RtlFillMemoryUlong","uint",&ki+     6,"uint",4,"uint",0x40000|hi_surrogate) ;KEYEVENTF_UNICODE
      DllCall("ntdll.dll\RtlFillMemoryUlong","uint",&ki+  28+6,"uint",4,"uint",0x40000|lo_surrogate) ;KEYEVENTF_UNICODE
      DllCall("SendInput","UInt",2,"UInt",&ki,"Int",28)
    }
  }
}

SendUnicodeCharUp(charCode){
  IfWinActive,ahk_class gdkWindowToplevel
  {
    ; nothing
  } else IfWinActive,ahk_class Emacs
  {
    ; nothing
  } else {
    static ki := "#"
    if (ki =="#") {
      VarSetCapacity(ki,28*2,0)
      DllCall("RtlFillMemory","uint",&ki+     0,"uint",1,"uint",1)
      DllCall("RtlFillMemory","uint",&ki+  28+0,"uint",1,"uint",1)
    }
    if (charCode < 0x10000) {
      DllCall("ntdll.dll\RtlFillMemoryUlong","uint",&ki+   6,"uint",4,"uint",0x60000|charCode) ;KEYEVENTF_KEYUP|KEYEVENTF_UNICODE
      DllCall("SendInput","UInt",1,"UInt",&ki,"Int",28)
    } else {
      hi_surrogate := 0xD800|((charCode-0x10000)/1024)
      lo_surrogate := 0xDC00|((charCode-0x10000)&0x3FF)
      DllCall("ntdll.dll\RtlFillMemoryUlong","uint",&ki+     6,"uint",4,"uint",0x60000|hi_surrogate) ;KEYEVENTF_KEYUP|KEYEVENTF_UNICODE
      DllCall("ntdll.dll\RtlFillMemoryUlong","uint",&ki+  28+6,"uint",4,"uint",0x60000|lo_surrogate) ;KEYEVENTF_KEYUP|KEYEVENTF_UNICODE
      DllCall("SendInput","UInt",2,"UInt",&ki,"Int",28)
    }
  }
}

