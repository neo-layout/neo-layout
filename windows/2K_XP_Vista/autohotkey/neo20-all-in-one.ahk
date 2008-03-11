/*
    Titel:        NEO 2.0 beta Autohotkey-Treiber
    Version:      0.12 beta
    Datum:        23.02.2008
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
    Ideen:        - Symbol ändern (Neo-Logo abwarten)
                  - bei Ebene 4 rechte Hand (Numpad) z.B. Numpad5 statt 5 senden
    CHANGES:      - SUBSCRIPT von 0 bis 9 sowie (auf Nummernblock) + und -
                     • auch bei Ziffernblock auf der 5. Ebene
                  - Kein Parsen über die Zwischenablage mehr
                  - Vista-kompatibel
                  - Compose-Taste
                     • Brüche (auf Zahlenreihe und Hardware-Ziffernblock)
                     • römische Zahlen
                     • Ligaturen und Copyright
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
   else if Ebene = 6
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
      Else If (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2081)
      Else If (CompKey = "r_small_1")
         Comp3UnicodeChar(0x217A)          ; römisch xi
      Else If (CompKey = "r_capital_1")
         Comp3UnicodeChar(0x216A)          ; römisch XI
      Else
         send {blind}1
      If (PriorDeadKey = "comp")
         CompKey := "1"
      Else If (CompKey = "r_small")
         CompKey := "r_small_1"
      Else If (CompKey = "r_capital")
         CompKey := "r_capital_1"
      Else
         CompKey := ""
   }
   else if Ebene = 2
   {
      send °
      CompKey := ""
   }
   else if Ebene = 4
   {
      SendUnicodeChar(0x2640) ; Piktogramm weiblich
      CompKey := ""
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x2022) ; bullet
      CompKey := ""
   }
   PriorDeadKey := ""
return

*2::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")          ; circumflex 
         BSSendUnicodeChar(0x00B2)
      Else If (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2082)
      Else If (CompKey = "r_small")
         CompUnicodeChar(0x2171)          ; römisch ii
      Else If (CompKey = "r_capital")
         CompUnicodeChar(0x2161)          ; römisch II
      Else If (CompKey = "r_small_1")
         Comp3UnicodeChar(0x217B)          ; römisch xii
      Else If (CompKey = "r_capital_1")
         Comp3UnicodeChar(0x216B)          ; römisch XII
      Else
         send {blind}2      
      If (PriorDeadKey = "comp")
         CompKey := "2"
      Else
         CompKey := ""         
   }
   else if Ebene = 2
   {
      SendUnicodeChar(0x2116) ; numero
      CompKey := ""
   }
   else if Ebene = 4
   {
      SendUnicodeChar(0x26A5) ; Piktogramm Zwitter
      CompKey := ""
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x2023) ; aufzaehlungspfeil
      CompKey := ""
   }
   PriorDeadKey := ""
return

*3::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x00B3)
      Else If (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2083)
      Else If (CompKey = "1")
         CompUnicodeChar(0x2153)          ; 1/3
      Else If (CompKey = "2")
         CompUnicodeChar(0x2154)          ; 2/3
      Else If (CompKey = "r_small")
         CompUnicodeChar(0x2172)          ; römisch iii
      Else If (CompKey = "r_capital")
         CompUnicodeChar(0x2162)          ; römisch III
      Else
         send {blind}3
      If (PriorDeadKey = "comp")
         CompKey := "3"
      Else
         CompKey := ""         
   }
   else if Ebene = 2
   {
      send §
      CompKey := ""
   }
   else if Ebene = 4
   {
      SendUnicodeChar(0x2642) ; Piktogramm männlich
      CompKey := ""
   }
   PriorDeadKey := ""
return

*4::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x2074)
      Else If (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2084)         
      Else If (CompKey = "r_small")
         CompUnicodeChar(0x2173)          ; römisch iv
      Else If (CompKey = "r_capital")
         CompUnicodeChar(0x2163)          ; römisch IV
      Else
         send {blind}4
      If (PriorDeadKey = "comp")
         CompKey := "4"
      Else
         CompKey := ""         
	}
   else if Ebene = 2
   {
      send »
      CompKey := ""
   }
   else if Ebene = 3
   {
      send ›
      CompKey := ""
   }
   else if Ebene = 5
   {
      Send {PgUp}    ; Prev
      CompKey := ""
   }
   else if Ebene = 6
   {
      Send +{Prev}
      CompKey := ""
   }
   PriorDeadKey := ""
return

*5::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x2075)
      Else If (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2085)
      Else If (CompKey = "1")
         CompUnicodeChar(0x2155)          ; 1/5
      Else If (CompKey = "2")
         CompUnicodeChar(0x2156)          ; 2/5
      Else If (CompKey = "3")
         CompUnicodeChar(0x2157)          ; 3/5
      Else If (CompKey = "4")
         CompUnicodeChar(0x2158)          ; 4/5
      Else If (CompKey = "r_small")
         CompUnicodeChar(0x2174)          ; römisch v
      Else If (CompKey = "r_capital")
         CompUnicodeChar(0x2164)          ; römisch V
      Else
         send {blind}5
      If (PriorDeadKey = "comp")
         CompKey := "5"
      Else
         CompKey := ""         
	}
   else if Ebene = 2
   {
      send «
      CompKey := ""
   }
   else if Ebene = 3
   {
      send ‹
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x21D2) ; Implikation
      CompKey := ""
   }
   PriorDeadKey := ""
return

*6::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x2076)
      Else If (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2086)         
      Else If (CompKey = "1")
         CompUnicodeChar(0x2159)          ; 1/6
      Else If (CompKey = "5")
         CompUnicodeChar(0x215A)          ; 5/6
      Else If (CompKey = "r_small")
         CompUnicodeChar(0x2175)          ; römisch vi
      Else If (CompKey = "r_capital")
         CompUnicodeChar(0x2165)          ; römisch VI
      Else
         send {blind}6
      If (PriorDeadKey = "comp")
         CompKey := "6"
      Else
         CompKey := ""         
	}
   else if Ebene = 2
   {
      send $
      CompKey := ""
   }
   else if Ebene = 3
   {
      send £
      CompKey := ""
   }
   else if Ebene = 4
   {
      send ¤
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x21D4) ; Äquivalenz
      CompKey := ""
   }
   PriorDeadKey := ""
return

*7::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x2077)
      Else If (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2087)
      Else If (CompKey = "r_small")
         CompUnicodeChar(0x2176)          ; römisch vii
      Else If (CompKey = "r_capital")
         CompUnicodeChar(0x2166)          ; römisch VII
      Else
         send {blind}7
      If (PriorDeadKey = "comp")
         CompKey := "7"
      Else
         CompKey := ""         
	}
   else if Ebene = 2
   {
      send €
      CompKey := ""
   }
   else if Ebene = 3
   {
      send ¢
      CompKey := ""
   }
   else if Ebene = 4
   {
      send ¥CompKey := ""
   }
   else if Ebene = 6
   {
      Send ¬
      CompKey := ""
   }
   PriorDeadKey := ""
return

*8::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x2078)
      Else If (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2088)
      Else If (CompKey = "1")
         CompUnicodeChar(0x215B)          ; 1/8
      Else If (CompKey = "3")
         CompUnicodeChar(0x215C)          ; 3/8
      Else If (CompKey = "5")
         CompUnicodeChar(0x215D)          ; 5/8
      Else If (CompKey = "7")
         CompUnicodeChar(0x215E)          ; 7/8
      Else If (CompKey = "r_small")
         CompUnicodeChar(0x2177)          ; römisch viii
      Else If (CompKey = "r_capital")
         CompUnicodeChar(0x2167)          ; römisch VIII
      Else
         send {blind}8
      If (PriorDeadKey = "comp")
         CompKey := "8"
      Else
         CompKey := ""         
	}
   else if Ebene = 2
   {
      send „
      CompKey := ""
   }
   else if Ebene = 3
   {
      send ‚
      CompKey := ""
   }
   else if Ebene = 5
   {
      Send /
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x2203) ; Existenzquantor
      CompKey := ""
   }
   PriorDeadKey := ""
return

*9::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x2079)
      Else If (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2089)
      Else If (CompKey = "r_small")
         CompUnicodeChar(0x2178)          ; römisch ix
      Else If (CompKey = "r_capital")
         CompUnicodeChar(0x2168)          ; römisch IX
      Else
         send {blind}9
      If (PriorDeadKey = "comp")
         CompKey := "9"
      Else
         CompKey := ""         
	}
   else if Ebene = 2
   {
      send “
      CompKey := ""
   }
   else if Ebene = 3
   {
      send ‘
      CompKey := ""
   }
   else if Ebene = 5
   {
      Send *
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x2200) ; Allquantor
      CompKey := ""
   }
   PriorDeadKey := ""
return

*0::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x2070)
      Else If (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2080)         
      Else If (CompKey = "r_small_1")
         Comp3UnicodeChar(0x2179)          ; römisch x
      Else If (CompKey = "r_capital_1")
         Comp3UnicodeChar(0x2169)          ; römisch X
      Else
         send {blind}0
      If (PriorDeadKey = "comp")
         CompKey := "0"
      Else
         CompKey := ""         
	}
   else if Ebene = 2
   {
      send ”
      CompKey := ""
   }
   else if Ebene = 3
   {
      send ’
      CompKey := ""
   }
   else if Ebene = 5
   {
      Send -
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x2228) ; logisch oder
      CompKey := ""
   }
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
      SendUnicodeChar(0x254C)
   else if Ebene = 5
      SendUnicodeChar(0x2011)
   else if Ebene = 6
      SendUnicodeChar(0x2227) ; logisch und
   PriorDeadKey := ""   CompKey := ""
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
   else if Ebene = 6
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
   else if Ebene = 6
      SendUnicodeChar(0x039E)  ; Xi
   PriorDeadKey := ""   CompKey := ""
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
   else if Ebene = 5
      Send {Tab}
   else if Ebene = 6
      Send +{Tab}
   PriorDeadKey := ""   CompKey := ""
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
      If (PriorDeadKey = "comp")            ; compose
         CompKey := "l_small"
      Else
         CompKey := ""
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
      If (PriorDeadKey = "comp")            ; compose
         CompKey := "l_capital"
      Else CompKey := ""
   }      
   else if Ebene = 3
   {
      send [
      CompKey := ""
   }
   else if Ebene = 4
   {
      SendUnicodeChar(0x03BB) ;lambda
      CompKey := ""
   }
   else if Ebene = 5
   {
      Sendinput {Blind}{Up}
      CompKey := ""
   }
   else if Ebene = 6
   {
      Sendinput {Blind}+{Up}
      CompKey := ""
   }
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
      Else If ( (CompKey = "o_small") or (CompKey = "o_capital") )
         Send {bs}©
      Else
         sendinput {blind}c
      If (PriorDeadKey = "comp")
         CompKey := "c_small"
      Else
         CompKey := ""
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
      Else If ( (CompKey = "o_small") or (CompKey = "o_capital") )
         Send {bs}©         
      Else 
         sendinput {blind}C
      If (PriorDeadKey = "comp")
         CompKey = "c_capital"
      Else
         CompKey := ""
   }
   else if Ebene = 3
   {
      send ]
      CompKey := ""
   }
   else if Ebene = 4
   {
      SendUnicodeChar(0x03C7) ;chi
      CompKey := ""
   }
   else if Ebene = 5
   {
      Send {Backspace}
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x039B)  ; Lambda
      CompKey := ""
   }
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
   else if Ebene = 5
      Send {Insert}
   else if Ebene = 6
      Send +{Insert}
   PriorDeadKey := ""   CompKey := ""
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
   PriorDeadKey := ""   CompKey := ""
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
   {
      If (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x2077)
      Else If (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2087)
      Else
         Send 7
   }
   else if Ebene = 6
      SendUnicodeChar(0x03A8)  ; Psi
   PriorDeadKey := ""   CompKey := ""
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
   {
      If (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x2078)
      Else If (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2088)
      Else
         Send 8
   }
   else if Ebene = 6
      SendUnicodeChar(0x0393)  ; Gamma
   PriorDeadKey := ""   CompKey := ""
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
      SendUnicodeChar(0x03C6) ;phi
   else if Ebene = 5
   {
      If (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x2079)
      Else If (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2089)
      Else
         Send 9
   }
   else if Ebene = 6
      SendUnicodeChar(0x03A6)  ; Phi
   PriorDeadKey := ""   CompKey := ""
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
      SendUnicodeChar(0x0278)  ; Varphi? (latin letter phi)
   else if Ebene = 5
   {
      If (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x207A)
      Else If (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x208A)
      Else
         Send {+}
   }
   else if Ebene = 6
      SendUnicodeChar(0x2202) ; "verdrehtes e" (partielle Ableitung)
   PriorDeadKey := ""   CompKey := ""
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
   else if Ebene = 5
      SendUnicodeChar(0x0259) ; schwa
   else if Ebene = 6
      SendUnicodeChar(0x018F)  ; Schwa
   PriorDeadKey := ""   CompKey := ""
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
   else if Ebene = 6
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
   PriorDeadKey := ""   CompKey := ""
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
      If (PriorDeadKey = "comp")            ; compose
         CompKey := "i_small"
      Else 
         CompKey := ""
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
      If (PriorDeadKey = "comp")            ; compose
         CompKey := "i_capital"
      Else
         CompKey := ""
   }
   else if Ebene = 3
   {
      send `/
      CompKey := ""
   }
   else if Ebene = 4
   {
      SendUnicodeChar(0x03B9) ;iota
      CompKey := ""
   }
   else if Ebene = 5
   {
      Sendinput {Blind}{Left}
      CompKey := ""
   }
   else if Ebene = 6
   {
      Sendinput {Blind}+{Left}
      CompKey := ""
   }
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
      If (PriorDeadKey = "comp")            ; compose
         CompKey := "a_small"
      Else
         CompKey := ""
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
      If (PriorDeadKey = "comp")            ; compose
         CompKey := "a_capital"
      Else
         CompKey := ""
   }
   else if Ebene = 3
   {
      sendraw {
      CompKey := ""
   }
   else if Ebene = 4
   {
      SendUnicodeChar(0x03B1) ;alpha
      CompKey := ""
   }
   else if Ebene = 5
   {
      Sendinput {Blind}{Down}
      CompKey := ""
   }
   else if Ebene = 6
   {
      Sendinput {Blind}+{Down}
      CompKey := ""
   }
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
      Else If (CompKey = "a_small")        ; compose
      {
         Send {bs}æ
         CompKey := ""
      }
      Else If (CompKey = "o_small")        ; compose
      {
         Send {bs}œ
         CompKey := ""
      }      
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
      Else If (CompKey = "a_capital")        ; compose
      {
         Send {bs}Æ
         CompKey := ""
      }
      Else If (CompKey = "o_capital")        ; compose
      {
         Send {bs}Œ
         CompKey := ""
      }      
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
   PriorDeadKey := ""   CompKey := ""
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
      If (PriorDeadKey = "comp")            ; compose
         CompKey := "o_small"
      Else
         CompKey := ""
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
      If (PriorDeadKey = "comp")            ; compose
         CompKey := "o_capital"
      Else
         CompKey := ""
   }
   else if Ebene = 3
   {
      send *
      CompKey := ""
   }
   else if Ebene = 4
   {
      SendUnicodeChar(0x03C9) ;omega
      CompKey := ""
   }
   else if Ebene = 5
   {
      Send {blind}{End}
      CompKey := ""
   }
   else if Ebene = 6
   {
      Send {blind}+{End}
      CompKey := ""
   }
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
      If (PriorDeadKey = "comp")
         CompKey := "s_small"
      Else
         CompKey := ""
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
      If (PriorDeadKey = "comp")
         CompKey := "s_capital"
      Else
         CompKey := ""
   }
   else if Ebene = 3
   {
      send ?
      CompKey := ""
   }
   else if Ebene = 4
   {
      SendUnicodeChar(0x03C3) ;sigma
      CompKey := ""
   }
   else if Ebene = 5
   {
      Send ¿
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x03A3)  ; Sigma
      CompKey := ""
   }
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
   {
      If (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x2074)
      Else If (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2084)
      Else
         Send 4
   }
   PriorDeadKey := ""   CompKey := ""
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
      If (PriorDeadKey = "comp")
         CompKey := "r_small"
      Else
         CompKey := ""
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
      If (PriorDeadKey = "comp")
         CompKey := "r_capital"
      Else
         CompKey := ""
   }
   else if Ebene = 3
   {
      send )
      CompKey := ""
   }
   else if Ebene = 4
   {
      SendUnicodeChar(0x03C1) ;rho
      CompKey := ""
   }
   else if Ebene = 5
   {
      If (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x2075)
      Else If (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2085)
      Else
         Send 5
      CompKey := ""
   }
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
      If (PriorDeadKey = "comp")
         CompKey := "t_small"
      Else
         CompKey := ""
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
      If (PriorDeadKey = "comp")
         CompKey := "t_capital"
      Else
         CompKey := ""
   }
   else if Ebene = 3
   {
      send {blind}- ; Bind
      CompKey := ""
   }
   else if Ebene = 4
   {
      SendUnicodeChar(0x03C4) ;tau
      CompKey := ""
   }
   else if Ebene = 5
   {
      If (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x2076)
      Else If (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2086)
      Else
         Send 6
      CompKey := ""
   }
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
   else if Ebene = 6
      SendUnicodeChar(0x0394)  ; Delta
   PriorDeadKey := ""   CompKey := ""
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
      Send þ         ; thorn
   else if Ebene = 6
      Send Þ         ; Thorn
   PriorDeadKey := ""   CompKey := ""
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
      send {blind}{#}
   else if Ebene = 5
      Send {Esc}
   PriorDeadKey := ""   CompKey := ""
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
   PriorDeadKey := ""   CompKey := ""
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
   PriorDeadKey := ""   CompKey := ""
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
   else if Ebene = 6
      SendUnicodeChar(0x03A0)  ; Pi
   PriorDeadKey := ""   CompKey := ""
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
   else if Ebene = 6
      SendUnicodeChar(0x03A9)  ; Omega
   PriorDeadKey := ""   CompKey := ""
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
   else if Ebene = 6
      SendUnicodeChar(0x221E) ;infty
   PriorDeadKey := ""   CompKey := ""
return

*m::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "a5")       ; punkt darüber 
         BSSendUnicodeChar(0x1E41)
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E43)
      Else If ( (CompKey = "t_small") or (CompKey = "t_capital") )       ; compose
         CompUnicodeChar(0x2122)          ; TM
      Else If ( (CompKey = "s_small") or (CompKey = "s_capital") )       ; compose
         CompUnicodeChar(0x2120)          ; SM
      Else
         sendinput {blind}m
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "a5")       ; punkt darüber 
         BSSendUnicodeChar(0x1E40)
      Else If (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E42)
      Else If ( (CompKey = "t_capital") or (CompKey = "t_small") )       ; compose
         CompUnicodeChar(0x2122)          ; TM
      Else If ( (CompKey = "s_capital") or (CompKey = "s_small") )       ; compose
         CompUnicodeChar(0x2120)          ; SM
      Else 
         sendinput {blind}M
   }
   else if Ebene = 3
      send `%
   else if Ebene = 4
      SendUnicodeChar(0x03BC) ;micro, mu wäre 0x00B5
   else if Ebene = 5
   {
      If (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x00B9)
      Else If (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2081)
      Else
         Send 1
   }
   else if Ebene = 6
      SendUnicodeChar(0x222B) ; Int
   PriorDeadKey := ""   CompKey := ""
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
   {
      If (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x00B2)
      Else If (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2082)
      Else
         Send 2
   }
   else if Ebene = 6
      SendUnicodeChar(0x221A) ; sqrt
   PriorDeadKey := ""   CompKey := ""
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
   {
      If (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x00B3)
      Else If (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2083)
      Else
         Send 3
   }
   else if Ebene = 6
      SendUnicodeChar(0x0398)  ; Theta
   PriorDeadKey := ""   CompKey := ""
return


*-::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x0135)
      Else If (PriorDeadKey = "c2")      ; caron
         BSSendUnicodeChar(0x01F0)
      Else If (CompKey = "i_small")        ; compose
         CompUnicodeChar(0x0133)          ; ij
      Else If (CompKey = "l_small")        ; compose
         CompUnicodeChar(0x01C9)          ; lj
      Else If (CompKey = "l_capital")       ; compose
         CompUnicodeChar(0x01C8)          ; Lj
      Else
         sendinput {blind}j
   }
   else if Ebene = 2
   {
      If (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x0134)
      Else If (CompKey = "i_capital")        ; compose
         CompUnicodeChar(0x0132)          ; IJ
      Else If (CompKey = "l_capital")        ; compose
         CompUnicodeChar(0x01C7)          ; LJ
      Else
         sendinput {blind}J
   }
   else if Ebene = 3
      send `;
   else if Ebene = 4
      SendUnicodeChar(0x03D1) ; vartheta
   else if Ebene = 5
      Send .
   else if Ebene = 6
      SendUnicodeChar(0x2207) ; Nabla
   PriorDeadKey := ""   CompKey := ""
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
   PriorDeadKey := ""   CompKey := ""
return

*NumpadMult::
   EbeneAktualisieren()
   if ( (Ebene = 1) or (Ebene = 2) )
      send {NumpadMult}
   else if Ebene = 3
      send ×
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x22C5)  ; cdot
   PriorDeadKey := ""   CompKey := ""
return

*NumpadSub::
   EbeneAktualisieren()
   if ( (Ebene = 1) or (Ebene = 2) )
   {
      If (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x207B)
      Else If (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x208B)         
      Else
         send {blind}{NumpadSub}
   }
   else if Ebene = 3
      SendUnicodeChar(0x2212) ; echtes minus
   PriorDeadKey := ""   CompKey := ""
return

*NumpadAdd::
   EbeneAktualisieren()
   if ( (Ebene = 1) or (Ebene = 2) )
   {
      If (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x207A)
      Else If (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x208A)         
      Else
         send {blind}{NumpadAdd}
   }
   else if Ebene = 3
      send ±
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x2213)   ; -+
   PriorDeadKey := ""   CompKey := ""
return

*NumpadEnter::
   EbeneAktualisieren()
   if ( (Ebene = 1) or (Ebene = 2) )
      send {NumpadEnter}      
   else if Ebene = 3
      SendUnicodeChar(0x2260) ; neq
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x2248) ; approx
   PriorDeadKey := ""   CompKey := ""
return

/*
   folgende Tasten verhalten sich bei ein- und ausgeschaltetem NumLock
   unterschiedlich:

   bei NumLock ein
*/



