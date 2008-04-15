/*
    Titel:        NEO 2.0 beta Autohotkey-Treiber
    $Revision$
    $Date$
    Autor:        Stefan Mayer <stm@neo-layout.org>
    Basiert auf:  neo20-all-in-one.ahk vom 29.06.2007
        
    TODO:         - ausgiebig testen...
                  - Menü des Tasksymbols
                  - Bessere Lösung für das leeren von PriorDeadKey finden, damit die Sondertasten
                    nicht mehr abgefangen werden müssen.
                  - Ebene 4 und 5 tauschen (im Programmcode, in der Doku ists schon)
                  - CapsLock auf 1. und 2. Ebene einbauen:
                    Die Buchstaben reagieren richtig auf CapsLock, da hier "sendinput {blind}"
                    verwendet wird. Bei anderen Tasten muss CapsLock in der ersten und zweiten Ebene
                    explizit abgefragt werden.
                    (Lässt sich das elegant in eine Funktion auslagern?)
                |------------------|
                | - Compose-Taste  |
                |------------------|
    Ideen:        - Symbol ändern (Neo-Logo abwarten)
                  - bei Ebene 4 rechte Hand (Numpad) z.B. Numpad5 statt 5 senden
    CHANGES:      - Kein Parsen über die Zwischenablage mehr
                  - Vista-kompatibel
                  - Ebene 6 über Mod3+Mod4
*/

; aus Noras script kopiert:
#usehook on
#singleinstance force
#LTrim 
  ; Quelltext kann eingerückt werden, 
  ; msgbox ist trotzdem linksbündig

SendMode Input
SetTitleMatchMode 2

;name    = NEO 2.0
;enable  = Aktiviere %name%
;disable = Deaktiviere %name%

