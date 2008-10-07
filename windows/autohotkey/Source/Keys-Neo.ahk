/*
  Die eigentliche NEO-Belegung und der Hauptteil des AHK-Treibers.

  Reihe 1
*/

neo_tot1:
  noCaps = 1
  EbeneAktualisieren()
  if (Ebene = 1) and !CheckDeadUni("c1",0x0302)
    deadUni(0x02C6, "dead_circumflex", "c1") ; Zirkumflex, tot
  else if (Ebene = 2) and !CheckDeadUni("c2",0x030C)
    deadUni(0x02C7, "dead_caron", "c2") ; Caron, tot
  else if (Ebene = 3) and !CheckDeadUni("c3",0x0306)
    deadUni(0x02D8, "dead_breve", "c3") ; Brevis, tot
  ;CompKey := PriorCompKey
return

neo_1:
  noCaps=1
  EbeneAktualisieren()
  if Ebene12 and !(CheckDeadUni("c1",0x00B9) ; Hochgestellte 1
                or CheckDeadUni("c5",0x2081)) ; Tiefgestellte 1
    OutputChar12(1,"°",1,"degree")
  else if (Ebene = 3)
    SendUnicodeChar(0x00B9, "onesuperior") ; Hochgestellte 1
  else if (Ebene = 4)
    SendUnicodeChar(0x2022, "enfilledcircbullet") ; Bullet
  else if (Ebene = 5)
    SendUnicodeChar(0x2081, "U2081") ; Tiefgestellte 1
  else if (Ebene = 6)
    SendUnicodeChar(0x00AC, "notsign") ; Nicht-Symbol
return

neo_2:
  noCaps = 1
  EbeneAktualisieren()
  if (Ebene = 1 and !(CheckDeadUni("c1",0x00B2) ; Hochgestellte 2
                   or CheckDeadUni("c5",0x2082))) ; Tiefgestellte 2
    OutputChar(2,2)
  else if (Ebene = 2)
    SendUnicodeChar(0x2116, "numerosign") ; Numero
  else if (Ebene = 3)
    SendUnicodeChar(0x00B2, "twosuperior") ; Hochgestellte 2
  else if (Ebene = 4)
    SendUnicodeChar(0x2023, "U2023") ; Aufzählungspfeil
  else if (Ebene = 5)
    SendUnicodeChar(0x2082, "U2082") ; Tiefgestellte 2
  else if (Ebene = 6)
    SendUnicodeChar(0x2228, "logicalor") ; Logisches Oder
return

neo_3:
  noCaps = 1
  EbeneAktualisieren()
  if Ebene12 and !(CheckDeadUni("c1",0x00B3) ; Hochgestellte 3
                or CheckDeadUni("c5",0x2083)) ; Tiefgestellte 3
    OutputChar12(3,"§",3,"section")
  else if (Ebene = 3)
    SendUnicodeChar(0x00B3, "threesuperior") ; Hochgestellte 3
  else if (Ebene = 4)
    SendUnicodeChar(0x266B, "U226B") ; 2 Achtelnoten
  else if (Ebene = 5)
    SendUnicodeChar(0x2083, "U2083") ; Tiefgestellte 3
  else if (Ebene = 6)
    SendUnicodeChar(0x2227, "logicaland") ; Logisches Und
return

neo_4:
  noCaps = 1
  EbeneAktualisieren()
  if (Ebene = 1) and !(CheckDeadUni("c1",0x2074) ; Hochgestellte 4
                    or CheckDeadUni("c5",0x2084)) ; Tiefgestellte 4
    OutputChar(4,4)
  else if (Ebene = 2)
    SendUnicodeChar(0x00BB, "guillemotright") ; Double guillemot right
  else if (Ebene = 3)
    OutputChar("›", "U230A") ; Single guillemot right
  else if (Ebene = 4)
    OutputChar("{PgUp}", "Prior") ; Bild auf
  else if (Ebene = 5)
    SendUnicodeChar(0x2113, "U2213") ; Script small L
  else if (Ebene = 6)
    SendUnicodeChar(0x22A5, "uptack") ; Senkrecht
return

neo_5:
  noCaps = 1
  EbeneAktualisieren()
  if (Ebene = 1) and !(CheckDeadUni("c1",0x2075) ; Hochgestellte 5
                    or CheckDeadUni("c5",0x2085)) ; Tiefgestellte 5
    OutputChar(5,5)
  else if (Ebene = 2)
    SendUnicodeChar(0x00AB, "guillemotleft") ; Double guillemot left
  else if (Ebene = 3)
    OutputChar("‹", "U2039") ; Single guillemot left
  else if (Ebene = 5)
    SendUnicodeChar(0x0AF8, "femalesymbol") ; Kreuz (Dagger)
  else if (Ebene = 6)
    SendUnicodeChar(0x2221, "U2221") ; Winkel
return

neo_6:
  noCaps = 1
  EbeneAktualisieren()
  if (Ebene = 1) and !(CheckDeadUni("c1",0x2076) ; Hochgestellte 6
                    or CheckDeadUni("c5",0x2086)) ; Tiefgestellte 6
    OutputChar(6,6)
  else if (Ebene = 2)
    SendUnicodeChar(0x20AC, "EuroSign")
  else if (Ebene = 3)
    OutputChar("¢", "cent")
  else if (Ebene = 4)
    OutputChar("£", "sterling")
  else if (Ebene = 5)
    SendUnicodeChar(0x0AF7, "malesymbol")
  else if (Ebene = 6)
    SendUnicodeChar(0x2225, "U2225") ; parallel
return

neo_7:
  noCaps = 1
  EbeneAktualisieren()
  if Ebene12 and !(CheckDeadUni("c1",0x2077) ; Hochgestellte 7
                or CheckDeadUni("c5",0x2087)) ; Tiefgestellte 7
    OutputChar12(7,"$",7,"dollar")
  else if (Ebene = 3)
    OutputChar("¥", "yen")
  else if (Ebene = 4)
    OutputChar("¤", "currency")
  else if (Ebene = 5)
    SendUnicodeChar(0x03BA, "Greek_kappa") ; greek small letter kappa
  else if (Ebene = 6)
    SendUnicodeChar(0x2209, "notelementof") ; nicht Element von