*Numpad7::
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {blind}{Numpad7}
      If (PriorDeadKey = "comp")
         CompKey := "Num_7"
      Else
         CompKey := ""       
   }
   else if Ebene = 2
   {
      send {NumpadHome}
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x226A)  ; ll
      CompKey := ""
   }
   PriorDeadKey := ""
return

*Numpad8::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (CompKey = "Num_1")
         CompUnicodeChar(0x215B)       ; 1/8
      Else If (CompKey = "Num_3")
         CompUnicodeChar(0x215C)       ; 3/8
      Else If (CompKey = "Num_5")
         CompUnicodeChar(0x215D)       ; 5/8
      Else If (CompKey = "Num_7")
         CompUnicodeChar(0x215E)       ; 7/8
      Else
         send {blind}{Numpad8}
      If (PriorDeadKey = "comp")
         CompKey := "Num_8"
      Else
         CompKey := "" 
   }
   else if Ebene = 2
   {
      send {NumpadUp}
      CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x2191)     ; uparrow
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x2229)    ; intersection
      CompKey := ""
   }
   PriorDeadKey := ""   CompKey := ""
return

*Numpad9::
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {blind}{Numpad9}
      If (PriorDeadKey = "comp")
         CompKey := "Num_9"
      Else
         CompKey := "" 
   }
   else if Ebene = 2
   {
      send {NumpadPgUp}
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x226B)  ; gg
      CompKey := ""
   }
   PriorDeadKey := ""
