~F24::return

+pause::
Suspend, Permit
  goto togglesuspend

~*VKA1SC136::
  if (isShiftLPressed and !isShiftRPressed and !wasNonShiftKeyPressed)
    ToggleMod2Lock()
  isShiftRPressed := 1
  isShiftPressed := 1
  wasNonShiftKeyPressed := 0
  EbeneAktualisieren()
return

~*VKA1SC136 up::
  isShiftRPressed := 0
  isShiftPressed := isShiftLPressed
  EbeneAktualisieren()
return

~*VKA0SC02A::
  if (isShiftRPressed and !isShiftLPressed and !wasNonShiftKeyPressed)
    ToggleMod2Lock()
  isShiftLPressed := 1
  isShiftPressed := 1
  wasNonShiftKeyPressed := 0
  EbeneAktualisieren()
return

~*VKA0SC02A up::
  isShiftLPressed := 0
  isShiftPressed := isShiftRPressed
  EbeneAktualisieren()
return

*VKBFSC02B::
  if (isMod3LPressed and !isMod3RPressed and !wasNonShiftKeyPressed)
    CharStarDown("MOD3", "MOD3", "SComp")
  isMod3RPressed := 1
  isMod3Pressed := 1
  wasNonShiftKeyPressed := 0
  EbeneAktualisieren()
return

*VKBFSC02B up::
  if (isMod3LPressed)
    CharStarUp("MOD3")
  isMod3RPressed := 0
  isMod3Pressed := isMod3LPressed
  EbeneAktualisieren()
return

*VK14SC03A::
  if (isMod3RPressed and !isMod3LPressed and !wasNonShiftKeyPressed)
    CharStarDown("MOD3", "MOD3", "SComp")
  isMod3LPressed := 1
  isMod3Pressed := 1
  wasNonShiftKeyPressed := 0
  EbeneAktualisieren()
return

*VK14SC03A up::
  if (isMod3RPressed)
    CharStarUp("MOD3")
  isMod3LPressed := 0
  isMod3Pressed := isMod3RPressed
  EbeneAktualisieren()
return

*VKA5SC138::
  wasMod4RPressed := isMod4RPressed
  isMod4RPressed := 1
  isMod4Pressed := 1
  waswasNonShiftKeyPressed := wasNonShiftKeyPressed
  wasNonShiftKeyPressed := 0
  EbeneAktualisieren()
  if (isMod4LPressed and !wasMod4RPressed and !waswasNonShiftKeyPressed)
    ToggleMod4Lock()
return

*VKA5SC138 up::
  isMod4RPressed := 0
  isMod4Pressed := isMod4LPressed
  EbeneAktualisieren()
return

*VKE2SC056::
  wasMod4LPressed := isMod4LPressed
  isMod4LPressed := 1
  isMod4Pressed := 1
  waswasNonShiftKeyPressed := wasNonShiftKeyPressed
  wasNonShiftKeyPressed := 0
  EbeneAktualisieren()
  if (isMod4RPressed and !wasMod4LPressed and !waswasNonShiftKeyPressed)
    ToggleMod4Lock()
return

*VKE2SC056 up::
  isMod4LPressed := 0
  isMod4Pressed := isMod4RPressed
  EbeneAktualisieren()
return



;;;;;; DOWN EVENTS
; Reihe 1

*VKDCSC029:: ; Zirkumflex
*VK31SC002:: ; 1
*VK32SC003:: ; 2
*VK33SC004:: ; 3
*VK34SC005:: ; 4
*VK35SC006:: ; 5
*VK36SC007:: ; 6
*VK37SC008:: ; 7
*VK38SC009:: ; 8
*VK39SC00A:: ; 9
*VK30SC00B:: ; 0
*VKDBSC00C:: ; ß
*VKDDSC00D:: ; Akut

; Reihe 2

*VK51SC010:: ; q (x)
*VK57SC011:: ; w (v)x
*VK45SC012:: ; e (l)
*VK52SC013:: ; r (c)
*VK54SC014:: ; t (w)
*VK5ASC015:: ; z (k) 
*VK55SC016:: ; u (h)
*VK49SC017:: ; i (g)
*VK4FSC018:: ; o (f)
*VK50SC019:: ; p (q)
*VKBASC01A:: ; ü (ß)
*VKBBSC01B:: ; + (tot3)

; Reihe 3

*VK41SC01E:: ; a (u)
*VK53SC01F:: ; s (i)
*VK44SC020:: ; d (a)
*VK46SC021:: ; f (e)
*VK47SC022:: ; g (o)
*VK48SC023:: ; h (s)
*VK4ASC024:: ; j (n)
*VK4BSC025:: ; k (r)
*VK4CSC026:: ; l (t)
*VKC0SC027:: ; ö (d)
*VKDESC028:: ; ä (y)

; Reihe 4

*VK59SC02C:: ; y (ü)
*VK58SC02D:: ; x (ö)
*VK43SC02E:: ; c (ä)
*VK56SC02F:: ; v (p)
*VK42SC030:: ; b (z)
*VK4ESC031:: ; n (b)
*VK4DSC032:: ; m (m)
*VKBCSC033:: ; , (,)
*VKBESC034:: ; . (.)
*VKBDSC035:: ; - (j)
*space::

; Numpad