return

neo_8:
  noCaps = 1
  EbeneAktualisieren()
  if Ebene12 and !(CheckDeadUni("c1",0x2078) ; Hochgestellte 8
            or CheckDeadUni("c5",0x2088)) ; Tiefgestellte 8
    OutputChar12(8,"„",8,"doublelowquotemark")
  else if (Ebene = 3)
    OutputChar("‚", "singlelowquotemark")
  else if (Ebene = 4)
    OutputChar("{NumpadDiv}", "KP_Divide")
  else if (Ebene = 5)
    SendUnicodeChar(0x27E8, "U27E8") ; bra (öffnende spitze Klammer)
  else if (Ebene = 6)
    SendUnicodeChar(0x2204, "U2204") ; es existiert nicht
return

neo_9:
  noCaps = 1
  EbeneAktualisieren()
  if Ebene12 and !(CheckDeadUni("c1",0x2079) ; Hochgestellte 9
      or CheckDeadUni("c5",0x2089)) ; Tiefgestellte 9
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

neo_0:
  noCaps = 1
  EbeneAktualisieren()
  if Ebene12 and !(CheckDeadUni("c1",0x2070) ; Hochgestellte 0
      or CheckDeadUni("c5",0x2080)) ; Tiefgestellte 0 
    OutputChar12(0,"”",0,"rightdoublequotemark")
   else if (Ebene = 3)
     OutputChar("’", "rightsingleqoutemark")
   else if (Ebene = 4)
     OutputChar("{NumpadSub}", "minus") ; s. Mail vom Sun, 14 Sep 2008 00:33:47 +0200
   else if (Ebene = 6)
     SendUnicodeChar(0x2205, "emptyset") ; leere Menge
return

neo_strich:
  noCaps = 1
  EbeneAktualisieren()
  if (Ebene = 1)
    OutputChar("-", "minus") ; Bindestrich-Minus
  else if (Ebene = 2)
    SendUnicodeChar(0x2013, "endash") ; Gedankenstrich
  else if (Ebene = 3)
    SendUnicodeChar(0x2014, "emdash") ; Englischer Gedankenstrich (Geviertstrich)
  else if (Ebene = 5)
    SendUnicodeChar(0x2011, "U2011") ; geschützter Bindestrich (Bindestrich ohne Zeilenumbruch)
  else if (Ebene = 6)
    SendUnicodeChar(0x00AD, "hyphen") ; weicher Bindestrich
return

neo_tot2:
  noCaps = 1
  EbeneAktualisieren()
  if (Ebene = 1) and !CheckDeadUni("a1",0x0301)
    deadAsc("{´}{space}", "dead_acute", "a1") ; Akut, tot
  else if (Ebene = 2) and !CheckDeadUni("a2",0x0300)
    deadAsc("``{space}", "dead_grave", "a2") ; Gravis, tot
  else if (Ebene = 3) and !CheckDeadUni("a3",0x0327)
    deadAsc("¸", "dead_cedilla", "a3") ; Cedilla, tot
  else if (Ebene = 4) and !CheckDeadUni("a4",0x0307)
    deadUni(0x02D9, "dead_abovedot", "a4") ; Punkt oben
  else if (Ebene = 5) and !CheckDeadUni("a5",0x0328)
    deadUni(0x02DB, "dead_ogonek", "a5") ; Ogonek
  else if (Ebene = 6) and !CheckDeadUni("a6",0x030A)
    deadUni(0x02DA, "dead_abovering", "a6") ; Ring oben
  CompKey := PriorCompKey
return


/*

  Reihe 2

*/

neo_x:
  EbeneAktualisieren()
  if Ebene12
    OutputChar12("x","X","x","X")
  else if (Ebene = 3)
    SendUnicodeChar(0x2026, "ellipsis") ; Ellipse horizontal
  else if (Ebene = 4)
    SendUnicodeChar(0x22EE, "U22EE") ; Ellipse vertikal
  else if (Ebene = 5)
    SendUnicodeChar(0x03BE, "Greek_xi") ; xi
  else if (Ebene = 6)
    SendUnicodeChar(0x039E, "Greek_XI") ; Xi
return

neo_v:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("c6",0x1E7F,0x1E7E)))
    OutputChar12("v","V","v","V")
  else if (Ebene = 3)
    OutputChar("_","underscore")
  else if (Ebene = 4) and (!lernModus or lernModus_neo_Backspace)
    OutputChar("{Backspace}", "BackSpace")
  else if (Ebene = 6)
    SendUnicodeChar(0x2259, "U2259") ; estimates/entspricht
return

neo_l:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a1",0x013A,0x0139)
                 or CheckDeadUni12("a3",0x013C,0x013B)
                 or CheckDeadUni12("c2",0x013E,0x013D)
                 or CheckDeadUni12("c4",0x0140,0x013F)
                 or CheckDeadUni12("c6",0x1E37,0x1E36)
                 or CheckDeadUni12("t4",0x0142,0x0141)))
    OutputChar12("l","L","l","L")
  else if (Ebene = 3)
    OutputChar("[", "bracketleft")
  else if (Ebene = 4)
    OutputChar("{Up}", "Up")
  else if (Ebene = 5)
    SendUnicodeChar(0x03BB, "Greek_lambda") ; lambda
  else if (Ebene = 6)
    SendUnicodeChar(0x039B, "Greek_LAMBDA") ; Lambda
return

neo_c:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a1",0x0107,0x0106)
                 or CheckDeadUni12("a3",0x00E7,0x00E6)
                 or CheckDeadUni12("a4",0x010B,0x010A)
                 or CheckDeadUni12("c1",0x0109,0x0108)
                 or CheckDeadUni12("c2",0x010D,0x010C)))
    OutputChar12("c","C","c","C")
  else if (Ebene = 3)
    OutputChar("]", "bracketright")
  else if (Ebene = 4) and (!lernModus or lernModus_neo_Entf)
    OutputChar("{Del}", "Delete")
  else if (Ebene = 5)
    SendUnicodeChar(0x03C7, "Greek_chi") ; chi
  else if (Ebene = 6)
    SendUnicodeChar(0x2102, "U2102") ; C (Komplexe Zahlen)]
