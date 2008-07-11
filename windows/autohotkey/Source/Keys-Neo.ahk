/*
Die eigentliche NEO-Belegung und der Hauptteil des AHK-Treibers.


   Ablauf bei toten Tasten:
   1. Ebene Aktualisieren
   2. Abhängig von der Variablen "Ebene" Zeichen ausgeben und die Variable "PriorDeadKey" setzen
   
   Ablauf bei "untoten" Tasten:
   1. Ebene Aktualisieren
   2. Abhängig von den Variablen "Ebene" und "PriorDeadKey" Zeichen ausgeben
   3. "PriorDeadKey" mit leerem String überschreiben

   ------------------------------------------------------
   Reihe 1
   ------------------------------------------------------
*/


neo_tot1:
   EbeneAktualisieren()
   if Ebene = 1
   {
      SendUnicodeChar(0x02C6) ; circumflex, tot
      PriorDeadKey := "c1"
   }
   else if Ebene = 2
   {
      SendUnicodeChar(0x02C7) ; caron, tot
      PriorDeadKey := "c2"
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x02D8) ; brevis
      PriorDeadKey := "c3"
   }
   else if Ebene = 4
   {
      SendUnicodeChar(0x00B7) ; Mittenpunkt, tot
      PriorDeadKey := "c5"
   }
   else if Ebene = 5
   {
      send -                  ; querstrich, tot
      PriorDeadKey := "c4"
   }
   else if Ebene = 6
   {
      Send .                  ; punkt darunter (colon)
      PriorDeadKey := "c6"
   }
return

neo_1:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")          ; circumflex 1
         BSSendUnicodeChar(0x00B9)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2081)
      else if (CompKey = "r_small_1")
         Comp3UnicodeChar(0x217A)          ; römisch xi
      else if (CompKey = "r_capital_1")
         Comp3UnicodeChar(0x216A)          ; römisch XI
      else
       {  
         if GetKeyState("CapsLock","T") 
         {
           if (IsModifierPressed())
           {
             send {blind}1
           }
           else
           {
              send 1
           }   
         }
         else {
            if ( not(lernModus) or (lernModus_std_ZahlenReihe) )
            {
                send {blind}1
            }
         }
       }
      if (PriorDeadKey = "comp")
         CompKey := "1"
      else if (CompKey = "r_small")
         CompKey := "r_small_1"
      else if (CompKey = "r_capital")
         CompKey := "r_capital_1"
      else
         CompKey := ""
   }
   else if Ebene = 2
   {
      send °
      CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x00B9) ; 2 Hochgestellte
      CompKey := ""
   }
   else if Ebene = 4
   {
      SendUnicodeChar(0x2022) ; bullet
      CompKey := ""
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x2640) ; Piktogramm weiblich
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x00AC) ; Nicht-Symbol
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_2:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")          ; circumflex 
         BSSendUnicodeChar(0x00B2)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2082)
      else if (CompKey = "r_small")
         CompUnicodeChar(0x2171)          ; römisch ii
      else if (CompKey = "r_capital")
         CompUnicodeChar(0x2161)          ; römisch II
      else if (CompKey = "r_small_1")
         Comp3UnicodeChar(0x217B)          ; römisch xii
      else if (CompKey = "r_capital_1")
         Comp3UnicodeChar(0x216B)          ; römisch XII
      else
       {  
         if GetKeyState("CapsLock","T") 
         {
           if (IsModifierPressed())
           {
             send {blind}2
           }
           else
           {
              send 2
           }
               
         }
         else {
            if ( not(lernModus) or (lernModus_std_ZahlenReihe) )
            {
                send {blind}2
            }
         }
       }
      if (PriorDeadKey = "comp")
         CompKey := "2"
      else
         CompKey := ""         
   }
   else if Ebene = 2
   {
      SendUnicodeChar(0x2116) ; numero
      CompKey := ""
   }
   else if Ebene = 3
   {    
      SendUnicodeChar(0x00B2) ; 2 Hochgestellte
      CompKey := ""
   }
   else if Ebene = 4
   {
      SendUnicodeChar(0x2023) ; aufzaehlungspfeil
      CompKey := ""
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x26A5) ; Piktogramm Zwitter
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x2228) ; Logisches Oder
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_3:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x00B3)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2083)
      else if (CompKey = "1")
         CompUnicodeChar(0x2153)          ; 1/3
      else if (CompKey = "2")
         CompUnicodeChar(0x2154)          ; 2/3
      else if (CompKey = "r_small")
         CompUnicodeChar(0x2172)          ; römisch iii
      else if (CompKey = "r_capital")
         CompUnicodeChar(0x2162)          ; römisch III
      else
       {  
         if GetKeyState("CapsLock","T") 
         {
           if (IsModifierPressed())
           {
             send {blind}3
           }
           else
           {
               send 3
           }    
         }
         else {
            if ( not(lernModus) or (lernModus_std_ZahlenReihe) )
            {           
              send {blind}3
            }
         }
       }
      if (PriorDeadKey = "comp")
         CompKey := "3"
      else
         CompKey := ""         
   }
   else if Ebene = 2
   {
      send §
      CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x00B3) ; 3 Hochgestellte
      CompKey := ""
   }
   else if Ebene = 4
   { } ; leer
   else if Ebene = 5
   {
      SendUnicodeChar(0x2642) ; Piktogramm Mann
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x2227) ; Logisches Und
      CompKey := ""
   }   
   PriorDeadKey := ""
return

neo_4:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x2074)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2084)         
      else if (CompKey = "r_small")
         CompUnicodeChar(0x2173)          ; römisch iv
      else if (CompKey = "r_capital")
         CompUnicodeChar(0x2163)          ; römisch IV
      else
       {  
         if GetKeyState("CapsLock","T") 
         {
           if (IsModifierPressed())
           {
             send {blind}4
           }
           else
           {
              send 4
           }
               
         }
         else
         {
           if ( not(lernModus) or (lernModus_std_ZahlenReihe) )
           {
               send {blind}4
           }
         }
       }
      if (PriorDeadKey = "comp")
         CompKey := "4"
      else
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
   else if Ebene = 4
   {
      Send {PgUp}    ; Prev
      CompKey := ""
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x2113) ; Script small L
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x22A5) ; Senkrecht
      CompKey := ""
   }   
   PriorDeadKey := ""
return

neo_5:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x2075)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2085)
      else if (CompKey = "1")
         CompUnicodeChar(0x2155)          ; 1/5
      else if (CompKey = "2")
         CompUnicodeChar(0x2156)          ; 2/5
      else if (CompKey = "3")
         CompUnicodeChar(0x2157)          ; 3/5
      else if (CompKey = "4")
         CompUnicodeChar(0x2158)          ; 4/5
      else if (CompKey = "r_small")
         CompUnicodeChar(0x2174)          ; römisch v
      else if (CompKey = "r_capital")
         CompUnicodeChar(0x2164)          ; römisch V
      else
       {  
         if GetKeyState("CapsLock","T") 
         {
           if (IsModifierPressed())
           {
             send {blind}5
           }
           else
           {
              send 5
           }
               
         }
         else {
            if ( not(lernModus) or (lernModus_std_ZahlenReihe) )
            {
               send {blind}5
            }
         }
       }
      if (PriorDeadKey = "comp")
         CompKey := "5"
      else
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
   else if Ebene = 4
   { } ; leer
   else if Ebene = 5
   {
      SendUnicodeChar(0x2020) ; Kreuz (Dagger)
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x2221) ; Winkel
      CompKey := ""
   }   
   PriorDeadKey := ""
return

