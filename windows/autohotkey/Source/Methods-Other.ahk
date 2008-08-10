/*
   ------------------------------------------------------
   Funktionen
   ------------------------------------------------------
*/

/*
Ebenen laut Referenz:
1. Ebene (kein Mod)      4. Ebene (Mod4)
2. Ebene (Umschalt)      5. Ebene (Umschalt+Mod3)
3. Ebene (Mod3)          6. Ebene (Mod3+Mod4)
*/

EbeneAktualisieren()
{
   global
   PriorDeadKey := DeadKey
   PriorCompKey := CompKey
   DeadKey := ""
   CompKey := ""
   Ebene12 := 0
   Modstate := IsShiftPressed() . IsMod3Pressed() . IsMod4Pressed()

   if (ahkTreiberKombi)
      if ( Modstate = "001")
         Ebene = 6      
      else
         Ebene = -1
   else 
     if      (Modstate = "000")
         Ebene = 1                 ; Ebene 1: Ohne Mod
     else if (Modstate = "100")
         Ebene = 2                 ; Ebene 2: Shift
     else if (Modstate = "010")
         Ebene = 3                 ; Ebene 3: Mod3
     else if (Modstate = "001")
         Ebene = 4                 ; Ebene 4: Mod4
     else if (Modstate = "110")
         Ebene = 5                 ; Ebene 5: Shift+Mod3
     else if (Modstate = "011")
         Ebene = 6                 ; Ebene 6: Mod3+Mod4
     else if (Modstate = "101")
         Ebene = 4                 ; Ebene 7: Shift+Mod4 impliziert Ebene 4
     else if (Modstate = "111")
         Ebene = 6                 ; Ebene 8: Shift+Mod3+Mod4 impliziert Ebene 6

   Ebene12 := ((Ebene = 1) or (Ebene = 2))

   if GetKeyState("NumLock","T")
     NumLock = 1
   else
     NumLock = 0
}



IsShiftPressed()
{
  return GetKeyState("Shift","P")
}

IsMod3Pressed()
{
   global
   if (IsMod3Locked) 
   {
       return (not ( GetKeyState("CapsLock","P") or GetKeyState("#","P") ))  ; # = SC02B
   }
   else {
      return ( GetKeyState("CapsLock","P") or GetKeyState("#","P") )  ; # = SC02B
   }
}

IsMod4Pressed()
{
   global
   if( not(einHandNeo) or not(spacepressed) )
   {
     if (IsMod4Locked) 
     {
         return (not ( GetKeyState("<","P") or GetKeyState("SC138","P")))
     }
     else {
         return ( GetKeyState("<","P") or GetKeyState("SC138","P"))
     }
   }
   else
   {
     if (IsMod4Locked) 
     {
         return (not ( GetKeyState("<","P") or GetKeyState("SC138","P") or GetKeyState("ä","P")))
     }
     else {
         return ( GetKeyState("<","P") or GetKeyState("SC138","P") or GetKeyState("ä","P"))
     }
   }
   
}


SendUnicodeChar(charCode)
{
   IfWinActive, ahk_class gdkWindowToplevel
   {
      StringLower, charCode, charCode
      send % "^+u" . SubStr(charCode,3) . " "
   } else {
      VarSetCapacity(ki, 28 * 2, 0)

      EncodeInteger(&ki + 0, 1)
      EncodeInteger(&ki + 6, charCode)
      EncodeInteger(&ki + 8, 4)
      EncodeInteger(&ki +28, 1)
      EncodeInteger(&ki +34, charCode)
      EncodeInteger(&ki +36, 4|2)

      DllCall("SendInput", "UInt", 2, "UInt", &ki, "Int", 28)
   }
}
/*
Über den GTK-Workaround:
Dieser basiert auf http://www.autohotkey.com/forum/topic32947.html

Der Aufruf von »SubStr(charCode,3)« geht davon aus, dass alle charCodes in Hex mit führendem „0x“ angegeben sind. Die abenteuerliche „^+u“-Konstruktion benötigt im Übrigen den Hex-Wert in Kleinschrift, was derzeit nicht bei den Zeichendefinitionen umgesetzt ist, daher zentral und weniger fehlerträchtig an dieser Stelle. Außerdem ein abschließend gesendetes Space, sonst bleibt der „eingetippte“ Unicode-Wert noch kurz sichtbar stehen, bevor er sich GTK-sei-dank in das gewünschte Zeichen verwandelt.
*/


BSSendUnicodeChar(charCode)
{
   send {bs}
   SendUnicodeChar(charCode)
}

CompUnicodeChar(charCode)
{
   send {bs}
   SendUnicodeChar(charCode)
}

Comp3UnicodeChar(charCode)
{
   send {bs}{bs}
   SendUnicodeChar(charCode)
}


EncodeInteger(ref, val)
{
   DllCall("ntdll\RtlFillMemoryUlong", "Uint", ref, "Uint", 4, "Uint", val)
}

