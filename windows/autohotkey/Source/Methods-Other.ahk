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


/*************************
  Alte Methoden
*************************/

/*
Unicode(code)
{
   saved_clipboard := ClipboardAll
   Transform, Clipboard, Unicode, %code%
   sendplay ^v
   Clipboard := saved_clipboard
}

BSUnicode(code)
{
   saved_clipboard := ClipboardAll
   Transform, Clipboard, Unicode, %code%
   sendplay {bs}^v
   Clipboard := saved_clipboard
}
*/

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
   VarSetCapacity(ki, 28 * 2, 0)

   EncodeInteger(&ki + 0, 1)
   EncodeInteger(&ki + 6, charCode)
   EncodeInteger(&ki + 8, 4)
   EncodeInteger(&ki +28, 1)
   EncodeInteger(&ki +34, charCode)
   EncodeInteger(&ki +36, 4|2)

   DllCall("SendInput", "UInt", 2, "UInt", &ki, "Int", 28)
}

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





/* 
   ------------------------------------------------------
   BildschirmTastatur
   ------------------------------------------------------
*/
guiErstellt = 0
alwaysOnTop = 1
aktuellesBild = ebene1.png 
SC056 & *F1::
SC138 & *F1::
{
  if (zeigeBildschirmTastatur)
    goto Switch1
  return
}
SC056 & *F2::
SC138 & *F2::
{
  if (zeigeBildschirmTastatur)
    goto Switch2
  return
}
SC056 & *F3::
SC138 & *F3::
{
  if (zeigeBildschirmTastatur)
    goto Switch3
  return
}
SC056 & *F4::
SC138 & *F4::
{
  if (zeigeBildschirmTastatur)
    goto Switch4
  return
}
SC056 & *F5::
SC138 & *F5::
{
  if (zeigeBildschirmTastatur)
    goto Switch5
  return
}
SC056 & *F6::
SC138 & *F6::
{
  if (zeigeBildschirmTastatur)
    goto Switch6
  return
}
SC056 & *F7::
SC138 & *F7::
{
  if (zeigeBildschirmTastatur)
    goto Show
  return
}
SC056 & *F8::
SC138 & *F8::
{
  if (zeigeBildschirmTastatur)
    goto ToggleAlwaysOnTop
  return
}
Switch1:
  if (guiErstellt) 
  {
     if (Image == "ebene1.png")
        goto Close
     else
     {
       Image = ebene1.png
       SetTimer, Refresh
     }
  }
  else 
  {
    Image = ebene1.png
    goto Show    
  }
Return

Switch2:
  if (guiErstellt) 
  {
     if (Image == "ebene2.png")
        goto Close
     else
     {
       Image = ebene2.png
       SetTimer, Refresh
     }
  }
  else 
  {
    Image = ebene2.png
    goto Show    
  }
Return

Switch3:
  if (guiErstellt) 
  {
     if (Image == "ebene3.png")
        goto Close
     else
     {
       Image = ebene3.png
       SetTimer, Refresh
     }
  }
  else 
  {
    Image = ebene3.png
    goto Show    
  }
Return

Switch4:
  if (guiErstellt) 
  {
     if (Image == "ebene4.png")
        goto Close
     else
     {
       Image = ebene4.png
       SetTimer, Refresh
     }
  }
  else 
  {
    Image = ebene4.png
    goto Show    
  }
Return

Switch5:
  if (guiErstellt) 
  {
     if (Image == "ebene5.png")
        goto Close
     else
     {
       Image = ebene5.png
       SetTimer, Refresh
     }
  }
  else 
  {
    Image = ebene5.png
    goto Show    
  }
Return

Switch6:
  if (guiErstellt) 
  {
     if (Image == "ebene6.png")
        goto Close
     else
     {
       Image = ebene6.png
       SetTimer, Refresh
     }
  }
  else 
  {
    Image = ebene6.png
    goto Show    
  }
Return