neo_6:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x2076)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2086)         
      else if (CompKey = "1")
         CompUnicodeChar(0x2159)          ; 1/6
      else if (CompKey = "5")
         CompUnicodeChar(0x215A)          ; 5/6
      else if (CompKey = "r_small")
         CompUnicodeChar(0x2175)          ; römisch vi
      else if (CompKey = "r_capital")
         CompUnicodeChar(0x2165)          ; römisch VI
      else
       {  
         if GetKeyState("CapsLock","T") 
         {
           if (IsModifierPressed())
           {
             send {blind}6
           }
           else
           {
              send 6
           }
               
         }
         else {
            if ( not(lernModus) or (lernModus_std_ZahlenReihe) )
            {
              send {blind}6
            }
         }
       }
      if (PriorDeadKey = "comp")
         CompKey := "6"
      else
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
      send £
      CompKey := ""
   }
   else if Ebene = 5
   {  } ; leer
   else if Ebene = 6
   {
      SendUnicodeChar(0x2225) ; parallel
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_7:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x2077)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2087)
      else if (CompKey = "r_small")
         CompUnicodeChar(0x2176)          ; römisch vii
      else if (CompKey = "r_capital")
         CompUnicodeChar(0x2166)          ; römisch VII
      else
       {  
         if GetKeyState("CapsLock","T") 
         {
           if (IsModifierPressed())
           {
             send {blind}7
           }
           else
           {
              send 7
           }
               
         }
         else {
            if ( not(lernModus) or (lernModus_std_ZahlenReihe) )
            {
               send {blind}7
            }
         }
       }
      if (PriorDeadKey = "comp")
         CompKey := "7"
      else
         CompKey := ""         
    }
   else if Ebene = 2
   {
      send $
      CompKey := ""
   }
   else if Ebene = 3
   {
      send ¥
      CompKey := ""
   }
   else if Ebene = 4
   {
      send ¤ 
      CompKey := ""
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x03BA) ; greek small letter kappa
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x2209) ; nicht Element von 
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_8:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x2078)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2088)
      else if (CompKey = "1")
         CompUnicodeChar(0x215B)          ; 1/8
      else if (CompKey = "3")
         CompUnicodeChar(0x215C)          ; 3/8
      else if (CompKey = "5")
         CompUnicodeChar(0x215D)          ; 5/8
      else if (CompKey = "7")
         CompUnicodeChar(0x215E)          ; 7/8
      else if (CompKey = "r_small")
         CompUnicodeChar(0x2177)          ; römisch viii
      else if (CompKey = "r_capital")
         CompUnicodeChar(0x2167)          ; römisch VIII
      else
       {  
         if GetKeyState("CapsLock","T") 
         {
           if (IsModifierPressed())
           {
             send {blind}8
           }
           else
           {
              send 8
           }
               
         }
         else {
            if ( not(lernModus) or (lernModus_std_ZahlenReihe) )
            {
              send {blind}8
            }   
         }
       }
      if (PriorDeadKey = "comp")
         CompKey := "8"
      else
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
   else if Ebene = 4
   {
      Send /
      CompKey := ""
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x27E8) ;bra (öffnende spitze klammer)
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x2204) ; es existiert nicht
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_9:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x2079)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2089)
      else if (CompKey = "r_small")
         CompUnicodeChar(0x2178)          ; römisch ix
      else if (CompKey = "r_capital")
         CompUnicodeChar(0x2168)          ; römisch IX
      else
       {  
         if GetKeyState("CapsLock","T") 
         {
           if (IsModifierPressed())
           {
             send {blind}9
           }
           else
           {
              send 9
           }
               
         }
         else {
            if ( not(lernModus) or (lernModus_std_ZahlenReihe) )
            {
              send {blind}9
            }
         }
       }
      if (PriorDeadKey = "comp")
         CompKey := "9"
      else
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
   else if Ebene = 4
   {
      Send *
      CompKey := ""
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x27E9) ;ket (schließende spitze klammer)
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x2226) ; nicht parallel
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_0:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x2070)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2080)         
      else if (CompKey = "r_small_1")
         Comp3UnicodeChar(0x2179)          ; römisch x
      else if (CompKey = "r_capital_1")
         Comp3UnicodeChar(0x2169)          ; römisch X
      else
       {  
         if GetKeyState("CapsLock","T") 
         {
           if (IsModifierPressed())
           {
             send {blind}0
           }
           else
           {
              send 0
           }
               
         }
         else {
            if ( not(lernModus) or (lernModus_std_ZahlenReihe) )
            {
               send {blind}0
            }
         }
       }
      if (PriorDeadKey = "comp")
         CompKey := "0"
      else
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
   else if Ebene = 4
   {
      Send -
      CompKey := ""
   }
   else if Ebene = 5
   {  } ; leer
   else if Ebene = 6
   {
      SendUnicodeChar(0x2205) ; leere Menge
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_strich:
   EbeneAktualisieren()
   if Ebene = 1
        {  
         if GetKeyState("CapsLock","T") 
         {
           if (IsModifierPressed())
           {
             send {blind}-
           }
           else
           {
              send -
           }
               
         }
         else {
           send {blind}-   ;Bindestrich
         }
       }
   else if Ebene = 2
      SendUnicodeChar(0x2013) ; Gedankenstrich
   else if Ebene = 3
      SendUnicodeChar(0x2014) ; Englische Gedankenstrich
   else if Ebene = 4
     { } ; leer ...  SendUnicodeChar(0x254C) 
   else if Ebene = 5
      SendUnicodeChar(0x2011) ; geschützter Bindestrich
   else if Ebene = 6
      SendUnicodeChar(0x00AD) ; weicher Trennstrich
   PriorDeadKey := ""   CompKey := ""
return

neo_tot2:
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
      SendUnicodeChar(0x02D9) ; punkt oben drüber
      PriorDeadKey := "a5"
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x02DB) ; ogonek
      PriorDeadKey := "a4"
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

neo_x:
   EbeneAktualisieren()
   if Ebene = 1
      sendinput {blind}x
   else if Ebene = 2
      sendinput {blind}X
   else if Ebene = 5
      SendUnicodeChar(0x03BE) ;xi
   else if Ebene = 6
      SendUnicodeChar(0x039E)  ; Xi
   PriorDeadKey := ""   CompKey := ""
return


neo_v:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c6")      ; punkt darunter 
         BSSendUnicodeChar(0x1E7F)
      else
         sendinput {blind}v
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c6")      ; punkt darunter
         BSSendUnicodeChar(0x1E7E)
      else 
         sendinput {blind}V
   }
   else if Ebene = 3
      send _
   else if Ebene = 4
      if ( not(lernModus) or (lernModus_neo_Backspace) )
      {
         Send {Backspace}
      }
      else 
      {} ; leer
   else if Ebene = 6
      SendUnicodeChar(0x2259) ; estimates
   PriorDeadKey := ""   CompKey := ""
return



neo_l:
   EbeneAktualisieren()
   if Ebene = 1
   { 
      if (PriorDeadKey = "t5")       ; Schrägstrich
         BSSendUnicodeChar(0x0142)
      else if (PriorDeadKey = "a1")      ; akut 
         BSSendUnicodeChar(0x013A)
      else if (PriorDeadKey = "c2")     ; caron 
         BSSendUnicodeChar(0x013E)
      else if (PriorDeadKey = "a3")    ; cedilla
         BSSendUnicodeChar(0x013C)
      else if (PriorDeadKey = "c5")  ; Mittenpunkt
         BSSendUnicodeChar(0x0140)
      else if (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E37)
      else 
         sendinput {blind}l
      if (PriorDeadKey = "comp")            ; compose
         CompKey := "l_small"
      else
         CompKey := ""
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "a1")           ; akut 
         BSSendUnicodeChar(0x0139)
      else if (PriorDeadKey = "c2")     ; caron 
         BSSendUnicodeChar(0x013D)
      else if (PriorDeadKey = "a3")    ; cedilla
         BSSendUnicodeChar(0x013B)
      else if (PriorDeadKey = "t5")  ; Schrägstrich 
         BSSendUnicodeChar(0x0141)
      else if (PriorDeadKey = "c5")  ; Mittenpunkt 
         BSSendUnicodeChar(0x013F)
      else if (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E36)
      else 
         sendinput {blind}L
      if (PriorDeadKey = "comp")            ; compose
         CompKey := "l_capital"
      else CompKey := ""
   }      
   else if Ebene = 3
   {
      send [
      CompKey := ""
   }
   else if Ebene = 4
   {
      Sendinput {Blind}{Up}
      CompKey := ""
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x03BB) ; lambda
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x039B) ; Lambda
      CompKey := ""
   }
   PriorDeadKey := ""
return


neo_c:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x0109)
      else if (PriorDeadKey = "c2")     ; caron
         BSSendUnicodeChar(0x010D)
      else if (PriorDeadKey = "a1")      ; akut
         BSSendUnicodeChar(0x0107)
      else if (PriorDeadKey = "a3")    ; cedilla
         BSSendUnicodeChar(0x00E7)
      else if (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x010B)
      else if ( (CompKey = "o_small") or (CompKey = "o_capital") )
         Send {bs}©
      else
      {         
         sendinput {blind}c      
      }
      if (PriorDeadKey = "comp")
         CompKey := "c_small"
      else
         CompKey := ""
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c1")          ; circumflex 
         BSSendUnicodeChar(0x0108)
      else if (PriorDeadKey = "c2")    ; caron 
         BSSendUnicodeChar(0x010C)
      else if (PriorDeadKey = "a1")     ; akut 
         BSSendUnicodeChar(0x0106)
      else if (PriorDeadKey = "a3")   ; cedilla 
         BSSendUnicodeChar(0x00E6)
      else if (PriorDeadKey = "a5") ; punkt darüber 
         BSSendUnicodeChar(0x010A)
      else if ( (CompKey = "o_small") or (CompKey = "o_capital") )
         Send {bs}©         
      else 
         sendinput {blind}C
      if (PriorDeadKey = "comp")
         CompKey = "c_capital"
      else
         CompKey := ""
   }
   else if Ebene = 3
   {
      send ]
      CompKey := ""
   }
   else if Ebene = 4
   {
      if ( not(lernModus) or (lernModus_neo_Entf) )
      {
        Send {Del}
        CompKey := ""
      }
      else 
      {} ; leer
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x03C7) ;chi
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x2102)  ; C (Komplexe Zahlen)
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_w:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x0175)
      else
         sendinput {blind}w
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x0174)
      else
         sendinput {blind}W
   }
   else if Ebene = 3
      send {^}{space} ; untot
   else if Ebene = 4
      Send {Insert}
   else if Ebene = 5
      SendUnicodeChar(0x03C9) ; omega
   else if Ebene = 6
      SendUnicodeChar(0x03A9) ; Omega
   PriorDeadKey := ""   CompKey := ""
