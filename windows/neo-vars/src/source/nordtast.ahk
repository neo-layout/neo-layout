; -*- encoding:utf-8 -*-
; NordTast. Belegung von Ulf Bro, http://www.nordtast.org/
; Aus der Neo-Welt (AdNW) von Andreas Wettstein, http://wettstae.home.solnet.ch/
; (c) 2010 Matthias Wächter

CharProcNordTt() {
  global
  ; Custom Layout togglen
  if (isNordTast == 0) {
    isNordTast := 1
    CharProcNordT1()
    if (zeigeModusBox)
      TrayTip,NordTast-Belegungsvariante,Die Belegungsvariante NT wurde aktiviert. Zum Umschalten`, Mod3+F12 drücken.,10,1
  } else if (isNordTast == 1) {
    isNordTast := 2
    CharProcNordT2()
    if (zeigeModusBox)
      TrayTip,NordTast-Belegungsvariante,Die Belegungsvariante AdNW wurde aktiviert. Zum Umschalten`, Mod3+F12 drücken.,10,1
  } else if (isNordTast == 2) {
    isNordTast := 3
    CharProcNordT3()
    if (zeigeModusBox)
      TrayTip,NordTast-Belegungsvariante,Die Belegungsvariante DIEgO wurde aktiviert. Zum Umschalten`, Mod3+F12 drücken.,10,1
  } else {
    isNordTast := 0
    CharProcNordT0()
    if (zeigeModusBox)
      TrayTip,NordTast-Belegungsvariante,Die Belegungsvariante wurde deaktiviert.,10,1
  }
}

CharProcNordT1() {
  global
  ; Tastaturbelegungsvariante aktivieren
  ED1256("010",1,"ä","Ä","η","ℵ")
  ED1256("011",1,"u","U","" ,"⊂")
  ED1256("012",1,"o","O","ο","∈")
  ED1256("013",1,"b","B","β","⇐")
  ED1256("014",1,"p","P","π","Π")
  ED1256("015",1,"k","K","κ","×")
  ED1256("016",1,"g","G","γ","Γ")
  ED1256("017",1,"l","L","λ","Λ")
  ED1256("018",1,"m","M","μ","⇔")
  ED1256("019",1,"f","F","φ","Φ")
  ED1256("01A",1,"x","X","ξ","Ξ")

  ED1256("01E",1,"a","A","α","∀")
  ED1256("01F",1,"i","I","ι","∫")
  ED1256("020",1,"e","E","ε","∃")
  ED1256("021",1,"t","T","τ","∂")
  ED1256("022",1,"c","C","χ","ℂ")
  ED1256("023",1,"h","H","ψ","Ψ")
  ED1256("024",1,"d","D","δ","Δ")
  ED1256("025",1,"n","N","ν","ℕ")
  ED1256("026",1,"r","R","ρ","ℝ")
  ED1256("027",1,"s","S","σ","Σ")
  ED1256("028",1,"ß","ẞ","ς","∘")

  ED1256("02C",0,".","•","ϑ","↦")
  ED1256("02D",0,",","–","ϱ","⇒")
  ED1256("02E",1,"ü","Ü","" ,"∪")
  ED1256("02F",1,"ö","Ö","ϵ","∩")
  ED1256("030",1,"q","Q","ϕ","ℚ")
  ED1256("031",1,"y","Y","υ","∇")
  ED1256("032",1,"z","Z","ζ","ℤ")
  ED1256("033",1,"w","W","ω","Ω")
  ED1256("034",1,"v","V","" ,"√")
  ED1256("035",1,"j","J","θ","Θ")
}

CharProcNordT2() {
  global
  ; Tastaturbelegungsvariante Aus der Neo-Welt (AdNW) aktivieren
  ED1256("010",1,"k","K","κ","×")
  ED1256("011",1,"u","U","" ,"⊂")
  ED1256("012",1,"ü","Ü","" ,"∪")
  ED1256("013",0,".","•","ϑ","↦")
  ED1256("014",1,"ä","Ä","η","ℵ")
  ED1256("015",1,"v","V","" ,"√")
  ED1256("016",1,"g","G","γ","Γ")
  ED1256("017",1,"c","C","χ","ℂ")
  ED1256("018",1,"l","L","λ","Λ")
  ED1256("019",1,"j","J","θ","Θ")
  ED1256("01A",1,"f","F","φ","Φ")

  ED1256("01E",1,"h","H","ψ","Ψ")
  ED1256("01F",1,"i","I","ι","∫")
  ED1256("020",1,"e","E","ε","∃")
  ED1256("021",1,"a","A","α","∀")
  ED1256("022",1,"o","O","ο","∈")
  ED1256("023",1,"d","D","δ","Δ")
  ED1256("024",1,"t","T","τ","∂")
  ED1256("025",1,"r","R","ρ","ℝ")
  ED1256("026",1,"n","N","ν","ℕ")
  ED1256("027",1,"s","S","σ","Σ")
  ED1256("028",1,"ß","ẞ","ς","∘")

  ED1256("02C",1,"x","X","ξ","Ξ")
  ED1256("02D",1,"y","Y","υ","∇")
  ED1256("02E",1,"ö","Ö","ϵ","∩")
  ED1256("02F",0,",","–","ϱ","⇒")
  ED1256("030",1,"q","Q","ϕ","ℚ")
  ED1256("031",1,"b","B","β","⇐")
  ED1256("032",1,"p","P","π","Π")
  ED1256("033",1,"w","W","ω","Ω")
  ED1256("034",1,"m","M","μ","⇔")
  ED1256("035",1,"z","Z","ζ","ℤ")
}

CharProcNordT3() {
  global
  ; Tastaturbelegungsvariante DIEgO aktivieren
  ED1256("010",1,"p","P","π","Π")
  ED1256("011",1,"u","U","" ,"⊂")
  ED1256("012",1,"ü","Ü","" ,"∪")
  ED1256("013",0,".","•","ϑ","↦")
  ED1256("014",1,"ä","Ä","η","ℵ")
  ED1256("015",1,"j","J","θ","Θ")
  ED1256("016",1,"c","C","χ","ℂ")
  ED1256("017",1,"l","L","λ","Λ")
  ED1256("018",1,"h","H","ψ","Ψ")
  ED1256("019",1,"x","X","ξ","Ξ")
  ED1256("01A",1,"z","Z","ζ","ℤ")

  ED1256("01E",1,"d","D","δ","Δ")
  ED1256("01F",1,"i","I","ι","∫")
  ED1256("020",1,"e","E","ε","∃")
  ED1256("021",1,"a","A","α","∀")
  ED1256("022",1,"o","O","ο","∈")
  ED1256("023",1,"g","G","γ","Γ")
  ED1256("024",1,"t","T","τ","∂")
  ED1256("025",1,"r","R","ρ","ℝ")
  ED1256("026",1,"n","N","ν","ℕ")
  ED1256("027",1,"s","S","σ","Σ")
  ED1256("028",1,"ß","ẞ","ς","∘")

  ED1256("02C",1,"k","K","κ","×")
  ED1256("02D",1,"y","Y","υ","∇")
  ED1256("02E",1,"ö","Ö","ϵ","∩")
  ED1256("02F",0,",","–","ϱ","⇒")
  ED1256("030",1,"q","Q","ϕ","ℚ")
  ED1256("031",1,"m","M","μ","⇔")
  ED1256("032",1,"v","V","" ,"√")
  ED1256("033",1,"w","W","ω","Ω")
  ED1256("034",1,"b","B","β","⇐")
  ED1256("035",1,"f","F","φ","Φ")
}

CharProcNordT0() {
  global
  ; Tastaturbelegungsvariante deaktivieren
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

ActivateNordTast() {
  global

  CP3F12  := "PNordTt"                   ; M3+F12: Aktiviere/Deaktiviere NordTast

  IniRead,isNordTast,%ini%,Global,isNordTast,0
  if (isNordTast == 1)
    CharProcNordT1()
  else if (isNordTast == 2)
    CharProcNordT2()
  else if (isNordTast == 3)
    CharProcNordT3()
}

ActivateNordTast()