; Überprüfung auf deutsches Tastaturlayout 
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
     `nÄndern Sie die Tastatureinstellung unter 
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

; KP_Decimal durch Mod4+Mod4
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
   2. Abhängig von der Variablen "Ebene" Zeichen ausgeben und die Variable "PriorDeadKey" setzen
   
   Ablauf bei "lebenden" (sagt man das?) Tasten:
   1. Ebene Aktualisieren
   2. Abhängig von den Variablen "Ebene" und "PriorDeadKey" Zeichen ausgeben
   3. "PriorDeadKey" mit leerem String überschreiben

   ------------------------------------------------------
   Reihe 1
   ------------------------------------------------------
*/

*^::
   EbeneAktualisieren()
   if Ebene = 1
   {
      SendUnicodeChar(0x02C6) ; circumflex, tot
      PriorDeadKey := "c1"
   }
   else if Ebene = 2
   {
      SendUnicodeChar(0x02C7)  ; caron, tot
      PriorDeadKey := "c2"
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x02D8)   ; brevis
      PriorDeadKey := "c3"
   }
   else if Ebene = 4
   {
      send - ; querstrich, tot
      PriorDeadKey := "c4"
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x00B7)  ; Mittenpunkt, tot
      PriorDeadKey := "c5"
   }
   else if Ebene = 7
   {
      Send .         ; punkt darunter (colon)
      PriorDeadKey := "c6"
   }
return

*1::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")          ; circumflex 1
         BSSendUnicodeChar(0x00B9)
      Else
         send {blind}1
   }
   else if Ebene = 2
      send °
   else if Ebene = 4
      SendUnicodeChar(0x2640) ; Piktogramm weiblich
   else if Ebene = 5
      SendUnicodeChar(0x2022) ; bullet
   else if Ebene = 7
      Send ¬
   PriorDeadKey := ""
return

*2::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")          ; circumflex 
         BSSendUnicodeChar(0x00B2)
      Else
         send {blind}2      
   }
   else if Ebene = 2
      SendUnicodeChar(0x2116) ; numero
   else if Ebene = 4
      SendUnicodeChar(0x26A5) ; Piktogramm Zwitter
   else if Ebene = 5
      SendUnicodeChar(0x2023) ; aufzaehlungspfeil
   else if Ebene = 7
      SendUnicodeChar(0x2228) ; logisch oder      
   PriorDeadKey := ""
return

*3::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x00B3)
      Else
         send {blind}3
   }
   else if Ebene = 2
      send §
   else if Ebene = 4
      SendUnicodeChar(0x2642) ; Piktogramm männlich
   else if Ebene = 7
      SendUnicodeChar(0x2227) ; logisch und
   PriorDeadKey := ""
return

*4::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x2074)
      Else
         send {blind}4
	}
   else if Ebene = 2
      send »
   else if Ebene = 3
      send ›
   else if Ebene = 5
      Send {PgUp}    ; Prev
   else if Ebene = 6
      Send +{Prev}
   else if Ebene = 7
      SendUnicodeChar(0x22A5)          ; Up Tack
   PriorDeadKey := ""
return

*5::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x2075)
      Else
         send {blind}5
	}
   else if Ebene = 2
      send «
   else if Ebene = 3
      send ‹
   else if Ebene = 7
      SendUnicodeChar(0x2221) ; gemessener Winkel
   PriorDeadKey := ""
return

*6::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x2076)
      Else
         send {blind}6
	}
   else if Ebene = 2
      send $
   else if Ebene = 3
      send £
   else if Ebene = 5
      send ¤
   else if Ebene = 7
      SendUnicodeChar(0x2225) ; parallel zu
   PriorDeadKey := ""
return

*7::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x2077)
      Else
         send {blind}7
	}
   else if Ebene = 2
      send €
   else if Ebene = 3
      send ¢
   else if Ebene = 4
      SendUnicodeChar(0x03F0)          ; varkappa
   else if Ebene = 5
      send ¥
   else if Ebene = 7
      SendUnicodeChar(0x2209)          ; nicht Element von
   PriorDeadKey := ""
return

*8::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x2078)
      Else
         send {blind}8
	}
   else if Ebene = 2
      send „
   else if Ebene = 3
      send ‚
   else if Ebene = 5
      Send /
   else if Ebene = 7
      SendUnicodeChar(0x2204) ; Nicht-Existenzquantor
   PriorDeadKey := ""
return

*9::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x2079)
      Else
         send {blind}9
	}
   else if Ebene = 2
      send “
   else if Ebene = 3
      send ‘
   else if Ebene = 5
      Send *
   else if Ebene = 7
      SendUnicodeChar(0x2226) ; Nicht parallel zu
   PriorDeadKey := ""
return

*0::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x2070)
      Else
         send {blind}0
	}
   else if Ebene = 2
      send ”
   else if Ebene = 3
      send ’
   else if Ebene = 5
      Send -
   else if Ebene = 7
      SendUnicodeChar(0x2205)          ; Leere Menge   
   PriorDeadKey := ""
return

*ß::
   EbeneAktualisieren()
   if Ebene = 1
      send {blind}- ; Bind
   else if Ebene = 2
      SendUnicodeChar(0x2013) ; Ged
   else if Ebene = 3
      SendUnicodeChar(0x2014)
   else if Ebene = 4
      SendUnicodeChar(0x2011)
   else if Ebene = 7
      SendUnicodeChar(0x254C)
   PriorDeadKey := ""
return

*´::
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {´}{space} ; akut, tot
      PriorDeadKey := "a1"
   }
   else if Ebene = 2
   {
      send ``{space}
      PriorDeadKey := "a2"
   }
   else if Ebene = 3
   {
      send ¸ ; cedilla
      PriorDeadKey := "a3"
   }
   else if Ebene = 4
   {
      SendUnicodeChar(0x02DB) ; ogonek
      PriorDeadKey := "a4"
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x02D9) ; punkt oben drüber
      PriorDeadKey := "a5"
   }
   else if Ebene = 7
   {
      SendUnicodeChar(0x02DA)  ; ring obendrauf
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
      SendUnicodeChar(0x03BE) ;xi
   else if Ebene = 5
      send @         ; Redundanz
   else if Ebene = 7
      SendUnicodeChar(0x039E)  ; Xi
   PriorDeadKey := ""
return


*w::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c6")      ; punkt darunter 
         BSSendUnicodeChar(0x1E7F)
      Else
         sendinput {blind}v
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c6")      ; punkt darunter
         BSSendUnicodeChar(0x1E7E)
      Else 
         sendinput {blind}V
   }
   else if Ebene = 3
      send _
   else if Ebene = 4
      SendUnicodeChar(0x03F5)       ; varepsilon
   else if Ebene = 5
      Send {Backspace}
   else if Ebene = 7
      SendUnicodeChar(0x2259)       ; estimates   
   PriorDeadKey := ""
return



*e::
   EbeneAktualisieren()
   if Ebene = 1
   { 
      If (PriorDeadKey = "t5")       ; Schrägstrich
         BSSendUnicodeChar(0x0142)
      Else If (PriorDeadKey = "a1")      ; akut 
         BSSendUnicodeChar(0x013A)
      Else If (PriorDeadKey = "c2")     ; caron 
         BSSendUnicodeChar(0x013E)
      Else If (PriorDeadKey = "a3")    ; cedilla
         BSSendUnicodeChar(0x013C)
      Else If (PriorDeadKey = "c5")  ; Mittenpunkt
         BSSendUnicodeChar(0x0140)
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E37)
      Else 
         sendinput {blind}l
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "a1")           ; akut 
         BSSendUnicodeChar(0x0139)
      Else If (PriorDeadKey = "c2")     ; caron 
         BSSendUnicodeChar(0x013D)
      Else If (PriorDeadKey = "a3")    ; cedilla
         BSSendUnicodeChar(0x013B)
      Else If (PriorDeadKey = "t5")  ; Schrägstrich 
         BSSendUnicodeChar(0x0141)
      Else If (PriorDeadKey = "c5")  ; Mittenpunkt 
         BSSendUnicodeChar(0x013F)
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E36)
      Else 
         sendinput {blind}L
   }      
   else if Ebene = 3
      send [
   else if Ebene = 4
      SendUnicodeChar(0x03BB) ;lambda
   else if Ebene = 5
      Sendinput {Blind}{Up}
   else if Ebene = 6
      Sendinput {Blind}+{Up}
   else if Ebene = 7
      SendUnicodeChar(0x039B)          ; Lambda
   PriorDeadKey := ""
return


*r::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x0109)
      Else If (PriorDeadKey = "c2")     ; caron
         BSSendUnicodeChar(0x010D)
      Else If (PriorDeadKey = "a1")      ; akut
         BSSendUnicodeChar(0x0107)
      Else If (PriorDeadKey = "a3")    ; cedilla
         BSSendUnicodeChar(0x00E7)
      Else If (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x010B)
      Else 
         sendinput {blind}c
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c1")          ; circumflex 
         BSSendUnicodeChar(0x0108)
      Else If (PriorDeadKey = "c2")    ; caron 
         BSSendUnicodeChar(0x010C)
      Else If (PriorDeadKey = "a1")     ; akut 
         BSSendUnicodeChar(0x0106)
      Else If (PriorDeadKey = "a3")   ; cedilla 
         BSSendUnicodeChar(0x00E6)
      Else If (PriorDeadKey = "a5") ; punkt darüber 
         BSSendUnicodeChar(0x010A)
      Else 
         sendinput {blind}C
   }
   else if Ebene = 3
      send ]
   else if Ebene = 4
      SendUnicodeChar(0x03C7) ;chi
   else if Ebene = 5
      Send {Tab}
   else if Ebene = 6
      Send +{Tab}
   else if Ebene = 7
      SendUnicodeChar(0x2102)          ; Komplexe Zahlen
   PriorDeadKey := ""
return

*t::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x0175)
      Else
         sendinput {blind}w
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x0174)
      Else
         sendinput {blind}W
   }
   else if Ebene = 3
      send {^}{space} ; untot
   else if Ebene = 4
      SendUnicodeChar(0x03C9)          ; omega
   else if Ebene = 5
      Send {Insert}
   else if Ebene = 6
      Send +{Insert}
   else if Ebene = 7
      SendUnicodeChar(0x03A9)          ; Omega
   PriorDeadKey := ""
return

*z::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "a3")         ; cedilla
         BSSendUnicodeChar(0x0137)
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E33)
      Else
         sendinput {blind}k
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "a3")         ; cedilla 
         BSSendUnicodeChar(0x0136)
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E32)
      Else
         sendinput {blind}K
   }
   else if Ebene = 3
      sendraw !
   else if Ebene = 4
      SendUnicodeChar(0x03BA) ;kappa
   else if Ebene = 5
      Send ¡
   else if Ebene = 7
      SendUnicodeChar(0x221A)       ; Wurzelzeichen
   PriorDeadKey := ""
return

*u::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x0125)
      Else If (PriorDeadKey = "c4")   ; Querstrich 
         BSSendUnicodeChar(0x0127)
      Else If (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x1E23)
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E25)
      Else sendinput {blind}h
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x0124)
      Else If (PriorDeadKey = "c4")   ; Querstrich
         BSSendUnicodeChar(0x0126)
      Else If (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x1E22)
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E24)
      Else sendinput {blind}H
   }
   else if Ebene = 3
   {
      If (PriorDeadKey = "c4")    ; Querstrich
         BSSendUnicodeChar(0x2264) ; kleiner gleich
      Else
         send {blind}<
   }
   else if Ebene = 4
      SendUnicodeChar(0x03C8) ;psi
   else if Ebene = 5
      Send 7
   else if Ebene = 7
      SendUnicodeChar(0x03A8)  ; Psi
   PriorDeadKey := ""
return

*i::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x011D)
      Else If (PriorDeadKey = "c3")   ; brevis
         BSSendUnicodeChar(0x011F)
      Else If (PriorDeadKey = "a3")   ; cedilla
         BSSendUnicodeChar(0x0123)
      Else If (PriorDeadKey = "a5") ; punkt darüber 
         BSSendUnicodeChar(0x0121)
      Else sendinput {blind}g
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x011C)
      Else If (PriorDeadKey = "c3")    ; brevis 
         BSSendUnicodeChar(0x011E)
      Else If (PriorDeadKey = "a3")    ; cedilla 
         BSSendUnicodeChar(0x0122)
      Else If (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x0120)
      Else sendinput {blind}G
   }
   else if Ebene = 3
   {
      If (PriorDeadKey = "c4")    ; Querstrich
         SendUnicodeChar(0x2265) ; größer gleich
      Else
         send >
   }
   else if Ebene = 4
      SendUnicodeChar(0x03B3) ;gamma
   else if Ebene = 5
      Send 8
   else if Ebene = 7
      SendUnicodeChar(0x0393)  ; Gamma
   PriorDeadKey := ""
return

*o::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "t5")      ; durchgestrichen
         BSSendUnicodeChar(0x0192)
      Else If (PriorDeadKey = "a5") ; punkt darüber 
         BSSendUnicodeChar(0x1E1F)
      Else sendinput {blind}f
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "t5")       ; durchgestrichen
         BSSendUnicodeChar(0x0191)
      Else If (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x1E1E)
      Else sendinput {blind}F
   } 
   else if Ebene = 3
   {
      If (PriorDeadKey = "c1")            ; circumflex 
         BSSendUnicodeChar(0x2259)   ; entspricht
      Else If (PriorDeadKey = "t1")       ; tilde 
         BSSendUnicodeChar(0x2245)   ; ungefähr gleich
      Else If (PriorDeadKey = "t5")   ; Schrägstrich 
         BSSendUnicodeChar(0x2260)   ; ungleich
      Else If (PriorDeadKey = "c4")    ; Querstrich
         BSSendUnicodeChar(0x2261)   ; identisch
      Else If (PriorDeadKey = "c2")      ; caron 
         BSSendUnicodeChar(0x225A)   ; EQUIANGULAR TO
      Else If (PriorDeadKey = "a6")      ; ring drüber 
         BSSendUnicodeChar(0x2257)   ; ring equal to
      Else
         send `=
   }
   else if Ebene = 4
      SendUnicodeChar(0x0278) ; latin small letter phi
   else if Ebene = 5
      Send 9
   else if Ebene = 7
      SendUnicodeChar(0x03A6)  ; Phi
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
   else if Ebene = 4
      SendUnicodeChar(0x03C6)  ; phi
   else if Ebene = 5
      Send {+}
   else if Ebene = 7
      SendUnicodeChar(0x211A) ; Rationale Zahlen
   PriorDeadKey := ""