return

neo_k:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "a3")         ; cedilla
         BSSendUnicodeChar(0x0137)
      else if (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E33)
      else
         sendinput {blind}k
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "a3")         ; cedilla 
         BSSendUnicodeChar(0x0136)
      else if (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E32)
      else
         sendinput {blind}K
   }
   else if Ebene = 3
      sendraw !
   else if Ebene = 4
      Send ¡
   else if Ebene = 5
      SendUnicodeChar(0x03F0) ;kappa symbol (varkappa)
   else if Ebene = 6
      SendUnicodeChar(0x221A) ; Wurzel
   PriorDeadKey := ""   CompKey := ""
return

neo_h:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x0125)
      else if (PriorDeadKey = "c4")   ; Querstrich 
         BSSendUnicodeChar(0x0127)
      else if (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x1E23)
      else if (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E25)
      else sendinput {blind}h
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x0124)
      else if (PriorDeadKey = "c4")   ; Querstrich
         BSSendUnicodeChar(0x0126)
      else if (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x1E22)
      else if (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E24)
      else sendinput {blind}H
   }
   else if Ebene = 3
   {
      if (PriorDeadKey = "c4")    ; Querstrich
         BSSendUnicodeChar(0x2264) ; kleiner gleich
      else
         send {blind}<
   }
   else if Ebene = 4
   {
      if (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x2077)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2087)
      else
         Send 7
   }
   else if Ebene = 5
      SendUnicodeChar(0x03C8) ;psi
   else if Ebene = 6
      SendUnicodeChar(0x03A8)  ; Psi
   PriorDeadKey := ""   CompKey := ""
return

neo_g:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x011D)
      else if (PriorDeadKey = "c3")   ; brevis
         BSSendUnicodeChar(0x011F)
      else if (PriorDeadKey = "a3")   ; cedilla
         BSSendUnicodeChar(0x0123)
      else if (PriorDeadKey = "a5") ; punkt darüber 
         BSSendUnicodeChar(0x0121)
      else sendinput {blind}g
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x011C)
      else if (PriorDeadKey = "c3")    ; brevis 
         BSSendUnicodeChar(0x011E)
      else if (PriorDeadKey = "a3")    ; cedilla 
         BSSendUnicodeChar(0x0122)
      else if (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x0120)
      else sendinput {blind}G
   }
   else if Ebene = 3
   {
      if (PriorDeadKey = "c4")    ; Querstrich
         SendUnicodeChar(0x2265) ; größer gleich
      else
         send >
   }
   else if Ebene = 4
   {
      if (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x2078)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2088)
      else
         Send 8
   }
   else if Ebene = 5
      SendUnicodeChar(0x03B3) ;gamma
   else if Ebene = 6
      SendUnicodeChar(0x0393)  ; Gamma
   PriorDeadKey := ""   CompKey := ""
return

neo_f:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "t5")      ; durchgestrichen
         BSSendUnicodeChar(0x0192)
      else if (PriorDeadKey = "a5") ; punkt darüber 
         BSSendUnicodeChar(0x1E1F)
      else sendinput {blind}f
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "t5")       ; durchgestrichen
         BSSendUnicodeChar(0x0191)
      else if (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x1E1E)
      else sendinput {blind}F
   } 
   else if Ebene = 3
   {
      if (PriorDeadKey = "c1")            ; circumflex 
         BSSendUnicodeChar(0x2259)   ; entspricht
      else if (PriorDeadKey = "t1")       ; tilde 
         BSSendUnicodeChar(0x2245)   ; ungefähr gleich
      else if (PriorDeadKey = "t5")       ; Schrägstrich 
         BSSendUnicodeChar(0x2260)   ; ungleich
      else if (PriorDeadKey = "c4")       ; Querstrich
         BSSendUnicodeChar(0x2261)   ; identisch
      else if (PriorDeadKey = "c2")       ; caron 
         BSSendUnicodeChar(0x225A)   ; EQUIANGULAR TO
      else if (PriorDeadKey = "a6")       ; ring drüber 
         BSSendUnicodeChar(0x2257)   ; ring equal to
      else
         send `=
   }
   else if Ebene = 4
   {
      if (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x2079)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2089)
      else
         Send 9
   }
   else if Ebene = 5
      SendUnicodeChar(0x03C6) ; phi
   else if Ebene = 6
      SendUnicodeChar(0x03A6)  ; Phi
   PriorDeadKey := ""   CompKey := ""
return

neo_q:
   EbeneAktualisieren()
   if Ebene = 1
      sendinput {blind}q
   else if Ebene = 2
      sendinput {blind}Q
   else if Ebene = 3
      send {&}
   else if Ebene = 4
   {
      if (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x207A)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x208A)
      else
         Send {+}
   }
   else if Ebene = 5
      SendUnicodeChar(0x03D5) ; phi symbol (varphi)
   else if Ebene = 6
      SendUnicodeChar(0x211A) ; Q (rationale Zahlen)
   PriorDeadKey := ""   CompKey := ""
return

neo_sz:
   EbeneAktualisieren()
   if Ebene = 1
      if GetKeyState("CapsLock","T")
      {
         SendUnicodeChar(0x1E9E) ; verssal-ß
      }
      else
      {
         if (LangSTastatur = 1)
         {
            sendinput {blind}s
         }
         else
         {
            send ß
         }
      }
   else if Ebene = 2
      if GetKeyState("CapsLock","T")
      {
         if (LangSTastatur = 1)
         {
            sendinput {blind}s
         }
         else
         {
            send ß
         }
      }
      else
      {
         SendUnicodeChar(0x1E9E) ; versal-ß
      }
   else if Ebene = 3
   {
      if (LangSTastatur = 1)
         send ß
      else
         SendUnicodeChar(0x017F) ; langes s
   }
   else if Ebene = 4
   {
       ;LangSTastatur := not(LangSTastatur) ; schaltet die Lang-s-Tastatur ein und aus
   }
   else if Ebene = 5
      SendUnicodeChar(0x03C2) ; varsigma
   else if Ebene = 6
      SendUnicodeChar(0x2218) ; Verknüpfungsoperator
   PriorDeadKey := ""   CompKey := ""
return


neo_tot3:
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
      SendUnicodeChar(0x002F)  ; Schrägstrich, tot
      PriorDeadKey := "t5"
   }
   else if Ebene = 5
   {
      send "        ;doppelakut
      PriorDeadKey := "t4"
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

neo_u:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")       ; circumflex
         BSSendUnicodeChar(0x00FB)
      else if (PriorDeadKey = "a1")  ; akut 
         BSSendUnicodeChar(0x00FA)
      else if (PriorDeadKey = "a2")  ; grave
         BSSendUnicodeChar(0x00F9)
      else if (PriorDeadKey = "t3")  ; Diaerese
         Send, {bs}ü
      else if (PriorDeadKey = "t4")  ; doppelakut 
         BSSendUnicodeChar(0x0171)
      else if (PriorDeadKey = "c3")  ; brevis
         BSSendUnicodeChar(0x016D)
      else if (PriorDeadKey = "t2")  ; macron
         BSSendUnicodeChar(0x016B)
      else if (PriorDeadKey = "a4")  ; ogonek
         BSSendUnicodeChar(0x0173)
      else if (PriorDeadKey = "a6")  ; Ring
         BSSendUnicodeChar(0x016F)
      else if (PriorDeadKey = "t1")  ; tilde
         BSSendUnicodeChar(0x0169)
      else if (PriorDeadKey = "c2")  ; caron
         BSSendUnicodeChar(0x01D4)
      else
         sendinput {blind}u
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c1")        ; circumflex
         BSSendUnicodeChar(0x00DB)
      else if (PriorDeadKey = "a1")   ; akut 
         BSSendUnicodeChar(0x00DA)
      else if (PriorDeadKey = "a2")   ; grave
         BSSendUnicodeChar(0x00D9)
      else if (PriorDeadKey = "t3")   ; Diaerese
         Send, {bs}Ü
      else if (PriorDeadKey = "a6")   ; Ring
         BSSendUnicodeChar(0x016E)
      else if (PriorDeadKey = "c3")   ; brevis
         BSSendUnicodeChar(0x016C)
      else if (PriorDeadKey = "t4")   ; doppelakut
         BSSendUnicodeChar(0x0170)
      else if (PriorDeadKey = "c2")   ; caron 
         BSSendUnicodeChar(0x01D3)
      else if (PriorDeadKey = "t2")   ; macron
         BSSendUnicodeChar(0x016A)
      else if (PriorDeadKey = "a4")   ; ogonek
         BSSendUnicodeChar(0x0172)
      else if (PriorDeadKey = "t1")   ; tilde
         BSSendUnicodeChar(0x0168)
      else
         sendinput {blind}U
   }
   else if Ebene = 3
      send \
   else if Ebene = 4
      Send {blind}{Home}
   else if Ebene = 5    
   {  } ; leer
   else if Ebene = 6
      SendUnicodeChar(0x222E) ; contour integral
   PriorDeadKey := ""   CompKey := ""
return

neo_i:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")        ; circumflex
         BSSendUnicodeChar(0x00EE)
      else if (PriorDeadKey = "a1")   ; akut 
         BSSendUnicodeChar(0x00ED)
      else if (PriorDeadKey = "a2")   ; grave
         BSSendUnicodeChar(0x00EC)
      else if (PriorDeadKey = "t3")   ; Diaerese
         Send, {bs}ï
      else if (PriorDeadKey = "t2")   ; macron
         BSSendUnicodeChar(0x012B)
      else if (PriorDeadKey = "c3")   ; brevis
         BSSendUnicodeChar(0x012D)
      else if (PriorDeadKey = "a4")   ; ogonek
         BSSendUnicodeChar(0x012F)
      else if (PriorDeadKey = "t1")   ; tilde
         BSSendUnicodeChar(0x0129)
      else if (PriorDeadKey = "a5")   ; (ohne) punkt darüber 
         BSSendUnicodeChar(0x0131)
      else if (PriorDeadKey = "c2")   ; caron
         BSSendUnicodeChar(0x01D0)
      else 
         sendinput {blind}i
      if (PriorDeadKey = "comp")      ; compose
         CompKey := "i_small"
      else 
         CompKey := ""
   }
   else if Ebene = 2
   {   
      if (PriorDeadKey = "c1")        ; circumflex
         BSSendUnicodeChar(0x00CE)
      else if (PriorDeadKey = "a1")   ; akut 
         BSSendUnicodeChar(0x00CD)
      else if (PriorDeadKey = "a2")   ; grave
         BSSendUnicodeChar(0x00CC)
      else if (PriorDeadKey = "t3")   ; Diaerese
         Send, {bs}Ï
      else if (PriorDeadKey = "t2")   ; macron
         BSSendUnicodeChar(0x012A)
      else if (PriorDeadKey = "c3")   ; brevis 
         BSSendUnicodeChar(0x012C)
      else if (PriorDeadKey = "a4")   ; ogonek
         BSSendUnicodeChar(0x012E)
      else if (PriorDeadKey = "t1")   ; tilde
         BSSendUnicodeChar(0x0128)
      else if (PriorDeadKey = "a5")   ; punkt darüber 
         BSSendUnicodeChar(0x0130)
      else if (PriorDeadKey = "c2")   ; caron
         BSSendUnicodeChar(0x01CF)
      else 
         sendinput {blind}I
      if (PriorDeadKey = "comp")      ; compose
         CompKey := "i_capital"
      else
         CompKey := ""
   }
   else if Ebene = 3
   {
      send `/
      CompKey := ""
   }
   else if Ebene = 4
   {
      Sendinput {Blind}{Left}
      CompKey := ""
   }
   else if Ebene = 5    
   {
      SendUnicodeChar(0x03B9) ; iota
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x222B) ; integral
      CompKey := ""
   }
      PriorDeadKey := ""
