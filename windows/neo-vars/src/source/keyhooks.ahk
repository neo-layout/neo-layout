; Wir müssen F24 nicht hooken, aber bei einem Restart hat AHK den Bug,
; dass manchmal der erste Hook ausgeführt wird, als wäre diese Taste
; gedrückt worden. Da F24 auf den wenigsten Tastaturen vorkommt und daher für
; NEO uninteressant ist, kehren wir einfach wieder zurück.
~F24::return

+pause::
Suspend, Permit
  goto togglesuspend

;;;;;; DOWN EVENTS

; Funktionstasten

*F1::
*F2::
*F3::
*F4::
*F5::
*F6::
*F7::
*F8::
*F9::
*F10::
*F11::
*F12::

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

; Navigation, Sonstiges

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
numpadenter::

;;;;;; UP EVENTS

; Funktionstasten

*F1 up::
*F2 up::
*F3 up::
*F4 up::
*F5 up::
*F6 up::
*F7 up::
*F8 up::
*F9 up::
*F10 up::
*F11 up::
*F12 up::

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

; Navigation, Sonstiges

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
numpadenter up::

allstarhook:
  AllStar(A_ThisHotkey)
return
