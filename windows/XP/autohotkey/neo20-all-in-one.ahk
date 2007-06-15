/*
    Titel:        NEO Autohotkey-Treiber
    Version:      0.05 beta
    Datum:        12.06.2007
    Basiert auf:  neo20.ahk und neo20-remap.ahk vom 25.05.2007
    
    TODO:         - ausgiebig testen...
                  - Men� des Tasksymbols
                  - Bessere L�sung f�r das leeren von PriorDeadKey finden, damit die Sondertasten
                    nicht mehr abgefangen werden m�ssen.
    
    Ideen:
                  - DeadKeys tot machen
                  - Symbol �ndern
                  - wenn m�glich, "sendinput {blind}" verwenden
                    (gibt es irgendwelche Probleme bei "sendinput {blind}" ?)
                  - bei Ebene 5 rechte Hand (Numpad) z.B. Numpad5 statt 5 senden
*/

; aus Nora's script kopiert:
#usehook on
#singleinstance force
#LTrim 
  ; Quelltext kann einger�ckt werden, 
  ; msgbox ist trotzdem linksb�ndig

SendMode Input
SetTitleMatchMode 2

;name    = NEO 2.0
;enable  = Aktiviere %name%
;disable = Deaktiviere %name%

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

/*
   Variablen initialisieren
*/

Ebene = 1
PriorDeadKey := ""


/*
   ------------------------------------------------------
   Modifier
   ------------------------------------------------------
*/

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

; KP_Decimal durch Mod5+Mod5
*<::
*SC138::
   if GetKeyState("<","P") and GetKeyState("SC138","P")
   {
      send {numpaddot}
   }
   return


/*
   Ablauf bei toten Tasten:
   1. Ebene Aktualisieren
   2. Abh�ngig von der Variablen "Ebene" Zeichen ausgeben und die Variable "PriorDeadKey" setzen
   
   Ablauf bei "lebenden" (sagt man das?) Tasten:
   1. Ebene Aktualisieren
   2. Abh�ngig von den Variablen "Ebene" und "PriorDeadKey" Zeichen ausgeben
   3. "PriorDeadKey" mit leerem String �berschreiben

   ------------------------------------------------------
   Reihe 1
   ------------------------------------------------------
*/

*^::
   EbeneAktualisieren()
   if Ebene = 1
   {
      Unicode("ˆ") ; circumflex, tot
      PriorDeadKey := "c1"
   }
   else if Ebene = 2
   {
      Unicode("ˇ")  ; caron, tot
      PriorDeadKey := "c2"
   }
   else if Ebene = 3
   {
      Unicode("˘")   ; brevis
      PriorDeadKey := "c3"
   }
   else if Ebene = 4
   {
      send - ; querstrich, tot
      PriorDeadKey := "c4"
   }
   else if Ebene = 5
   {
      Unicode("·")  ; Mittenpunkt, tot
      PriorDeadKey := "c5"
   }
   else if Ebene = 6
   {
      Send .         ; punkt darunter
      PriorDeadKey := "c6"
   }
return

*1::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")          ; circumflex 1
         BSUnicode("¹")
      Else
         send 1
   }
   else if Ebene = 2
      send �
   else if Ebene = 4
      send �
   else if Ebene = 5
      Unicode("⅛") ; 1/8
   PriorDeadKey := ""
return

*2::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")          ; circumflex 
         BSUnicode("²")
      Else
         send 2      
   }
   else if Ebene = 2
      send �
   else if Ebene = 4
      send �
   PriorDeadKey := ""
return

*3::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")          ; circumflex
         BSUnicode("³")
      Else
         send 3      
   }
   else if Ebene = 2
      send �
   else if Ebene = 4
      send �
   else if Ebene = 5
      Unicode("⅜") ; 3/8
   PriorDeadKey := ""
return

*4::
   EbeneAktualisieren()
   if Ebene = 1
      send 4
   else if Ebene = 2
      send $
   else if Ebene = 3
      send �
   else if Ebene = 4
      send �
   else if Ebene = 5
      Send {PgUp}    ; Prev
   else if Ebene = 6
      Send +{Prev}
   PriorDeadKey := ""
return

*5::
   EbeneAktualisieren()
   if Ebene = 1
      send 5
   else if Ebene = 2
      send �
   else if Ebene = 3
      send �
   else if Ebene = 4
      send �
   else if Ebene = 5
      Unicode("⅝") ; 5/8
   else if Ebene = 6
      Unicode("⇒") ; Implikation
   PriorDeadKey := ""
return

*6::
   EbeneAktualisieren()
   if Ebene = 1
      send 6
   else if Ebene = 2
      send �
   else if Ebene = 3
      send � 
   else if Ebene = 4
      send �
   else if Ebene = 6
      Unicode("⇔") ; �quivalenz
   PriorDeadKey := ""
return

*7::
   EbeneAktualisieren()
   if Ebene = 1
      send 7
   else if Ebene = 2
      send �
   else if Ebene = 3
      send �
   else if Ebene = 4
      send �
   else if Ebene = 5
      Unicode("⅞") ; 7/8
   PriorDeadKey := ""
return

*8::
   EbeneAktualisieren()
   if Ebene = 1
      send 8
   else if Ebene = 2
      send �
   else if Ebene = 3
      send �
   else if Ebene = 4
      send �
   else if Ebene = 5
      Send /
   else if Ebene = 6
      Unicode("∃") ; Existenzquantor
   PriorDeadKey := ""
return

*9::
   EbeneAktualisieren()
   if Ebene = 1
      send 9
   else if Ebene = 2
      send �
   else if Ebene = 3
      send �
   else if Ebene = 4
      send �
   else if Ebene = 5
      Send *
   else if Ebene = 6
      Unicode("∀") ; Allquantor
   PriorDeadKey := ""
return

*0::
   EbeneAktualisieren()
   if Ebene = 1
      send 0
   else if Ebene = 2
      send �
   else if Ebene = 3
      send �
   else if Ebene = 4
      send �
   else if Ebene = 5
      Send -
   else if Ebene = 6
      Send �
   PriorDeadKey := ""
return

*�::
   EbeneAktualisieren()
   if Ebene = 1
      send - ; Bind
   else if Ebene = 2
      Unicode("–") ; Ged
   else if Ebene = 3
      Unicode("—")
   else if Ebene = 4
      send �
   else if Ebene = 6
      Unicode("∨") ; logisch oder
   PriorDeadKey := ""