return

neo_a:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")        ; circumflex
         BSSendUnicodeChar(0x00E2)
      else if (PriorDeadKey = "a1")   ; akut 
         BSSendUnicodeChar(0x00E1)
      else if (PriorDeadKey = "a2")   ; grave
         BSSendUnicodeChar(0x00E0)
      else if (PriorDeadKey = "t3")   ; Diaerese
         send {bs}ä
      else if (PriorDeadKey = "a6")   ; Ring 
         Send {bs}å
      else if (PriorDeadKey = "t1")   ; tilde
         BSSendUnicodeChar(0x00E3)
      else if (PriorDeadKey = "a4")   ; ogonek
         BSSendUnicodeChar(0x0105)
      else if (PriorDeadKey = "t2")   ; macron
         BSSendUnicodeChar(0x0101)
      else if (PriorDeadKey = "c3")   ; brevis
         BSSendUnicodeChar(0x0103)
      else if (PriorDeadKey = "c2")   ; caron
         BSSendUnicodeChar(0x01CE)
      else
         sendinput {blind}a
      if (PriorDeadKey = "comp")      ; compose
         CompKey := "a_small"
      else
         CompKey := ""
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c1")        ; circumflex
         BSSendUnicodeChar(0x00C2)
      else if (PriorDeadKey = "a1")   ; akut 
         BSSendUnicodeChar(0x00C1)
      else if (PriorDeadKey = "a2")   ; grave
         BSSendUnicodeChar(0x00C0)
      else if (PriorDeadKey = "t3")   ; Diaerese
         send {bs}Ä
      else if (PriorDeadKey = "t1")   ; tilde
         BSSendUnicodeChar(0x00C3)
      else if (PriorDeadKey = "a6")   ; Ring 
         Send {bs}Å
      else if (PriorDeadKey = "t2")   ; macron
         BSSendUnicodeChar(0x0100)
      else if (PriorDeadKey = "c3")   ; brevis 
         BSSendUnicodeChar(0x0102)
      else if (PriorDeadKey = "a4")   ; ogonek
         BSSendUnicodeChar(0x0104)
      else if (PriorDeadKey = "c2")   ; caron
         BSSendUnicodeChar(0x01CD)
      else
         sendinput {blind}A
      if (PriorDeadKey = "comp")      ; compose
         CompKey := "a_capital"
      else
         CompKey := ""
   }
   else if Ebene = 3
   {
      sendraw {
      CompKey := ""
   }
   else if Ebene = 4
   {
      Sendinput {Blind}{Down}
      CompKey := ""
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x03B1) ;alpha
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x2200) ;fuer alle   
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_e:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")        ; circumflex
         BSSendUnicodeChar(0x00EA)
      else if (PriorDeadKey = "a1")   ; akut 
         BSSendUnicodeChar(0x00E9)
      else if (PriorDeadKey = "a2")   ; grave
         BSSendUnicodeChar(0x00E8)
      else if (PriorDeadKey = "t3")   ; Diaerese
         Send, {bs}ë
      else if (PriorDeadKey = "a4")   ; ogonek
         BSSendUnicodeChar(0x0119)
      else if (PriorDeadKey = "t2")   ; macron
         BSSendUnicodeChar(0x0113)
      else if (PriorDeadKey = "c3")   ; brevis
         BSSendUnicodeChar(0x0115)
      else if (PriorDeadKey = "c2")   ; caron
         BSSendUnicodeChar(0x011B)
      else if (PriorDeadKey = "a5")   ; punkt darüber 
         BSSendUnicodeChar(0x0117)
      else if (CompKey = "a_small")   ; compose
      {
         Send {bs}æ
         CompKey := ""
      }
      else if (CompKey = "o_small")   ; compose
      {
         Send {bs}œ
         CompKey := ""
      }      
      else
         sendinput {blind}e
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c1")        ; circumflex
         BSSendUnicodeChar(0x00CA)
      else if (PriorDeadKey = "a1")   ; akut 
         BSSendUnicodeChar(0x00C9)
      else if (PriorDeadKey = "a2")   ; grave
         BSSendUnicodeChar(0x00C8)
      else if (PriorDeadKey = "t3")   ; Diaerese
         Send, {bs}Ë
      else if (PriorDeadKey = "c2")   ; caron
         BSSendUnicodeChar(0x011A)
      else if (PriorDeadKey = "t2")   ; macron
         BSSendUnicodeChar(0x0112)
      else if (PriorDeadKey = "c3")   ; brevis 
         BSSendUnicodeChar(0x0114)
      else if (PriorDeadKey = "a4")   ; ogonek 
         BSSendUnicodeChar(0x0118)
      else if (PriorDeadKey = "a5")   ; punkt darüber 
         BSSendUnicodeChar(0x0116)
      else if (CompKey = "a_capital") ; compose
      {
         Send {bs}Æ
         CompKey := ""
      }
      else if (CompKey = "o_capital")        ; compose
      {
         Send {bs}Œ
         CompKey := ""
      }      
      else 
         sendinput {blind}E
   }
   else if Ebene = 3
      sendraw }
   else if Ebene = 4
      Sendinput {Blind}{Right}
   else if Ebene = 5
        SendUnicodeChar(0x03B5) ;epsilon
   else if Ebene = 6
        SendUnicodeChar(0x2203) ;es existiert   
   PriorDeadKey := ""   CompKey := ""
return