return

neo_w:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("c1",0x0175,0x0174)))
    OutputChar12("w","W","w","W")
  else if (Ebene = 3)
    SendUnicodeChar(0x005E, "asciicircum") ; Zirkumflex
  else if (Ebene = 4)
    OutputChar("{Insert}", "Insert") ; Einfg
  else if (Ebene = 5)
    SendUnicodeChar(0x03C9, "Greek_omega") ; omega
  else if (Ebene = 6)
    SendUnicodeChar(0x03A9, "Greek_OMEGA") ; Omega
return

neo_k:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a3",0x0137,0x0136)
                 or CheckDeadUni12("c6",0x1E33,0x1E32)))
    OutputChar12("k","K","k","K")
  else if (Ebene = 3)
    OutputChar("{!}", "exclam")
  else if (Ebene = 4)
    OutputChar("¡", "exclamdown")
  else if (Ebene = 5)
    SendUnicodeChar(0x03F0, "U03F0") ; kappa symbol (varkappa)
  else if (Ebene = 6)
    SendUnicodeChar(0x221A, "radical") ; Wurzel
return

neo_h:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a4",0x1E23,0x1E22)
                 or CheckDeadUni12("c1",0x0125,0x0124)
                 or CheckDeadUni12("c5",0x0127,0x0126)
                 or CheckDeadUni12("c6",0x1E25,0x1E24)))
    OutputChar12("h","H","h","H")
  else if ((Ebene = 3) and !(CheckDeadUni("t4",0x2264))) ; kleiner gleich
    OutputChar("<", "less")
  else if ((Ebene = 4) and !(CheckDeadUni("c1",0x2077)
                          or CheckDeadUni("t4",0x2087)))
    OutputChar("{Numpad7}", "KP_7")
  else if (Ebene = 5)
    SendUnicodeChar(0x03C8, "Greek_psi") ; psi
  else if (Ebene = 6)
    SendUnicodeChar(0x03A8, "Greek_PSI") ; Psi
return

neo_g:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a3",0x0123,0x0122)
                 or CheckDeadUni12("a4",0x0121,0x0120)
                 or CheckDeadUni12("c1",0x011D,0x011C)
                 or CheckDeadUni12("c3",0x011F,0x011E)))
    OutputChar12("g","G","g","G")
  else if ((Ebene = 3) and !(CheckDeadUni("t4",0x2265))) ; größer gleich
    OutputChar(">", "greater")
  else if ((Ebene = 4) and !(CheckDeadUni("c1",0x2078)
                          or CheckDeadUni("t4",0x2088)))
    OutputChar("{Numpad8}", "KP_8")
  else if (Ebene = 5)
    SendUnicodeChar(0x03B3, "Greek_gamma") ; gamma
  else if (Ebene = 6)
    SendUnicodeChar(0x0393, "Greek_GAMMA") ; Gamma
return

neo_f:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a4",0x1E1F,0x1E1E)
                 or CheckDeadUni12("t4",0x0192,0x0191)))
    OutputChar12("f","F","f","F")
  else if ((Ebene = 3) and !(CheckDeadUni("a6",0x2257) ; ring equal to
                          or CheckDeadUni("c1",0x2259) ; entspricht
                          or CheckDeadUni("c2",0x225A) ; EQUIANGULAR TO
                          or CheckDeadUni("t2",0x2261) ; identisch
                          or CheckDeadUni("t1",0x2245) ; ungefähr gleich
                          or CheckDeadUni("t4",0x2260))) ; ungleich
    OutputChar("`=", "equal")
  else if ((Ebene = 4) and !(CheckDeadUni("c1",0x2079)
                          or CheckDeadUni("t4",0x2089)))
    OutputChar("{Numpad9}", "KP_9")
  else if (Ebene = 5)
    SendUnicodeChar(0x03C6, "Greek_phi") ; phi
  else if (Ebene = 6)
    SendUnicodeChar(0x03A6, "Greek_PHI") ; Phi
return

neo_q:
  EbeneAktualisieren()
  if (Ebene12)
     OutputChar12("q","Q","q","Q")
  else if (Ebene = 3)
    OutputChar("{&}", "ampersand")
  else if ((Ebene = 4) and !(CheckDeadUni("c1",0x207A)
                          or CheckDeadUni("c5",0x208A)))
    OutputChar("{NumPadAdd}", "plus") ; !!!
  else if (Ebene = 5)
     SendUnicodeChar(0x03D5, "U03D5") ; phi symbol (varphi)
  else if (Ebene = 6)
     SendUnicodeChar(0x211A, "U211A") ; Q (rationale Zahlen)
return

neo_sz:
  EbeneAktualisieren()
  if (Ebene = 1)
    if LangSTastatur
      OutputChar("s", "s")
    else OutputChar("ß", "ssharp")
  else if (Ebene = 2)
    SendUnicodeChar(0x1E9E, "U1E9E") ; versal-ß
  else if (Ebene = 3)
    if LangSTastatur
      OutputChar("ß", "ssharp")
    else SendUnicodeChar(0x017F, "17F") ; langes s
  else if (Ebene = 5)
    SendUnicodeChar(0x03C2, "Greek_finalsmallsigma") ; varsigma
  else if (Ebene = 6)
    SendUnicodeChar(0x2218, "jot") ; Verknüpfungsoperator
return


neo_tot3:
  noCaps = 1
  EbeneAktualisieren()
  if (Ebene = 1) and !CheckDeadUni("t1",0x0303)
    deadUni(0x02DC, "dead_tilde", "t1") ; Tilde, tot
  else if (Ebene = 2) and !CheckDeadUni("t2",0x0304)
    deadUni(0x00AF, "dead_macron", "t2") ; Macron, tot
  else if (Ebene = 3) and !CheckDeadUni("t3",0x0308)
    deadUni(0x00A8, "dead_diaeresis", "t3") ; Diärese
  else if (Ebene = 4) and !CheckDeadUni("t4",0x0338)
    deadUni(0x002F, "", "t4") ; Schrägstrich, tot
  else if (Ebene = 5) and !CheckDeadUni("t5",0x030B)
    deadUni(0x02DD, "dead_doubleacute", "t5") ; Doppelakut
  else if (Ebene = 6) and !CheckDeadUni("t6",0x0326)
    deadUni(0x02CF, "", "t6") ; Komma drunter, tot