return

*�::
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {�}{space} ; akut, tot
      PriorDeadKey := "a1"
   }
   else if Ebene = 2
   {
      send ``{space}
      PriorDeadKey := "a2"
   }
   else if Ebene = 3
   {
      send � ; cedilla
      PriorDeadKey := "a3"
   }
   else if Ebene = 4
   {
      Unicode("˛") ; ogonek
      PriorDeadKey := "a4"
   }
   else if Ebene = 5
   {
      Unicode("˙") ; punkt oben dr�ber
      PriorDeadKey := "a5"
   }
   else if Ebene = 6
   {
      Unicode("˚")  ; ring obendrauf
      PriorDeadKey := "a6"
   }
return


/*
   ------------------------------------------------------
   Reihe 2
   ------------------------------------------------------
*/

*q::
   EbeneAktualisieren()
   if Ebene = 1
      sendinput {blind}x
   else if Ebene = 2
      sendinput {blind}X
   else if Ebene = 3
      send @
   else if Ebene = 4
      Unicode("ξ") ;xi
   else if Ebene = 6
      Unicode("Ξ")  ; Xi
   PriorDeadKey := ""
return


*w::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c6")      ; punkt darunter 
         BSUnicode("ṿ")
      Else
         sendinput {blind}v
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c6")      ; punkt darunter
         BSUnicode("Ṿ")
      Else 
         sendinput {blind}V
   }
   else if Ebene = 3
      send _
   else if Ebene = 5
      Send {Backspace}
   else if Ebene = 6
      Unicode("Λ")  ; Lambda
   PriorDeadKey := ""
return



*e::
   EbeneAktualisieren()
   if Ebene = 1
   { 
      If (PriorDeadKey = "t5")       ; Schr�gstrich
         BSUnicode("ł")
      Else If (PriorDeadKey = "a1")      ; akut 
         BSUnicode("ĺ")
      Else If (PriorDeadKey = "c2")     ; caron 
         BSUnicode("ľ")
      Else If (PriorDeadKey = "a3")    ; cedilla
         BSUnicode("ļ")
      Else If (PriorDeadKey = "c5")  ; Mittenpunkt
         BSUnicode("ŀ")
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSUnicode("ḷ")
      Else 
         sendinput {blind}l
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "a1")           ; akut 
         BSUnicode("Ĺ")
      Else If (PriorDeadKey = "c2")     ; caron 
         BSUnicode("Ľ")
      Else If (PriorDeadKey = "a3")    ; cedilla
         BSUnicode("Ļ")
      Else If (PriorDeadKey = "t5")  ; Schr�gstrich 
         BSUnicode("Ł")
      Else If (PriorDeadKey = "c5")  ; Mittenpunkt 
         BSUnicode("Ŀ")
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSUnicode("Ḷ")
      Else 
         sendinput {blind}L
   }      
   else if Ebene = 3
      send [
   else if Ebene = 4
      Unicode("λ") ;lambda
   else if Ebene = 5
      Sendinput {Blind}{Up}
   else if Ebene = 6
      Sendinput {Blind}+{Up}
   PriorDeadKey := ""
return


*r::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSUnicode("ĉ")
      Else If (PriorDeadKey = "c2")     ; caron
         BSUnicode("č")
      Else If (PriorDeadKey = "a1")      ; akut
         BSUnicode("ć")
      Else If (PriorDeadKey = "a3")    ; cedilla
         BSUnicode("ç")
      Else If (PriorDeadKey = "a5")  ; punkt dar�ber 
         BSUnicode("ċ")
      Else 
         sendinput {blind}c
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c1")          ; circumflex 
         BSUnicode("Ĉ")
      Else If (PriorDeadKey = "c2")    ; caron 
         BSUnicode("Č")
      Else If (PriorDeadKey = "a1")     ; akut 
         BSUnicode("Ć")
      Else If (PriorDeadKey = "a3")   ; cedilla 
         BSUnicode("Ç")
      Else If (PriorDeadKey = "a5") ; punkt dar�ber 
         BSUnicode("Ċ")
      Else 
         sendinput {blind}C
   }
   else if Ebene = 3
      send ]
   else if Ebene = 4
      Unicode("χ") ;chi
   else if Ebene = 5
      Send {Tab}
   else if Ebene = 6
      Send +{Tab}
   PriorDeadKey := ""
return

*t::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSUnicode("ŵ")
      Else
         sendinput {blind}w
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSUnicode("ŵ")
      Else
         sendinput {blind}W
   }
   else if Ebene = 3
      send {^}{space} ; untot
   else if Ebene = 5
      Send {Insert}
   else if Ebene = 6
      Send +{Insert}
   PriorDeadKey := ""
return

*z::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "a3")         ; cedilla
         BSUnicode("ķ")
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSUnicode("ḳ")
      Else
         sendinput {blind}k
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "a3")         ; cedilla 
         BSUnicode("Ķ")
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSUnicode("Ḳ")
      Else
         sendinput {blind}K
   }
   else if Ebene = 3
      sendraw !
   else if Ebene = 4
      Unicode("κ") ;kappa
   else if Ebene = 5
      Send �
   else if Ebene = 6
      Send �
   PriorDeadKey := ""
return

*u::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSUnicode("ĥ")
      Else If (PriorDeadKey = "c4")   ; Querstrich 
         BSUnicode("ħ")
      Else If (PriorDeadKey = "a5")  ; punkt dar�ber 
         BSUnicode("ḣ")
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSUnicode("ḥ")
      Else sendinput {blind}h
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSUnicode("Ĥ")
      Else If (PriorDeadKey = "c4")   ; Querstrich
         BSUnicode("Ħ")
      Else If (PriorDeadKey = "a5")  ; punkt dar�ber 
         BSUnicode("Ḣ")
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSUnicode("Ḥ")
      Else sendinput {blind}H
   }
   else if Ebene = 3
   {
      If (PriorDeadKey = "c4")    ; Querstrich
         BSUnicode("≤")
      Else
         send <
   }
   else if Ebene = 4
      Unicode("ψ") ;psi
   else if Ebene = 5
      Send 7
   else if Ebene = 6
      Unicode("Ψ")  ; Phi
   PriorDeadKey := ""
return

