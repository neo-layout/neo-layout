/*
   ------------------------------------------------------
   Modifier
   ------------------------------------------------------
*/


; CapsLock durch Umschalt+Umschalt
;*CapsLock::return ; Nichts machen beim Capslock release event (weil es Mod3 ist)

*#::return ; Nichts machen beim # release event (weil es Mod3 ist) ; # = SC02B

;RShift wenn vorher LShift gedrückt wurde
LShift & ~RShift::  
      if GetKeyState("CapsLock","T")
      {
         setcapslockstate, off
      }
      else
      {
         setcapslockstate, on
      }
return

;LShift wenn vorher RShift gedrückt wurde
RShift & ~LShift::
      if GetKeyState("CapsLock","T")
      {
         setcapslockstate, off
      }
      else
      {
         setcapslockstate, on
      }
return

; Mod4-Lock durch Mod4+Mod4
IsMod4Locked := 0
< & *SC138::
      if (IsMod4Locked) 
      {
         MsgBox Mod4-Feststellung aufgebehoben
         IsMod4Locked = 0
         if (UseMod4Light==1)
         {
            KeyboardLED(1,"off")
         }
      }
      else
      {
         MsgBox Mod4 festgestellt: Um Mod4 wieder zu lösen drücke beide Mod4 Tasten gleichzeitig
         IsMod4Locked = 1
         if (UseMod4Light==1)
         {
            KeyboardLED(1,"on")
         }
      }
return

*SC138::
 altGrPressed := 1
return  ; Damit AltGr nicht extra etwas schickt und als stiller Modifier geht.
*SC138 up::
 altGrPressed := 0
return 

; das folgende wird seltsamerweise nicht gebraucht :) oder führt zum AltGr Bug; Umschalt+‹ (Mod4) Zeigt ‹
SC138 & *<::
      if (IsMod4Locked) 
      {
         MsgBox Mod4-Feststellung aufgebehoben
         IsMod4Locked = 0
      }
      else
      {
         MsgBox Mod4 festgestellt: Um Mod4 wieder zu lösen drücke beide Mod4 Tasten gleichzeitig 
         IsMod4Locked = 1
      }
return

 
 ; Mod3-Lock durch Mod3+Mod3
IsMod3Locked := 0
SC02B & *Capslock::  ; #
      if (IsMod3Locked) 
      {
         MsgBox Mod3-Feststellung aufgebehoben
         IsMod3Locked = 0
      }
      else
      {
         MsgBox Mod3 festgestellt: Um Mod3 wieder zu lösen drücke beide Mod3 Tasten gleichzeitig 
         IsMod3Locked = 1
      }
return


*Capslock:: return
;Capslock::MsgBox hallo
/*
Capslock & *:
      if (IsMod3Locked) 
      {
         MsgBox Mod3-Feststellung aufgebehoben
         IsMod3Locked = 0
      }
      else
      {
         MsgBox Mod3 festgestellt: Um Mod3 wieder zu lösen drücke beide Mod3 Tasten gleichzeitig 
         IsMod3Locked = 1
      }
return
*/
 
/*
;  Wird nicht mehr gebraucht weil jetzt auf b (bzw. *n::)
; KP_Decimal durch Mod4+Mod4
*<::
*SC138::
   if GetKeyState("<","P") and GetKeyState("SC138","P")
   {
      send {numpaddot}
   }
return
 
*/



