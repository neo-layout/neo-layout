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
   if (ahkTreiberKombi)
   {
      if ( IsMod4Pressed() and not(IsShiftPressed()) and not(IsMod3Pressed()))
      {
         Ebene = 6      
      }
      else
      {
        Ebene = -1
      }  
   }
   else 
   {   
     if ( IsShiftPressed() )
     {  ; Umschalt
        if ( IsMod3Pressed() )
            { ; Umschalt UND Mod3 
            if ( IsMod4Pressed() )
            {  ; Umschalt UND Mod3 UND Mod4 
               ; Ebene 8 impliziert Ebene 6
               Ebene = 6
             }
            else
            { ; Umschald UND Mod3 NICHT Mod4
                Ebene = 5                  
            }
        }
        else 
        {  ; Umschalt NICHT Mod3
            if ( IsMod4Pressed() )
            {  ; Umschalt UND Mod4 NICHT Mod3
               ; Ebene 7 impliziert Ebene 4 
                Ebene = 4
            }
            else
            { ; Umschalt NICHT Mod3 NICHT Mod4
               Ebene = 2    
            }
         }   
     }
     else
     { ; NICHT Umschalt
        if ( IsMod3Pressed() )
        { ; Mod3 NICHT Umschalt 
           if ( IsMod4Pressed() )
           {  ; Mod3 UND Mod4 NICHT Umschalt
               Ebene = 6
           }
           else
           { ; Mod3 NICHT Mod4 NICHT Umschalt
               Ebene = 3    
           }
        }
        else 
        {  ; NICHT Umschalt NICHT Mod3
           if ( IsMod4Pressed() )
           {  ; Mod4 NICHT Umschalt NICHT Mod3 
               Ebene = 4
           }
           else
           { ; NICHT Umschalt NICHT Mod3 NICHT Mod4
               Ebene = 1
           }
        }   
      }
   }
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
         return (not ( GetKeyState("<","P") or GetKeyState("SC138","P") or altGrPressed ))
     }
     else {
         return ( GetKeyState("<","P") or GetKeyState("SC138","P") or altGrPressed )
     }
   }
   else
   {
     if (IsMod4Locked) 
     {
         return (not ( GetKeyState("<","P") or GetKeyState("SC138","P") or GetKeyState("ä","P")  or altGrPressed ))
     }
     else {
         return ( GetKeyState("<","P") or GetKeyState("SC138","P") or GetKeyState("ä","P") or altGrPressed )
     }
   }
   
}


IsModifierPressed()
{
   if (GetKeyState("LControl","P") or GetKeyState("RControl","P") or GetKeyState("LAlt","P") or GetKeyState("RAltl","P") or GetKeyState("LWin","P") or GetKeyState("RWin","P") or GetKeyState("LShift","P") or GetKeyState("RShift","P") or GetKeyState("AltGr","P") ) 
    {
       return 1
    }
    else
    {
       return 0
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
Über den GDK-Workaround:
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
   send {bs}
   send {bs}
   SendUnicodeChar(charCode)
}


EncodeInteger(ref, val)
{
   DllCall("ntdll\RtlFillMemoryUlong", "Uint", ref, "Uint", 4, "Uint", val)
}


;Lang-s-Tastatur:
SC056 & *F11::
LangSTastatur := not(LangSTastatur) ; schaltet die Lang-s-Tastatur ein und aus
return