return



*Numpad4::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (CompKey = "Num_1")
         CompUnicodeChar(0x00BC)       ; 1/4
      Else If (CompKey = "Num_3")
         CompUnicodeChar(0x00BE)       ; 3/4
      Else
         send {blind}{Numpad4}
      If (PriorDeadKey = "comp")
         CompKey := "Num_4"
      Else
         CompKey := ""
   }
   else if Ebene = 2
   {
      send {NumpadLeft}
      CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x2190)     ; leftarrow
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x2282)  ; subset of
      CompKey := ""
   }
   PriorDeadKey := ""
return

*Numpad5::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (CompKey = "Num_1")
         CompUnicodeChar(0x2155)       ; 1/5
      Else If (CompKey = "Num_2")
         CompUnicodeChar(0x2156)       ; 2/5
      Else If (CompKey = "Num_3")
         CompUnicodeChar(0x2157)       ; 3/5
      Else If (CompKey = "Num_4")
         CompUnicodeChar(0x2158)       ; 4/5
      Else
         send {blind}{Numpad5}
      If (PriorDeadKey = "comp")
         CompKey := "Num_5"
      Else
         CompKey := ""
   }
   else if Ebene = 2
   {
      send {NumpadClear}
      CompKey := ""
   }
   else if Ebene = 3
   {
      send †
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x220A) ; small element of
      CompKey := ""
   }
   PriorDeadKey := ""
