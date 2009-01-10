neo_0:
  noCaps = 1
  EbeneAktualisieren()
  if Ebene12 and !(CheckDeadUni("c1",0x2070) ; Hochgestellte 0
                or CheckDeadUni("a3",0x2080)) ; Tiefgestellte 0 
    OutputChar12(0,"”",0,"rightdoublequotemark")
   else if (Ebene = 3)
     OutputChar("’", "rightsingleqoutemark")
   else if (Ebene = 4)
     OutputChar("{NumpadSub}", "KP_Minus")
   else if (Ebene = 5)
     SendUnicodeChar(0x2080, "U2080")
   else if (Ebene = 6)
     SendUnicodeChar(0x2205, "emptyset") ; leere Menge
return

neo_1:
  noCaps=1
  EbeneAktualisieren()
  if Ebene12 and !(CheckDeadUni("c1",0x00B9) ; Hochgestellte 1
                or CheckDeadUni("a3",0x2081)) ; Tiefgestellte 1
    OutputChar12(1,"°",1,"degree")
  else if (Ebene = 3)
    OutputChar("¹", "onesuperior") ; Hochgestellte 1
  else if (Ebene = 4)
    OutputChar("º", "U00BA") ; männlicher Ordinalindikator (º)
  else if (Ebene = 5)
    SendUnicodeChar(0x2081, "U2081") ; Tiefgestellte 1
  else if (Ebene = 6)
    OutputChar("¬", "notsign") ; Nicht-Symbol
return

neo_2:
  noCaps = 1
  EbeneAktualisieren()
  if Ebene12 and !(CheckDeadUni("c1",0x00B2) ; Hochgestellte 2
                or CheckDeadUni("a3",0x2082)) ; Tiefgestellte 2
    OutputChar12(2,"§",2,"section")
  else if (Ebene = 3)
    OutputChar("²", "twosuperior") ; Hochgestellte 2
  else if (Ebene = 4)
    OutputChar("ª", "U00AA") ; weiblicher Ordinalindikator (ª)
  else if (Ebene = 5)
    SendUnicodeChar(0x2082, "U2082") ; Tiefgestellte 2
  else if (Ebene = 6)
    SendUnicodeChar(0x2228, "logicalor") ; Logisches Oder
return

neo_3:
  noCaps = 1
  EbeneAktualisieren()
  if (Ebene = 1) and !(CheckDeadUni("c1",0x00B3) ; Hochgestellte 3
                    or CheckDeadUni("a3",0x2083)) ; Tiefgestellte 3
    OutputChar(3,3)
  else if (Ebene = 2)
    SendUnicodeChar(0x2113, "U2113") ; kleines l (Skript)
  else if (Ebene = 3)
    OutputChar("³", "threesuperior") ; Hochgestellte 3
  else if (Ebene = 4)
    SendUnicodeChar(0x2116, "numerosign") ; Numero
  else if (Ebene = 5)
    SendUnicodeChar(0x2083, "U2083") ; Tiefgestellte 3
  else if (Ebene = 6)
    SendUnicodeChar(0x2227, "logicaland") ; Logisches Und
return

neo_4:
  noCaps = 1
  EbeneAktualisieren()
  if (Ebene = 1) and !(CheckDeadUni("c1",0x2074) ; Hochgestellte 4
                    or CheckDeadUni("a3",0x2084)) ; Tiefgestellte 4
    OutputChar(4,4)
  else if (Ebene = 2)
    OutputChar("»", "guillemotright")
  else if (Ebene = 3)
    OutputChar("›", "U230A") ; Single guillemot right
  else if (Ebene = 4)
    OutputChar("{PgUp}", "Prior") ; Bild auf
  else if (Ebene = 5)
    OutputChar("†", "dagger") ; Kreuz
  else if (Ebene = 6)
    SendUnicodeChar(0x22A5, "uptack") ; Senkrecht
return

neo_5:
  noCaps = 1
  EbeneAktualisieren()
  if (Ebene = 1) and !(CheckDeadUni("c1",0x2075) ; Hochgestellte 5
                    or CheckDeadUni("a3",0x2085)) ; Tiefgestellte 5
    OutputChar(5,5)
  else if (Ebene = 2)
    OutputChar("«", "guillemotleft") ; Double guillemot left
  else if (Ebene = 3)
    OutputChar("‹", "U2039") ; Single guillemot left
  else if (Ebene = 5)
    SendUnicodeChar(0x2640, "femalesymbol")
  else if (Ebene = 6)
    SendUnicodeChar(0x2221, "U2221") ; Winkel
return

neo_6:
  noCaps = 1
  EbeneAktualisieren()
  if (Ebene = 1) and !(CheckDeadUni("c1",0x2076) ; Hochgestellte 6
                    or CheckDeadUni("a3",0x2086)) ; Tiefgestellte 6
    OutputChar(6,6)
  else if (Ebene = 2)
    SendUnicodeChar(0x20AC, "EuroSign")
  else if (Ebene = 3)
    OutputChar("¢", "cent")
  else if (Ebene = 4)
    OutputChar("£", "sterling")
  else if (Ebene = 5)
    SendUnicodeChar(0x2642, "malesymbol")
  else if (Ebene = 6)
    SendUnicodeChar(0x2225, "U2225") ; parallel
return

neo_7:
  noCaps = 1
  EbeneAktualisieren()
  if Ebene12 and !(CheckDeadUni("c1",0x2077) ; Hochgestellte 7
                or CheckDeadUni("a3",0x2087)) ; Tiefgestellte 7
    OutputChar12(7,"$",7,"dollar")
  else if (Ebene = 3)
    OutputChar("¥", "yen")
  else if (Ebene = 4)
    OutputChar("¤", "currency")
  else if (Ebene = 5)
    SendUnicodeChar(0x03BA, "Greek_kappa") ; greek small letter kappa
  else if (Ebene = 6)
    SendUnicodeChar(0x2192, "rightarrow") ; Rechtspfeil
return

neo_8:
  noCaps = 1
  EbeneAktualisieren()
  if Ebene12 and !(CheckDeadUni("c1",0x2078) ; Hochgestellte 8
                or CheckDeadUni("a3",0x2088)) ; Tiefgestellte 8
    OutputChar12(8,"„",8,"doublelowquotemark")
  else if (Ebene = 3)
    OutputChar("‚", "singlelowquotemark")
  else if (Ebene = 4)
    OutputChar("{NumpadDiv}", "KP_Divide")
  else if (Ebene = 5)
    SendUnicodeChar(0x27E8, "U27E8") ; bra (öffnende spitze Klammer)
  else if (Ebene = 6)
    SendUnicodeChar(0x221E, "infinity")
return

neo_9:
  noCaps = 1
  EbeneAktualisieren()
  if Ebene12 and !(CheckDeadUni("c1",0x2079) ; Hochgestellte 9
                or CheckDeadUni("a3",0x2089)) ; Tiefgestellte 9
    OutputChar12(9,"“",9,"leftdoublequotemark")
  else if (Ebene = 3)
    OutputChar("‘", "leftsinglequotemark")
  else if (Ebene = 4)
    OutputChar("{NumpadMult}", "KP_Multiply")
  else if (Ebene = 5)
    SendUnicodeChar(0x27E9, "U27E9") ; ket (schließende spitze Klammer)
  else if (Ebene = 6)
    SendUnicodeChar(0x2226, "U2226") ; nicht parallel
return

