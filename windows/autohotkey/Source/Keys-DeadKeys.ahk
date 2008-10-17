neo_tot1:
  noCaps = 1
  EbeneAktualisieren()
  if (Ebene = 1) and !CheckDeadUni("c1",0x0302)      ; Zirkumflex, tot

    deadUni(0x02C6, "dead_circumflex", "c1")

  else if (Ebene = 2) and !CheckDeadUni("c2",0x0303) ; Tilde, tot

    deadUni(0x02DC, "dead_tilde", "c2")

  else if (Ebene = 3) and !CheckDeadUni("c3",0x030A) ; Ring, tot

    deadUni(0x02DA, "dead_breve", "c3")

  else if (Ebene = 4) and !CheckDeadUni("c4",0x030C) ; Caron, tot

    deadUni(0x02C7, "dead_caron", "c4")

  else if (Ebene = 5) and !CheckDeadUni("c5",0x0306) ; Brevis, tot

    deadUni(0x02D8, "dead_breve", "c5")

  else if (Ebene = 6) and !CheckDeadUni("c6",0x0304) ; Makron, tot

    deadUni(0x00AF, "dead_macron", "c6")
return

neo_tot2:
  noCaps = 1
  EbeneAktualisieren()
  if (Ebene = 1) and !CheckDeadUni("g1",0x0300)      ; Gravis, tot

    deadAsc("``{space}", "dead_grave", "g1")

  if (Ebene = 2) and !CheckDeadUni("g2",0x030F)      ; Doppelgravis, tot

    deadUni(0x02F5, "dead_doublegrave", "g2")

  else if (Ebene = 3) and !CheckDeadUni("g3",0x0308) ; Diärese, tot

    deadUni(0x00A8, "dead_diaeresis", "g3")

  else if (Ebene = 5) and !CheckDeadUni("g5",0x0485) ; Spiritus asper, tot

    deadUni(0x1FFE, "U1FFE", "g5")
return

neo_tot3:
  noCaps = 1
  EbeneAktualisieren()
  if (Ebene = 1) and !CheckDeadUni("a1",0x0301)      ; Akut, tot

    deadUni("{´}{space}", "dead_acute", "a1")

  else if (Ebene = 2) and !CheckDeadUni("a2",0x0327) ; Cedille, tot

    deadAsc("¸", "dead_cedilla", "a2")

  else if (Ebene = 3) and !CheckDeadUni("a3",0x0337) ; Strich, tot

    deadUni(0x002F, "dead_stroke", "a3")

  else if (Ebene = 4) and !CheckDeadUni("a4",0x0338) ; Doppelakut, tot

    deadUni(0x02DD, "dead_doubleacute", "a4")

  else if (Ebene = 5) and !CheckDeadUni("a5",0x0486) ; Spiritus lenis, tot

    deadUni(0x1FBF, "U1FBF", "a5")

  else if (Ebene = 6) and !CheckDeadUni("a6",0x0307) ; Punkt darüber, tot

    deadUni(0x02D9, "dead_abovedot", "a6")
return