neo_o:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")        ; circumflex
         BSSendUnicodeChar(0x00F4)
      else if (PriorDeadKey = "a1")   ; akut 
         BSSendUnicodeChar(0x00F3)
      else if (PriorDeadKey = "a2")   ; grave
         BSSendUnicodeChar(0x00F2)
      else if (PriorDeadKey = "t3")   ; Diaerese
         Send, {bs}ö
      else if (PriorDeadKey = "t1")   ; tilde
         BSSendUnicodeChar(0x00F5)
      else if (PriorDeadKey = "t4")   ; doppelakut
         BSSendUnicodeChar(0x0151)
      else if (PriorDeadKey = "t5")   ; Schrägstrich
         BSSendUnicodeChar(0x00F8)
      else if (PriorDeadKey = "t2")   ; macron
         BSSendUnicodeChar(0x014D)
      else if (PriorDeadKey = "c3")   ; brevis 
         BSSendUnicodeChar(0x014F)
      else if (PriorDeadKey = "a4")   ; ogonek
         BSSendUnicodeChar(0x01EB)
      else if (PriorDeadKey = "c2")   ; caron
         BSSendUnicodeChar(0x01D2)                      
      else
         sendinput {blind}o
      if (PriorDeadKey = "comp")      ; compose
         CompKey := "o_small"
      else
         CompKey := ""
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c1")        ; circumflex
         BSSendUnicodeChar(0x00D4)
      else if (PriorDeadKey = "a1")   ; akut 
         BSSendUnicodeChar(0x00D3)
      else if (PriorDeadKey = "a2")   ; grave
         BSSendUnicodeChar(0x00D2)
      else if (PriorDeadKey = "t5")   ; Schrägstrich
         BSSendUnicodeChar(0x00D8)
      else if (PriorDeadKey = "t1")   ; tilde
         BSSendUnicodeChar(0x00D5)
      else if (PriorDeadKey = "t4")   ; doppelakut
         BSSendUnicodeChar(0x0150)
      else if (PriorDeadKey = "t3")   ; Diaerese
         send {bs}Ö
      else if (PriorDeadKey = "t2")   ; macron 
         BSSendUnicodeChar(0x014C)
      else if (PriorDeadKey = "c3")   ; brevis 
         BSSendUnicodeChar(0x014E)
      else if (PriorDeadKey = "a4")   ; ogonek
         BSSendUnicodeChar(0x01EA)
      else if (PriorDeadKey = "c2")   ; caron
         BSSendUnicodeChar(0x01D1)    
      else
         sendinput {blind}O
      if (PriorDeadKey = "comp")      ; compose
         CompKey := "o_capital"
      else
         CompKey := ""
   }
   else if Ebene = 3
   {
      send *
      CompKey := ""
   }
   else if Ebene = 4
   {
      Send {blind}{End}
      CompKey := ""
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x03BF) ; omicron
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x2208) ; element of
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_s:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")      ; circumflex
         BSSendUnicodeChar(0x015D)
      else if (PriorDeadKey = "a1") ; akut 
         BSSendUnicodeChar(0x015B)
      else if (PriorDeadKey = "c2") ; caron
         BSSendUnicodeChar(0x0161)
      else if (PriorDeadKey = "a3") ; cedilla
         BSSendUnicodeChar(0x015F)
      else if (PriorDeadKey = "a5") ; punkt darüber 
         BSSendUnicodeChar(0x1E61)
      else if (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E63)
      else
      {
         if (LangSTastatur = 1)
         {
            if GetKeyState("CapsLock","T")
               sendinput {blind}s
            else
               SendUnicodeChar(0x017F) ; langes s
         }
         else
            sendinput {blind}s
      }
      if (PriorDeadKey = "comp")
         CompKey := "s_small"
      else
         CompKey := ""
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c1")      ; circumflex
         BSSendUnicodeChar(0x015C)
      else if (PriorDeadKey = "c2") ; caron
         BSSendUnicodeChar(0x0160)
      else if (PriorDeadKey = "a1") ; akut 
         BSSendUnicodeChar(0x015A)
      else if (PriorDeadKey = "a3") ; cedilla 
         BSSendUnicodeChar(0x015E)
      else if (PriorDeadKey = "a5") ; punkt darüber 
         BSSendUnicodeChar(0x1E60)
      else if (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E62)
      else
      {
         if GetKeyState("CapsLock","T") && (LangSTastatur = 1)
            SendUnicodeChar(0x017F)
         else 
            sendinput {blind}S
      }
      if (PriorDeadKey = "comp")
         CompKey := "s_capital"
      else
         CompKey := ""
   }
   else if Ebene = 3
   {
      send ?
      CompKey := ""
   }
   else if Ebene = 4
   {
      Send ¿
      CompKey := ""
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x03C3) ;sigma
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x03A3)  ; Sigma
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_n:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "a1")          ; akut
         BSSendUnicodeChar(0x0144)
      else if (PriorDeadKey = "t1")     ; tilde
         BSSendUnicodeChar(0x00F1)
      else if (PriorDeadKey = "c2")    ; caron
         BSSendUnicodeChar(0x0148)
      else if (PriorDeadKey = "a3")   ; cedilla
         BSSendUnicodeChar(0x0146)
      else if (PriorDeadKey = "a5") ; punkt darüber 
         BSSendUnicodeChar(0x1E45)
      else
         sendinput {blind}n
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c2")         ; caron
         BSSendUnicodeChar(0x0147)
      else if (PriorDeadKey = "t1")     ; tilde
         BSSendUnicodeChar(0x00D1)
      else if (PriorDeadKey = "a1")     ; akut 
         BSSendUnicodeChar(0x0143)
      else if (PriorDeadKey = "a3")   ; cedilla 
         BSSendUnicodeChar(0x0145)
      else if (PriorDeadKey = "a5") ; punkt darüber 
         BSSendUnicodeChar(0x1E44)
      else
         sendinput {blind}N
   }
   else if Ebene = 3
      send (
   else if Ebene = 4
   {
      if (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x2074)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2084)
      else
         Send 4
   }
   else if Ebene = 5
      SendUnicodeChar(0x03BD) ; nu
   else if Ebene = 6
      SendUnicodeChar(0x2115) ; N (natürliche Zahlen)
   PriorDeadKey := ""   CompKey := ""
return