return

*ü::
   EbeneAktualisieren()
   if Ebene = 1
      if GetKeyState("CapsLock","T")
      {
         SendUnicodeChar(0x1E9E) ; versal-ß
      }
      else
      {
         send ß
      }      
   else if Ebene = 2
      if GetKeyState("CapsLock","T")
      {
         send ß
      }
      else
      {
         SendUnicodeChar(0x1E9E) ; versal-ß
      }
   else if Ebene = 3
      SendUnicodeChar(0x017F)   ; langes s
   else if Ebene = 4
      SendUnicodeChar(0x03C2) ; varsigma
   else if Ebene = 7
      SendUnicodeChar(0x2218)  ; Ring Operator
   PriorDeadKey := ""
return


*+::
   EbeneAktualisieren()
   if Ebene = 1
   {
      SendUnicodeChar(0x02DC)    ; tilde, tot 
      PriorDeadKey := "t1"
   }
   else if Ebene = 2
   {
      SendUnicodeChar(0x00AF)  ; macron, tot
      PriorDeadKey := "t2"
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x00A8)   ; Diaerese
      PriorDeadKey := "t3"
   }
   else if Ebene = 4
   {
      send "        ;doppelakut
      PriorDeadKey := "t4"
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x002F)  ; Schrägstrich, tot
      PriorDeadKey := "t5"
   }
   else if Ebene = 7
   {
      SendUnicodeChar(0x02CF)  ; komma drunter, tot
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
         BSSendUnicodeChar(0x00FB)
      Else If (PriorDeadKey = "a1")      ; akut 
         BSSendUnicodeChar(0x00FA)
      Else If (PriorDeadKey = "a2")     ; grave
         BSSendUnicodeChar(0x00F9)
      Else If (PriorDeadKey = "t3")    ; Diaerese
         Send, {bs}ü
      Else If (PriorDeadKey = "t4")   ; doppelakut 
         BSSendUnicodeChar(0x0171)
      Else If (PriorDeadKey = "c3")    ; brevis
         BSSendUnicodeChar(0x016D)
      Else If (PriorDeadKey = "t2")     ; macron
         BSSendUnicodeChar(0x016B)
      Else If (PriorDeadKey = "a4")   ; ogonek
         BSSendUnicodeChar(0x0173)
      Else If (PriorDeadKey = "a6") ; Ring
         BSSendUnicodeChar(0x016F)
      Else If (PriorDeadKey = "t1")      ; tilde
         BSSendUnicodeChar(0x0169)
      Else If (PriorDeadKey = "c2")  ; caron
         BSSendUnicodeChar(0x01D4)
      Else
         sendinput {blind}u
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x00DB)
      Else If (PriorDeadKey = "a1")      ; akut 
         BSSendUnicodeChar(0x00DA)
      Else If (PriorDeadKey = "a2")     ; grave
         BSSendUnicodeChar(0x00D9)
      Else If (PriorDeadKey = "t3")    ; Diaerese
         Send, {bs}Ü
      Else If (PriorDeadKey = "a6") ; Ring
         BSSendUnicodeChar(0x016E)
      Else If (PriorDeadKey = "c3")    ; brevis
         BSSendUnicodeChar(0x016C)
      Else If (PriorDeadKey = "t4")   ; doppelakut
         BSSendUnicodeChar(0x0170)
      Else If (PriorDeadKey = "c2")     ; caron 
         BSSendUnicodeChar(0x01D3)
      Else If (PriorDeadKey = "t2")     ; macron
         BSSendUnicodeChar(0x016A)
      Else If (PriorDeadKey = "a4")   ; ogonek
         BSSendUnicodeChar(0x0172)
      Else If (PriorDeadKey = "t1")      ; tilde
         BSSendUnicodeChar(0x0168)
      Else
         sendinput {blind}U
   }
   else if Ebene = 3
      send \
   else if Ebene = 5
      Send {blind}{Home}
   else if Ebene = 6
      Send {blind}+{Home}
   else if Ebene = 7
      SendUnicodeChar(0x222E)          ; Contour Integral
   PriorDeadKey := ""