*i::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")          ; circumflex
         BSUnicode("ĝ")
      Else If (PriorDeadKey = "c3")   ; brevis
         BSUnicode("ğ")
      Else If (PriorDeadKey = "a3")   ; cedilla
         BSUnicode("ģ")
      Else If (PriorDeadKey = "a5") ; punkt dar�ber 
         BSUnicode("ġ")
      Else sendinput {blind}g
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSUnicode("Ĝ") 
      Else If (PriorDeadKey = "c3")    ; brevis 
         BSUnicode("Ğ")
      Else If (PriorDeadKey = "a3")    ; cedilla 
         BSUnicode("Ģ")
      Else If (PriorDeadKey = "a5")  ; punkt dar�ber 
         BSUnicode("Ġ")
      Else sendinput {blind}G
   }
   else if Ebene = 3
   {
      If (PriorDeadKey = "c4")    ; Querstrich
         BSUnicode("≥")
      Else
         send >
   }
   else if Ebene = 4
      Unicode("γ") ;gamma
   else if Ebene = 5
      Send 8
   else if Ebene = 6
      Unicode("Γ")  ; Gamma
   PriorDeadKey := ""
return

*o::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "t5")      ; durchgestrichen
         BSUnicode("ƒ")
      Else If (PriorDeadKey = "a5") ; punkt dar�ber 
         BSUnicode("ḟ")
      Else sendinput {blind}f
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "t5")       ; durchgestrichen
         BSUnicode("₣")
      Else If (PriorDeadKey = "a5")  ; punkt dar�ber 
         BSUnicode("Ḟ")
      Else sendinput {blind}F
   } 
   else if Ebene = 3
   {
      If (PriorDeadKey = "c1")            ; circumflex 
         BSUnicode("≙")
      Else If (PriorDeadKey = "t1")       ; tilde 
         BSUnicode("≅")
      Else If (PriorDeadKey = "t5")   ; Schr�gstrich 
         BSUnicode("≠")
      Else If (PriorDeadKey = "c4")    ; Querstrich
         BSUnicode("≡")
      Else If (PriorDeadKey = "c2")      ; caron 
         BSUnicode("≚")
      Else If (PriorDeadKey = "a6")  ; ring dr�ber 
         BSUnicode("≗")
         


/*
        was bedeutet dieser PriorHotkey?
*/

      Else If A_PriorHotkey = +1      ; Grad
         BSUnicode("≗")
      Else
         send `=
   }
   else if Ebene = 4
      Unicode("φ") ;phi
   else if Ebene = 5
      Send 9
   else if Ebene = 6
      Unicode("Φ")  ; Psi
   PriorDeadKey := ""
return

*p::
   EbeneAktualisieren()
   if Ebene = 1
      sendinput {blind}q
   else if Ebene = 2
      sendinput {blind}Q
   else if Ebene = 3
      send {&}
   else if Ebene = 5
      Send {+}
   else if Ebene = 6
      Unicode("∧") ; logisches Und
   PriorDeadKey := ""
return

*�::
   EbeneAktualisieren()
   if Ebene = 1
      sendinput {blind}�
   else if Ebene = 2
      Unicode("ẞ") ; versal-�
   else if Ebene = 3
      Unicode("ĳ")   ; ij
   else if Ebene = 4
      Unicode("Ĳ") ;IJ
   else if Ebene = 5
      Unicode("ə") ; schwa
   else if Ebene = 6
      Unicode("Ə")  ; Schwa
   PriorDeadKey := ""
return


*+::
   EbeneAktualisieren()
   if Ebene = 1
   {
      Unicode("˜")    ; tilde, tot 
      PriorDeadKey := "t1"
   }
   else if Ebene = 2
   {
      Unicode("ˉ")  ; macron, tot
      PriorDeadKey := "t2"
   }
   else if Ebene = 3
   {
      Unicode("¨")   ; Diaerese
      PriorDeadKey := "t3"
   }
   else if Ebene = 4
   {
      send "        ;doppelakut
      PriorDeadKey := "t4"
   }
   else if Ebene = 5
   {
      Unicode("/")  ; Schr�gstrich, tot
      PriorDeadKey := "t5"
   }
   else if Ebene = 6
   {
      Unicode("ˏ")  ; komma drunter, tot
      PriorDeadKey := "t6"
   }
return


/*
   ------------------------------------------------------
   Reihe 3
   ------------------------------------------------------
*/

*a::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSUnicode("û")
      Else If (PriorDeadKey = "a1")      ; akut 
         BSUnicode("ú")
      Else If (PriorDeadKey = "a2")     ; grave
         BSUnicode("ù")
      Else If (PriorDeadKey = "t3")    ; Diaerese
         Send, {bs}�
      Else If (PriorDeadKey = "t4")   ; doppelakut 
         BSUnicode("ű")
      Else If (PriorDeadKey = "c3")    ; brevis
         BSUnicode("ŭ")
      Else If (PriorDeadKey = "t2")     ; macron
         BSUnicode("ū")
      Else If (PriorDeadKey = "a4")   ; ogonek
         BSUnicode("ų")
      Else If (PriorDeadKey = "a6") ; Ring
         BSUnicode("ů")
      Else If (PriorDeadKey = "t1")      ; tilde
         BSUnicode("ũ")
      Else
         sendinput {blind}u
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSUnicode("Û")
      Else If (PriorDeadKey = "a1")      ; akut 
         BSUnicode("Ú")
      Else If (PriorDeadKey = "a2")     ; grave
         BSUnicode("Ù")
      Else If (PriorDeadKey = "t3")    ; Diaerese
         Send, {bs}�
      Else If (PriorDeadKey = "a6") ; Ring
         BSUnicode("Ů")
      Else If (PriorDeadKey = "c3")    ; brevis
         BSUnicode("Ŭ")
      Else If (PriorDeadKey = "t4")   ; doppelakut
         BSUnicode("Ű")
      Else If (PriorDeadKey = "c2")     ; caron 
         BSUnicode("Ů")
      Else If (PriorDeadKey = "t2")     ; macron
         BSUnicode("Ū")
      Else If (PriorDeadKey = "c3")    ; brevis 
         BSUnicode("Ŭ")
      Else If (PriorDeadKey = "a4")   ; ogonek
         BSUnicode("Ų")
      Else If (PriorDeadKey = "t1")      ; tilde
         BSUnicode("Ũ")
      Else
         sendinput {blind}U
   }
   else if Ebene = 3
      send \
   else if Ebene = 5
      Send {Home}
   else if Ebene = 6
      Send +{Home}
   PriorDeadKey := ""
return

*s::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")          ; circumflex
         BSUnicode("î")
      Else If (PriorDeadKey = "a1")      ; akut 
         BSUnicode("í")
      Else If (PriorDeadKey = "a2")     ; grave
         BSUnicode("ì")
      Else If (PriorDeadKey = "t3")   ; Diaerese
         Send, {bs}�
      Else If (PriorDeadKey = "t2")    ; macron
         BSUnicode("ī")
      Else If (PriorDeadKey = "c3")   ; brevis
         BSUnicode("ĭ")
      Else If (PriorDeadKey = "a4")  ; ogonek
         BSUnicode("į")
      Else If (PriorDeadKey = "t1")     ; tilde
         BSUnicode("ĩ")
      Else If (PriorDeadKey = "a5") ; (ohne) punkt dar�ber 
         BSUnicode("ı")
      Else 
         sendinput {blind}i
   }
   else if Ebene = 2
   {   
      If (PriorDeadKey = "c1")           ; circumflex
         BSUnicode("Î")
      Else If (PriorDeadKey = "a1")      ; akut 
         BSUnicode("Í")
      Else If (PriorDeadKey = "a2")     ; grave
         BSUnicode("Ì")
      Else If (PriorDeadKey = "t3")    ; Diaerese
         Send, {bs}�
      Else If (PriorDeadKey = "t2")     ; macron
         BSUnicode("Ī")
      Else If (PriorDeadKey = "c3")    ; brevis 
         BSUnicode("Ĭ")
      Else If (PriorDeadKey = "a4")   ; ogonek
         BSUnicode("Į")
      Else If (PriorDeadKey = "t1")      ; tilde
         BSUnicode("Ĩ")
      Else If (PriorDeadKey = "a5")  ; punkt dar�ber 
         BSUnicode("İ")
      Else 
         sendinput {blind}I
   }
   else if Ebene = 3
      send `/
   else if Ebene = 4
      Unicode("ι") ;iota
   else if Ebene = 5
      Sendinput {Blind}{Left}
   else if Ebene = 6
      Sendinput {Blind}+{Left}
   PriorDeadKey := ""
return

*d::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSUnicode("â")
      Else If (PriorDeadKey = "a1")      ; akut 
         BSUnicode("á")
      Else If (PriorDeadKey = "a2")     ; grave
         BSUnicode("à")
      Else If (PriorDeadKey = "t3")    ; Diaerese
         send {bs}�
      Else If (PriorDeadKey = "a6") ; Ring 
         Send {bs}�
      Else If (PriorDeadKey = "t1")      ; tilde
         BSUnicode("ã")
      Else If (PriorDeadKey = "a4")   ; ogonek
         BSUnicode("ą")
      Else If (PriorDeadKey = "t2")     ; macron
         BSUnicode("ā")
      Else If (PriorDeadKey = "c3")    ; brevis
         BSUnicode("ă")
      Else 
         sendinput {blind}a
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c1")            ; circumflex
         BSUnicode("Â")
      Else If (PriorDeadKey = "a1")       ; akut 
         BSUnicode("Á")
      Else If (PriorDeadKey = "a2")      ; grave
         BSUnicode("À")
      Else If (PriorDeadKey = "t3")     ; Diaerese
         send {bs}�
      Else If (PriorDeadKey = "t1")       ; tilde
         BSUnicode("Ã")
      Else If (PriorDeadKey = "a6")  ; Ring 
         Send {bs}�
      Else If (PriorDeadKey = "t2")      ; macron
         BSUnicode("Ā")
      Else If (PriorDeadKey = "c3")     ; brevis 
         BSUnicode("Ă")
      Else If (PriorDeadKey = "a4")    ; ogonek
         BSUnicode("Ą")
      Else 
         sendinput {blind}A
   }
   else if Ebene = 3
      sendraw {
   else if Ebene = 4
      Unicode("α") ;alpha
   else if Ebene = 5
      Sendinput {Blind}{Down}
   else if Ebene = 6
      Sendinput {Blind}+{Down}
   PriorDeadKey := ""
return

*f::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")          ; circumflex
         BSUnicode("ê")
      Else If (PriorDeadKey = "a1")      ; akut 
         BSUnicode("é")
      Else If (PriorDeadKey = "a2")     ; grave
         BSUnicode("è")
      Else If (PriorDeadKey = "t3")   ; Diaerese
         Send, {bs}�
      Else If (PriorDeadKey = "a4")  ; ogonek
         BSUnicode("ę")
      Else If (PriorDeadKey = "t2")    ; macron
         BSUnicode("ē")
      Else If (PriorDeadKey = "c3")   ; brevis
         BSUnicode("ĕ")
      Else If (PriorDeadKey = "c2")    ; caron
         BSUnicode("ě")
      Else If (PriorDeadKey = "a5") ; punkt dar�ber 
         BSUnicode("ė")
      Else 
         sendinput {blind}e
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSUnicode("Ê")
      Else If (PriorDeadKey = "a1")      ; akut 
         BSUnicode("É")
      Else If (PriorDeadKey = "a2")     ; grave
         BSUnicode("È")
      Else If (PriorDeadKey = "t3")    ; Diaerese
         Send, {bs}�
      Else If (PriorDeadKey = "c2")     ; caron
         BSUnicode("Ě")
      Else If (PriorDeadKey = "t2")     ; macron
         BSUnicode("Ē")
      Else If (PriorDeadKey = "c3")    ; brevis 
         BSUnicode("Ĕ")
      Else If (PriorDeadKey = "a4")   ; ogonek 
         BSUnicode("Ę")
      Else If (PriorDeadKey = "a5")  ; punkt dar�ber 
         BSUnicode("Ė")
      Else 
         sendinput {blind}E
   }
   else if Ebene = 3
      sendraw }
   else if Ebene = 4
      Unicode("ε") ;epsilon
   else if Ebene = 5
      Sendinput {Blind}{Right}
   else if Ebene = 6
      Sendinput {Blind}+{Right}
   PriorDeadKey := ""
