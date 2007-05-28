/*
    Titel:          NEO Autohotkey-Treiber
    Version:        0.01b
    Datum:          28.05.2007
    Basiert auf:    Neo-Layout und Neo-Remap vom 25.05.2007
*/

; aus Nora's script kopiert:
#usehook on
#singleinstance force
#LTrim 
  ; Quelltext kann einger�ckt werden, 
  ; msgbox ist trotzdem linksb�ndig

SendMode Play	
SetTitleMatchMode 2

name    = NEO 2.0
enable  = Aktiviere %name%
disable = Deaktiviere %name%

; �berpr�fung auf deutsches Tastaturlayout 
; ----------------------------------------

regread, inputlocale, HKEY_CURRENT_USER, Keyboard Layout\Preload, 1
regread, inputlocalealias, HKEY_CURRENT_USER
     , Keyboard Layout\Substitutes, %inputlocale%
if inputlocalealias <>
   inputlocale = %inputlocalealias%
if inputlocale <> 00000407
{
   suspend   
   regread, inputlocale, HKEY_LOCAL_MACHINE
     , SYSTEM\CurrentControlSet\Control\Keyboard Layouts\%inputlocale%
     , Layout Text
   msgbox, 48, Warnung!, 
     (
     Nicht kompatibles Tastaturlayout:   
     `t%inputlocale%   
     `nDas deutsche QWERTZ muss als Standardlayout eingestellt  
     sein, damit %name% wie erwartet funktioniert.   
     `n�ndern Sie die Tastatureinstellung unter 
     `tSystemsteuerung   
     `t-> Regions- und Sprachoptionen   
     `t-> Sprachen 
     `t-> Details...   `n
     )
   exitapp
}



; Variablen initialisieren
Ebene = 1
myPriorHotkey = ""

; CapsLock durch Mod3+Mod3
*#::
*CapsLock::
   if GetKeyState("#","P") and GetKeyState("CapsLock","P")
   {
      if GetKeyState("CapsLock","T")
      {
         setcapslockstate, off
      }
      else
      {
         setcapslockstate, on
      }
   }
return

; Mod5-Tasten einen Hotkey zuweisen, damit die QWERTZ-Entsprechung nicht mehr ausgegeben wird:
*<::
*<^>!::
return



/*
   Hier gehts jetzt los.
   
   Ablauf bei toten Tasten:
   1. Ebene Aktualisieren
   2. Abh�ngig von der Variablen "Ebene" Zeichen ausgeben und die Variable "myPriorHotkey" setzen
   
   Ablauf bei "lebenden" (sagt man das?) Tasten:
   1. Ebene Aktualisieren
   2. Abh�ngig von den Variablen "Ebene" und "myPriorHotkey" Zeichen ausgeben
   3. "myPriorHotkey" mit leerem String �berschreiben
*/


*^::
   EbeneAktualisieren()
   if Ebene = 1
   {
      Unicode("ˆ") ; circumflex, tot
      myPriorHotkey = "c1"
   }
   else if Ebene = 2
   {
      Unicode("ˇ")  ; caron, tot
      myPriorHotkey = "c2"
   }
   else if Ebene = 3
   {
      myPriorHotkey = "c3"
   }
   else if Ebene = 4
   {
      myPriorHotkey = "c4"
   }
   else if Ebene = 5
   {
      myPriorHotkey = "c5"
   }
   else if Ebene = 6
   {
      myPriorHotkey = "c6"
   }
return

*1::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If myPriorHotkey = "c1"          ; circumflex 1
         BSUnicode("¹")
      Else
         send 1
   }
   else if Ebene = 2
      send �
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return

*2::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If myPriorHotkey = "c1"          ; circumflex 
         BSUnicode("²")
      Else
         send 2      
   }
   else if Ebene = 2
      send �
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return

*3::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If myPriorHotkey = "c1"          ; circumflex
         BSUnicode("³")
      Else
         send 3      
   }
   else if Ebene = 2
      send �
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
        
    myPriorHotkey = ""
return

*4::
   EbeneAktualisieren()
   if Ebene = 1
      send 4
   else if Ebene = 2
      send $
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return

*5::
   EbeneAktualisieren()
   if Ebene = 1
      send 5
   else if Ebene = 2
      send �
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return