return

*s::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x00EE)
      Else If (PriorDeadKey = "a1")      ; akut 
         BSSendUnicodeChar(0x00ED)
      Else If (PriorDeadKey = "a2")     ; grave
         BSSendUnicodeChar(0x00EC)
      Else If (PriorDeadKey = "t3")   ; Diaerese
         Send, {bs}ï
      Else If (PriorDeadKey = "t2")    ; macron
         BSSendUnicodeChar(0x012B)
      Else If (PriorDeadKey = "c3")   ; brevis
         BSSendUnicodeChar(0x012D)
      Else If (PriorDeadKey = "a4")  ; ogonek
         BSSendUnicodeChar(0x012F)
      Else If (PriorDeadKey = "t1")     ; tilde
         BSSendUnicodeChar(0x0129)
      Else If (PriorDeadKey = "a5") ; (ohne) punkt darüber 
         BSSendUnicodeChar(0x0131)
      Else 
         sendinput {blind}i
   }
   else if Ebene = 2
   {   
      If (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x00CE)
      Else If (PriorDeadKey = "a1")      ; akut 
         BSSendUnicodeChar(0x00CD)
      Else If (PriorDeadKey = "a2")     ; grave
         BSSendUnicodeChar(0x00CC)
      Else If (PriorDeadKey = "t3")    ; Diaerese
         Send, {bs}Ï
      Else If (PriorDeadKey = "t2")     ; macron
         BSSendUnicodeChar(0x012A)
      Else If (PriorDeadKey = "c3")    ; brevis 
         BSSendUnicodeChar(0x012C)
      Else If (PriorDeadKey = "a4")   ; ogonek
         BSSendUnicodeChar(0x012E)
      Else If (PriorDeadKey = "t1")      ; tilde
         BSSendUnicodeChar(0x0128)
      Else If (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x0130)
      Else 
         sendinput {blind}I
   }
   else if Ebene = 3
      send `/
   else if Ebene = 4
      SendUnicodeChar(0x03B9) ;iota
   else if Ebene = 5
      Sendinput {Blind}{Left}
   else if Ebene = 6
      Sendinput {Blind}+{Left}
   else if Ebene = 7
      sendUnicodeChar(0x222B)          ; Integral
   PriorDeadKey := ""
return

*d::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x00E2)
      Else If (PriorDeadKey = "a1")      ; akut 
         BSSendUnicodeChar(0x00E1)
      Else If (PriorDeadKey = "a2")     ; grave
         BSSendUnicodeChar(0x00E0)
      Else If (PriorDeadKey = "t3")    ; Diaerese
         send {bs}ä
      Else If (PriorDeadKey = "a6") ; Ring 
         Send {bs}å
      Else If (PriorDeadKey = "t1")      ; tilde
         BSSendUnicodeChar(0x00E3)
      Else If (PriorDeadKey = "a4")   ; ogonek
         BSSendUnicodeChar(0x0105)
      Else If (PriorDeadKey = "t2")     ; macron
         BSSendUnicodeChar(0x0101)
      Else If (PriorDeadKey = "c3")    ; brevis
         BSSendUnicodeChar(0x0103)
      Else 
         sendinput {blind}a
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x00C2)
      Else If (PriorDeadKey = "a1")       ; akut 
         BSSendUnicodeChar(0x00C1)
      Else If (PriorDeadKey = "a2")      ; grave
         BSSendUnicodeChar(0x00C0)
      Else If (PriorDeadKey = "t3")     ; Diaerese
         send {bs}Ä
      Else If (PriorDeadKey = "t1")       ; tilde
         BSSendUnicodeChar(0x00C3)
      Else If (PriorDeadKey = "a6")  ; Ring 
         Send {bs}Å
      Else If (PriorDeadKey = "t2")      ; macron
         BSSendUnicodeChar(0x0100)
      Else If (PriorDeadKey = "c3")     ; brevis 
         BSSendUnicodeChar(0x0102)
      Else If (PriorDeadKey = "a4")    ; ogonek
         BSSendUnicodeChar(0x0104)
      Else 
         sendinput {blind}A
   }
   else if Ebene = 3
      sendraw {
   else if Ebene = 4
      SendUnicodeChar(0x03B1) ;alpha
   else if Ebene = 5
      Sendinput {Blind}{Down}
   else if Ebene = 6
      Sendinput {Blind}+{Down}
   else if Ebene = 7
      SendUnicodeChar(0x2200)           ; For All
   PriorDeadKey := ""
return

*f::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x00EA)
      Else If (PriorDeadKey = "a1")      ; akut 
         BSSendUnicodeChar(0x00E9)
      Else If (PriorDeadKey = "a2")     ; grave
         BSSendUnicodeChar(0x00E8)
      Else If (PriorDeadKey = "t3")   ; Diaerese
         Send, {bs}ë
      Else If (PriorDeadKey = "a4")  ; ogonek
         BSSendUnicodeChar(0x0119)
      Else If (PriorDeadKey = "t2")    ; macron
         BSSendUnicodeChar(0x0113)
      Else If (PriorDeadKey = "c3")   ; brevis
         BSSendUnicodeChar(0x0115)
      Else If (PriorDeadKey = "c2")    ; caron
         BSSendUnicodeChar(0x011B)
      Else If (PriorDeadKey = "a5") ; punkt darüber 
         BSSendUnicodeChar(0x0117)
      Else 
         sendinput {blind}e
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x00CA)
      Else If (PriorDeadKey = "a1")      ; akut 
         BSSendUnicodeChar(0x00C9)
      Else If (PriorDeadKey = "a2")     ; grave
         BSSendUnicodeChar(0x00C8)
      Else If (PriorDeadKey = "t3")    ; Diaerese
         Send, {bs}Ë
      Else If (PriorDeadKey = "c2")     ; caron
         BSSendUnicodeChar(0x011A)
      Else If (PriorDeadKey = "t2")     ; macron
         BSSendUnicodeChar(0x0112)
      Else If (PriorDeadKey = "c3")    ; brevis 
         BSSendUnicodeChar(0x0114)
      Else If (PriorDeadKey = "a4")   ; ogonek 
         BSSendUnicodeChar(0x0118)
      Else If (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x0116)
      Else 
         sendinput {blind}E
   }
   else if Ebene = 3
      sendraw }
   else if Ebene = 4
      SendUnicodeChar(0x03B5) ;epsilon
   else if Ebene = 5
      Sendinput {Blind}{Right}
   else if Ebene = 6
      Sendinput {Blind}+{Right}
   else if Ebene = 7
      SendUnicodeChar(0x2203)          ; Existensquantor
   PriorDeadKey := ""
return

*g::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x00F4)
      Else If (PriorDeadKey = "a1")      ; akut 
         BSSendUnicodeChar(0x00F3)
      Else If (PriorDeadKey = "a2")     ; grave
         BSSendUnicodeChar(0x00F2)
      Else If (PriorDeadKey = "t3")    ; Diaerese
         Send, {bs}ö
      Else If (PriorDeadKey = "t1")      ; tilde
         BSSendUnicodeChar(0x00F5)
      Else If (PriorDeadKey = "t4")   ; doppelakut
         BSSendUnicodeChar(0x0151)
      Else If (PriorDeadKey = "t5")  ; Schrägstrich
         BSSendUnicodeChar(0x00F8)
      Else If (PriorDeadKey = "t2")     ; macron
         BSSendUnicodeChar(0x014D)
      Else If (PriorDeadKey = "c3")    ; brevis 
         BSSendUnicodeChar(0x014F)
      Else 
         sendinput {blind}o
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x00D4)
      Else If (PriorDeadKey = "a1")      ; akut 
         BSSendUnicodeChar(0x00D3)
      Else If (PriorDeadKey = "a2")     ; grave
         BSSendUnicodeChar(0x00D2)
      Else If (PriorDeadKey = "t5")  ; Schrägstrich
         BSSendUnicodeChar(0x00D8)
      Else If (PriorDeadKey = "t1")      ; tilde
         BSSendUnicodeChar(0x00D5)
      Else If (PriorDeadKey = "t4")   ; doppelakut
         BSSendUnicodeChar(0x0150)
      Else If (PriorDeadKey = "t3")    ; Diaerese
         send {bs}Ö
      Else If (PriorDeadKey = "t2")     ; macron 
         BSSendUnicodeChar(0x014C)
      Else If (PriorDeadKey = "c3")    ; brevis 
         BSSendUnicodeChar(0x014E)
      Else
         sendinput {blind}O
   }
   else if Ebene = 3
      send *
   else if Ebene = 4
      SendUnicodeChar(0x03C9) ;omega
   else if Ebene = 5
      Send {blind}{End}
   else if Ebene = 6
      Send {blind}+{End}
   else if Ebene = 7
      SendUnicodeChar(0x2208)          ; Element von
   PriorDeadKey := ""
return

*h::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x015D)
      Else If (PriorDeadKey = "a1")      ; akut 
         BSSendUnicodeChar(0x015B)
      Else If (PriorDeadKey = "c2")     ; caron
         BSSendUnicodeChar(0x0161)
      Else If (PriorDeadKey = "a3")    ; cedilla
         BSSendUnicodeChar(0x015F)
      Else If (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x1E61)
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E63)
      Else   
         sendinput {blind}s
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x015C)
      Else If (PriorDeadKey = "c2")     ; caron
         BSSendUnicodeChar(0x0160)
      Else If (PriorDeadKey = "a1")      ; akut 
         BSSendUnicodeChar(0x015A)
      Else If (PriorDeadKey = "a3")    ; cedilla 
         BSSendUnicodeChar(0x015E)
      Else If (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x1E60)
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E62)
      Else
         sendinput {blind}S
   }
   else if Ebene = 3
      send ?
   else if Ebene = 4
      SendUnicodeChar(0x03C3) ;sigma
   else if Ebene = 5
      Send ¿
   else if Ebene = 7
      SendUnicodeChar(0x03A3)  ; Sigma
   PriorDeadKey := ""
return

*j::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "a1")          ; akut
         BSSendUnicodeChar(0x0144)
      Else If (PriorDeadKey = "t1")     ; tilde
         BSSendUnicodeChar(0x00F1)
      Else If (PriorDeadKey = "c2")    ; caron
         BSSendUnicodeChar(0x0148)
      Else If (PriorDeadKey = "a3")   ; cedilla
         BSSendUnicodeChar(0x0146)
      Else If (PriorDeadKey = "a5") ; punkt darüber 
         BSSendUnicodeChar(0x1E45)
      Else
         sendinput {blind}n
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c2")         ; caron
         BSSendUnicodeChar(0x0147)
      Else If (PriorDeadKey = "t1")     ; tilde
         BSSendUnicodeChar(0x00D1)
      Else If (PriorDeadKey = "a1")     ; akut 
         BSSendUnicodeChar(0x0143)
      Else If (PriorDeadKey = "a3")   ; cedilla 
         BSSendUnicodeChar(0x0145)
      Else If (PriorDeadKey = "a5") ; punkt darüber 
         BSSendUnicodeChar(0x1E44)
      Else
         sendinput {blind}N
   }
   else if Ebene = 3
      send (
   else if Ebene = 4
      SendUnicodeChar(0x03BD) ;nu
   else if Ebene = 5
      Send 4
   else if Ebene = 7
      SendUnicodeChar(0x2115)          ; Natürliche Zahlen
   PriorDeadKey := ""
return

*k::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "a1")           ; akut 
         BSSendUnicodeChar(0x0155)
      Else If (PriorDeadKey = "c2")     ; caron
         BSSendUnicodeChar(0x0159)
      Else If (PriorDeadKey = "a3")    ; cedilla
         BSSendUnicodeChar(0x0157)
      Else If (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x0E59)
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E5B)
      Else 
         sendinput {blind}r
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c2")          ; caron
         BSSendUnicodeChar(0x0158)
      Else If (PriorDeadKey = "a1")      ; akut 
         BSSendUnicodeChar(0x0154)
      Else If (PriorDeadKey = "a3")    ; cedilla 
         BSSendUnicodeChar(0x0156)
      Else If (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x1E58)
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E5A)
      Else 
         sendinput {blind}R
   }
   else if Ebene = 3
      send )
   else if Ebene = 4
      SendUnicodeChar(0x03C1) ;rho
   else if Ebene = 5
      Send 5
   else if Ebene = 7
      SendUnicodeChar(0x211D)          ; Rationale Zahlen
   PriorDeadKey := ""
return

*l::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c2")          ; caron 
         BSSendUnicodeChar(0x0165)
      Else If (PriorDeadKey = "a3")    ; cedilla
         BSSendUnicodeChar(0x0163)
      Else If (PriorDeadKey = "c4")   ; Querstrich
         BSSendUnicodeChar(0x0167)
      Else If (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x1E6B)
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E6D)
      Else 
         sendinput {blind}t
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c2")          ; caron
         BSSendUnicodeChar(0x0164)
      Else If (PriorDeadKey = "a3")    ; cedilla 
         BSSendUnicodeChar(0x0162)
      Else If (PriorDeadKey = "c4")   ; Querstrich
         BSSendUnicodeChar(0x0166)
      Else If (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x1E6A)
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E6C)
      Else 
         sendinput {blind}T
   }
   else if Ebene = 3
      send {blind}- ; Bind
   else if Ebene = 4
      SendUnicodeChar(0x03C4) ;tau
   else if Ebene = 5
      Send 6
   else if Ebene = 7
      SendUnicodeChar(0x2202)          ; partielle Ableitung
   PriorDeadKey := ""
return

*ö::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c4")        ; Querstrich
         BSSendUnicodeChar(0x0111)
      Else If (PriorDeadKey = "t5")  ; Schrägstrich
         BSSendUnicodeChar(0x00F0)
      Else If (PriorDeadKey = "c2")     ; caron
         BSSendUnicodeChar(0x010F)
      Else If (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x1E0B)
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E0D)
      Else 
         sendinput {blind}d
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c4")        ; Querstrich
         BSSendUnicodeChar(0x0110)
      Else If (PriorDeadKey = "t5")  ; Schrägstrich
         BSSendUnicodeChar(0x00D0)
      Else If (PriorDeadKey = "c2")     ; caron 
         BSSendUnicodeChar(0x010E)
      Else If (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x1E0A)
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E0D)
      Else sendinput {blind}D
   }
   else if Ebene = 3
      send :
   else if Ebene = 4
      SendUnicodeChar(0x03B4) ;delta
   else if Ebene = 5
      Send `,
   else if Ebene = 7
      SendUnicodeChar(0x0394)  ; Delta
   PriorDeadKey := ""