DeadSilence = 0

deadAsc(val)
{
  global
  if (DeadSilence)
    {} ; keine Ausgabe
  else
    send % "{blind}" . val
}

deadUni(val)
{
  global
  if (DeadSilence)
    {} ; keine Ausgabe
  else
    SendUnicodeChar(val)
}

undeadAsc(val)
{
  global
  if (DeadSilence)
    send % "{blind}" . val
  else
    send % "{blind}{bs}" . val
}

undeadUni(val)
{
  global
  if (DeadSilence)
    {} ; keine ausgabe
  else
    send {bs}
  SendUnicodeChar(val)    
}

CheckDeadAsc(d,val)
{
  global
  if (PriorDeadKey == d)
  {
    undeadAsc(val)
    return 1
  }
  else
    return 0
}

CheckDeadUni(d,val)
{
  global
  if (PriorDeadKey == d)
  {
    undeadUni(val)
    return 1
  }
  else
    return 0
}

CheckDeadAsc12(d,val1,val2)
{
  global
  if (PriorDeadKey == d)
  {
    if      ((Ebene = 1) and (val1 != ""))
    {
      undeadAsc(val1)
      return 1
    }
    else if ((Ebene = 2) and (val2 != ""))
    {
      undeadAsc(val2)
      return 1
    }
    else 
      return 0
  }
  else
    return 0
}

CheckDeadUni12(d,val1,val2)
{
  global
  if (PriorDeadKey == d)
  {
    if      ((Ebene = 1) and (val1 != ""))
    {
      undeadUni(val1)
      return 1
    }
    else if ((Ebene = 2) and (val2 != ""))
    {
      undeadUni(val2)
      return 1
    }
    else 
      return 0
  }
  else
    return 0
}

DeadCompose = 0

compAsc(val)
{
  global
  if (DeadCompose)
    {} ; keine Ausgabe
  else
    send % "{blind}" . val
}

compUni(val)
{
  global
  if (DeadCompose)
    {} ; keine Ausgabe
  else
    SendUnicodeChar(val)
}

uncompAsc(val)
{
  global
  if (DeadCompose)
    send % "{blind}" . val
  else
    send % "{blind}{bs}" . val
}

uncompUni(val)
{
  global
  if (DeadCompose)
    {} ; keine ausgabe
  else
    send {bs}
  SendUnicodeChar(val)    
}

uncomp3Uni(val)
{
  global
  if (DeadCompose)
    {} ; keine ausgabe
  else
    send {bs}{bs}
  SendUnicodeChar(val)    
}

CheckCompAsc(d,val)
{
  global
  if (PriorCompKey == d)
  {
    uncompAsc(val)
    return 1
  }
  else
    return 0
}

CheckCompAsc12(d,val1,val2)
{
  global
  if (PriorCompKey == d)
    if      ((Ebene = 1) and (val1 != ""))
    {
      uncompAsc(val1)
      return 1
    }
    else if ((Ebene = 2) and (val2 != ""))
    {
      uncompAsc(val2)
      return 1
    }
    else 
      return 0
  else
    return 0
}

CheckCompUni(d,val)
{
  global
  if (PriorCompKey == d)
  {
    uncompUni(val)
    return 1
  }
  else
    return 0
}

CheckCompUni12(d,val1,val2)
{
  global
  if (PriorCompKey == d)
  {
    if      ((Ebene = 1) and (val1 != ""))
    {
      uncompUni(val1)
      return 1
    }
    else if ((Ebene = 2) and (val2 != ""))
    {
      uncompUni(val2)
      return 1
    }
    else 
      return 0
  }
  else
    return 0
}

CheckComp3Uni(d,val)
{
  global
  if (PriorCompKey == d)
  {
    uncomp3Uni(val)
    return 1
  }
  else
    return 0
}

CheckComp3Uni12(d,val1,val2)
{
  global
  if (PriorCompKey == d)
  {
    if      ((Ebene = 1) and (val1 != ""))
    {
      uncomp3Uni(val1)
      return 1
    }
    else if ((Ebene = 2) and (val2 != ""))
    {
      uncomp3Uni(val2)
      return 1
    }
    else
      return 0
  }
  else
    return 0
}

outputChar(val1,val2)
{
  global
  if (Ebene = 1)
    c := val1
  else
    c := val2
  send % "{blind}" . c
  if (PriorDeadKey = "comp")
    CompKey := c
}

;Tote/Untote Tasten
*F9::
  if (isMod4pressed())
    DeadSilence :=  not(DeadSilence)
  else
    send {blind}{F9}
return

;Tote/Untote Compose
*F10::
  if (isMod4pressed())
    DeadCompose :=  not(DeadCompose)
  else
    send {blind}{F10}
return

;Lang-s-Tastatur:
*F11::
  if (isMod4pressed())
    LangSTastatur := not(LangSTastatur) ; schaltet die Lang-s-Tastatur ein und aus
  else
    send {blind}{F11}
return


