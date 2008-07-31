/*
   ------------------------------------------------------
   BildschirmTastatur
   ------------------------------------------------------
*/
guiErstellt = 0
alwaysOnTop = 1
aktuellesBild = %ResourceFolder%\ebene1.png 
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
     if (Image == "%ResourceFolder%\ebene1.png")
        goto Close
     else
     {
       Image = %ResourceFolder%\ebene1.png
       SetTimer, Refresh
     }
  }
  else 
  {
    Image = %ResourceFolder%\ebene1.png
    goto Show    
  }
Return

Switch2:
  if (guiErstellt) 
  {
     if (Image == "%ResourceFolder%\ebene2.png")
        goto Close
     else
     {
       Image = %ResourceFolder%\ebene2.png
       SetTimer, Refresh
     }
  }
  else 
  {
    Image = %ResourceFolder%\ebene2.png
    goto Show    
  }
Return

Switch3:
  if (guiErstellt) 
  {
     if (Image == "%ResourceFolder%\ebene3.png")
        goto Close
     else
     {
       Image = %ResourceFolder%\ebene3.png
       SetTimer, Refresh
     }
  }
  else 
  {
    Image = %ResourceFolder%\ebene3.png
    goto Show    
  }
Return

Switch4:
  if (guiErstellt) 
  {
     if (Image == "%ResourceFolder%\ebene4.png")
        goto Close
     else
     {
       Image = %ResourceFolder%\ebene4.png
       SetTimer, Refresh
     }
  }
  else 
  {
    Image = %ResourceFolder%\ebene4.png
    goto Show    
  }
Return

Switch5:
  if (guiErstellt) 
  {
     if (Image == "%ResourceFolder%\ebene5.png")
        goto Close
     else
     {
       Image = %ResourceFolder%\ebene5.png
       SetTimer, Refresh
     }
  }
  else 
  {
    Image = %ResourceFolder%\ebene5.png
    goto Show    
  }
Return

Switch6:
  if (guiErstellt) 
  {
     if (Image == "%ResourceFolder%\ebene6.png")
        goto Close
     else
     {
       Image = %ResourceFolder%\ebene6.png
       SetTimer, Refresh
     }
  }
  else 
  {
    Image = %ResourceFolder%\ebene6.png
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
      Image = %ResourceFolder%\ebene1.png 
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
          menu, tray, icon, %ResourceFolder%\neo.ico,,1  
      suspend , off ; Schaltet Suspend aus -> NEO
   }
   else
   {
      menu, tray, rename, %disable%, %enable%
      menu, tray, tip, %name% : Deaktiviert
      if (iconBenutzen)
         menu, tray, icon, %ResourceFolder%\neo_disabled.ico,,1
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