return

*ä::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "t3")       ; Diaerese
         Send {bs}ÿ
      Else If (PriorDeadKey = "a1")      ; akut 
         BSSendUnicodeChar(0x00FD)
      Else If (PriorDeadKey = "c1")    ; circumflex
         BSSendUnicodeChar(0x0177)
      Else
         sendinput {blind}y
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "a1")           ; akut 
         BSSendUnicodeChar(0x00DD)
      Else If (PriorDeadKey = "t3")    ; Diaerese
         Send {bs}Ÿ
      Else If (PriorDeadKey = "c1")      ; circumflex
         BSSendUnicodeChar(0x0176)
      Else
         sendinput {blind}Y
   }
   else if Ebene = 4
      SendUnicodeChar(0x03C5) ;upsilon
   else if Ebene = 5
      SendUnicodeChar(0x2207)         ; nabla
   PriorDeadKey := ""
return

;SC02B (#) wird zu Mod3


/*
   ------------------------------------------------------
   Reihe 4
   ------------------------------------------------------
*/

;SC056 (<) wird zu Mod4

*y::
   EbeneAktualisieren()
   if Ebene = 1
      sendinput {blind}ü
   else if Ebene = 2
      sendinput {blind}Ü
   else if Ebene = 3
      send {#}
   else if Ebene = 5
      Send {Esc}
   else if Ebene = 7
      SendUnicodeChar(0x221D)          ; proportional zu
   PriorDeadKey := ""
return

*x::
   EbeneAktualisieren()
   if Ebene = 1
      sendinput {blind}ö
   else if Ebene = 2
      sendinput {blind}Ö
   else if Ebene = 3
      send $
   else if Ebene = 5
      Send {Del}
   else if Ebene = 6
      Send +{Del}
   else if Ebene = 7
      SendUnicodeChar(0x2111)          ; Black-Letter Capital I
   PriorDeadKey := ""
return

*c::
   EbeneAktualisieren()
   if Ebene = 1
      sendinput {blind}ä
   else if Ebene = 2
      sendinput {blind}Ä
   else if Ebene = 3
      send |
   else if Ebene = 4
      SendUnicodeChar(0x03B7) ;eta
   else if Ebene = 5
      Send {PgDn}    ; Next
   else if Ebene = 6
      Send +{PgDn}
   else if Ebene = 7
      SendUnicodeChar(0x211C)          ; Black-Letter Capital I
   PriorDeadKey := ""
return

*v::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "a5")      ; punkt darüber 
         BSSendUnicodeChar(0x1E57)
      Else
         sendinput {blind}p
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "a5")      ; punkt darüber 
         BSSendUnicodeChar(0x1E56)
      Else 
         sendinput {blind}P
   }
   else if Ebene = 3
   {
      If (PriorDeadKey = "t1")    ; tilde
         BSSendUnicodeChar(0x2248)
      Else
         sendraw ~
   }      
   else if Ebene = 4
      SendUnicodeChar(0x03C0) ;pi
   else if Ebene = 5
      Send {Enter}
   else if Ebene = 7
      SendUnicodeChar(0x03A0)  ; Pi
   PriorDeadKey := ""