*6::
   EbeneAktualisieren()
   if Ebene = 1
      send 6
   else if Ebene = 2
      send �
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return

*7::
   EbeneAktualisieren()
   if Ebene = 1
      send 7
   else if Ebene = 2
      send �
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return

*8::
   EbeneAktualisieren()
   if Ebene = 1
      send 8
   else if Ebene = 2
      send �
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return

*9::
   EbeneAktualisieren()
   if Ebene = 1
      send 9
   else if Ebene = 2
      send �
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return

*0::
   EbeneAktualisieren()
   if Ebene = 1
      send 0
   else if Ebene = 2
      send �
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return

*�::
   EbeneAktualisieren()
   if Ebene = 1
      send - ; Bind
   else if Ebene = 2
      Unicode("–") ; Ged
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return

*�::
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {"a1"}{space} ; akut, tot
      myPriorHotkey = "a1"
   }
   else if Ebene = 2
   {
      send ``{space}
      myPriorHotkey = "a2"
   }
   else if Ebene = 3
   {
      myPriorHotkey = "a3"
   }
   else if Ebene = 4
   {
      myPriorHotkey = "a4"
   }
   else if Ebene = 5
   {
      myPriorHotkey = "a5"
   }
   else if Ebene = 6
   {
      myPriorHotkey = "a6"
   }
return


*q::
   EbeneAktualisieren()
   if Ebene = 1
      sendinput {blind}x
   else if Ebene = 2
      sendinput {blind}X
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return


*w::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If myPriorHotkey = "c6"      ; punkt darunter 
         BSUnicode("ṿ")
      Else
         sendinput {blind}v
   }
   else if Ebene = 2
   {
      If myPriorHotkey = "c6"      ; punkt darunter
         BSUnicode("Ṿ")
      Else 
         sendinput {blind}V
   }
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return



*e::
   EbeneAktualisieren()
   if Ebene = 1
   { 
      If myPriorHotkey = "t5"       ; Schr�gstrich
         BSUnicode("ł")
      Else If myPriorHotkey = "a1"      ; akut 
         BSUnicode("ĺ")
      Else If myPriorHotkey = "c2"     ; caron 
         BSUnicode("ľ")
      Else If myPriorHotkey = "a3"    ; cedilla
         BSUnicode("ļ")
      Else If myPriorHotkey = "c5"  ; Mittenpunkt
         BSUnicode("ŀ")
      Else If myPriorHotkey = "c6" ; punkt darunter 
         BSUnicode("ḷ")
      Else 
         sendinput {blind}l
   }
   else if Ebene = 2
   {
      If myPriorHotkey = "a1"           ; akut 
         BSUnicode("Ĺ")
      Else If myPriorHotkey = "c2"     ; caron 
         BSUnicode("Ľ")
      Else If myPriorHotkey = "a3"    ; cedilla
         BSUnicode("Ļ")
      Else If myPriorHotkey = "t5"  ; Schr�gstrich 
         BSUnicode("Ł")
      Else If myPriorHotkey = "c5"  ; Mittenpunkt 
         BSUnicode("Ŀ")
      Else If myPriorHotkey = "c6" ; punkt darunter 
         BSUnicode("Ḷ")
      Else 
         sendinput {blind}L
   }
      
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return


*r::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If myPriorHotkey = "c1"           ; circumflex
         BSUnicode("ĉ")
      Else If myPriorHotkey = "c2"     ; caron
         BSUnicode("č")
      Else If myPriorHotkey = "a1"      ; akut
         BSUnicode("ć")
      Else If myPriorHotkey = "a3"    ; cedilla
         BSUnicode("ç")
      Else If myPriorHotkey = "a5"  ; punkt dar�ber 
         BSUnicode("ċ")
      Else 
         sendinput {blind}c
   }
   else if Ebene = 2
   {
      If myPriorHotkey = "c1"          ; circumflex 
         BSUnicode("Ĉ")
      Else If myPriorHotkey = "c2"    ; caron 
         BSUnicode("Č")
      Else If myPriorHotkey = "a1"     ; akut 
         BSUnicode("Ć")
      Else If myPriorHotkey = "a3"   ; cedilla 
         BSUnicode("Ç")
      Else If myPriorHotkey = "a5" ; punkt dar�ber 
         BSUnicode("Ċ")
      Else 
         sendinput {blind}C
   }
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return