return

*Numpad6::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (CompKey = "Num_1")
         CompUnicodeChar(0x2159)       ; 1/6
      Else If (CompKey = "Num_5")
         CompUnicodeChar(0x215A)       ; 5/6
      Else
         send {blind}{Numpad6}
      If (PriorDeadKey = "comp")
         CompKey := "Num_6"
      Else
         CompKey := ""
   }
   else if Ebene = 2
   {
      send {NumpadRight}
      CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x2192)     ; rightarrow
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x2283) ; superset of
      CompKey := ""
   }
   PriorDeadKey := ""
return

*Numpad1::
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {blind}{Numpad1}
      If (PriorDeadKey = "comp")
         CompKey := "Num_1"
      Else
         CompKey := ""
   }
   else if Ebene = 2
   {
      send {NumpadEnd}
      CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x21CB) ; LEFTWARDS HARPOON OVER RIGHTWARDS HARPOON
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x2264)   ; leq
      CompKey := ""
   }
   PriorDeadKey := ""
return

*Numpad2::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (CompKey = "Num_1")
         CompUnicodeChar(0x00BD)       ; 1/2
      Else
         send {blind}{Numpad2}
      If (PriorDeadKey = "comp")
         CompKey := "Num_2"
      Else
         CompKey := ""
   }
   else if Ebene = 2
   {
      send {NumpadDown}
      CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x2193)     ; downarrow
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x222A)  ; vereinigt
      CompKey := ""
   }
   PriorDeadKey := ""