return

*b::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c2")         ; caron
         BSSendUnicodeChar(0x017E)
      Else If (PriorDeadKey = "a1")     ; akut
         BSSendUnicodeChar(0x017A)
      Else If (PriorDeadKey = "a5") ; punkt drüber
         BSSendUnicodeChar(0x017C)
      Else If (PriorDeadKey = "c6") ; punkt drunter
         BSSendUnicodeChar(0x1E93)
      Else 
         sendinput {blind}z
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c2")         ; caron  
         BSSendUnicodeChar(0x017D)
      Else If (PriorDeadKey = "a1")     ; akut 
         BSSendUnicodeChar(0x0179)
      Else If (PriorDeadKey = "a5") ; punkt darüber 
         BSSendUnicodeChar(0x017B)
      Else If (PriorDeadKey = "c6") ; punkt drunter
         BSSendUnicodeChar(0x1E92)
      Else
         sendinput {blind}Z
   }
   else if Ebene = 3
      send ``{space} ; untot
   else if Ebene = 4
      SendUnicodeChar(0x03B6) ;zeta
   else if Ebene = 7
      SendUnicodeChar(0x2124)  ; Ganze Zahlen
   PriorDeadKey := ""
return

*n::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "a5")      ; punkt darüber 
         BSSendUnicodeChar(0x1E03)
      Else 
         sendinput {blind}b
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "a5")       ; punkt darüber 
         BSSendUnicodeChar(0x1E02)
      Else 
         sendinput {blind}B
   }
   else if Ebene = 3
      send {blind}{+}
   else if Ebene = 4
      SendUnicodeChar(0x03B2) ;beta
   else if Ebene = 7
      SendUnicodeChar(0x21D2) ; daraus folgt (Implikation)
   PriorDeadKey := ""