return


/*

  Reihe 3

*/

neo_u:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a1",0x00FA,0x00DA)
                 or CheckDeadUni12("a2",0x00F9,0x00D9)
                 or CheckDeadUni12("a5",0x0173,0x0172)
                 or CheckDeadUni12("a6",0x016F,0x016E)
                 or CheckDeadUni12("c1",0x00FB,0x00DB)
                 or CheckDeadUni12("c2",0x01D4,0x01D3)
                 or CheckDeadUni12("c3",0x016D,0x016C)
                 or CheckDeadUni12("t1",0x0169,0x0168)
                 or CheckDeadUni12("t2",0x016B,0x016A)
                 or CheckDeadAsc12("t3","ü","Ü")
                 or CheckDeadUni12("t5",0x0171,0x0170)))
    OutputChar12("u","U","u","U")
  else if (Ebene = 3)
    OutputChar("\", "backslash")
  else if (Ebene = 4)
    OutputChar("{Home}", "Home")
  else if (Ebene = 6)
    SendUnicodeChar(0x222E, "U222E") ; contour integral
return

neo_i:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a1",0x00ED,0x00CD)
                 or CheckDeadUni12("a2",0x00EC,0x00CC)
                 or CheckDeadUni12("a4",0x012F,0x012E)
                 or CheckDeadUni12("a5",0x0131,0x0130)
                 or CheckDeadUni12("c1",0x00EE,0x00CE)
                 or CheckDeadUni12("c2",0x01D0,0x01CF)
                 or CheckDeadUni12("c3",0x012D,0x012C)
                 or CheckDeadUni12("t1",0x0129,0x0128)
                 or CheckDeadUni12("t2",0x012B,0x012A)
                 or CheckDeadAsc12("t3","ï","Ï")))
    OutputChar12("i","I","i","I")
  else if (Ebene = 3)
    OutputChar("`/", "slash")
  else if (Ebene = 4)
    OutputChar("{Left}", "Left")
  else if (Ebene = 5)
    SendUnicodeChar(0x03B9, "Greek_iota") ; iota
  else if (Ebene = 6)
    SendUnicodeChar(0x222B, "integral") ; integral
return

neo_a:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a1",0x00E1,0x00C1)
                or CheckDeadUni12("a2",0x00E0,0x00C0)
                or CheckDeadUni12("a5",0x0105,0x0104)
                or CheckDeadAsc12("a6","å","Å")
                or CheckDeadUni12("c1",0x00E2,0x00C2)
                or CheckDeadUni12("c2",0x01CE,0x01CD)
                or CheckDeadUni12("c3",0x0103,0x0102)
                or CheckDeadUni12("t1",0x00E3,0x00C3)
                or CheckDeadUni12("t2",0x0101,0x0100)
                or CheckDeadAsc12("t3","ä","Ä")))
    OutputChar12("a","A","a","A")
  else if (Ebene = 3)
    OutputChar("{{}", "braceleft")
  else if (Ebene = 4)
    OutputChar("{Down}", "Down")
  else if (Ebene = 5)
    SendUnicodeChar(0x03B1, "Greek_alpha") ; alpha
  else if (Ebene = 6)
    SendUnicodeChar(0x2200, "U2200") ; für alle
return

neo_e:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a1",0x00E9,0x00C9)
                 or CheckDeadUni12("a2",0x00E8,0x00C8)
                 or CheckDeadUni12("a4",0x0117,0x0116)
                 or CheckDeadUni12("a5",0x0119,0x0118)
                 or CheckDeadUni12("c1",0x00EA,0x00CA)
                 or CheckDeadUni12("c2",0x011B,0x011A)
                 or CheckDeadUni12("c3",0x0115,0x0114)
                 or CheckDeadUni12("t1",0x1EBD,0x1EBC)
                 or CheckDeadUni12("t2",0x0113,0x0112)
                 or CheckDeadAsc12("t3","ë","Ë")))
    OutputChar12("e","E","e","E")
  else if (Ebene = 3)
    OutputChar("{}}", "braceright")
  else if (Ebene = 4)
    OutputChar("{Right}", "Right")
  else if (Ebene = 5)
    SendUnicodeChar(0x03B5, "Greek_epsilon") ; epsilon
  else if (Ebene = 6)
    SendUnicodeChar(0x2203, "U2203") ; es existiert
return

neo_o:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a1",0x00F3,0x00D3)
                 or CheckDeadUni12("a2",0x00F2,0x00D2)
                 or CheckDeadUni12("a5",0x01EB,0x01EA)
                 or CheckDeadUni12("c1",0x00F4,0x00D4)
                 or CheckDeadUni12("c2",0x01D2,0x01D1)
                 or CheckDeadUni12("c3",0x014F,0x014E)
                 or CheckDeadUni12("t1",0x00F5,0x00D5)
                 or CheckDeadUni12("t2",0x014D,0x014C)
                 or CheckDeadAsc12("t3","ö","Ö")
                 or CheckDeadUni12("t4",0x00F8,0x00D8)
                 or CheckDeadUni12("t5",0x0151,0x0150)))
    OutputChar12("o","O","o","O")
  else if (Ebene = 3)
    OutputChar("*", "asterisk")
  else if (Ebene = 4)
    OutputChar("{End}", "End")
  else if (Ebene = 5)
    SendUnicodeChar(0x03BF, "Greek_omicron") ; omicron
  else if (Ebene = 6)
    SendUnicodeChar(0x2208, "elementof") ; element of
return

