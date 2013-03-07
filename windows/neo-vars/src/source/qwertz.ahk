﻿; -*- encoding:utf-8 -*-
; QWERTZ
; (c) 2011 Matthias Wächter

CharProcQwertT() {
  global
  ; Custom Layout togglen
  if (isQwertz == 0) {
    isQwertz := 1
    CharProcQwerT1()
    if (zeigeModusBox)
      TrayTip,QWERTZ-Belegungsvariante,Die Belegungsvariante QWERTZ wurde aktiviert. Zum Umschalten`, Mod3+F6 drücken.,10,1
  } else {
    isQwertz := 0
    CharProcQwerT0()
    if (zeigeModusBox)
      TrayTip,QWERTZ-Belegungsvariante,Die Belegungsvariante wurde deaktiviert.,10,1
  }
}

CharProcQwerT1() {
  global
  ; Tastaturbelegungsvariante QWERTZ aktivieren

  ED1256("00C",1,"ß","ẞ","ς","∘")

  ED1256("010",1,"q","Q","ϕ","ℚ")
  ED1256("011",1,"w","W","ω","Ω")
  ED1256("012",1,"e","E","ε","∃")
  ED1256("013",1,"r","R","ρ","ℝ")
  ED1256("014",1,"t","T","τ","∂")
  ED1256("015",1,"z","Z","ζ","ℤ")
  ED1256("016",1,"u","U","" ,"⊂")
  ED1256("017",1,"i","I","ι","∫")
  ED1256("018",1,"o","O","ο","∈")
  ED1256("019",1,"p","P","π","Π")
  ED1256("01A",1,"ü","Ü","" ,"∪")

  ED1256("01E",1,"a","A","α","∀")
  ED1256("01F",1,"s","S","σ","Σ")
  ED1256("020",1,"d","D","δ","Δ")
  ED1256("021",1,"f","F","φ","Φ")
  ED1256("022",1,"g","G","γ","Γ")
  ED1256("023",1,"h","H","ψ","Ψ")
  ED1256("024",1,"j","J","θ","Θ")
  ED1256("025",1,"k","K","κ","×")
  ED1256("026",1,"l","L","λ","Λ")
  ED1256("027",1,"ö","Ö","ϵ","∩")
  ED1256("028",1,"ä","Ä","η","ℵ")

  ED1256("02C",1,"y","Y","υ","∇")
  ED1256("02D",1,"x","X","ξ","Ξ")
  ED1256("02E",1,"c","C","χ","ℂ")
  ED1256("02F",1,"v","V","" ,"√")
  ED1256("030",1,"b","B","β","⇐")
  ED1256("031",1,"n","N","ν","ℕ")
  ED1256("032",1,"m","M","μ","⇔")
  ED1256("033",0,",","–","ϱ","⇒")
  ED1256("034",0,".","•","ϑ","↦")
  ED1256("035",0,"-","—","‑","­")
}

CharProcQwerT0() {
  global
  ; Tastaturbelegungsvariante deaktivieren
  ED1256("00C",0,"-","—","‑","­")

  ED1256("010",1,"x","X","ξ","Ξ")
  ED1256("011",1,"v","V","" ,"√")
  ED1256("012",1,"l","L","λ","Λ")
  ED1256("013",1,"c","C","χ","ℂ")
  ED1256("014",1,"w","W","ω","Ω")
  ED1256("015",1,"k","K","κ","×")
  ED1256("016",1,"h","H","ψ","Ψ")
  ED1256("017",1,"g","G","γ","Γ")
  ED1256("018",1,"f","F","φ","Φ")
  ED1256("019",1,"q","Q","ϕ","ℚ")
  ED1256("01A",1,"ß","ẞ","ς","∘")

  ED1256("01E",1,"u","U","" ,"⊂")
  ED1256("01F",1,"i","I","ι","∫")
  ED1256("020",1,"a","A","α","∀")
  ED1256("021",1,"e","E","ε","∃")
  ED1256("022",1,"o","O","ο","∈")
  ED1256("023",1,"s","S","σ","Σ")
  ED1256("024",1,"n","N","ν","ℕ")
  ED1256("025",1,"r","R","ρ","ℝ")
  ED1256("026",1,"t","T","τ","∂")
  ED1256("027",1,"d","D","δ","Δ")
  ED1256("028",1,"y","Y","υ","∇")

  ED1256("02C",1,"ü","Ü","" ,"∪")
  ED1256("02D",1,"ö","Ö","ϵ","∩")
  ED1256("02E",1,"ä","Ä","η","ℵ")
  ED1256("02F",1,"p","P","π","Π")
  ED1256("030",1,"z","Z","ζ","ℤ")
  ED1256("031",1,"b","B","β","⇐")
  ED1256("032",1,"m","M","μ","⇔")
  ED1256("033",0,",","–","ϱ","⇒")
  ED1256("034",0,".","•","ϑ","↦")
  ED1256("035",1,"j","J","θ","Θ")
}

ActivateQwertz() {
  global

  CP3F6   := "PQwertt"                   ; M3+F6: Aktiviere/Deaktiviere QWERTZ

  IniRead,isQwertz,%ini%,Global,isQwertz,0
  if (isQwertz == 1)
    CharProcQwerT1()
}

ActivateQwertz()