*t::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If myPriorHotkey = "c1"           ; circumflex
         BSUnicode("ŵ")
      Else
         sendinput {blind}w
   }
   else if Ebene = 2
   {
      If myPriorHotkey = "c1"           ; circumflex
         BSUnicode("ŵ")
      Else
         sendinput {blind}W
   }
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return

*z::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If myPriorHotkey = "a3"         ; cedilla
         BSUnicode("ķ")
      Else If myPriorHotkey = "c6" ; punkt darunter 
         BSUnicode("ḳ")
      Else
         sendinput {blind}k
   }
   else if Ebene = 2
   {
      If myPriorHotkey = "a3"         ; cedilla 
         BSUnicode("Ķ")
      Else If myPriorHotkey = "c6" ; punkt darunter 
         BSUnicode("Ḳ")
      Else
         sendinput {blind}K
   }
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return

*u::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If myPriorHotkey = "c1"           ; circumflex
         BSUnicode("ĥ")
      Else If myPriorHotkey = "c4"   ; Querstrich 
         BSUnicode("ħ")
      Else If myPriorHotkey = "a5"  ; punkt dar�ber 
         BSUnicode("ḣ")
      Else If myPriorHotkey = "c6" ; punkt darunter 
         BSUnicode("ḥ")
      Else sendinput {blind}h
   }
   else if Ebene = 2
   {
      If myPriorHotkey = "c1"           ; circumflex
         BSUnicode("Ĥ")
      Else If myPriorHotkey = "c4"   ; Querstrich
         BSUnicode("Ħ")
      Else If myPriorHotkey = "a5"  ; punkt dar�ber 
         BSUnicode("Ḣ")
      Else If myPriorHotkey = "c6" ; punkt darunter 
         BSUnicode("Ḥ")
      Else sendinput {blind}H
   }
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return

*i::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If myPriorHotkey = "c1"          ; circumflex
         BSUnicode("ĝ")
      Else If myPriorHotkey = "c3"   ; brevis
         BSUnicode("ğ")
      Else If myPriorHotkey = "a3"   ; cedilla
         BSUnicode("ģ")
      Else If myPriorHotkey = "a5" ; punkt dar�ber 
         BSUnicode("ġ")
      Else sendinput {blind}g
   }
   else if Ebene = 2
   {
      If myPriorHotkey = "c1"           ; circumflex
         BSUnicode("Ĝ") 
      Else If myPriorHotkey = "c3"    ; brevis 
         BSUnicode("Ğ")
      Else If myPriorHotkey = "a3"    ; cedilla 
         BSUnicode("Ģ")
      Else If myPriorHotkey = "a5"  ; punkt dar�ber 
         BSUnicode("Ġ")
      Else sendinput {blind}G
   }
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return

*o::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If myPriorHotkey = "t5"      ; durchgestrichen
         BSUnicode("ƒ")
      Else If myPriorHotkey = "a5" ; punkt dar�ber 
         BSUnicode("ḟ")
      Else sendinput {blind}f
   }
   else if Ebene = 2
   {
      If myPriorHotkey = "t5"       ; durchgestrichen
         BSUnicode("₣")
      Else If myPriorHotkey = "a5"  ; punkt dar�ber 
         BSUnicode("Ḟ")
      Else sendinput {blind}F
   } 
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return

*p::
   EbeneAktualisieren()
   if Ebene = 1
      sendinput {blind}q
   else if Ebene = 2
      sendinput {blind}Q
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return

*�::
   EbeneAktualisieren()
   if Ebene = 1
      sendinput {blind}�
   else if Ebene = 2
      send SS ; wird versal-�
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return


*+::
   EbeneAktualisieren()
   if Ebene = 1
   {
      Unicode("˜")    ; tilde, tot 
      myPriorHotkey = "t1"
   }
   else if Ebene = 2
   {
      Unicode("ˉ")  ; macron, tot
      myPriorHotkey = "t2"
   }
   else if Ebene = 3
   {
      myPriorHotkey = "t3"
   }
   else if Ebene = 4
   {
      myPriorHotkey = "t4"
   }
   else if Ebene = 5
   {
      myPriorHotkey = "t5"
   }
   else if Ebene = 6
   {
      myPriorHotkey = "t6"
   }