return

*m::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "a5")       ; punkt darüber 
         BSSendUnicodeChar(0x1E41)
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E43)
      Else 
         sendinput {blind}m
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "a5")       ; punkt darüber 
         BSSendUnicodeChar(0x1E40)
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E42)
      Else 
         sendinput {blind}M
   }
   else if Ebene = 3
      send `%
   else if Ebene = 4
      SendUnicodeChar(0x03BC) ;micro, mu wäre 0x00B5
   else if Ebene = 5
      Send 1
   else if Ebene = 7
      SendUnicodeChar(0x21D4) ; Äquivalenz
   PriorDeadKey := ""
return

*,::
   EbeneAktualisieren()
   if Ebene = 1
      send {blind},
   else if Ebene = 3
      send '
   else if Ebene = 4
      SendUnicodeChar(0x03F1) ; varrho
   else if Ebene = 5
      Send 2
   else if Ebene = 7
      SendUnicodeChar(0x21D0) ; Doppelpfeil nach links
   PriorDeadKey := ""
return

*.::
   EbeneAktualisieren()
   if Ebene = 1
      send {blind}.
   else if Ebene = 2
      SendUnicodeChar(0x2026)  ; ellipse
   else if Ebene = 3
      send "
   else if Ebene = 4
      SendUnicodeChar(0x03B8) ;theta
   else if Ebene = 5
      Send 3
   else if Ebene = 7
      SendUnicodeChar(0x0398)  ; Theta
   PriorDeadKey := ""
return


*-::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x0135)
      Else If (PriorDeadKey = "c2")      ; caron
         BSSendUnicodeChar(0x01F0)
      Else
         sendinput {blind}j
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x0134)
      Else
         sendinput {blind}J
   }
   else if Ebene = 3
      send `;
   else if Ebene = 4
      SendUnicodeChar(0x03D1) ; vartheta
   else if Ebene = 5
      Send .
   else if Ebene = 7
      SendUnicodeChar(0x2261) ; identisch zu (auch über tote Tasten)
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
      send ÷
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x2215)   ; slash
   PriorDeadKey := ""
return

*NumpadMult::
   EbeneAktualisieren()
   if ( (Ebene = 1) or (Ebene = 2) )
      send {NumpadMult}
   else if Ebene = 3
      send ×
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x22C5)  ; cdot
   PriorDeadKey := ""
return

*NumpadSub::
   EbeneAktualisieren()
   if ( (Ebene = 1) or (Ebene = 2) )
   {
      If (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x207B)
      Else
         send {blind}{NumpadSub}
   }
   else if ( (Ebene = 3) or (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x2212) ; echtes minus
   PriorDeadKey := ""
return

*NumpadAdd::
   EbeneAktualisieren()
   if ( (Ebene = 1) or (Ebene = 2) )
   {
      If (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x207A)
      Else
         send {blind}{NumpadAdd}
   }
   else if Ebene = 3
      send ±
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x2213)   ; -+
   PriorDeadKey := ""
return

*NumpadEnter::
   EbeneAktualisieren()
   if ( (Ebene = 1) or (Ebene = 2) )
      send {NumpadEnter}      
   else if Ebene = 3
      SendUnicodeChar(0x2260) ; neq
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x2248) ; approx
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
      send {blind}{Numpad7}
   else if Ebene = 2
      send {NumpadHome}
   else if Ebene = 3
      SendUnicodeChar(0x20D7)          ; Combining Vektorpfeil
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x226A)  ; ll
   PriorDeadKey := ""
return

*Numpad8::
   EbeneAktualisieren()
   if Ebene = 1
      send {blind}{Numpad8}
   else if Ebene = 2
      send {NumpadUp}
   else if Ebene = 3
      SendUnicodeChar(0x2191)     ; uparrow
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x2229)    ; intersection
   PriorDeadKey := ""
return

*Numpad9::
   EbeneAktualisieren()
   if Ebene = 1
      send {blind}{Numpad9}
   else if Ebene = 2
      send {NumpadPgUp}
   else if Ebene = 3
      SendUnicodeChar(0x2297)             ; Circled Times
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x226B)  ; gg
   PriorDeadKey := ""
return

*Numpad4::
   EbeneAktualisieren()
   if Ebene = 1
      send {blind}{Numpad4}
   else if Ebene = 2
      send {NumpadLeft}
   else if Ebene = 3
      SendUnicodeChar(0x2190)     ; leftarrow
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x2282)  ; subset of
   PriorDeadKey := ""