return

*g::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSUnicode("ô")
      Else If (PriorDeadKey = "a1")      ; akut 
         BSUnicode("ó")
      Else If (PriorDeadKey = "a2")     ; grave
         BSUnicode("ò")
      Else If (PriorDeadKey = "t3")    ; Diaerese
         Send, {bs}�
      Else If (PriorDeadKey = "t1")      ; tilde
         BSUnicode("õ")
      Else If (PriorDeadKey = "t4")   ; doppelakut
         BSUnicode("ő")
      Else If (PriorDeadKey = "t5")  ; Schr�gstrich
         BSUnicode("ø")
      Else If (PriorDeadKey = "t2")     ; macron
         BSUnicode("ō")
      Else If (PriorDeadKey = "c3")    ; brevis 
         BSUnicode("ŏ")
      Else 
         sendinput {blind}o
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSUnicode("Ô")
      Else If (PriorDeadKey = "a1")      ; akut 
         BSUnicode("Ó")
      Else If (PriorDeadKey = "a2")     ; grave
         BSUnicode("Ò")
      Else If (PriorDeadKey = "t5")  ; Schr�gstrich
         BSUnicode("Ø")
      Else If (PriorDeadKey = "t1")      ; tilde
         BSUnicode("Õ")
      Else If (PriorDeadKey = "t4")   ; doppelakut
         BSUnicode("Ő")
      Else If (PriorDeadKey = "t3")    ; Diaerese
         send {bs}�
      Else If (PriorDeadKey = "t2")     ; macron 
         BSUnicode("Ō")
      Else If (PriorDeadKey = "c3")    ; brevis 
         BSUnicode("Ŏ")
      Else
         sendinput {blind}O
   }
   else if Ebene = 3
      send *
   else if Ebene = 4
      Unicode("ω") ;omega
   else if Ebene = 5
      Send {End}
   else if Ebene = 6
      Send +{End}
   PriorDeadKey := ""