return


*a::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If myPriorHotkey = "c1"           ; circumflex
         BSUnicode("û")
      Else If myPriorHotkey = "a1"      ; akut 
         BSUnicode("ú")
      Else If myPriorHotkey = "a2"     ; grave
         BSUnicode("ù")
      Else If myPriorHotkey = "t3"    ; Diaerese
         Send, {bs}�
      Else If myPriorHotkey = "t4"   ; doppelakut 
         BSUnicode("ű")
      Else If myPriorHotkey = "c3"    ; brevis
         BSUnicode("ŭ")
      Else If myPriorHotkey = "t2"     ; macron
         BSUnicode("ū")
      Else If myPriorHotkey = "a4"   ; ogonek
         BSUnicode("ų")
      Else If myPriorHotkey = "a6" ; Ring
         BSUnicode("ů")
      Else If myPriorHotkey = "t1"      ; tilde
         BSUnicode("ũ")
      Else
         sendinput {blind}u
   }
   else if Ebene = 2
   {
      If myPriorHotkey = "c1"           ; circumflex
         BSUnicode("Û")
      Else If myPriorHotkey = "a1"      ; akut 
         BSUnicode("Ú")
      Else If myPriorHotkey = "a2"     ; grave
         BSUnicode("Ù")
      Else If myPriorHotkey = "t3"    ; Diaerese
         Send, {bs}�
      Else If myPriorHotkey = "a6" ; Ring
         BSUnicode("Ů")
      Else If myPriorHotkey = "c3"    ; brevis
         BSUnicode("Ŭ")
      Else If myPriorHotkey = "t4"   ; doppelakut
         BSUnicode("Ű")
      Else If myPriorHotkey = "c2"     ; caron 
         BSUnicode("Ů")
      Else If myPriorHotkey = "t2"     ; macron
         BSUnicode("Ū")
      Else If myPriorHotkey = "c3"    ; brevis 
         BSUnicode("Ŭ")
      Else If myPriorHotkey = "a4"   ; ogonek
         BSUnicode("Ų")
      Else If myPriorHotkey = "t1"      ; tilde
         BSUnicode("Ũ")
      Else
         sendinput {blind}U
   }
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return

*s::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If myPriorHotkey = "c1"          ; circumflex
         BSUnicode("î")
      Else If myPriorHotkey = "a1"      ; akut 
         BSUnicode("í")
      Else If myPriorHotkey = "a2"     ; grave
         BSUnicode("ì")
      Else If myPriorHotkey = "t3"   ; Diaerese
         Send, {bs}�
      Else If myPriorHotkey = "t2"    ; macron
         BSUnicode("ī")
      Else If myPriorHotkey = "c3"   ; brevis
         BSUnicode("ĭ")
      Else If myPriorHotkey = "a4"  ; ogonek
         BSUnicode("į")
      Else If myPriorHotkey = "t1"     ; tilde
         BSUnicode("ĩ")
      Else If myPriorHotkey = "a5" ; (ohne) punkt dar�ber 
         BSUnicode("ı")
      Else 
         sendinput {blind}i
   }
   else if Ebene = 2
   {   
      If myPriorHotkey = "c1"           ; circumflex
         BSUnicode("Î")
      Else If myPriorHotkey = "a1"      ; akut 
         BSUnicode("Í")
      Else If myPriorHotkey = "a2"     ; grave
         BSUnicode("Ì")
      Else If myPriorHotkey = "t3"    ; Diaerese
         Send, {bs}�
      Else If myPriorHotkey = "t2"     ; macron
         BSUnicode("Ī")
      Else If myPriorHotkey = "c3"    ; brevis 
         BSUnicode("Ĭ")
      Else If myPriorHotkey = "a4"   ; ogonek
         BSUnicode("Į")
      Else If myPriorHotkey = "t1"      ; tilde
         BSUnicode("Ĩ")
      Else If myPriorHotkey = "a5"  ; punkt dar�ber 
         BSUnicode("İ")
      Else 
         sendinput {blind}I
   }
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return