return

*Numpad3::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (CompKey = "Num_1")
         CompUnicodeChar(0x2153)       ; 1/3
      Else If (CompKey = "Num_2")
         CompUnicodeChar(0x2154)       ; 2/3
      Else
         send {blind}{Numpad3}
      If (PriorDeadKey = "comp")
         CompKey := "Num_3"
      Else
         CompKey := ""
   }
   else if Ebene = 2
      send {NumpadPgDn}
   else if Ebene = 3
      SendUnicodeChar(0x21CC) ; RIGHTWARDS HARPOON OVER LEFTWARDS HARPOON
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x2265)  ; geq
   PriorDeadKey := ""   CompKey := ""
return

*Numpad0::
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {blind}{Numpad0}
      If (PriorDeadKey = "comp")
         CompKey := "Num_0"
      Else
         CompKey := ""
   }
   else if Ebene = 2
   {
      send {NumpadIns}
      CompKey := ""
   }
   else if Ebene = 3
   {
      send `%
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      send ‰ 
      CompKey := ""
   }
   PriorDeadKey := ""
return

*NumpadDot::
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadDot}
      CompKey := ""
   }
   else if Ebene = 2
   {
      send {NumpadDel}
      CompKey := ""
   }
   else if Ebene = 3
   {
      send .
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      send `,
      CompKey := ""
   }
   PriorDeadKey := ""
