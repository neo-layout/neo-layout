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