*d::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If myPriorHotkey = "c1"           ; circumflex
         BSUnicode("â")
      Else If myPriorHotkey = "a1"      ; akut 
         BSUnicode("á")
      Else If myPriorHotkey = "a2"     ; grave
         BSUnicode("à")
      Else If myPriorHotkey = "t3"    ; Diaerese
         send {bs}�
      Else If myPriorHotkey = "a6" ; Ring 
         Send {bs}�
      Else If myPriorHotkey = "t1"      ; tilde
         BSUnicode("ã")
      Else If myPriorHotkey = "a4"   ; ogonek
         BSUnicode("ą")
      Else If myPriorHotkey = "t2"     ; macron
         BSUnicode("ā")
      Else If myPriorHotkey = "c3"    ; brevis
         BSUnicode("ă")
      Else 
         sendinput {blind}a
   }
   else if Ebene = 2
   {
      If myPriorHotkey = "c1"            ; circumflex
         BSUnicode("Â")
      Else If myPriorHotkey = "a1"       ; akut 
         BSUnicode("Á")
      Else If myPriorHotkey = "a2"      ; grave
         BSUnicode("À")
      Else If myPriorHotkey = "t3"     ; Diaerese
         send {bs}�
      Else If myPriorHotkey = "t1"       ; tilde
         BSUnicode("Ã")
      Else If myPriorHotkey = "a6"  ; Ring 
         Send {bs}�
      Else If myPriorHotkey = "t2"      ; macron
         BSUnicode("Ā")
      Else If myPriorHotkey = "c3"     ; brevis 
         BSUnicode("Ă")
      Else If myPriorHotkey = "a4"    ; ogonek
         BSUnicode("Ą")
      Else 
         sendinput {blind}A
   }
      
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return

*f::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If myPriorHotkey = "c1"          ; circumflex
         BSUnicode("ê")
      Else If myPriorHotkey = "a1"      ; akut 
         BSUnicode("é")
      Else If myPriorHotkey = "a2"     ; grave
         BSUnicode("è")
      Else If myPriorHotkey = "t3"   ; Diaerese
         Send, {bs}�
      Else If myPriorHotkey = "a4"  ; ogonek
         BSUnicode("ę")
      Else If myPriorHotkey = "t2"    ; macron
         BSUnicode("ē")
      Else If myPriorHotkey = "c3"   ; brevis
         BSUnicode("ĕ")
      Else If myPriorHotkey = "c2"    ; caron
         BSUnicode("ě")
      Else If myPriorHotkey = "a5" ; punkt dar�ber 
         BSUnicode("ė")
      Else 
         sendinput {blind}e
   }
   else if Ebene = 2
   {
      If myPriorHotkey = "c1"           ; circumflex
         BSUnicode("Ê")
      Else If myPriorHotkey = "a1"      ; akut 
         BSUnicode("É")
      Else If myPriorHotkey = "a2"     ; grave
         BSUnicode("È")
      Else If myPriorHotkey = "t3"    ; Diaerese
         Send, {bs}�
      Else If myPriorHotkey = "c2"     ; caron
         BSUnicode("Ě")
      Else If myPriorHotkey = "t2"     ; macron
         BSUnicode("Ē")
      Else If myPriorHotkey = "c3"    ; brevis 
         BSUnicode("Ĕ")
      Else If myPriorHotkey = "a4"   ; ogonek 
         BSUnicode("Ę")
      Else If myPriorHotkey = "a5"  ; punkt dar�ber 
         BSUnicode("Ė")
      Else 
         sendinput {blind}E
   }
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return