return

/*
   bei NumLock aus
*/

*NumpadHome::
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadHome}
      CompKey := ""
   }
   else if Ebene = 2
   {
      send {Numpad7}
      If (PriorDeadKey = "comp")
         CompKey := "Num_7"
      Else
         CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x226A)  ; ll
      CompKey := ""
   }
   PriorDeadKey := ""
return

*NumpadUp::
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadUp}
      CompKey := ""
   }
   else if Ebene = 2
   {
      If (CompKey = "Num_1")
         CompUnicodeChar(0x215B)       ; 1/8
      Else If (CompKey = "Num_3")
         CompUnicodeChar(0x215C)       ; 3/8
      Else If (CompKey = "Num_5")
         CompUnicodeChar(0x215D)       ; 5/8
      Else If (CompKey = "Num_7")
         CompUnicodeChar(0x215E)       ; 7/8
      Else
         send {Numpad8}
      If (PriorDeadKey = "comp")
         CompKey := "Num_8"
      Else
         CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x2191)     ; uparrow
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x2229)    ; intersection
      CompKey := ""
   }
   PriorDeadKey := ""
return

*NumpadPgUp::
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadPgUp}
      CompKey := ""
   }
   else if Ebene = 2
   {
      send {Numpad9}
      If (PriorDeadKey = "comp")
         CompKey := "Num_9"
      Else
         CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x226B)  ; gg
      CompKey := ""
   }
   PriorDeadKey := ""