return

*h::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSUnicode("ŝ")
      Else If (PriorDeadKey = "a1")      ; akut 
         BSUnicode("ś")
      Else If (PriorDeadKey = "c2")     ; caron
         BSUnicode("š")
      Else If (PriorDeadKey = "a3")    ; cedilla
         BSUnicode("ş")
      Else If (PriorDeadKey = "a5")  ; punkt dar�ber 
         BSUnicode("ṡ")
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSUnicode("ṣ")
      Else   
         sendinput {blind}s
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSUnicode("Ŝ")
      Else If (PriorDeadKey = "c2")     ; caron
         BSUnicode("Š")
      Else If (PriorDeadKey = "a1")      ; akut 
         BSUnicode("Ś")
      Else If (PriorDeadKey = "a3")    ; cedilla 
         BSUnicode("Ş")
      Else If (PriorDeadKey = "a5")  ; punkt dar�ber 
         BSUnicode("�")
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSUnicode("Ṣ")
      Else
         sendinput {blind}S
   }
   else if Ebene = 3
      send ?
   else if Ebene = 4
      Unicode("σ") ;sigma
   else if Ebene = 5
      Send �
   else if Ebene = 6
      Unicode("Σ")  ; Sigma
   PriorDeadKey := ""
return

*j::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "a1")          ; akut
         BSUnicode("ń")
      Else If (PriorDeadKey = "t1")     ; tilde
         BSUnicode("ñ")
      Else If (PriorDeadKey = "c2")    ; caron
         BSUnicode("ň")
      Else If (PriorDeadKey = "a3")   ; cedilla
         BSUnicode("ņ")
      Else If (PriorDeadKey = "a5") ; punkt dar�ber 
         BSUnicode("ṅ")
      Else
         sendinput {blind}n
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c2")         ; caron
         BSUnicode("Ň")
      Else If (PriorDeadKey = "t1")     ; tilde
         BSUnicode("Ñ")
      Else If (PriorDeadKey = "a1")     ; akut 
         BSUnicode("Ń")
      Else If (PriorDeadKey = "a3")   ; cedilla 
         BSUnicode("Ņ")
      Else If (PriorDeadKey = "a5") ; punkt dar�ber 
         BSUnicode("Ṅ")
      Else
         sendinput {blind}N
   }
   else if Ebene = 3
      send (
   else if Ebene = 4
      Unicode("ν") ;nu
   else if Ebene = 5
      Send 4
   else if Ebene = 6
      Unicode("№") ; No
   PriorDeadKey := ""
return

*k::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "a1")           ; akut 
         BSUnicode("ŕ")
      Else If (PriorDeadKey = "c2")     ; caron
         BSUnicode("ř")
      Else If (PriorDeadKey = "a3")    ; cedilla
         BSUnicode("ŗ")
      Else If (PriorDeadKey = "a5")  ; punkt dar�ber 
         BSUnicode("ṙ")
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSUnicode("ṛ")
      Else 
         sendinput {blind}r
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c2")          ; caron
         BSUnicode("Ř")
      Else If (PriorDeadKey = "a1")      ; akut 
         BSUnicode("Ŕ")
      Else If (PriorDeadKey = "a3")    ; cedilla 
         BSUnicode("Ŗ")
      Else If (PriorDeadKey = "a5")  ; punkt dar�ber 
         BSUnicode("Ṙ")
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSUnicode("Ṛ")
      Else 
         sendinput {blind}R
   }
   else if Ebene = 3
      send )
   else if Ebene = 4
      Unicode("ρ") ;rho
   else if Ebene = 5
      Send 5
   else if Ebene = 6
      Unicode("®")  ; (R)
   PriorDeadKey := ""
return

*l::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c2")          ; caron 
         BSUnicode("ť")
      Else If (PriorDeadKey = "a3")    ; cedilla
         BSUnicode("ţ")
      Else If (PriorDeadKey = "c4")   ; Querstrich
         BSUnicode("ŧ")
      Else If (PriorDeadKey = "a5")  ; punkt dar�ber 
         BSUnicode("ṫ")
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSUnicode("ṭ")
      Else 
         sendinput {blind}t
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c2")          ; caron
         BSUnicode("Ť")
      Else If (PriorDeadKey = "a3")    ; cedilla 
         BSUnicode("Ţ")
      Else If (PriorDeadKey = "c4")   ; Querstrich
         BSUnicode("Ŧ")
      Else If (PriorDeadKey = "a5")  ; punkt dar�ber 
         BSUnicode("Ṫ")
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSUnicode("Ṭ")
      Else 
         sendinput {blind}T
   }
   else if Ebene = 3
      send - ; Bind
   else if Ebene = 4
      Unicode("τ") ;tau
   else if Ebene = 5
      Send 6
   else if Ebene = 6
      Unicode("™") ; TM
   PriorDeadKey := ""