*g::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If myPriorHotkey = "c1"           ; circumflex
         BSUnicode("ô")
      Else If myPriorHotkey = "a1"      ; akut 
         BSUnicode("ó")
      Else If myPriorHotkey = "a2"     ; grave
         BSUnicode("ò")
      Else If myPriorHotkey = "t3"    ; Diaerese
         Send, {bs}�
      Else If myPriorHotkey = "t1"      ; tilde
         BSUnicode("õ")
      Else If myPriorHotkey = "t4"   ; doppelakut
         BSUnicode("ő")
      Else If myPriorHotkey = "t5"  ; Schr�gstrich
         BSUnicode("ø")
      Else If myPriorHotkey = "t2"     ; macron
         BSUnicode("ō")
      Else If myPriorHotkey = "c3"    ; brevis 
         BSUnicode("ŏ")
      Else 
         sendinput {blind}o
   }
   else if Ebene = 2
   {
      If myPriorHotkey = "c1"           ; circumflex
         BSUnicode("Ô")
      Else If myPriorHotkey = "a1"      ; akut 
         BSUnicode("Ó")
      Else If myPriorHotkey = "a2"     ; grave
         BSUnicode("Ò")
      Else If myPriorHotkey = "t5"  ; Schr�gstrich
         BSUnicode("Ø")
      Else If myPriorHotkey = "t1"      ; tilde
         BSUnicode("Õ")
      Else If myPriorHotkey = "t4"   ; doppelakut
         BSUnicode("Ő")
      Else If myPriorHotkey = "t3"    ; Diaerese
         send {bs}�
      Else If myPriorHotkey = "t2"     ; macron 
         BSUnicode("Ō")
      Else If myPriorHotkey = "c3"    ; brevis 
         BSUnicode("Ŏ")
      Else
         sendinput {blind}O
   }
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return

*h::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If myPriorHotkey = "c1"           ; circumflex
         BSUnicode("ŝ")
      Else If myPriorHotkey = "a1"      ; akut 
         BSUnicode("ś")
      Else If myPriorHotkey = "c2"     ; caron
         BSUnicode("š")
      Else If myPriorHotkey = "a3"    ; cedilla
         BSUnicode("ş")
      Else If myPriorHotkey = "a5"  ; punkt dar�ber 
         BSUnicode("ṡ")
      Else If myPriorHotkey = "c6" ; punkt darunter 
         BSUnicode("ṣ")
      Else   
         sendinput {blind}s
   }
   else if Ebene = 2
   {
      If myPriorHotkey = "c1"           ; circumflex
         BSUnicode("Ŝ")
      Else If myPriorHotkey = "c2"     ; caron
         BSUnicode("Š")
      Else If myPriorHotkey = "a1"      ; akut 
         BSUnicode("Ś")
      Else If myPriorHotkey = "a3"    ; cedilla 
         BSUnicode("Ş")
      Else If myPriorHotkey = "a5"  ; punkt dar�ber 
         BSUnicode("�")
      Else If myPriorHotkey = "c6" ; punkt darunter 
         BSUnicode("Ṣ")
      Else
         sendinput {blind}S
   }
      
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return

*j::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If myPriorHotkey = "a1"          ; akut
         BSUnicode("ń")
      Else If myPriorHotkey = "t1"     ; tilde
         BSUnicode("ñ")
      Else If myPriorHotkey = "c2"    ; caron
         BSUnicode("ň")
      Else If myPriorHotkey = "a3"   ; cedilla
         BSUnicode("ņ")
      Else If myPriorHotkey = "a5" ; punkt dar�ber 
         BSUnicode("ṅ")
      Else
         sendinput {blind}n
   }
   else if Ebene = 2
   {
      If myPriorHotkey = "c2"         ; caron
         BSUnicode("Ň")
      Else If myPriorHotkey = "t1"     ; tilde
         BSUnicode("Ñ")
      Else If myPriorHotkey = "a1"     ; akut 
         BSUnicode("Ń")
      Else If myPriorHotkey = "a3"   ; cedilla 
         BSUnicode("Ņ")
      Else If myPriorHotkey = "a5" ; punkt dar�ber 
         BSUnicode("Ṅ")
      Else
         sendinput {blind}N
   }
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return