return

*NumpadLeft::
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadLeft}
      CompKey := ""
   }
   else if Ebene = 2
   {
      If (CompKey = "Num_1")
         CompUnicodeChar(0x00BC)       ; 1/4
      Else If (CompKey = "Num_3")
         CompUnicodeChar(0x00BE)       ; 3/4
      Else
         send {Numpad4}
      If (PriorDeadKey = "comp")
         CompKey := "Num_4"
      Else
         CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x2190)     ; leftarrow
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x2282)  ; subset of
      CompKey := ""
   }
   PriorDeadKey := ""
return

*NumpadClear::
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadClear}
      CompKey := ""
   }
   else if Ebene = 2
   {
      If (CompKey = "Num_1")
         CompUnicodeChar(0x2155)       ; 1/5
      Else If (CompKey = "Num_2")
         CompUnicodeChar(0x2156)       ; 2/5
      Else If (CompKey = "Num_3")
         CompUnicodeChar(0x2157)       ; 3/5
      Else If (CompKey = "Num_4")
         CompUnicodeChar(0x2158)       ; 4/5
      Else
         send {Numpad5}
      If (PriorDeadKey = "comp")
         CompKey := "Num_5"
      Else
         CompKey := ""
   }
   else if Ebene = 3
   {
      send †
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x220A) ; small element of
      CompKey := ""
   }
   PriorDeadKey := ""
return

*NumpadRight::
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadRight}
      CompKey := ""
   }
   else if Ebene = 2
   {
      If (CompKey = "Num_1")
         CompUnicodeChar(0x2159)       ; 1/6
      Else If (CompKey = "Num_5")
         CompUnicodeChar(0x215A)       ; 5/6
      Else
         send {Numpad6}
      If (PriorDeadKey = "comp")
         CompKey := "Num_6"
      Else
         CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x2192)     ; rightarrow
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x2283) ; superset of
      CompKey := ""
   }
   PriorDeadKey := ""
return

*NumpadEnd::
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadEnd}
      CompKey := ""
   }
   else if Ebene = 2
   {
      send {Numpad1}
      If (PriorDeadKey = "comp")
         CompKey := "Num_1"
      Else
         CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x21CB) ; LEFTWARDS HARPOON OVER RIGHTWARDS HARPOON
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x2264)   ; leq
      CompKey := ""
   }
   PriorDeadKey := ""
return