return

*Numpad5::
   EbeneAktualisieren()
   if Ebene = 1
      send {blind}{Numpad5}
   else if Ebene = 2
      send {€}
   else if Ebene = 3
      SendUnicodeChar(0x221E)          ; Infty
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x220B) ; Element
   PriorDeadKey := ""
return

*Numpad6::
   EbeneAktualisieren()
   if Ebene = 1
      send {blind}{Numpad6}
   else if Ebene = 2
      send {NumpadRight}
   else if Ebene = 3
      SendUnicodeChar(0x2192)     ; rightarrow
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x2283) ; superset of
   PriorDeadKey := ""
return

*Numpad1::
   EbeneAktualisieren()
   if Ebene = 1
      send {blind}{Numpad1}
   else if Ebene = 2
      send {NumpadEnd}
   else if Ebene = 3
      SendUnicodeChar(0x21CB) ; LEFTWARDS HARPOON OVER RIGHTWARDS HARPOON
      else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x2264)   ; leq
   PriorDeadKey := ""
return

*Numpad2::
   EbeneAktualisieren()
   if Ebene = 1
      send {blind}{Numpad2}
   else if Ebene = 2
      send {NumpadDown}
   else if Ebene = 3
      SendUnicodeChar(0x2193)     ; downarrow
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x222A)  ; vereinigt
   PriorDeadKey := ""
return

*Numpad3::
   EbeneAktualisieren()
   if Ebene = 1
      send {blind}{Numpad3}
   else if Ebene = 2
      send {NumpadPgDn}
   else if Ebene = 3
      SendUnicodeChar(0x21CC) ; RIGHTWARDS HARPOON OVER LEFTWARDS HARPOON
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x2265)  ; geq
   PriorDeadKey := ""
return

*Numpad0::
   EbeneAktualisieren()
   if Ebene = 1
      send {blind}{Numpad0}
   else if Ebene = 2
      send {NumpadIns}
   else if Ebene = 3
      send `%
   else if ( (Ebene = 4) or (Ebene = 5) )
      send ‰ 
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
      send {blind}{Numpad7}
   else if Ebene = 2
      send {NumpadHome}
   else if Ebene = 3
      SendUnicodeChar(0x20D7)          ; Combining Vektorpfeil
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x226A)  ; ll
   PriorDeadKey := ""
return

*NumpadUp::
   EbeneAktualisieren()
   if Ebene = 1
      send {NumpadUp}
   else if Ebene = 2
      send {Numpad8}
   else if Ebene = 3
      SendUnicodeChar(0x2191)     ; uparrow
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x2229)    ; intersection
   PriorDeadKey := ""
return

*NumpadPgUp::
   EbeneAktualisieren()
   if Ebene = 1
      send {blind}{Numpad9}
   else if Ebene = 2
      send {NumpadPgUp}
   else if Ebene = 3
      SendUnicodeChar(0x2297)             ; Circled Times
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x226B)  ; gg
   PriorDeadKey := ""
return

*NumpadLeft::
   EbeneAktualisieren()
   if Ebene = 1
      send {NumpadLeft}
   else if Ebene = 2
      send {Numpad4}
   else if Ebene = 3
      SendUnicodeChar(0x2190)     ; leftarrow
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x2282)  ; subset of
   PriorDeadKey := ""
return

*NumpadClear::
   EbeneAktualisieren()
   if Ebene = 1
      send {blind}{Numpad5}
   else if Ebene = 2
      send {€}
   else if Ebene = 3
      SendUnicodeChar(0x221E)          ; Infty
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x220B) ; Element
      PriorDeadKey := ""
return

*NumpadRight::
   EbeneAktualisieren()
   if Ebene = 1
      send {NumpadRight}
   else if Ebene = 2
      send {Numpad6}
   else if Ebene = 3
      SendUnicodeChar(0x2192)     ; rightarrow
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x2283) ; superset of
   PriorDeadKey := ""
return

*NumpadEnd::
   EbeneAktualisieren()
   if Ebene = 1
      send {NumpadEnd}
   else if Ebene = 2
      send {Numpad1}
   else if Ebene = 3
      SendUnicodeChar(0x21CB) ; LEFTWARDS HARPOON OVER RIGHTWARDS HARPOON
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x2264)   ; leq
   PriorDeadKey := ""
return

*NumpadDown::
   EbeneAktualisieren()
   if Ebene = 1
      send {NumpadDown}
   else if Ebene = 2
      send {Numpad2}
   else if Ebene = 3
      SendUnicodeChar(0x2193)     ; downarrow
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x222A)  ; vereinigt
   PriorDeadKey := ""
return

*NumpadPgDn::
   EbeneAktualisieren()
   if Ebene = 1
      send {NumpadPgDn}
   else if Ebene = 2
      send {Numpad3}
   else if Ebene = 3
      SendUnicodeChar(0x21CC) ; RIGHTWARDS HARPOON OVER LEFTWARDS HARPOON   
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x2265)  ; geq
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
      send ‰ 
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
      SendUnicodeChar(0x00A0)   ; geschütztes Leerzeichen
   else if Ebene = 5
      Send 0
   else if Ebene = 7
      SendUnicodeChar(0x202F) ; schmales Leerzeichen
   else
      Send {blind}{Space}
   PriorDeadKey := ""
return

/*
   Folgende Tasten sind nur aufgeführt, um PriorDeadKey zu leeren.
   Irgendwie sieht das noch nicht schön aus. Vielleicht lässt sich dieses
   Problem irgendwie eleganter lösen...
   
   Nachtrag:
   Weil es mit Alt+Tab Probleme gab, wird hier jetzt erstmal rumgeflickschustert,
   bis eine allgemeinere Lösung gefunden wurde.
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
einem DeadKey drückt...

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
   if ( GetKeyState("CapsLock","P") or GetKeyState("#","P") ) {
      ; ist Mod4 down?
      if ( GetKeyState("<","P") or GetKeyState("SC138","P") ) {
         Ebene +=6
      }
      else Ebene += 2
   }
   ; ist Mod4 down? Mod3 hat Vorrang!
   else if ( GetKeyState("<","P") or GetKeyState("SC138","P") ) {
      ; ist Mod3 down?
      if ( GetKeyState("CapsLock","P") or GetKeyState("#","P") ) {
         Ebene +=6
      }
      else Ebene += 4
   }
   
   return
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