neo_r:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "a1")           ; akut 
         BSSendUnicodeChar(0x0155)
      else if (PriorDeadKey = "c2")     ; caron
         BSSendUnicodeChar(0x0159)
      else if (PriorDeadKey = "a3")    ; cedilla
         BSSendUnicodeChar(0x0157)
      else if (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x0E59)
      else if (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E5B)
      else 
         sendinput {blind}r
      if (PriorDeadKey = "comp")
         CompKey := "r_small"
      else
         CompKey := ""
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c2")          ; caron
         BSSendUnicodeChar(0x0158)
      else if (PriorDeadKey = "a1")      ; akut 
         BSSendUnicodeChar(0x0154)
      else if (PriorDeadKey = "a3")    ; cedilla 
         BSSendUnicodeChar(0x0156)
      else if (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x1E58)
      else if (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E5A)
      else 
         sendinput {blind}R
      if (PriorDeadKey = "comp")
         CompKey := "r_capital"
      else
         CompKey := ""
   }
   else if Ebene = 3
   {
      send )
      CompKey := ""
   }
   else if Ebene = 4
   {
      if (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x2075)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2085)
      else
         Send 5
      CompKey := ""
   }
   else if Ebene = 5
   {
      SendUnicodeChar(0x03F1) ; rho symbol (varrho)
      CompKey := ""
   }
   else if Ebene = 6
   {
      SendUnicodeChar(0x211D) ; R (reelle Zahlen)
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_t:
     EbeneAktualisieren()
     if Ebene = 1
     {
        if (PriorDeadKey = "c2")          ; caron 
           BSSendUnicodeChar(0x0165)
        else if (PriorDeadKey = "a3")    ; cedilla
           BSSendUnicodeChar(0x0163)
        else if (PriorDeadKey = "c4")   ; Querstrich
           BSSendUnicodeChar(0x0167)
        else if (PriorDeadKey = "a5")  ; punkt darüber 
           BSSendUnicodeChar(0x1E6B)
        else if (PriorDeadKey = "c6") ; punkt darunter 
           BSSendUnicodeChar(0x1E6D)
        else 
           sendinput {blind}t
        if (PriorDeadKey = "comp")
           CompKey := "t_small"
        else
           CompKey := ""
     }
     else if Ebene = 2
     {
        if (PriorDeadKey = "c2")          ; caron
           BSSendUnicodeChar(0x0164)
        else if (PriorDeadKey = "a3")    ; cedilla 
           BSSendUnicodeChar(0x0162)
        else if (PriorDeadKey = "c4")   ; Querstrich
           BSSendUnicodeChar(0x0166)
        else if (PriorDeadKey = "a5")  ; punkt darüber 
           BSSendUnicodeChar(0x1E6A)
        else if (PriorDeadKey = "c6") ; punkt darunter 
           BSSendUnicodeChar(0x1E6C)
        else 
           sendinput {blind}T
        if (PriorDeadKey = "comp")
           CompKey := "t_capital"
        else
           CompKey := ""
     }
     else if Ebene = 3
     {
        send {blind}- ; Bis
        CompKey := ""
     }
     else if Ebene = 4
     {
        if (PriorDeadKey = "c1")            ; circumflex
           BSSendUnicodeChar(0x2076)
        else if (PriorDeadKey = "c4")       ; toter -
           BSSendUnicodeChar(0x2086)
        else
           Send 6
        CompKey := ""
     }
     else if Ebene = 5
     {
        SendUnicodeChar(0x03C4) ; tau
        CompKey := ""
     }
     else if Ebene = 6
     {
        SendUnicodeChar(0x2202 ) ; partielle Ableitung
        CompKey := ""
     }
     PriorDeadKey := ""
return

neo_d:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c4")        ; Querstrich
         BSSendUnicodeChar(0x0111)
      else if (PriorDeadKey = "t5")  ; Schrägstrich
         BSSendUnicodeChar(0x00F0)
      else if (PriorDeadKey = "c2")     ; caron
         BSSendUnicodeChar(0x010F)
      else if (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x1E0B)
      else if (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E0D)
      else 
         sendinput {blind}d
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c4")        ; Querstrich
         BSSendUnicodeChar(0x0110)
      else if (PriorDeadKey = "t5")  ; Schrägstrich
         BSSendUnicodeChar(0x00D0)
      else if (PriorDeadKey = "c2")     ; caron 
         BSSendUnicodeChar(0x010E)
      else if (PriorDeadKey = "a5")  ; punkt darüber 
         BSSendUnicodeChar(0x1E0A)
      else if (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E0D)
      else sendinput {blind}D
   }
   else if Ebene = 3
      send :
   else if Ebene = 4
     Send `,
   else if Ebene = 5
      SendUnicodeChar(0x03B4) ;delta
   else if Ebene = 6
      SendUnicodeChar(0x0394)  ; Delta
   PriorDeadKey := ""   CompKey := ""
return

neo_y:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "t3")       ; Diaerese
         Send {bs}ÿ
      else if (PriorDeadKey = "a1")      ; akut 
         BSSendUnicodeChar(0x00FD)
      else if (PriorDeadKey = "c1")    ; circumflex
         BSSendUnicodeChar(0x0177)
      else
         sendinput {blind}y
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "a1")           ; akut 
         BSSendUnicodeChar(0x00DD)
      else if (PriorDeadKey = "t3")    ; Diaerese
         Send {bs}Ÿ
      else if (PriorDeadKey = "c1")      ; circumflex
         BSSendUnicodeChar(0x0176)
      else
         sendinput {blind}Y
   }
   else if Ebene = 3
      send @
   else if Ebene = 4
      Send .
   else if Ebene = 5
      SendUnicodeChar(0x03C5) ; upsilon
   else if Ebene = 6
      SendUnicodeChar(0x2207) ; nabla
   PriorDeadKey := ""   CompKey := ""
return

;SC02B (#) wird zu Mod3


/*
   ------------------------------------------------------
   Reihe 4
   ------------------------------------------------------
*/

;SC056 (<) wird zu Mod4

neo_ü:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "t2")        ; macron
         BSSendUnicodeChar(0x01D6)
      else if (PriorDeadKey = "a1")   ; akut 
         BSSendUnicodeChar(0x01D8)
      else if (PriorDeadKey = "a2")   ; grave
         BSSendUnicodeChar(0x01DC)
      else if (PriorDeadKey = "c2")   ; caron
         BSSendUnicodeChar(0x01DA)
      else
         sendinput {blind}ü
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "t2")        ; macron
         BSSendUnicodeChar(0x01D5)
      else if (PriorDeadKey = "a1")   ; akut 
         BSSendUnicodeChar(0x01D7)
      else if (PriorDeadKey = "a2")   ; grave
         BSSendUnicodeChar(0x01DB)
      else if (PriorDeadKey = "c2")   ; caron
         BSSendUnicodeChar(0x01D9)
      else
         sendinput {blind}Ü
   }
   else if Ebene = 3
      send {blind}{#}
   else if Ebene = 4
      Send {Esc}
   else if Ebene = 5
     {} ; leer
   else if Ebene = 6
      SendUnicodeChar(0x221D) ; proportional

   PriorDeadKey := ""   CompKey := ""
return

neo_ö:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "t2")        ; macron
         BSSendUnicodeChar(0x022B)
      else
         sendinput {blind}ö
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "t2")        ; macron
         BSSendUnicodeChar(0x022A)
      else
         sendinput {blind}Ö
   }
   else if Ebene = 3
      send $
   else if Ebene = 4
      goto neo_tab
   else if Ebene = 5
       {} ;leer
   else if Ebene = 6
      SendUnicodeChar(0x2111) ; Fraktur I
   PriorDeadKey := ""   CompKey := ""
return

neo_ä:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "t2")        ; macron
         BSSendUnicodeChar(0x01DF)
      else
         sendinput {blind}ä
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "t2")        ; macron
         BSSendUnicodeChar(0x001DE)
      else
         sendinput {blind}Ä
   }
   else if Ebene = 3
      send |
   else if Ebene = 4
      Send {PgDn}    ; Next
   else if Ebene = 5
      SendUnicodeChar(0x03B7) ; eta
   else if Ebene = 6
      SendUnicodeChar(0x211C) ; altes R
   PriorDeadKey := ""   CompKey := ""
return

neo_p:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "a5")      ; punkt darüber 
         BSSendUnicodeChar(0x1E57)
      else
         sendinput {blind}p
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "a5")      ; punkt darüber 
         BSSendUnicodeChar(0x1E56)
      else 
         sendinput {blind}P
   }
   else if Ebene = 3
   {
      if (PriorDeadKey = "t1")    ; tilde
         BSSendUnicodeChar(0x2248)
      else
         sendraw ~
   }      
   else if Ebene = 4
        Send {Enter}
   else if Ebene = 5
      SendUnicodeChar(0x03C0) ;pi
   else if Ebene = 6
      SendUnicodeChar(0x03A0)  ; Pi
   PriorDeadKey := ""   CompKey := ""
return

neo_z:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c2")         ; caron
         BSSendUnicodeChar(0x017E)
      else if (PriorDeadKey = "a1")     ; akut
         BSSendUnicodeChar(0x017A)
      else if (PriorDeadKey = "a5") ; punkt drüber
         BSSendUnicodeChar(0x017C)
      else if (PriorDeadKey = "c6") ; punkt drunter
         BSSendUnicodeChar(0x1E93)
      else 
         sendinput {blind}z
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c2")         ; caron  
         BSSendUnicodeChar(0x017D)
      else if (PriorDeadKey = "a1")     ; akut 
         BSSendUnicodeChar(0x0179)
      else if (PriorDeadKey = "a5") ; punkt darüber 
         BSSendUnicodeChar(0x017B)
      else if (PriorDeadKey = "c6") ; punkt drunter
         BSSendUnicodeChar(0x1E92)
      else
         sendinput {blind}Z
   }
   else if Ebene = 3
      send ``{space} ; untot
   else if Ebene = 4
     {} ; leer   
   else if Ebene = 5
      SendUnicodeChar(0x03B6) ;zeta 
   else if Ebene = 6
      SendUnicodeChar(0x2124)  ; Z (ganze Zahlen)
   PriorDeadKey := ""   CompKey := ""
return

neo_b:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "a5")      ; punkt darüber 
         BSSendUnicodeChar(0x1E03)
      else 
         sendinput {blind}b
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "a5")       ; punkt darüber 
         BSSendUnicodeChar(0x1E02)
      else 
         sendinput {blind}B
   }
   else if Ebene = 3
      send {blind}{+}
   else if Ebene = 4
      send :
   else if Ebene = 5
      SendUnicodeChar(0x03B2) ; beta
   else if Ebene = 6
      SendUnicodeChar(0x21D2) ; Doppel-Pfeil rechts
   PriorDeadKey := ""   CompKey := ""
return

neo_m:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "a5")       ; punkt darüber 
         BSSendUnicodeChar(0x1E41)
      else if (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E43)
      else if ( (CompKey = "t_small") or (CompKey = "t_capital") )       ; compose
         CompUnicodeChar(0x2122)          ; TM
      else if ( (CompKey = "s_small") or (CompKey = "s_capital") )       ; compose
         CompUnicodeChar(0x2120)          ; SM
      else
         sendinput {blind}m
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "a5")       ; punkt darüber 
         BSSendUnicodeChar(0x1E40)
      else if (PriorDeadKey = "c6") ; punkt darunter 
         BSSendUnicodeChar(0x1E42)
      else if ( (CompKey = "t_capital") or (CompKey = "t_small") )       ; compose
         CompUnicodeChar(0x2122)          ; TM
      else if ( (CompKey = "s_capital") or (CompKey = "s_small") )       ; compose
         CompUnicodeChar(0x2120)          ; SM
      else 
         sendinput {blind}M
   }
   else if Ebene = 3
      send `%
   else if Ebene = 4
   {
      if (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x00B9)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2081)
      else
         Send 1
   }
   else if Ebene = 5
      SendUnicodeChar(0x03BC) ; griechisch mu, micro wäre 0x00B5
   else if Ebene = 6
      SendUnicodeChar(0x21D4) ; doppelter Doppelpfeil (genau dann wenn)
   PriorDeadKey := ""   CompKey := ""
return