*NumpadDown::
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadDown}
      CompKey := ""
   }
   else if Ebene = 2
   {
      If (CompKey = "Num_1")
         CompUnicodeChar(0x00BD)       ; 1/2
      Else
         send {Numpad2}
      If (PriorDeadKey = "comp")
         CompKey := "Num_2"
      Else
         CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x2193)     ; downarrow
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x222A)  ; vereinigt
      CompKey := ""
   }
   PriorDeadKey := ""
return

*NumpadPgDn::
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadPgDn}
      CompKey := ""
   }
   else if Ebene = 2
   {
      If (CompKey = "Num_1")
         CompUnicodeChar(0x2153)       ; 1/3
      Else If (CompKey = "Num_2")
         CompUnicodeChar(0x2154)       ; 2/3
      Else
         send {Numpad3}
      If (PriorDeadKey = "comp")
         CompKey := "Num_3"
      Else
         CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x21CC) ; RIGHTWARDS HARPOON OVER LEFTWARDS HARPOON   
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x2265)  ; geq
      CompKey := ""
   }
   PriorDeadKey := ""
return

*NumpadIns::
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadIns}
      CompKey := ""
   }
   else if Ebene = 2
   {
      send {Numpad0}
      If (PriorDeadKey = "comp")
         CompKey := "Num_0"
      Else
         CompKey := ""
   }
   else if Ebene = 3
   {
      send `%
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      send ‰ 
      CompKey := ""
   }
   PriorDeadKey := ""
return

*NumpadDel::
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadDel}
      CompKey := ""
   }
   else if Ebene = 2
   {
      send {NumpadDot}
      CompKey := ""
   }
   else if Ebene = 3
   {
      send .
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      send `,
      CompKey := ""
   }
   PriorDeadKey := ""
return


/*
   ------------------------------------------------------
   Sondertasten
   ------------------------------------------------------
*/

*Space::
   EbeneAktualisieren()
   if Ebene = 1
   {
      If (CompKey = "r_small_1")
         Comp3UnicodeChar(0x2170)          ; römisch i
      Else If (CompKey = "r_capital_1")
         Comp3UnicodeChar(0x2160)          ; römisch I
      Else
         Send {blind}{Space}
   }
   if  Ebene  =  2
      Send  {blind}{Space}
   if Ebene = 3
      Send {blind}{Space}
   if Ebene = 4
      SendUnicodeChar(0x00A0)   ; geschütztes Leerzeichen
   else if Ebene = 5
   {
      If (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x2070)
      Else If (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2080)
      Else
         Send 0
   }
   else if Ebene = 6
      SendUnicodeChar(0x202F) ; schmales Leerzeichen
   PriorDeadKey := ""   CompKey := ""
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
   PriorDeadKey := ""   CompKey := ""
return

*Backspace::
   sendinput {Blind}{Backspace}
   PriorDeadKey := ""   CompKey := ""
return



/*
Auf Mod3+Tab liegt Compose. AltTab funktioniert, jedoch ShiftAltTab nicht.
Wenigstens kommt es jetzt nicht mehr zu komischen Ergebnissen, wenn man Tab 
nach einem DeadKey drückt...
*/

*Tab::
   if ( GetKeyState("SC038","P") )
   {
      SC038 & Tab::AltTab            ; http://de.autohotkey.com/docs/Hotkeys.htm#AltTabDetail
   }
   else if GetKeyState("#","P")
   {
      PriorDeadKey := "comp"
      CompKey := ""
   }
   else
   {
      send {blind}{Tab}
      PriorDeadKey := ""
      CompKey := ""
   }
return

*SC038::                            ; LAlt, damit AltTab funktioniert
   send {blind}{LAlt}
   PriorDeadKey := ""   CompKey := ""
return

*Home::
   sendinput {Blind}{Home}
   PriorDeadKey := ""   CompKey := ""
return

*End::
   sendinput {Blind}{End}
   PriorDeadKey := ""   CompKey := ""
return

*PgUp::
   sendinput {Blind}{PgUp}
   PriorDeadKey := ""   CompKey := ""
return

*PgDn::
   sendinput {Blind}{PgDn}
   PriorDeadKey := ""   CompKey := ""
return

*Up::
   sendinput {Blind}{Up}
   PriorDeadKey := ""   CompKey := ""
return

*Down::
   sendinput {Blind}{Down}
   PriorDeadKey := ""   CompKey := ""
return

*Left::
   sendinput {Blind}{Left}
   PriorDeadKey := ""   CompKey := ""
return

*Right::
   sendinput {Blind}{Right}
   PriorDeadKey := ""   CompKey := ""
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
   
   ; ist Mod4 down? Mod3 hat Vorrang!
   else if ( GetKeyState("<","P") or GetKeyState("SC138","P") )
   {
      Ebene += 4
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

CompUnicodeChar(charCode)
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

Comp3UnicodeChar(charCode)
{
   send {bs}
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