neo_s:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a1",0x015B,0x015A)
                 or CheckDeadUni12("a3",0x015F,0x015E)
                 or CheckDeadUni12("a4",0x1E61,0x1E60)
                 or CheckDeadUni12("c1",0x015D,0x015C)
                 or CheckDeadUni12("c2",0x0161,0x0160)
                 or CheckDeadUni12("c6",0x1E63,0x1A62))) {
    if LangSTastatur and (Ebene = 1)
      SendUnicodeChar(0x017F, "17F") ; langes s
    else OutputChar12("s","S","s","S")
  } else if (Ebene = 3)
    OutputChar("?", "question")
  else if Ebene7 {
    if LangSTastatur
      OutputChar("s", "s")
    else SendUnicodeChar(0x017F, "17F")
  } else if (Ebene = 4)
    OutputChar("¿", "questiondown")
  else if (Ebene = 5)
    SendUnicodeChar(0x03C3, "Greek_sigma") ;sigma
  else if (Ebene = 6)
    SendUnicodeChar(0x03A3, "Greek_SIGMA") ;Sigma
return

neo_n:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a1",0x0144,0x0143)
                 or CheckDeadUni12("a3",0x0146,0x0145)
                 or CheckDeadUni12("a4",0x1E45,0x1E44)
                 or CheckDeadUni12("c2",0x0148,0x0147)
                 or CheckDeadUni12("t1",0x00F1,0x00D1)))
    OutputChar12("n","N","n","N")
  else if (Ebene = 3)
    OutputChar("(", "parenleft")
  else if ((Ebene = 4) and !(CheckDeadUni("c1",0x2074)
                          or CheckDeadUni("t4",0x2084)))
    OutputChar("{Numpad4}", "KP_4")
  else if (Ebene = 5)
    SendUnicodeChar(0x03BD, "Greek_nu") ; nu
  else if (Ebene = 6)
    SendUnicodeChar(0x2115, "U2115") ; N (natürliche Zahlen)
return

neo_r:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a1",0x0155,0x0154)
                 or CheckDeadUni12("a3",0x0157,0x0156)
                 or CheckDeadUni12("a4",0x0E59,0x0E58)
                 or CheckDeadUni12("c2",0x0159,0x0158)
                 or CheckDeadUni12("t3",0x1E5B,0x1E5A)))
    OutputChar12("r","R","r","R")
  else if (Ebene = 3)
    OutputChar(")", "parenright")
  else if ((Ebene = 4) and !(CheckDeadUni("c1",0x2075)
                          or CheckDeadUni("t4",0x2085)))
    OutputChar("{Numpad5}", "KP_5")
  else if (Ebene = 5)
    SendUnicodeChar(0x03F1, "U03F1") ; rho symbol (varrho)
  else if (Ebene = 6)
    SendUnicodeChar(0x211D, "U221D") ; R (reelle Zahlen)
return

neo_t:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a3",0x0163,0x0162)
                 or CheckDeadUni12("a4",0x1E6B,0x1E6A)
                 or CheckDeadUni12("c2",0x0165,0x0164)
                 or CheckDeadUni12("c5",0x0167,0x0166)
                 or CheckDeadUni12("t4",0x1E6D,0x1E6C)
                 or CheckDeadUni("t3",0x1E97)))
    OutputChar12("t","T","t","T")
  else if (Ebene = 3)
    OutputChar("-", "minus") ; Bisstrich
  else if (Ebene = 4) and !(CheckDeadUni("c1",0x2076)
                          or CheckDeadUni("c5",0x2086))
    OutputChar("{Numpad6}", "KP_6")
  else if (Ebene = 5)
    SendUnicodeChar(0x03C4, "Greek_tau") ; tau
  else if (Ebene = 6)
    SendUnicodeChar(0x2202, "partialderivative") ; partielle Ableitung
return

neo_d:
   EbeneAktualisieren()
   if (Ebene12 and !(CheckDeadUni12("a4",0x1E0B,0x1E0A)
                  or CheckDeadUni12("c2",0x010F,0x010E)
                  or CheckDeadUni12("t2",0x0111,0x0110)
                  or CheckDeadUni12("t3",0x1E0D,0x1E0C)
                  or CheckDeadUni12("t4",0x00F0,0x00D0)))
     OutputChar12("d","D","d","D")
   else if (Ebene = 3)
     OutputChar(":", "colon")
   else if (Ebene = 4)
     OutputChar("{NumpadDot}", "comma")
   else if (Ebene = 5)
      SendUnicodeChar(0x03B4, "Greek_delta") ; delta
   else if (Ebene = 6)
      SendUnicodeChar(0x0394, "Greek_DELTA") ; Delta
return

neo_y:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a1",0x00FD,0x00DD)
                 or CheckDeadUni12("c1",0x0177,0x0176)
                 or CheckDeadAsc12("t3","ÿ","Ÿ")))
    OutputChar12("y","Y","y","Y")
  else if (Ebene = 3)
    OutputChar("@", "at")
  else if (Ebene = 4)
    OutputChar(".", "period")
  else if (Ebene = 5)
    SendUnicodeChar(0x03C5, "Greek_upsilon") ; upsilon
  else if (Ebene = 6)
    SendUnicodeChar(0x2207, "nabla") ; nabla
return

/*

  Reihe 4

*/

neo_ü:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a1",0x01D8,0x01D7)
                 or CheckDeadUni12("a2",0x01DC,0x01DB)
                 or CheckDeadUni12("c2",0x01DA,0x01D9)
                 or CheckDeadUni12("t2",0x01D6,0x01D5)))
    OutputChar12("ü","Ü","udiaeresis","Udiaeresis")
  else if (Ebene = 3)
    if isMod2Locked
      OutputChar("{Shift Up}{#}", "numbersign")
    else OutputChar("{blind}{#}", "numbersign")
  else if (Ebene = 4)
    OutputChar("{Esc}", "Escape")
  else if (Ebene = 6)
    SendUnicodeChar(0x221D, "variation") ; proportional
return

neo_ö:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("t2",0x022B,0x022A)))
    OutputChar12("ö","Ö","odiaeresis","Odiaeresis")
  else if (Ebene = 3)
    OutputChar("$", "dollar")
  else if (Ebene = 4)
    OutputChar("{Tab}", "Tab")
  else if (Ebene = 6)
    SendUnicodeChar(0x2111, "U2221") ; Fraktur I