*k::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If myPriorHotkey = "a1"           ; akut 
         BSUnicode("ŕ")
      Else If myPriorHotkey = "c2"     ; caron
         BSUnicode("ř")
      Else If myPriorHotkey = "a3"    ; cedilla
         BSUnicode("ŗ")
      Else If myPriorHotkey = "a5"  ; punkt dar�ber 
         BSUnicode("ṙ")
      Else If myPriorHotkey = "c6" ; punkt darunter 
         BSUnicode("ṛ")
      Else 
         sendinput {blind}r
   }
   else if Ebene = 2
   {
      If myPriorHotkey = "c2"          ; caron
         BSUnicode("Ř")
      Else If myPriorHotkey = "a1"      ; akut 
         BSUnicode("Ŕ")
      Else If myPriorHotkey = "a3"    ; cedilla 
         BSUnicode("Ŗ")
      Else If myPriorHotkey = "a5"  ; punkt dar�ber 
         BSUnicode("Ṙ")
      Else If myPriorHotkey = "c6" ; punkt darunter 
         BSUnicode("Ṛ")
      Else 
         sendinput {blind}R
   }
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return

*l::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If myPriorHotkey = "c2"          ; caron 
         BSUnicode("ť")
      Else If myPriorHotkey = "a3"    ; cedilla
         BSUnicode("ţ")
      Else If myPriorHotkey = "c4"   ; Querstrich
         BSUnicode("ŧ")
      Else If myPriorHotkey = "a5"  ; punkt dar�ber 
         BSUnicode("ṫ")
      Else If myPriorHotkey = "c6" ; punkt darunter 
         BSUnicode("ṭ")
      Else 
         sendinput {blind}t
   }
   else if Ebene = 2
   {
      If myPriorHotkey = "c2"          ; caron
         BSUnicode("Ť")
      Else If myPriorHotkey = "a3"    ; cedilla 
         BSUnicode("Ţ")
      Else If myPriorHotkey = "c4"   ; Querstrich
         BSUnicode("Ŧ")
      Else If myPriorHotkey = "a5"  ; punkt dar�ber 
         BSUnicode("Ṫ")
      Else If myPriorHotkey = "c6" ; punkt darunter 
         BSUnicode("Ṭ")
      Else 
         sendinput {blind}T
   }
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return

*�::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If myPriorHotkey = "c4"        ; Querstrich
         BSUnicode("đ")
      Else If myPriorHotkey = "t5"  ; Schr�gstrich
         BSUnicode("ð")
      Else If myPriorHotkey = "c2"     ; caron
         BSUnicode("ď")
      Else If myPriorHotkey = "a5"  ; punkt dar�ber 
         BSUnicode("ḋ")
      Else If myPriorHotkey = "c6" ; punkt darunter 
         BSUnicode("ḍ")
      Else 
         sendinput {blind}d
   }
   else if Ebene = 2
   {
      If myPriorHotkey = "c4"        ; Querstrich
         BSUnicode("Đ")
      Else If myPriorHotkey = "t5"  ; Schr�gstrich
         BSUnicode("Ð")
      Else If myPriorHotkey = "c2"     ; caron 
         BSUnicode("Ď")
      Else If myPriorHotkey = "a5"  ; punkt dar�ber 
         BSUnicode("Ḋ")
      Else If myPriorHotkey = "c6" ; punkt darunter 
         BSUnicode("Ḍ")
      Else sendinput {blind}D
   }
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
    myPriorHotkey = ""
return

*�::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If myPriorHotkey = "t3"       ; Diaerese
         Send {bs}�
      Else If myPriorHotkey = "a1"      ; akut 
         BSUnicode("ý")
      Else If myPriorHotkey = "c1"    ; circumflex
         BSUnicode("ŷ")
      Else
         sendinput {blind}y
   }
   else if Ebene = 2
   {
      If myPriorHotkey = "a1"           ; akut 
         BSUnicode("Ý")
      Else If myPriorHotkey = "t3"    ; Diaerese
         Send {bs}�
      Else If myPriorHotkey = "c1"      ; circumflex
         BSUnicode("Ŷ")
      Else
         sendinput {blind}Y
   }
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
   myPriorHotkey = ""
return