neo_komma:
   EbeneAktualisieren()
   if Ebene = 1
       {  
         if GetKeyState("CapsLock","T") 
         {
           if (IsModifierPressed())
           {
             send {blind},
           }
           else
           {
              send `,
           }
               
         }
         else
         {
           send {blind},
         }
       }
   else if Ebene = 2
       SendUnicodeChar(0x22EE) ;  vertikale ellipse 
   else if Ebene = 3
      send "
   else if Ebene = 4
   {
      if (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x00B2)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2082)
      else
         Send 2
   }
   else if Ebene = 5
      SendUnicodeChar(0x03C1) ; rho
   else if Ebene = 6
      SendUnicodeChar(0x21D0) ; Doppelpfeil links
   PriorDeadKey := ""   CompKey := ""
return

neo_punkt:
   EbeneAktualisieren()
   if Ebene = 1
        {  
         if GetKeyState("CapsLock","T") 
         {
           if (IsModifierPressed())
           {
             send {blind}.
           }
           else
           {
              send .
           }
               
         }
         else {
           send {blind}.
         }
       }
  else if Ebene = 2
      SendUnicodeChar(0x2026)  ; ellipse
   else if Ebene = 3
      send '
   else if Ebene = 4
   {
      if (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x00B3)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2083)
      else
         Send 3
   }
   else if Ebene = 5
      SendUnicodeChar(0x03D1) ; theta symbol (vartheta)
   else if Ebene = 6
      SendUnicodeChar(0x0398)  ; Theta
   PriorDeadKey := ""   CompKey := ""
return


neo_j:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (PriorDeadKey = "c1")           ; circumflex
         BSSendUnicodeChar(0x0135)
      else if (PriorDeadKey = "c2")      ; caron
         BSSendUnicodeChar(0x01F0)
      else if (CompKey = "i_small")        ; compose
         CompUnicodeChar(0x0133)          ; ij
      else if (CompKey = "l_small")        ; compose
         CompUnicodeChar(0x01C9)          ; lj
      else if (CompKey = "l_capital")       ; compose
         CompUnicodeChar(0x01C8)          ; Lj
      else
         sendinput {blind}j
   }
   else if Ebene = 2
   {
      if (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x0134)
      else if (CompKey = "i_capital")        ; compose
         CompUnicodeChar(0x0132)          ; IJ
      else if (CompKey = "l_capital")        ; compose
         CompUnicodeChar(0x01C7)          ; LJ
      else
         sendinput {blind}J
   }
   else if Ebene = 3
      send `;
   else if Ebene = 4
     Send `;
   else if Ebene = 5
      SendUnicodeChar(0x03B8) ; theta
   else if Ebene = 6
      SendUnicodeChar(0x2261) ; identisch
   PriorDeadKey := ""   CompKey := ""
return

/*
   ------------------------------------------------------
   Numpad
   ------------------------------------------------------

   folgende Tasten verhalten sich bei ein- und ausgeschaltetem
   NumLock gleich:
*/

neo_NumpadDiv:
   EbeneAktualisieren()
   if ( (Ebene = 1) or (Ebene = 2) )
      send {NumpadDiv}
   else if Ebene = 3
      send ÷
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x2215)   ; slash
   PriorDeadKey := ""   CompKey := ""
return

neo_NumpadMult:
   EbeneAktualisieren()
   if ( (Ebene = 1) or (Ebene = 2) )
      send {NumpadMult}
   else if Ebene = 3
      send ×
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x22C5)  ; cdot
   PriorDeadKey := ""   CompKey := ""
return

neo_NumpadSub:
   EbeneAktualisieren()
   if ( (Ebene = 1) or (Ebene = 2) )
   {
      if (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x207B)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x208B)         
      else
         send {blind}{NumpadSub}
   }
   else if Ebene = 3
      SendUnicodeChar(0x2212) ; echtes minus
   PriorDeadKey := ""   CompKey := ""
return

neo_NumpadAdd:
   EbeneAktualisieren()
   if ( (Ebene = 1) or (Ebene = 2) )
   {
      if (PriorDeadKey = "c1")          ; circumflex
         BSSendUnicodeChar(0x207A)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x208A)         
      else
         send {blind}{NumpadAdd}
   }
   else if Ebene = 3
      send ±
   else if ( (Ebene = 4) or (Ebene = 5) )
      SendUnicodeChar(0x2213)   ; -+
   PriorDeadKey := ""   CompKey := ""
return

neo_NumpadEnter:
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



neo_Numpad7:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {blind}{Numpad7}
      if (PriorDeadKey = "comp")
         CompKey := "Num_7"
      else
         CompKey := ""       
   }
   else if Ebene = 2
   {
      send {NumpadHome}
      CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x2195)   ; Hoch-Runter-Pfeil
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x226A)  ; ll
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_Numpad8:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (CompKey = "Num_1")
         CompUnicodeChar(0x215B)       ; 1/8
      else if (CompKey = "Num_3")
         CompUnicodeChar(0x215C)       ; 3/8
      else if (CompKey = "Num_5")
         CompUnicodeChar(0x215D)       ; 5/8
      else if (CompKey = "Num_7")
         CompUnicodeChar(0x215E)       ; 7/8
      else
         send {blind}{Numpad8}
      if (PriorDeadKey = "comp")
         CompKey := "Num_8"
      else
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

neo_Numpad9:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {blind}{Numpad9}
      if (PriorDeadKey = "comp")
         CompKey := "Num_9"
      else
         CompKey := "" 
   }
   else if Ebene = 2
   {
      send {NumpadPgUp}
      CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x2297) ; Tensorprodukt ; Vektor in die Ebene zeigend 
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x226B)  ; gg
      CompKey := ""
   }
   PriorDeadKey := ""
return



neo_Numpad4:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (CompKey = "Num_1")
         CompUnicodeChar(0x00BC)       ; 1/4
      else if (CompKey = "Num_3")
         CompUnicodeChar(0x00BE)       ; 3/4
      else
         send {blind}{Numpad4}
      if (PriorDeadKey = "comp")
         CompKey := "Num_4"
      else
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

neo_Numpad5:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (CompKey = "Num_1")
         CompUnicodeChar(0x2155)       ; 1/5
      else if (CompKey = "Num_2")
         CompUnicodeChar(0x2156)       ; 2/5
      else if (CompKey = "Num_3")
         CompUnicodeChar(0x2157)       ; 3/5
      else if (CompKey = "Num_4")
         CompUnicodeChar(0x2158)       ; 4/5
      else
         send {blind}{Numpad5}
      if (PriorDeadKey = "comp")
         CompKey := "Num_5"
      else
         CompKey := ""
   }
   else if Ebene = 2
   {
      send {NumpadClear}
      CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x221E) ; INFINITY
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x220B) ; enthält das Element
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_Numpad6:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (CompKey = "Num_1")
         CompUnicodeChar(0x2159)       ; 1/6
      else if (CompKey = "Num_5")
         CompUnicodeChar(0x215A)       ; 5/6
      else
         send {blind}{Numpad6}
      if (PriorDeadKey = "comp")
         CompKey := "Num_6"
      else
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

neo_Numpad1:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {blind}{Numpad1}
      if (PriorDeadKey = "comp")
         CompKey := "Num_1"
      else
         CompKey := ""
   }
   else if Ebene = 2
   {
      send {NumpadEnd}
      CompKey := ""
   }
   else if Ebene = 3
   {
      SendUnicodeChar(0x2194) ; Links-Rechts-Pfeil
      CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x2264)   ; leq
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_Numpad2:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (CompKey = "Num_1")
         CompUnicodeChar(0x00BD)       ; 1/2
      else
         send {blind}{Numpad2}
      if (PriorDeadKey = "comp")
         CompKey := "Num_2"
      else
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

neo_Numpad3:
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (CompKey = "Num_1")
         CompUnicodeChar(0x2153)       ; 1/3
      else if (CompKey = "Num_2")
         CompUnicodeChar(0x2154)       ; 2/3
      else
         send {blind}{Numpad3}
      if (PriorDeadKey = "comp")
         CompKey := "Num_3"
      else
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

neo_Numpad0:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {blind}{Numpad0}
      if (PriorDeadKey = "comp")
         CompKey := "Num_0"
      else
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

neo_NumpadDot:
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

neo_NumpadHome:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadHome}
      CompKey := ""
   }
   else if Ebene = 2
   {
      send {Numpad7}
      if (PriorDeadKey = "comp")
         CompKey := "Num_7"
      else
         CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {
      SendUnicodeChar(0x226A)  ; ll
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_NumpadUp:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadUp}
      CompKey := ""
   }
   else if Ebene = 2
   {
      if (CompKey = "Num_1")
         CompUnicodeChar(0x215B)       ; 1/8
      else if (CompKey = "Num_3")
         CompUnicodeChar(0x215C)       ; 3/8
      else if (CompKey = "Num_5")
         CompUnicodeChar(0x215D)       ; 5/8
      else if (CompKey = "Num_7")
         CompUnicodeChar(0x215E)       ; 7/8
      else
         send {Numpad8}
      if (PriorDeadKey = "comp")
         CompKey := "Num_8"
      else
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

neo_NumpadPgUp:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadPgUp}
      CompKey := ""
   }
   else if Ebene = 2
   {
      send {Numpad9}
      if (PriorDeadKey = "comp")
         CompKey := "Num_9"
      else
         CompKey := ""
   }
   else if ( (Ebene = 4) or (Ebene = 5) )
   {

      SendUnicodeChar(0x226B)  ; gg
      CompKey := ""
   }
   PriorDeadKey := ""
return

neo_NumpadLeft:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadLeft}
      CompKey := ""
   }
   else if Ebene = 2
   {
      if (CompKey = "Num_1")
         CompUnicodeChar(0x00BC)       ; 1/4
      else if (CompKey = "Num_3")
         CompUnicodeChar(0x00BE)       ; 3/4
      else
         send {Numpad4}
      if (PriorDeadKey = "comp")
         CompKey := "Num_4"
      else
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

neo_NumpadClear:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadClear}
      CompKey := ""
   }
   else if Ebene = 2
   {
      if (CompKey = "Num_1")
         CompUnicodeChar(0x2155)       ; 1/5
      else if (CompKey = "Num_2")
         CompUnicodeChar(0x2156)       ; 2/5
      else if (CompKey = "Num_3")
         CompUnicodeChar(0x2157)       ; 3/5
      else if (CompKey = "Num_4")
         CompUnicodeChar(0x2158)       ; 4/5
      else
         send {Numpad5}
      if (PriorDeadKey = "comp")
         CompKey := "Num_5"
      else
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

neo_NumpadRight:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadRight}
      CompKey := ""
   }
   else if Ebene = 2
   {
      if (CompKey = "Num_1")
         CompUnicodeChar(0x2159)       ; 1/6
      else if (CompKey = "Num_5")
         CompUnicodeChar(0x215A)       ; 5/6
      else
         send {Numpad6}
      if (PriorDeadKey = "comp")
         CompKey := "Num_6"
      else
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

neo_NumpadEnd:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadEnd}
      CompKey := ""
   }
   else if Ebene = 2
   {
      send {Numpad1}
      if (PriorDeadKey = "comp")
         CompKey := "Num_1"
      else
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

neo_NumpadDown:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadDown}
      CompKey := ""
   }
   else if Ebene = 2
   {
      if (CompKey = "Num_1")
         CompUnicodeChar(0x00BD)       ; 1/2
      else
         send {Numpad2}
      if (PriorDeadKey = "comp")
         CompKey := "Num_2"
      else
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

neo_NumpadPgDn:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadPgDn}
      CompKey := ""
   }
   else if Ebene = 2
   {
      if (CompKey = "Num_1")
         CompUnicodeChar(0x2153)       ; 1/3
      else if (CompKey = "Num_2")
         CompUnicodeChar(0x2154)       ; 2/3
      else
         send {Numpad3}
      if (PriorDeadKey = "comp")
         CompKey := "Num_3"
      else
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

neo_NumpadIns:
   EbeneAktualisieren()
   if Ebene = 1
   {
      send {NumpadIns}
      CompKey := ""
   }
   else if Ebene = 2
   {
      send {Numpad0}
      if (PriorDeadKey = "comp")
         CompKey := "Num_0"
      else
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

neo_NumpadDel:
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
*space::
   if (einHandNeo)
    spacepressed := 1
   else
    goto neo_SpaceUp
return

*space up::
   if (einHandNeo)
   {
     if (keypressed)
     {
       keypressed := 0
       spacepressed := 0    
     }
     else
     {
        goto neo_SpaceUp
     }
   }
   else
     { } ;do nothing
return 

neo_SpaceUp:
     EbeneAktualisieren()
     if Ebene = 1
     {
        if (CompKey = "r_small_1")
           Comp3UnicodeChar(0x2170)          ; römisch i
        else if (CompKey = "r_capital_1")
           Comp3UnicodeChar(0x2160)          ; römisch I
        else
           Send {blind}{Space}
     }
     if  Ebene  =  2
        Send  {blind}{Space}
     if Ebene = 3
        Send {blind}{Space}
     if Ebene = 4
     {
        if (PriorDeadKey = "c1")            ; circumflex
           BSSendUnicodeChar(0x2070)
        else if (PriorDeadKey = "c4")       ; toter -
           BSSendUnicodeChar(0x2080)
        else
           Send 0
     }
     else if Ebene = 5
        SendUnicodeChar(0x00A0)   ; geschütztes Leerzeichen
     else if Ebene = 6
        SendUnicodeChar(0x202F) ; schmales Leerzeichen
     PriorDeadKey := ""   CompKey := ""
  spacepressed := 0     
  keypressed := 0       
return

/*
*Space::
   EbeneAktualisieren()
   if Ebene = 1
   {
      if (CompKey = "r_small_1")
         Comp3UnicodeChar(0x2170)          ; römisch i
      else if (CompKey = "r_capital_1")
         Comp3UnicodeChar(0x2160)          ; römisch I
      else
         Send {blind}{Space}
   }
   if  Ebene  =  2
      Send  {blind}{Space}
   if Ebene = 3
      Send {blind}{Space}
   if Ebene = 4
   {
      if (PriorDeadKey = "c1")            ; circumflex
         BSSendUnicodeChar(0x2070)
      else if (PriorDeadKey = "c4")       ; toter -
         BSSendUnicodeChar(0x2080)
      else
         Send 0
   }
   else if Ebene = 5
      SendUnicodeChar(0x00A0)   ; geschütztes Leerzeichen
   else if Ebene = 6
      SendUnicodeChar(0x202F) ; schmales Leerzeichen
   PriorDeadKey := ""   CompKey := ""
return
*/
/*
   Folgende Tasten sind nur aufgeführt, um PriorDeadKey zu leeren.
   Irgendwie sieht das noch nicht schön aus. Vielleicht lässt sich dieses
   Problem irgendwie eleganter lösen...
   
   Nachtrag:
   Weil es mit Alt+Tab Probleme gab, wird hier jetzt erstmal rumgeflickschustert,
   bis eine allgemeinere Lösung gefunden wurde.
*/

*Enter::
   if ( not(lernModus) or (lernModus_std_Return) )
   {
     sendinput {Blind}{Enter}
     PriorDeadKey := ""   CompKey := ""
   }
return

*Backspace::
   if ( not(lernModus) or (lernModus_std_Backspace) )
   {
     sendinput {Blind}{Backspace}
     PriorDeadKey := ""   CompKey := ""
   }
return

*Del::
   if ( not(lernModus) or (lernModus_std_Entf) )
   {
     sendinput {Blind}{Del}
   }
return

*Ins::
   if ( not(lernModus) or (lernModus_std_Einf) )
   {
     sendinput {Blind}{Ins}
   }
return





/*
Auf Mod3+Tab liegt Compose. AltTab funktioniert, jedoch ShiftAltTab nicht.
Wenigstens kommt es jetzt nicht mehr zu komischen Ergebnissen, wenn man Tab 
nach einem DeadKey drückt...
*/

neo_tab:
   if ( GetKeyState("SC038","P") )
   {
    Send,{Blind}{AltDown}{tab}
    
/*
     if (isShiftPressed())
     {
      Send,{ShiftDown}{AltDown}{tab}
     }
     else
     {       
;       msgbox alt+tab
        Send,{AltDown}{tab}
      ; SC038 & Tab::AltTab            ; http://de.autohotkey.com/docs/Hotkeys.htm#AltTabDetail
     }
*/
   }
   else if (IsMod3Pressed()) ;#
   {
      #Include *i %a_scriptdir%\ComposeLaunch.ahk
      #Include *i %a_scriptdir%\Source\ComposeLaunch.ahk
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

*SC038 up::
   PriorDeadKey := ""   CompKey := ""
   send {blind}{AltUp}
return
   
*SC038 down::                    ; LAlt, damit AltTab funktioniert
    Send,{Blind}{AltDown}
   PriorDeadKey := ""   CompKey := ""
return

*Home::
   if ( not(lernModus) or (lernModus_std_Pos1) )
   {
     sendinput {Blind}{Home}
     PriorDeadKey := ""   CompKey := ""
   }
return

*End::
   if ( not(lernModus) or (lernModus_std_Ende) )
   {
     sendinput {Blind}{End}
     PriorDeadKey := ""   CompKey := ""
   }
return

*PgUp::
   if ( not(lernModus) or (lernModus_std_PgUp) )
   {
     sendinput {Blind}{PgUp}
     PriorDeadKey := ""   CompKey := ""
   }
return

*PgDn::
   if ( not(lernModus) or (lernModus_std_PgDn) )
   {
     sendinput {Blind}{PgDn}
     PriorDeadKey := ""   CompKey := ""
   }
return

*Up::
   if ( not(lernModus) or (lernModus_std_Hoch) )
   {
     sendinput {Blind}{Up}
     PriorDeadKey := ""   CompKey := ""
   }
return

*Down::
   if ( not(lernModus) or (lernModus_std_Runter) )
   {
     sendinput {Blind}{Down}
     PriorDeadKey := ""   CompKey := ""
   }
return

*Left::
   if ( not(lernModus) or (lernModus_std_Links) )
   {
     sendinput {Blind}{Left}
     PriorDeadKey := ""   CompKey := ""
   }
return

*Right::
   if ( not(lernModus) or (lernModus_std_Rechts) )
   {
     sendinput {Blind}{Right}
     PriorDeadKey := ""   CompKey := ""
   }
return