return

*�::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c4")        ; Querstrich
         BSUnicode("đ")
      Else If (PriorDeadKey = "t5")  ; Schr�gstrich
         BSUnicode("ð")
      Else If (PriorDeadKey = "c2")     ; caron
         BSUnicode("ď")
      Else If (PriorDeadKey = "a5")  ; punkt dar�ber 
         BSUnicode("ḋ")
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSUnicode("ḍ")
      Else 
         sendinput {blind}d
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c4")        ; Querstrich
         BSUnicode("Đ")
      Else If (PriorDeadKey = "t5")  ; Schr�gstrich
         BSUnicode("Ð")
      Else If (PriorDeadKey = "c2")     ; caron 
         BSUnicode("Ď")
      Else If (PriorDeadKey = "a5")  ; punkt dar�ber 
         BSUnicode("Ḋ")
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSUnicode("Ḍ")
      Else sendinput {blind}D
   }
   else if Ebene = 3
      send :
   else if Ebene = 4
      Unicode("δ") ;delta
   else if Ebene = 5
      Send `,
   else if Ebene = 6
      Unicode("Δ")  ; Delta
   PriorDeadKey := ""
return

*�::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "t3")       ; Diaerese
         Send {bs}�
      Else If (PriorDeadKey = "a1")      ; akut 
         BSUnicode("ý")
      Else If (PriorDeadKey = "c1")    ; circumflex
         BSUnicode("ŷ")
      Else
         sendinput {blind}y
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "a1")           ; akut 
         BSUnicode("Ý")
      Else If (PriorDeadKey = "t3")    ; Diaerese
         Send {bs}�
      Else If (PriorDeadKey = "c1")      ; circumflex
         BSUnicode("Ŷ")
      Else
         sendinput {blind}Y
   }
   else if Ebene = 4
      Unicode("υ") ;upsilon
   else if Ebene = 5
      Send �         ; thorn
   else if Ebene = 6
      Send �         ; Thorn
   PriorDeadKey := ""
return

;SC02B (#) wird zu Mod3


/*
   ------------------------------------------------------
   Reihe 4
   ------------------------------------------------------
*/

;SC056 (<) wird zu Mod5

*y::
   EbeneAktualisieren()
   if Ebene = 1
      sendinput {blind}�
   else if Ebene = 2
      sendinput {blind}�
   else if Ebene = 3
      send {#}
   else if Ebene = 5
      Send {Esc}
   PriorDeadKey := ""
return

*x::
   EbeneAktualisieren()
   if Ebene = 1
      sendinput {blind}�
   else if Ebene = 2
      sendinput {blind}�
   else if Ebene = 3
      send $
   else if Ebene = 5
      Send {Del}
   else if Ebene = 6
      Unicode("∫") ; Int
   PriorDeadKey := ""
return

*c::
   EbeneAktualisieren()
   if Ebene = 1
      sendinput {blind}�
   else if Ebene = 2
      sendinput {blind}�
   else if Ebene = 3
      send |
   else if Ebene = 4
      Unicode("η") ;eta
   else if Ebene = 5
      Send {PgDn}    ; Next
   else if Ebene = 6
      Send +{PgDn}
   PriorDeadKey := ""
return

*v::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "a5")      ; punkt dar�ber 
         BSUnicode("ṗ")
      Else
         sendinput {blind}p
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "a5")      ; punkt dar�ber 
         BSUnicode("Ṗ")
      Else 
         sendinput {blind}P
   }
   else if Ebene = 3
   {
      If (PriorDeadKey = "t1")    ; tilde
         BSUnicode("≈")
      Else
         sendraw ~
   }      
   else if Ebene = 4
      Unicode("π") ;pi
   else if Ebene = 5
      Send {Enter}
   else if Ebene = 6
      Unicode("Π")  ; Pi
   PriorDeadKey := ""
return

*b::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c2")         ; caron
         BSUnicode("ž")
      Else If (PriorDeadKey = "a1")     ; akut
         BSUnicode("ź")
      Else If (PriorDeadKey = "a5") ; punkt dr�ber
         BSUnicode("ż")
      Else If (PriorDeadKey = "a5") ; punkt dar�ber 
         BSUnicode("ż")
      Else 
         sendinput {blind}z
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c2")         ; caron  
         BSUnicode("Ž")
      Else If (PriorDeadKey = "a1")     ; akut 
         BSUnicode("Ź")
      Else If (PriorDeadKey = "a5") ; punkt dar�ber 
         BSUnicode("Ż")
      Else
         sendinput {blind}Z
   }
   else if Ebene = 3
      send ``{space} ; untot
   else if Ebene = 4
      Unicode("ζ") ;zeta
   else if Ebene = 6
      Unicode("Ω")  ; Omega
   PriorDeadKey := ""
return

*n::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "a5")      ; punkt dar�ber 
         BSUnicode("ḃ")
      Else 
         sendinput {blind}b
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "a5")       ; punkt dar�ber 
         BSUnicode("Ḃ")
      Else 
         sendinput {blind}B
   }
   else if Ebene = 3
      send {+}
   else if Ebene = 4
      Unicode("β") ;beta
   else if Ebene = 5
      Unicode("∞") ;infty
   else if Ebene = 6
      Unicode("•") ; bullet
   PriorDeadKey := ""
return

*m::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "a5")       ; punkt dar�ber 
         BSUnicode("ṁ")
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSUnicode("ṃ")
      Else 
         sendinput {blind}m
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "a5")       ; punkt dar�ber 
         BSUnicode("Ṁ")
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSUnicode("Ṃ")
      Else 
         sendinput {blind}M
   }
   else if Ebene = 3
      send `%
   else if Ebene = 4
      Unicode("µ") ;micro, mu w�re μ
   else if Ebene = 5
      Send 1
   PriorDeadKey := ""
return