*VK90SC145:: ; NumLock
*VK6FSC135:: ; NumpadDiv
*VK6ASC037:: ; NumpadMult
*VK6DSC04A:: ; NumpadSub
*VK6BSC04E:: ; NumpadAdd
; *VK0DSC11C:: ; NumpadEnter
*VK67SC047:: ; NumPad7
*VK24SC047:: ; NumPadHome
*VK68SC048:: ; NumPad8
*VK26SC048:: ; NumPadUp
*VK69SC049:: ; NumPad9
*VK21SC049:: ; NumPadPgUp
*VK64SC04B:: ; NumPad4
*VK25SC04B:: ; NumPadLeft
*VK65SC04C:: ; NumPad5
*VK0CSC04C:: ; NumPadClear
*VK66SC04D:: ; NumPad6
*VK27SC04D:: ; NumPadRight
*VK61SC04F:: ; NumPad1
*VK23SC04F:: ; NumPadEnd
*VK62SC050:: ; NumPad2
*VK28SC050:: ; NumPadDown
*VK63SC051:: ; NumPad3
*VK22SC051:: ; NumPadPgDn
*VK60SC052:: ; NumPad0
*VK2DSC052:: ; NumPadIns
*VK6ESC053:: ; NumPadDot
*VK2ESC053:: ; NumPadDel
tab::
esc::
*enter::
*backspace::
*del::
*ins::
*home::
*end::
*pgup::
*pgdn::
*up::
*down::
*left::
*right::
F9::
F10::
F11::
F12::
numpadenter::

;;;;;; UP EVENTS
; Reihe 1

*VKDCSC029 up:: ; Zirkumflex
*VK31SC002 up:: ; 1
*VK32SC003 up:: ; 2
*VK33SC004 up:: ; 3
*VK34SC005 up:: ; 4
*VK35SC006 up:: ; 5
*VK36SC007 up:: ; 6
*VK37SC008 up:: ; 7
*VK38SC009 up:: ; 8
*VK39SC00A up:: ; 9
*VK30SC00B up:: ; 0
*VKDBSC00C up:: ; ß
*VKDDSC00D up:: ; Akut

; Reihe 2

*VK51SC010 up:: ; q (x)
*VK57SC011 up:: ; w (v)x
*VK45SC012 up:: ; e (l)
*VK52SC013 up:: ; r (c)
*VK54SC014 up:: ; t (w)
*VK5ASC015 up:: ; z (k) 
*VK55SC016 up:: ; u (h)
*VK49SC017 up:: ; i (g)
*VK4FSC018 up:: ; o (f)
*VK50SC019 up:: ; p (q)
*VKBASC01A up:: ; ü (ß)
*VKBBSC01B up:: ; + (tot3)

; Reihe 3

*VK41SC01E up:: ; a (u)
*VK53SC01F up:: ; s (i)
*VK44SC020 up:: ; d (a)
*VK46SC021 up:: ; f (e)
*VK47SC022 up:: ; g (o)
*VK48SC023 up:: ; h (s)
*VK4ASC024 up:: ; j (n)
*VK4BSC025 up:: ; k (r)
*VK4CSC026 up:: ; l (t)
*VKC0SC027 up:: ; ö (d)
*VKDESC028 up:: ; ä (y)

; Reihe 4

*VK59SC02C up:: ; y (ü)
*VK58SC02D up:: ; x (ö)
*VK43SC02E up:: ; c (ä)
*VK56SC02F up:: ; v (p)
*VK42SC030 up:: ; b (z)
*VK4ESC031 up:: ; n (b)
*VK4DSC032 up:: ; m (m)
*VKBCSC033 up:: ; , (,)
*VKBESC034 up:: ; . (.)
*VKBDSC035 up:: ; - (j)
*space up::

; Numpad

*VK90SC145 up:: ; NumLock
*VK6FSC135 up:: ; NumpadDiv
*VK6ASC037 up:: ; NumpadMult
*VK6DSC04A up:: ; NumpadSub
*VK6BSC04E up:: ; NumpadAdd
; *VK0DSC11C up:: ; NumpadEnter
*VK67SC047 up:: ; NumPad7
*VK24SC047 up:: ; NumPadHome
*VK68SC048 up:: ; NumPad8
*VK26SC048 up:: ; NumPadUp
*VK69SC049 up:: ; NumPad9
*VK21SC049 up:: ; NumPadPgUp
*VK64SC04B up:: ; NumPad4
*VK25SC04B up:: ; NumPadLeft
*VK65SC04C up:: ; NumPad5
*VK0CSC04C up:: ; NumPadClear
*VK66SC04D up:: ; NumPad6
*VK27SC04D up:: ; NumPadRight
*VK61SC04F up:: ; NumPad1
*VK23SC04F up:: ; NumPadEnd
*VK62SC050 up:: ; NumPad2
*VK28SC050 up:: ; NumPadDown
*VK63SC051 up:: ; NumPad3
*VK22SC051 up:: ; NumPadPgDn
*VK60SC052 up:: ; NumPad0
*VK2DSC052 up:: ; NumPadIns
*VK6ESC053 up:: ; NumPadDot
*VK2ESC053 up:: ; NumPadDel
tab up::
esc up::
*enter up::
*backspace up::
*del up::
*ins up::
*home up::
*end up::
*pgup up::
*pgdn up::
*up up::
*down up::
*left up::
*right up::
F9 up::
F10 up::
F11 up::
F12 up::
numpadenter up::

  AllStar(A_ThisHotkey)
return