return

neo_ä:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("t2",0x01DF,0x01DE)))
    OutputChar12("ä","Ä","adiaeresis","Adiaeresis")
  else if (Ebene = 3)
    OutputChar("|", "bar")
  else if (Ebene = 4)
    OutputChar("{PgDn}", "Next")
  else if (Ebene = 5)
    SendUnicodeChar(0x03B7, "Greek_eta") ; eta
  else if (Ebene = 6)
    SendUnicodeChar(0x211C, "U221C") ; Fraktur R
return

neo_p:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a4",0x1E57,0x1E56)))
    OutputChar12("p","P","p","P")
  else if ((Ebene = 3) and !(CheckDeadUni("t1",0x2248)))
    OutputChar("~", "asciitilde")
  else if (Ebene = 4)
    OutputChar("{Enter}", "Return")
  else if (Ebene = 5)
    SendUnicodeChar(0x03C0, "Greek_pi") ; pi
  else if (Ebene = 6)
    SendUnicodeChar(0x03A0, "Greek_PI") ; Pi
return

neo_z:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a1",0x017A,0x0179)
                 or CheckDeadUni12("a4",0x017C,0x017B)
                 or CheckDeadUni12("c2",0x017E,0x017D)
                 or CheckDeadUni12("c6",0x1E93,0x1E92)))
    OutputChar12("z","Z","z","Z")
  else if (Ebene = 3)
    OutputChar("``{space}", "grave") ; untot
  else if (Ebene = 5)
    SendUnicodeChar(0x03B6, "Greek_zeta") ; zeta
  else if (Ebene = 6)
    SendUnicodeChar(0x2124, "U2124") ; Z (ganze Zahlen)
return

neo_b:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a4",0x1E03,0x1E02)))
    OutputChar12("b","B","b","B")
  else if (Ebene = 3)
    if isMod2Locked
      OutputChar("{Shift Up}{+}", "plus")
    else OutputChar("{blind}{+}", "plus")
  else if (Ebene = 4)
    OutputChar(":", "colon")
  else if (Ebene = 5)
    SendUnicodeChar(0x03B2, "Greek_beta") ; beta
  else if (Ebene = 6)
    SendUnicodeChar(0x21D2, "implies") ; Doppel-Pfeil rechts
return

neo_m:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("a4",0x1E41,0x1E40)
                 or CheckDeadUni12("c6",0x1E43,0x1E42)))
    OutputChar12("m","M","m","M")
  else if (Ebene = 3)
    OutputChar("`%", "percent")
  else if ((Ebene = 4) and !(CheckDeadUni("c1",0x00B9)
                          or CheckDeadUni("t4",0x2081)))
    OutputChar("{Numpad1}", "KP_1")
  else if (Ebene = 5)
    SendUnicodeChar(0x03BC, "Greek_mu") ; griechisch mu, micro wäre 0x00B5
  else if (Ebene = 6)
    SendUnicodeChar(0x21D4, "ifonlyif") ; doppelter Doppelpfeil (genau dann wenn)
return

neo_komma:
  noCaps = 1
  EbeneAktualisieren()
  if (Ebene = 1)
    OutputChar(",", "comma")
  else if (Ebene = 2)
    SendUnicodeChar(0x22EE, "U22EE") ; vertikale Ellipse
  else if (Ebene = 3)
    OutputChar(Chr(34), "quotedbl")
  else if ((Ebene = 4) and !(CheckDeadUni("c1",0x00B2)
                          or CheckDeadUni("c5",0x2082)))
    OutputChar("{Numpad2}", "KP_2")
  else if (Ebene = 5)
    SendUnicodeChar(0x03C1, "Greek_rho") ; rho
  else if (Ebene = 6)
    SendUnicodeChar(0x21D0, "U21D0") ; Doppelpfeil links
return

neo_punkt:
  noCaps = 1
  EbeneAktualisieren()
  if (Ebene = 1)
    OutputChar(".", "period")
  else if (Ebene = 2)
    SendUnicodeChar("0x2026", "ellipsis") ; Ellipse
  else if (Ebene = 3)
    OutputChar("'", "apostrophe")
  else if ((Ebene = 4) and !(CheckDeadUni("c1",0x00B3)
                          or CheckDeadUni("t4",0x2083)))
    OutputChar("{Numpad3}", "KP_3")
  else if (Ebene = 5)
    SendUnicodeChar(0x03D1, "U03D1") ; theta symbol (vartheta)
  else if (Ebene = 6)
    SendUnicodeChar(0x0398, "Greek_THETA") ; Theta
return


neo_j:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni12("c1",0x0135,0x0134)
                 or CheckDeadUni("c2",0x01F0)))
    OutputChar12("j","J","j","J")
  else if (Ebene = 3)
    OutputChar("`;", "semicolon")
  else if (Ebene = 4)
    OutputChar("`;", "semicolon")
  else if (Ebene = 5)
    SendUnicodeChar(0x03B8, "Greek_theta") ; theta
  else if (Ebene = 6)
    SendUnicodeChar(0x2261, "identical") ; identisch
return

/*

  Numpad

*/

neo_NumLock:
  EbeneAktualisieren()
  if Ebene12
    OutputChar("{Tab}", "Tab")
  else if (Ebene = 3)
    OutputChar("`=", "equal")
  else if (Ebene = 4)
    SendUnicodeChar(0x2260, "notequal") ; Ungleich zu
  else if (Ebene = 5)
    SendUnicodeChar(0x2248, "approxeq") ; Fast gleich
  else if (Ebene = 6)
    SendUnicodeChar(0x2261, "identical")
return

neo_NumpadDiv:
  EbeneAktualisieren()
  if Ebene12
    OutputChar("{NumpadDiv}", "KP_Divide")
  else if (Ebene = 3)
    OutputChar("÷", "division")
  else if (Ebene = 4)
    SendUnicodeChar(0x2300, "U2300") ; diameter
  else if (Ebene = 5)
    SendUnicodeChar(0x2223, "U2223") ; divides
  else if (Ebene = 6)
    SendUnicodeChar(0x2044, "U2044") ; fraction slash