Show:
  if (guiErstellt) 
  {
     goto Close
  }
  else
  {
    if (Image = "") 
    {
      Image = ebene1.png 
    }     
    yPosition := A_ScreenHeight -270
    Gui, Color, FFFFFF
    Gui, Add, Button, xm+5 gSwitch1, F1
    Gui, Add, Text, x+5, kleine Buchstaben
    Gui, Add, Button, xm+5 gSwitch2, F2
    Gui, Add, Text, x+5, große Buchstaben
    Gui, Add, Button, xm+5 gSwitch3, F3
    Gui, Add, Text, x+5, Satz-/Sonderzeichen
    Gui, Add, Button, xm+5 gSwitch4, F4
    Gui, Add, Text, x+5, Zahlen / Steuerung
    Gui, Add, Button, xm+5 gSwitch5, F5
    Gui, Add, Text, x+5, Sprachen
    Gui, Add, Button, xm+5 gSwitch6, F6
    Gui, Add, Text, x+5, Mathesymbole
    Gui, Add, Button, xm+5 gShow, F7
    Gui, Add, Text, x+5, An /
    Gui, Add, Text, y+3, Aus
    Gui, Add, Button, x+10 y+-30 gShow, F8
    Gui, Add, Text, x+5, OnTop
    Gui, Add, Picture,AltSubmit ys w564 h200 vPicture, %Image%
    Gui, +AlwaysOnTop
    Gui, Show, y%yposition% Autosize
    SetTimer, Refresh
    guiErstellt = 1
  } 
Return

Close:
  guiErstellt = 0
  Gui, Destroy
Return

Refresh:
   If (Image != OldImage)
   {
      GuiControl, , Picture, %Image%
      OldImage := Image
   }
Return

ToggleAlwaysOnTop:
    if (alwaysOnTop)
    {
      Gui, -AlwaysOnTop
      alwaysOnTop = 0    
    }
    else
    {
      Gui, +AlwaysOnTop
      alwaysOnTop = 1
    }
Return
 ; Ende der BildschirmTastatur


/*
   ------------------------------------------------------
   Shift+Pause "pausiert" das Script.
   ------------------------------------------------------
*/

+pause::
Suspend, Permit
   goto togglesuspend
return

; ------------------------------------

^SC034::einHandNeo := not(einHandNeo)  ; Punkt
^SC033::lernModus := not(lernModus)    ; Komma



togglesuspend:
   if A_IsSuspended
   {
      menu, tray, rename, %enable%, %disable%
      menu, tray, tip, %name%
      if (iconBenutzen)
          menu, tray, icon, neo.ico,,1  
      suspend , off ; Schaltet Suspend aus -> NEO
   }
   else
   {
      menu, tray, rename, %disable%, %enable%
      menu, tray, tip, %name% : Deaktiviert
      if (iconBenutzen)
         menu, tray, icon, neo_disabled.ico,,1
      suspend , on  ; Schaltet Suspend ein -> QWERTZ 
   }

return


help:
   Run, %A_WinDir%\hh mk:@MSITStore:autohotkey.chm
return


about:
   msgbox, 64, %name% – Ergonomische Tastaturbelegung, 
   (
   %name% 
   `nDas Neo-Layout ersetzt das übliche deutsche 
   Tastaturlayout mit der Alternative Neo, 
   beschrieben auf http://neo-layout.org/. 
   `nDazu sind keine Administratorrechte nötig. 
   `nWenn Autohotkey aktiviert ist, werden alle Tastendrucke 
   abgefangen und statt dessen eine Übersetzung weitergeschickt. 
   `nDies geschieht transparent für den Anwender, 
   es muss nichts installiert werden. 
   `nDie Zeichenübersetzung kann leicht über das Icon im 
   Systemtray deaktiviert werden.  `n
   )
return


neo:
   run http://neo-layout.org/
return

autohotkey:
   run http://autohotkey.com/
return

open:
   ListLines ; shows the Autohotkey window
return

edit:
   edit
return

reload:
   Reload
return

hide:
   menu, tray, noicon
return

exitprogram:
   exitapp
return