*,::
   EbeneAktualisieren()
   if Ebene = 1
      send `,
   else if Ebene = 3
      send '
   else if Ebene = 4
      Unicode("ϑ") ;vartheta?
   else if Ebene = 5
      Send 2
   else if Ebene = 6
      Unicode("√") ; sqrt
   PriorDeadKey := ""
return

*.::
   EbeneAktualisieren()
   if Ebene = 1
      send .
   else if Ebene = 2
      Unicode("…")  ; ellipse
   else if Ebene = 3
      send "
   else if Ebene = 4
      Unicode("θ") ;theta
   else if Ebene = 5
      Send 3
   else if Ebene = 6
      Unicode("Θ")  ; Theta
   PriorDeadKey := ""
return


*-::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSUnicode("ĵ")
      Else
         sendinput {blind}j
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c1")            ; circumflex
         BSUnicode("Ĵ")
      Else
         sendinput {blind}J
   }
   else if Ebene = 3
      send `;
   else if Ebene = 5
      Send .
   else if Ebene = 6
      Unicode("∇") ; Nabla
   PriorDeadKey := ""
return

/*
   ------------------------------------------------------
   Numpad
   ------------------------------------------------------

   folgende Tasten verhalten sich bei ein- und ausgeschaltetem
   NumLock gleich:
*/

*NumpadDiv::
   EbeneAktualisieren()
   if ( (Ebene = 1) or (Ebene = 2) )
      send {NumpadDiv}
   else if Ebene = 3
      send �
   else if ( (Ebene = 4) or (Ebene = 5) )
      Unicode("∕")   ; slash
   PriorDeadKey := ""
return

*NumpadMult::
   EbeneAktualisieren()
   if ( (Ebene = 1) or (Ebene = 2) )
      send {NumpadMult}
   else if Ebene = 3
      send �
   else if ( (Ebene = 4) or (Ebene = 5) )
      Unicode("⋅")  ; cdot
   PriorDeadKey := ""
return

*NumpadSub::
   EbeneAktualisieren()
   if ( (Ebene = 1) or (Ebene = 2) )
      send {NumpadSub}
   else if Ebene = 3
      send -
   PriorDeadKey := ""
return

*NumpadAdd::
   EbeneAktualisieren()
   if ( (Ebene = 1) or (Ebene = 2) )
      send {NumpadAdd}
   else if Ebene = 3
      send �
   else if ( (Ebene = 4) or (Ebene = 5) )
      Unicode("∓")   ; -+
   PriorDeadKey := ""
return

*NumpadEnter::
   EbeneAktualisieren()
   if ( (Ebene = 1) or (Ebene = 2) )
      send {NumpadEnter}      
   else if Ebene = 3
      Unicode("≠") ; neq
   else if ( (Ebene = 4) or (Ebene = 5) )
      Unicode("≈") ; approx
   PriorDeadKey := ""
return

/*
   folgende Tasten verhalten sich bei ein- und ausgeschaltetem NumLock
   unterschiedlich:

   bei NumLock ein
*/

*Numpad7::
   EbeneAktualisieren()
   if Ebene = 1
      send {Numpad7}
   else if Ebene = 2
      send {NumpadHome}
   else if ( (Ebene = 4) or (Ebene = 5) )
      Unicode("≪")  ; ll
   PriorDeadKey := ""
return

*Numpad8::
   EbeneAktualisieren()
   if Ebene = 1
      send {Numpad8}
   else if Ebene = 2
      send {NumpadUp}
   else if Ebene = 3
      Unicode("↑")     ; uparrow
   else if ( (Ebene = 4) or (Ebene = 5) )
      Unicode("∩")    ;
   PriorDeadKey := ""
return

*Numpad9::
   EbeneAktualisieren()
   if Ebene = 1
      send {Numpad9}
   else if Ebene = 2
      send {NumpadPgUp}
   else if ( (Ebene = 4) or (Ebene = 5) )
      Unicode("≫")  ; gg
   PriorDeadKey := ""
return

*Numpad4::
   EbeneAktualisieren()
   if Ebene = 1
      send {Numpad4}
   else if Ebene = 2
      send {NumpadLeft}
   else if Ebene = 3
      Unicode("←")     ; leftarrow
   else if ( (Ebene = 4) or (Ebene = 5) )
      Unicode("⊂")  ;
   PriorDeadKey := ""
return

*Numpad5::
   EbeneAktualisieren()
   if Ebene = 1
      send {Numpad5}
   else if Ebene = 2
      send {NumpadClear}
   else if Ebene = 3
      send �
   else if ( (Ebene = 4) or (Ebene = 5) )
      Unicode("∊") ;
   PriorDeadKey := ""
return

*Numpad6::
   EbeneAktualisieren()
   if Ebene = 1
      send {Numpad6}
   else if Ebene = 2
      send {NumpadRight}
   else if Ebene = 3
      Unicode("→")     ; rightarrow
   else if ( (Ebene = 4) or (Ebene = 5) )
      Unicode("⊃") ;
   PriorDeadKey := ""
return

*Numpad1::
   EbeneAktualisieren()
   if Ebene = 1
      send {Numpad1}
   else if Ebene = 2
      send {NumpadEnd}
   else if ( (Ebene = 4) or (Ebene = 5) )
      Unicode("≤")   ; leq
   PriorDeadKey := ""
return

*Numpad2::
   EbeneAktualisieren()
   if Ebene = 1
      send {Numpad2}
   else if Ebene = 2
      send {NumpadDown}
   else if Ebene = 3
      Unicode("↓")     ; downarrow
   else if ( (Ebene = 4) or (Ebene = 5) )
      Unicode("∪")  ;
   PriorDeadKey := ""
return

*Numpad3::
   EbeneAktualisieren()
   if Ebene = 1
      send {Numpad3}
   else if Ebene = 2
      send {NumpadPgDn}
   else if ( (Ebene = 4) or (Ebene = 5) )
      Unicode("≥")  ; geq
   PriorDeadKey := ""
return

*Numpad0::
   EbeneAktualisieren()
   if Ebene = 1
      send {Numpad0}
   else if Ebene = 2
      send {NumpadIns}
   else if Ebene = 3
      send `%
   else if ( (Ebene = 4) or (Ebene = 5) )
      send � 
   PriorDeadKey := ""
return

*NumpadDot::
   EbeneAktualisieren()
   if Ebene = 1
      send {NumpadDot}
   else if Ebene = 2
      send {NumpadDel}
   else if Ebene = 3
      send .
   else if ( (Ebene = 4) or (Ebene = 5) )
      send `,
   PriorDeadKey := ""
return

/*
   bei NumLock aus
*/