return

neo_NumpadMult:
  EbeneAktualisieren()
  if Ebene12
    send {blind}{NumpadMult}
  else if (Ebene = 3)
    SendUnicodeChar(0x22C5, "U22C5") ; multiplication dot
  else if (Ebene = 4)
    SendUnicodeChar(0x2299, "U2299") ; circled dot
  else if (Ebene = 5)
    OutputChar("×", "multiply")
  else if (Ebene = 6)
    SendUnicodeChar(0x2297, "U2297") ; circled times
return

neo_NumpadSub:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni("c1",0x207B)
                 or CheckDeadUni("t4",0x208B)))
    send {blind}{NumpadSub}
  else if (Ebene = 3)
    SendUnicodeChar(0x2212, "U2212") ; Echtes Minus
  else if (Ebene = 4)
    SendUnicodeChar(0x2296, "U2296") ; circled minus
  else if (Ebene = 5)
    SendUnicodeChar(0x2216, "U2216") ; set minus
  else if (Ebene = 6)
    SendUnicodeChar(0x2238, "U2238") ; dot minus
return

neo_NumpadAdd:
  EbeneAktualisieren()
  if (Ebene12 and !(CheckDeadUni("c1",0x207A)
                 or CheckDeadUni("c5",0x208A)))
    send {blind}{NumpadAdd}
  else if (Ebene = 3)
    OutputChar("±", "plusminus")
  else if (Ebene = 4)
    SendUnicodeChar(0x2295, "U2295") ; circled plus
  else if (Ebene = 5)
    SendUnicodeChar(0x2213, "U2213") ; minus-plus
  else if (Ebene = 6)
    SendUnicodeChar(0x2214, "U2214") ; dot plus
return

neo_NumpadEnter:
  send {blind}{NumpadEnter}
return

neo_Numpad7:
  EbeneAktualisieren()
  if (Ebene = 1)
    OutputChar("{Numpad7}", "KP_7")
  else if (Ebene = 2)
    SendUnicodeChar(0x2714, "U2714") ; check mark
  else if (Ebene = 3)
    SendUnicodeChar(0x2195, "U2195") ; Hoch-Runter-Pfeil
  else if (Ebene = 4)
    send {blind}{NumpadHome}
  else if (Ebene = 5)
    SendUnicodeChar(0x230A, "downstile") ;linke Untergrenze
  else if (Ebene = 6)
    SendUnicodeChar(0x2308, "upstile") ; linke Obergrenze
return

neo_Numpad8:
  EbeneAktualisieren()
  if (Ebene = 1)
    OutputChar("{Numpad8}", "KP_8")
  else if (Ebene = 2)
    SendUnicodeChar(0x2718, "U2718") ; ballot x
  else if (Ebene = 3)
    SendUnicodeChar(0x2191, "uparrow") ; Hochpfeil
  else if (Ebene = 4)
    send {blind}{NumpadUp}
  else if (Ebene = 5)
    SendUnicodeChar(0x2229, "intersection") ; Durchschnitt
  else if (Ebene = 6)
    SendUnicodeChar(0x22C2, "U22C2") ; n-ary intersection
return

neo_Numpad9:
  EbeneAktualisieren()
  if (Ebene = 1)
    OutputChar("{Numpad9}", "KP_9")
  else if (Ebene = 2)
    SendUnicodeChar(0x2020, "dagger") ; Kreuz
  else if (Ebene = 3)
    SendUnicodeChar(0x20D7, "U20D7") ; Vektor
  else if (Ebene = 4)
    send {blind}{NumpadPgUp}
  else if (Ebene = 5)
    SendUnicodeChar(0x230B, "U230B") ; rechte Untergrenze
  else if (Ebene = 6)
    SendUnicodeChar(0x2309, "U2309") ; rechte Obergrenze
return

neo_Numpad4:
  EbeneAktualisieren()
  if (Ebene = 1)
    OutputChar("{Numpad4}", "KP_4")
  else if (Ebene = 2)
    SendUnicodeChar(0x2663, "club") ; schwarzes Kreuz
  else if (Ebene = 3)
    SendUnicodeChar(0x2190, "leftarrow") ; Linkspfeil
  else if (Ebene = 4)
    send {blind}{NumpadLeft}
  else if (Ebene = 5)
    SendUnicodeChar(0x2282, "includein") ; Teilmenge
  else if (Ebene = 6)
    SendUnicodeChar(0x2286, "U2286") ; Teilmenge-gleich
return

neo_Numpad5:
  EbeneAktualisieren()
  if (Ebene = 1)
    OutputChar("{Numpad5}", "KP_5")
  else if (Ebene = 2)
    SendUnicodeChar(0x20AC, "EuroSign") ; Euro
  else if (Ebene = 3)
    SendUnicodeChar(0x221E, "infinity") ; Unendlich
  else if (Ebene = 4)
    send {blind}{NumPadClear} ; begin
  else if (Ebene = 5)
    SendUnicodeChar(0x22B6, "U22B6") ; original of
  else if (Ebene = 6)
    SendUnicodeChar(0x22B7, "U22B7") ; image of
return

neo_Numpad6:
  EbeneAktualisieren()
  if (Ebene = 1)
    OutputChar("{Numpad6}", "KP_6")
  if (Ebene = 2)
    OutputChar("¦", "brokenbar")
  else if (Ebene = 3)
    SendUnicodeChar(0x2192, "rightarrow") ; Rechtspfeil
  else if (Ebene = 4)
    send {blind}{NumpadRight}
  else if (Ebene = 5)
    SendUnicodeChar(0x2283, "includes") ; Obermenge
  else if (Ebene = 6)
    SendUnicodeChar(0x2287, "U2287") ; Obermenge-gleich
return

neo_Numpad1:
  EbeneAktualisieren()
  if (Ebene = 1)
    OutputChar("{Numpad1}", "KP_1")
  else if (Ebene = 2)
    SendUnicodeChar(0x2666, "diamond") ; Karo
  else if (Ebene = 3)
    SendUnicodeChar(0x2194, "U2194") ; Links-Rechts-Pfeil
  else if (Ebene = 4)
    send {blind}{NumpadEnd}
  else if (Ebene = 5)
    SendUnicodeChar(0x226A, "U226A") ; much less
  else if (Ebene = 6)
    SendUnicodeChar(0x2264, "lessthanequal")