;SC02B (#) wird zu Mod3

;SC056 (<) wird zu Mod5
*y::
   EbeneAktualisieren()
   if Ebene = 1
      sendinput {blind}�
   else if Ebene = 2
      sendinput {blind}�
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
   myPriorHotkey = ""
return

*x::
   EbeneAktualisieren()
   if Ebene = 1
      sendinput {blind}�
   else if Ebene = 2
      sendinput {blind}�
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
   myPriorHotkey = ""
return

*c::
   EbeneAktualisieren()
   if Ebene = 1
      sendinput {blind}�
   else if Ebene = 2
      sendinput {blind}�
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
   myPriorHotkey = ""
return

*v::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If myPriorHotkey = "a5"      ; punkt dar�ber 
         BSUnicode("ṗ")
      Else
         sendinput {blind}p
   }
   else if Ebene = 2
   {
      If myPriorHotkey = "a5"      ; punkt dar�ber 
         BSUnicode("Ṗ")
      Else 
         sendinput {blind}P
   }
      
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
   myPriorHotkey = ""
return

*b::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If myPriorHotkey = "c2"         ; caron
         BSUnicode("ž")
      Else If myPriorHotkey = "a1"     ; akut
         BSUnicode("ź")
      Else If myPriorHotkey = "a5" ; punkt dr�ber
         BSUnicode("ż")
      Else If myPriorHotkey = "a5" ; punkt dar�ber 
         BSUnicode("ż")
      Else 
         sendinput {blind}z
   }
   else if Ebene = 2
   {
      If myPriorHotkey = "c2"         ; caron  
         BSUnicode("Ž")
      Else If myPriorHotkey = "a1"     ; akut 
         BSUnicode("Ź")
      Else If myPriorHotkey = "a5" ; punkt dar�ber 
         BSUnicode("Ż")
      Else
         sendinput {blind}Z
   }
      
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
   myPriorHotkey = ""
return

*n::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If myPriorHotkey = "a5"      ; punkt dar�ber 
         BSUnicode("ḃ")
      Else 
         sendinput {blind}b
   }
   else if Ebene = 2
   {
      If myPriorHotkey = "a5"       ; punkt dar�ber 
         BSUnicode("Ḃ")
      Else 
         sendinput {blind}B
   }
      
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
   myPriorHotkey = ""
return

*m::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If myPriorHotkey = "a5"       ; punkt dar�ber 
         BSUnicode("ṁ")
      Else If myPriorHotkey = "c6" ; punkt darunter 
         BSUnicode("ṃ")
      Else 
         sendinput {blind}m
   }
   else if Ebene = 2
   {
      If myPriorHotkey = "a5"       ; punkt dar�ber 
         BSUnicode("Ṁ")
      Else If myPriorHotkey = "c6" ; punkt darunter 
         BSUnicode("Ṃ")
      Else 
         sendinput {blind}M
   }
      
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
   myPriorHotkey = ""
return

*,::
   EbeneAktualisieren()
   if Ebene = 1
      send `,
;   else if Ebene = 2
      
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
   myPriorHotkey = ""
return

*.::
   EbeneAktualisieren()
   if Ebene = 1
      send .
   else if Ebene = 2
      Unicode("…")  ; ellipse
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
   myPriorHotkey = ""
return


*-::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If myPriorHotkey = "c1"           ; circumflex
         BSUnicode("ĵ")
      Else
         sendinput {blind}j
   }
   else if Ebene = 2
   {
      If myPriorHotkey = "c1"            ; circumflex
         BSUnicode("Ĵ")
      Else
         sendinput {blind}J
   }
   ;else if Ebene = 3
      
   ;else if Ebene = 4
      
   ;else if Ebene = 5
      
   ;else if Ebene = 6
      
   myPriorHotkey = ""
return



; Funktionen
; ------------------------------------------------------


EbeneAktualisieren()
{
   global
   Ebene = 1

   ; ist Shift down?
   if ( GetKeyState("Shift","P") )
   {
      Ebene += 1
   }
   ; ist Mod3 down?
   if ( GetKeyState("CapsLock","P") or GetKeyState("#","P") )
   {
      Ebene += 2
   }
   ; ist Mod5 down? Mod3 hat Vorrang!
   else if ( GetKeyState("<","P") or GetKeyState("<^>!","P") )
   {
      Ebene += 4
   }
   
   return
}

Unicode(code)
{
   saved_clipboard := ClipboardAll
   Transform, Clipboard, Unicode, %code%
   send ^v
   Clipboard := saved_clipboard
}

BSUnicode(code)
{
   saved_clipboard := ClipboardAll
   Transform, Clipboard, Unicode, %code%
   send {bs}^v
   Clipboard := saved_clipboard
}