*NumpadHome::
   EbeneAktualisieren()
   if Ebene = 1
      send {NumpadHome}
   else if Ebene = 2
      send {Numpad7}
   else if ( (Ebene = 4) or (Ebene = 5) )
      Unicode("≪")  ; ll
   PriorDeadKey := ""
return

*NumpadUp::
   EbeneAktualisieren()
   if Ebene = 1
      send {NumpadUp}
   else if Ebene = 2
      send {Numpad8}
   else if Ebene = 3
      Unicode("↑")     ; uparrow
   else if ( (Ebene = 4) or (Ebene = 5) )
      Unicode("∩")    ;
   PriorDeadKey := ""
return

*NumpadPgUp::
   EbeneAktualisieren()
   if Ebene = 1
      send {NumpadPgUp}
   else if Ebene = 2
      send {Numpad9}
   else if ( (Ebene = 4) or (Ebene = 5) )
      Unicode("≫")  ; gg
   PriorDeadKey := ""
return

*NumpadLeft::
   EbeneAktualisieren()
   if Ebene = 1
      send {NumpadLeft}
   else if Ebene = 2
      send {Numpad4}
   else if Ebene = 3
      Unicode("←")     ; leftarrow
   else if ( (Ebene = 4) or (Ebene = 5) )
      Unicode("⊂")  ;
   PriorDeadKey := ""
return

*NumpadClear::
   EbeneAktualisieren()
   if Ebene = 1
      send {NumpadClear}
   else if Ebene = 2
      send {Numpad5}
   else if Ebene = 3
      send �
   else if ( (Ebene = 4) or (Ebene = 5) )
      Unicode("∊") ;
   PriorDeadKey := ""
return

*NumpadRight::
   EbeneAktualisieren()
   if Ebene = 1
      send {NumpadRight}
   else if Ebene = 2
      send {Numpad6}
   else if Ebene = 3
      Unicode("→")     ; rightarrow
   else if ( (Ebene = 4) or (Ebene = 5) )
      Unicode("⊃") ;
   PriorDeadKey := ""
return

*NumpadEnd::
   EbeneAktualisieren()
   if Ebene = 1
      send {NumpadEnd}
   else if Ebene = 2
      send {Numpad1}
   else if ( (Ebene = 4) or (Ebene = 5) )
      Unicode("≤")   ; leq
   PriorDeadKey := ""
return

*NumpadDown::
   EbeneAktualisieren()
   if Ebene = 1
      send {NumpadDown}
   else if Ebene = 2
      send {Numpad2}
   else if Ebene = 3
      Unicode("↓")     ; downarrow
   else if ( (Ebene = 4) or (Ebene = 5) )
      Unicode("∪")  ;
   PriorDeadKey := ""
return

*NumpadPgDn::
   EbeneAktualisieren()
   if Ebene = 1
      send {NumpadPgDn}
   else if Ebene = 2
      send {Numpad3}
   else if ( (Ebene = 4) or (Ebene = 5) )
      Unicode("≥")  ; geq
   PriorDeadKey := ""
return

*NumpadIns::
   EbeneAktualisieren()
   if Ebene = 1
      send {NumpadIns}
   else if Ebene = 2
      send {Numpad0}
   else if Ebene = 3
      send `%
   else if ( (Ebene = 4) or (Ebene = 5) )
      send � 
   PriorDeadKey := ""
return

*NumpadDel::
   EbeneAktualisieren()
   if Ebene = 1
      send {NumpadDel}
   else if Ebene = 2
      send {NumpadDot}
   else if Ebene = 3
      send .
   else if ( (Ebene = 4) or (Ebene = 5) )
      send `,
   PriorDeadKey := ""
return



/*
   ------------------------------------------------------
   Sondertasten
   ------------------------------------------------------
*/

*Space::
   EbeneAktualisieren()
   if Ebene = 4
      SendUnicodeChar(0x00A0)   ; gesch�tztes Leerzeichen
   else if Ebene = 5
      Send 0
   else if Ebene = 6
      SendUnicodeChar(0x2009) ; schmales Leerzeichen
   else
      Send {blind}{Space}
   PriorDeadKey := ""
return

/*
   Folgende Tasten sind nur aufgef�hrt, um PriorDeadKey zu leeren.
   Irgendwie sieht das noch nicht sch�n aus. Vielleicht l�sst sich dieses
   Problem irgendwie eleganter l�sen...
   
   Nachtrag:
   Weil es mit Alt+Tab Probleme gab, wird hier jetzt erstmal rumgeflickschustert,
   bis eine allgemeinere L�sung gefunden wurde.
*/

*Enter::
   sendinput {Blind}{Enter}
   PriorDeadKey := ""
return

*Backspace::
   sendinput {Blind}{Backspace}
   PriorDeadKey := ""
return



/*
Tab wurde rausgenommen, weil es Probleme mit AltTab und ShiftAltTab gab.
Allerdings kommt es jetzt zu komischen Ergebnissen, wenn man Tab nach
einem DeadKey dr�ckt...

*Tab::
   send {Blind}{Tab}
   PriorDeadKey := ""
return

*/

*Home::
   sendinput {Blind}{Home}
   PriorDeadKey := ""      
return

*End::
   sendinput {Blind}{End}
   PriorDeadKey := ""
return

*PgUp::
   sendinput {Blind}{PgUp}
   PriorDeadKey := ""
return

*PgDn::
   sendinput {Blind}{PgDn}
   PriorDeadKey := ""
return

*Up::
   sendinput {Blind}{Up}
   PriorDeadKey := ""
return

*Down::
   sendinput {Blind}{Down}
   PriorDeadKey := ""
return

*Left::
   sendinput {Blind}{Left}
   PriorDeadKey := ""
return

*Right::
   sendinput {Blind}{Right}
   PriorDeadKey := ""
return


/*
   ------------------------------------------------------
   Funktionen
   ------------------------------------------------------
*/

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
   else if ( GetKeyState("<","P") or GetKeyState("SC138","P") )
   {
      Ebene += 4
   }
   
   return
}

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

EncodeInteger(ref, val)
{
   DllCall("ntdll\RtlFillMemoryUlong", "Uint", ref, "Uint", 4, "Uint", val)
}


/*
   ------------------------------------------------------
   Shift+Pause "pausiert" das Script.
   ------------------------------------------------------
*/

+pause::suspend