return

neo_Numpad2:
  EbeneAktualisieren()
  if (Ebene = 1)
    OutputChar("{Numpad2}", "KP_2")
  else if (Ebene = 2)
    SendUnicodeChar(0x2265, "heart")
  else if (Ebene = 3)
    SendUnicodeChar(0x2192, "downarrow")
  else if (Ebene = 4)
    send {blind}{NumpadDown}
  else if (Ebene = 5)
    SendUnicodeChar(0x222A, "union") ; Vereinigung
  else if (Ebene = 6)
    SendUnicodeChar(0x22C3, "U22C3") ; n-ary union
return

neo_Numpad3:
  EbeneAktualisieren()
  if (Ebene = 1)
    OutputChar("{Numpad3}", "KP_3")
  else if (Ebene = 2)
    SendUnicodeChar(0x2660, "U2660") ; Pik
  else if (Ebene = 3)
    SendUnicodeChar(0x21CC, "U21CC") ; Harpune
  else if (Ebene = 4)
    send {blind}{NumpadPgDn}
  else if (Ebene = 5)
    SendUnicodeChar(0x226B, "U226B") ; much greater
  else if (Ebene = 6)
    SendUnicodeChar(0x2265, "greaterthanequal")
return

neo_Numpad0:
  EbeneAktualisieren()
  if (Ebene = 1)
    OutputChar("{Numpad0}", "KP_0")
  else if (Ebene = 2)
    SendUnicodeChar(0x2423, "U2423") ; space sign
  else if (Ebene = 3)
    SendUnicodeChar(0x0025, "percent") ; Prozent
  else if (Ebene = 4)
    send {blind}{NumpadIns}
  else if (Ebene = 5)
    SendUnicodeChar(0x2030, "U2030") ; Promille
  else if (Ebene = 6)
    SendUnicodeChar(0x25A1, "U25A1") ; white square
return

neo_NumpadDot:
  EbeneAktualisieren()
  if (Ebene = 1)
    send {blind}{NumpadDot}
  else if (Ebene = 2)
    send {blind}.
  else if (Ebene = 3)
    send `,
  else if (Ebene = 4)
    send {blind}{NumpadDel}
  else if (Ebene = 5)
    SendUnicodeChar(0x2032, "minutes")
  else if (Ebene = 6)
    SendUnicodeChar(0x2033, "seconds")
return

/*

  Sondertasten

*/

*space::
  if einHandNeo
    spacepressed := 1
  else goto neo_SpaceUp
return

*space up::
  if einHandNeo
    if keypressed {
     keypressed := 0
     spacepressed := 0
    } else goto neo_SpaceUp
  return

neo_SpaceUp:
  EbeneAktualisieren()
  if (Ebene = 1) and !CheckDeadUni("t4",0x2010)  ; Echter Bindestrich
    OutputChar("{Space}", "Space")
  else if (Ebene = 2) or (Ebene = 3)
    Send {blind}{Space}
  else if ((Ebene = 4) and !(CheckDeadUni("c1",0x2070)
                        or CheckDeadUni("c5",0x2080)))
   OutputChar("{Numpad0}", "KP_0")
  else if (Ebene = 5)
    SendUnicodeChar(0x00A0, "U00A0") ; geschütztes Leerzeichen
  else if (Ebene = 6)
    SendUnicodeChar(0x202F, "U202F") ; schmales geschütztes Leerzeichen
  DeadKey := ""
  CompKey := ""
  spacepressed := 0
  keypressed := 0
return

/*
  Folgende Tasten sind nur aufgeführt, um DeadKey zu leeren.
  Irgendwie sieht das noch nicht schön aus. Vielleicht lässt sich dieses
  Problem auch eleganter lösen...
*/

*Enter::
  EbeneAktualisieren()
  if !lernModus or lernModus_std_Return {
    if (Ebene = 4)
      send {blind}{NumpadEnter}
    else send {blind}{Enter}
    DeadKey := ""
    CompKey := ""
  } return

*Backspace::
  if !lernModus or lernModus_std_Backspace {
    send {Blind}{Backspace}
    DeadKey := ""
    CompKey := ""
  } return

*Del::
  if !lernModus or lernModus_std_Entf
    send {Blind}{Del}
return

*Ins::
  if !lernModus or lernModus_std_Einf
    send {Blind}{Ins}
return

/*
Auf Mod3+Tab liegt Compose.
*/

neo_tab:
  if (IsMod3Pressed()) {
    DeadKey := "comp"
    CompKey := ""
  } else {
    OutputChar("{Tab}","Tab")
    DeadKey := ""
    CompKey := ""
  } return

*Home::
  if !lernModus or lernModus_std_Pos1 {
    send {Blind}{Home}
    DeadKey := ""
    CompKey := ""
  } return

*End::
  if !lernModus or lernModus_std_Ende {
    send {Blind}{End}
    DeadKey := ""
    CompKey := ""
  } return

*PgUp::
  if !lernModus or lernModus_std_PgUp {
    send {Blind}{PgUp}
    DeadKey := ""
    CompKey := ""
  } return

*PgDn::
  if !lernModus or lernModus_std_PgDn {
    send {Blind}{PgDn}
    DeadKey := ""
    CompKey := ""
  } return

*Up::
  if !lernModus or lernModus_std_Hoch {
    send {Blind}{Up}
    DeadKey := ""
    CompKey := ""
  } return

*Down::
  if !lernModus or lernModus_std_Runter {
    send {Blind}{Down}
    DeadKey := ""
    CompKey := ""
  } return

*Left::
  if !lernModus or lernModus_std_Links {
    send {Blind}{Left}
    DeadKey := ""
    CompKey := ""
  } return

*Right::
  if !lernModus or lernModus_std_Rechts {
    send {Blind}{Right}
    DeadKey := ""
    CompKey := ""
  } return


