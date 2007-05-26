/*
   NEO-Layout - Version vom 25.05.2007
   Mod3 (3./4. Ebene) funktioniert ¸ber Win+Ctrl, 
    Mod5 (5./6. Ebene) ¸ber AltGr.
   Zur Umbelegung von Mod3 auf CapsLock und #
    und f¸r einen zweiten Mod5 auf <
    verwende neo20-remap.ahk
*/

#usehook on
#singleinstance force
#LTrim 
  ; Quelltext kann einger¸ckt werden, 
  ; msgbox ist trotzdem linksb¸ndig

SendMode Play	
SetTitleMatchMode 2

name    = NEO-Layout 2.0
enable  = Aktiviere %name%
disable = Deaktiviere %name%


; ANSI-Darstellung von beliebigen Unicode-Zeichen
; -----------------------------------------------
;  - die untenstehende Definition auskommentieren
;  - gew¸nschtes Zeichen in die Zwischenablage befˆrdern
;  - ^!u (Control+Alt+U) dr¸cken
;  - die ANSI-Darstellung aus der Zwischenablage an die 
;    gew¸nschte Stelle ins Skript einf¸gen
; Wird benˆtigt f¸r Unicode("") und BSUnicode("").
; Alternativ kann SendUnicodeChar(0x002A) verwendet werden,
; braucht aber viel mehr CPU.
/*
^!u::  
   MsgBox, 
     (
     Copy some Unicode text onto the clipboard, 
     then return to this window and press OK to continue.
     )
   Transform, ClipUTF, Unicode
   Clipboard = Transform, Clipboard, Unicode, %ClipUTF%`r`n
   Clipboard = %ClipUTF%
   MsgBox, 
     (
     The clipboard now contains the following line 
     that you can paste into your script. 
     `n%Clipboard%
     )
return
*/


; ‹berpr¸fung auf deutsches Tastaturlayout 
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
     `nƒndern Sie die Tastatureinstellung unter 
     `tSystemsteuerung   
     `t-> Regions- und Sprachoptionen   
     `t-> Sprachen 
     `t-> Details...   `n
     )
   exitapp
}


; Men¸ des Systray-Icons 
; ----------------------

menu, tray, nostandard
menu, tray, add, ÷ffnen, open
   menu, helpmenu, add, About, about
   menu, helpmenu, add, Autohotkey-Hilfe, help
   menu, helpmenu, add
   menu, helpmenu, add, http://&autohotkey.com/, autohotkey
   menu, helpmenu, add, http://www.neo-layout.org/, neo
menu, tray, add, Hilfe, :helpmenu
menu, tray, add
menu, tray, add, %disable%, togglesuspend
menu, tray, default, %disable%
menu, tray, add
menu, tray, add, Edit, edit
menu, tray, add, Reload, reload
menu, tray, add
menu, tray, add, Nicht im Systray anzeigen, hide
menu, tray, add, %name% beenden, exitprogram
menu, tray, tip, %name%


; Sondertasten
; ------------

*Esc::Send {Esc} 

*Enter::Send {Enter}   

Space::Send {Space} 
+Space::Send {Space}
#^space::Send {Space}  
#^+space::SendUnicodeChar(0x00A0)   ; gesch¸tztes Leerzeichen 
<^>!Space::Send 0
<^>!+Space::SendUnicodeChar(0x2009) ; schmales Leerzeichen

Tab::Send {Tab}
+Tab::Send +{Tab}
#^Tab::Send {Tab}
#^+Tab::Send {Tab}
<^>!Tab::Send {Tab}
<^>!+Tab::Send {Tab}


Backspace::Send {BS}    
+Backspace::Send +{BS}
#^Backspace::Send {BS}    
#^+Backspace::Send {BS}    
<^>!Backspace::Send {BS}    
<^>!+Backspace::Send {BS}    


; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

; 1. Ebene
; ---------

^::Unicode("ÀÜ") ; circumflex, tot

1::
  If A_PriorHotkey = ^          ; circumflex 
    BSUnicode("¬π")
  Else
    send 1
return

2::  
  If A_PriorHotkey = ^          ; circumflex 
    BSUnicode("¬≤")
  Else
    send 2
return

3::  
  If A_PriorHotkey = ^          ; circumflex 
    BSUnicode("¬≥")
  Else
    send 3
return

4::send 4
5::send 5
6::send 6
7::send 7
8::send 8
9::send 9
0::send 0
ﬂ::send - ; Bind
¥::send {¥}{space} ; akut, tot

q::sendinput {blind}x

w::
  If A_PriorHotkey = <^>!+^      ; punkt darunter 
    BSUnicode("·πø")
  Else 
    sendinput {blind}v
Return

e::
  If A_PriorHotkey = <^>!+       ; Schr‰gstrich
    BSUnicode("≈Ç")
  Else If A_PriorHotkey = ¥      ; akut 
    BSUnicode("ƒ∫")
  Else If A_PriorHotkey = +^     ; caron 
    BSUnicode("ƒæ")
  Else If A_PriorHotkey = #^¥    ; cedilla
    BSUnicode("ƒº")
  Else If A_PriorHotkey = <^>!^  ; Mittenpunkt
    BSUnicode("≈Ä")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("·∏∑")
  Else 
    sendinput {blind}l
Return 

r::
  If A_PriorHotkey = ^           ; circumflex
    BSUnicode("ƒâ")
  Else If A_PriorHotkey = +^     ; caron
    BSUnicode("ƒç")
  Else If A_PriorHotkey = ¥      ; akut
    BSUnicode("ƒá")
  Else If A_PriorHotkey = #^¥    ; cedilla
    BSUnicode("√ß")
  Else If A_PriorHotkey = <^>!¥  ; punkt dar¸ber 
    BSUnicode("ƒã")
  Else 
    sendinput {blind}c
Return 

t::
  If A_PriorHotkey = ^           ; circumflex
    BSUnicode("≈µ")
  Else
    sendinput {blind}w
Return

z::
  If A_PriorHotkey = #^¥         ; cedilla
    BSUnicode("ƒ∑")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("·∏≥")
  Else
    sendinput {blind}k
Return

u::
  If A_PriorHotkey = ^           ; circumflex
    BSUnicode("ƒ•")
  Else If A_PriorHotkey = #^+^   ; Querstrich 
    BSUnicode("ƒß")
  Else If A_PriorHotkey = <^>!¥  ; punkt dar¸ber 
    BSUnicode("·∏£")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("·∏•")
  Else sendinput {blind}h
Return

i::
  If A_PriorHotkey = ^          ; circumflex
    BSUnicode("ƒù")
  Else If A_PriorHotkey = #^^   ; brevis
    BSUnicode("ƒü")
  Else If A_PriorHotkey = #^¥   ; cedilla
    BSUnicode("ƒ£")
  Else If A_PriorHotkey = <^>!¥ ; punkt dar¸ber 
    BSUnicode("ƒ°")
  Else sendinput {blind}g
Return

o::
  If A_PriorHotkey = <^>!+      ; durchgestrichen
    BSUnicode("∆í")
  Else If A_PriorHotkey = <^>!¥ ; punkt dar¸ber 
    BSUnicode("·∏ü")
  Else sendinput {blind}f
Return

p::sendinput {blind}q
¸::sendinput {blind}ﬂ

+::Unicode("Àú")    ; tilde, tot 

a::
  If A_PriorHotkey = ^           ; circumflex
    BSUnicode("√ª")
  Else If A_PriorHotkey = ¥      ; akut 
    BSUnicode("√∫")
  Else If A_PriorHotkey = +¥     ; grave
    BSUnicode("√π")
  Else If A_PriorHotkey = #^+    ; Diaerese
    Send, {bs}¸
  Else If A_PriorHotkey = #^++   ; doppelakut 
    BSUnicode("≈±")
  Else If A_PriorHotkey = #^^    ; brevis
    BSUnicode("≈≠")
  Else If A_PriorHotkey = ++     ; macron
    BSUnicode("≈´")
  Else If A_PriorHotkey = #^+¥   ; ogonek
    BSUnicode("≈≥")
  Else If A_PriorHotkey = <^>!+¥ ; Ring
    BSUnicode("≈Ø")
  Else If A_PriorHotkey = +      ; tilde
    BSUnicode("≈©")
  Else
    sendinput {blind}u
Return

s::
  If A_PriorHotkey = ^          ; circumflex
    BSUnicode("√Æ")
  Else If A_PriorHotkey = ¥      ; akut 
    BSUnicode("√≠")
  Else If A_PriorHotkey = +¥     ; grave
    BSUnicode("√¨")
  Else If A_PriorHotkey = #^+   ; Diaerese
    Send, {bs}Ô
  Else If A_PriorHotkey = ++    ; macron
    BSUnicode("ƒ´")
  Else If A_PriorHotkey = #^^   ; brevis
    BSUnicode("ƒ≠")
  Else If A_PriorHotkey = #^+¥  ; ogonek
    BSUnicode("ƒØ")
  Else If A_PriorHotkey = +     ; tilde
    BSUnicode("ƒ©")
  Else If A_PriorHotkey = <^>!¥ ; (ohne) punkt dar¸ber 
    BSUnicode("ƒ±")
  Else 
    sendinput {blind}i
Return

d::
  If A_PriorHotkey = ^           ; circumflex
    BSUnicode("√¢")
  Else If A_PriorHotkey = ¥      ; akut 
    BSUnicode("√°")
  Else If A_PriorHotkey = +¥     ; grave
    BSUnicode("√†")
  Else If A_PriorHotkey = #^+    ; Diaerese
    send {bs}‰
  Else If A_PriorHotkey = <^>!+¥ ; Ring 
    Send {bs}Â
  Else If A_PriorHotkey = +      ; tilde
    BSUnicode("√£")
  Else If A_PriorHotkey = #^+¥   ; ogonek
    BSUnicode("ƒÖ")
  Else If A_PriorHotkey = ++     ; macron
    BSUnicode("ƒÅ")
  Else If A_PriorHotkey = #^^    ; brevis
    BSUnicode("ƒÉ")
  Else 
    sendinput {blind}a
Return 

f::
  If A_PriorHotkey = ^          ; circumflex
    BSUnicode("√™")
  Else If A_PriorHotkey = ¥      ; akut 
    BSUnicode("√©")
  Else If A_PriorHotkey = +¥     ; grave
    BSUnicode("√®")
  Else If A_PriorHotkey = #^+   ; Diaerese
    Send, {bs}Î
  Else If A_PriorHotkey = #^+¥  ; ogonek
    BSUnicode("ƒô")
  Else If A_PriorHotkey = ++    ; macron
    BSUnicode("ƒì")
  Else If A_PriorHotkey = #^^   ; brevis
    BSUnicode("ƒï")
  Else If A_PriorHotkey = +^    ; caron
    BSUnicode("ƒõ")
  Else If A_PriorHotkey = <^>!¥ ; punkt dar¸ber 
    BSUnicode("ƒó")
  Else 
    sendinput {blind}e
Return 

g::
  If A_PriorHotkey = ^           ; circumflex
    BSUnicode("√¥")
  Else If A_PriorHotkey = ¥      ; akut 
    BSUnicode("√≥")
  Else If A_PriorHotkey = +¥     ; grave
    BSUnicode("√≤")
  Else If A_PriorHotkey = #^+    ; Diaerese
    Send, {bs}ˆ
  Else If A_PriorHotkey = +      ; tilde
    BSUnicode("√µ")
  Else If A_PriorHotkey = #^++   ; doppelakut
    BSUnicode("≈ë")
  Else If A_PriorHotkey = <^>!+  ; Schr‰gstrich
    BSUnicode("√∏")
  Else If A_PriorHotkey = ++     ; macron
    BSUnicode("≈ç")
  Else If A_PriorHotkey = #^^    ; brevis 
    BSUnicode("≈è")
  Else 
    sendinput {blind}o
Return

h::
  If A_PriorHotkey = ^           ; circumflex
    BSUnicode("≈ù")
  Else If A_PriorHotkey = ¥      ; akut 
    BSUnicode("≈õ")
  Else If A_PriorHotkey = +^     ; caron
    BSUnicode("≈°")
  Else If A_PriorHotkey = #^¥    ; cedilla
    BSUnicode("≈ü")
  Else If A_PriorHotkey = <^>!¥  ; punkt dar¸ber 
    BSUnicode("·π°")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("·π£")
  Else   
    sendinput {blind}s
Return

j::
  If A_PriorHotkey = ¥          ; akut
    BSUnicode("≈Ñ")
  Else If A_PriorHotkey = +     ; tilde
    BSUnicode("√±")
  Else If A_PriorHotkey = +^    ; caron
    BSUnicode("≈à")
  Else If A_PriorHotkey = #^¥   ; cedilla
    BSUnicode("≈Ü")
  Else If A_PriorHotkey = <^>!¥ ; punkt dar¸ber 
    BSUnicode("·πÖ")
  Else
    sendinput {blind}n
Return

k::
  If A_PriorHotkey = ¥           ; akut 
    BSUnicode("≈ï")
  Else If A_PriorHotkey = +^     ; caron
    BSUnicode("≈ô")
  Else If A_PriorHotkey = #^¥    ; cedilla
    BSUnicode("≈ó")
  Else If A_PriorHotkey = <^>!¥  ; punkt dar¸ber 
    BSUnicode("·πô")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("·πõ")
  Else 
    sendinput {blind}r
Return

l::  
  If A_PriorHotkey = +^          ; caron 
    BSUnicode("≈•")
  Else If A_PriorHotkey = #^¥    ; cedilla
    BSUnicode("≈£")
  Else If A_PriorHotkey = #^+^   ; Querstrich
    BSUnicode("≈ß")
  Else If A_PriorHotkey = <^>!¥  ; punkt dar¸ber 
    BSUnicode("·π´")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("·π≠")
  Else 
    sendinput {blind}t
Return

ˆ::
  If A_PriorHotkey = #^+^        ; Querstrich
    BSUnicode("ƒë")
  Else If A_PriorHotkey = <^>!+  ; Schr‰gstrich
    BSUnicode("√∞")
  Else If A_PriorHotkey = +^     ; caron
    BSUnicode("ƒè")
  Else If A_PriorHotkey = <^>!¥  ; punkt dar¸ber 
    BSUnicode("·∏ã")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("·∏ç")
  Else 
    sendinput {blind}d
Return

‰::  
  If A_PriorHotkey = #^+       ; Diaerese
    Send {bs}ˇ
  Else If A_PriorHotkey = ¥      ; akut 
    BSUnicode("√Ω")
  Else If A_PriorHotkey = ^    ; circumflex
    BSUnicode("≈∑")
  Else
    sendinput {blind}y
Return

;SC02B (#) wird zu Mod3

;SC056 (<) wird zu Mod5
y::sendinput {blind}ˆ
x::sendinput {blind}¸
c::sendinput {blind}‰
v::
  If A_PriorHotkey = <^>!¥      ; punkt dar¸ber 
    BSUnicode("·πó")
  Else
    sendinput {blind}p
Return

b::
  If A_PriorHotkey = +^         ; caron
    BSUnicode("≈æ")
  Else If A_PriorHotkey = ¥     ; akut
    BSUnicode("≈∫")
  Else If A_PriorHotkey = <^>!¥ ; punkt dr¸ber
    BSUnicode("≈º")
  Else If A_PriorHotkey = <^>!¥ ; punkt dar¸ber 
    BSUnicode("≈º")
  Else 
    sendinput {blind}z
Return 

n::
  If A_PriorHotkey = <^>!¥      ; punkt dar¸ber 
    BSUnicode("·∏É")
  Else 
    sendinput {blind}b
Return

m::
  If A_PriorHotkey = <^>!¥       ; punkt dar¸ber 
    BSUnicode("·πÅ")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("·πÉ")
  Else 
    sendinput {blind}m
Return

,::send `,
.::send .

-::
  If A_PriorHotkey = ^           ; circumflex
    BSUnicode("ƒµ")
  Else
    sendinput {blind}j
Return


;2. Ebene (Shift)
;---------
; 

+^::Unicode("Àá")  ; caron, tot
+1::send ∞
+2::send ∂
+3::send ß
+4::send $
+5::send Ä
+6::send ™
+7::send ∫
+8::send Ñ
+9::send ì
+0::send î
+ﬂ::Unicode("‚Äì") ; Ged
+¥::send ``{space} 

+q::sendinput {blind}X
+w::
  If A_PriorHotkey = <^>!+^      ; punkt darunter
    BSUnicode("·πæ")
  Else 
    sendinput {blind}V
Return

+e::
  If A_PriorHotkey = ¥           ; akut 
    BSUnicode("ƒπ")
  Else If A_PriorHotkey = +^     ; caron 
    BSUnicode("ƒΩ")
  Else If A_PriorHotkey = #^¥    ; cedilla
    BSUnicode("ƒª")
  Else If A_PriorHotkey = <^>!+  ; Schr‰gstrich 
    BSUnicode("≈Å")
  Else If A_PriorHotkey = <^>!^  ; Mittenpunkt 
    BSUnicode("ƒø")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("·∏∂")
  Else 
    sendinput {blind}L
return

+r::
  If A_PriorHotkey = ^          ; circumflex 
    BSUnicode("ƒà")
  Else If A_PriorHotkey = +^    ; caron 
    BSUnicode("ƒå")
  Else If A_PriorHotkey = ¥     ; akut 
    BSUnicode("ƒÜ")
  Else If A_PriorHotkey = #^¥   ; cedilla 
    BSUnicode("√á")
  Else If A_PriorHotkey = <^>!¥ ; punkt dar¸ber 
    BSUnicode("ƒä")
  Else 
    sendinput {blind}C
Return 

+t::
  If A_PriorHotkey = ^           ; circumflex
    BSUnicode("≈¥")
  Else
    sendinput {blind}W
Return

+z::  
  If A_PriorHotkey = #^¥         ; cedilla 
    BSUnicode("ƒ∂")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("·∏≤")
  Else
    sendinput {blind}K
Return

+u::
  If A_PriorHotkey = ^           ; circumflex
    BSUnicode("ƒ§")
  Else If A_PriorHotkey = #^+^   ; Querstrich
    BSUnicode("ƒ¶")
  Else If A_PriorHotkey = <^>!¥  ; punkt dar¸ber 
    BSUnicode("·∏¢")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("·∏§")
  Else sendinput {blind}H
Return

+i::
  If A_PriorHotkey = ^           ; circumflex
    BSUnicode("ƒú") 
  Else If A_PriorHotkey = #^^    ; brevis 
    BSUnicode("ƒû")
  Else If A_PriorHotkey = #^¥    ; cedilla 
    BSUnicode("ƒ¢")
  Else If A_PriorHotkey = <^>!¥  ; punkt dar¸ber 
    BSUnicode("ƒ†")
  Else sendinput {blind}G
Return

+o::
  If A_PriorHotkey = <^>!+       ; durchgestrichen
    BSUnicode("‚Ç£")
  Else If A_PriorHotkey = <^>!¥  ; punkt dar¸ber 
    BSUnicode("·∏û")
  Else sendinput {blind}F
Return

+p::sendinput {blind}Q
+¸::send SS ; wird versal-ﬂ

++::Unicode("Àâ")  ; macron, tot 

+a::
  If A_PriorHotkey = ^           ; circumflex
    BSUnicode("√õ")
  Else If A_PriorHotkey = ¥      ; akut 
    BSUnicode("√ö")
  Else If A_PriorHotkey = +¥     ; grave
    BSUnicode("√ô")
  Else If A_PriorHotkey = #^+    ; Diaerese
    Send, {bs}‹
  Else If A_PriorHotkey = <^>!+¥ ; Ring
    BSUnicode("≈Æ")
  Else If A_PriorHotkey = #^^    ; brevis
    BSUnicode("≈¨")
  Else If A_PriorHotkey = #^++   ; doppelakut
    BSUnicode("≈∞")
  Else If A_PriorHotkey = +^     ; caron 
    BSUnicode("≈Æ")
  Else If A_PriorHotkey = ++     ; macron
    BSUnicode("≈™")
  Else If A_PriorHotkey = #^^    ; brevis 
    BSUnicode("≈¨")
  Else If A_PriorHotkey = #^+¥   ; ogonek
    BSUnicode("≈≤")
  Else If A_PriorHotkey = +      ; tilde
    BSUnicode("≈®")
  Else
    sendinput {blind}U
Return

+s::
  If A_PriorHotkey = ^           ; circumflex
    BSUnicode("√é")
  Else If A_PriorHotkey = ¥      ; akut 
    BSUnicode("√ç")
  Else If A_PriorHotkey = +¥     ; grave
    BSUnicode("√å")
  Else If A_PriorHotkey = #^+    ; Diaerese
    Send, {bs}œ
  Else If A_PriorHotkey = ++     ; macron
    BSUnicode("ƒ™")
  Else If A_PriorHotkey = #^^    ; brevis 
    BSUnicode("ƒ¨")
  Else If A_PriorHotkey = #^+¥   ; ogonek
    BSUnicode("ƒÆ")
  Else If A_PriorHotkey = +      ; tilde
    BSUnicode("ƒ®")
  Else If A_PriorHotkey = <^>!¥  ; punkt dar¸ber 
    BSUnicode("ƒ∞")
  Else 
    sendinput {blind}I
Return

+d::
  If A_PriorHotkey = ^            ; circumflex
    BSUnicode("√Ç")
  Else If A_PriorHotkey = ¥       ; akut 
    BSUnicode("√Å")
  Else If A_PriorHotkey = +¥      ; grave
    BSUnicode("√Ä")
  Else If A_PriorHotkey = #^+     ; Diaerese
    send {bs}ƒ
  Else If A_PriorHotkey = +       ; tilde
    BSUnicode("√É")
  Else If A_PriorHotkey = <^>!+¥  ; Ring 
    Send {bs}≈
  Else If A_PriorHotkey = ++      ; macron
    BSUnicode("ƒÄ")
  Else If A_PriorHotkey = #^^     ; brevis 
    BSUnicode("ƒÇ")
  Else If A_PriorHotkey = #^+¥    ; ogonek
    BSUnicode("ƒÑ")
  Else 
    sendinput {blind}A
Return 

+f::
  If A_PriorHotkey = ^           ; circumflex
    BSUnicode("√ä")
  Else If A_PriorHotkey = ¥      ; akut 
    BSUnicode("√â")
  Else If A_PriorHotkey = +¥     ; grave
    BSUnicode("√à")
  Else If A_PriorHotkey = #^+    ; Diaerese
    Send, {bs}À
  Else If A_PriorHotkey = +^     ; caron
    BSUnicode("ƒö")
  Else If A_PriorHotkey = ++     ; macron
    BSUnicode("ƒí")
  Else If A_PriorHotkey = #^^    ; brevis 
    BSUnicode("ƒî")
  Else If A_PriorHotkey = #^+¥   ; ogonek 
    BSUnicode("ƒò")
  Else If A_PriorHotkey = <^>!¥  ; punkt dar¸ber 
    BSUnicode("ƒñ")
  Else 
    sendinput {blind}E
Return 

+g::
  If A_PriorHotkey = ^           ; circumflex
    BSUnicode("√î")
  Else If A_PriorHotkey = ¥      ; akut 
    BSUnicode("√ì")
  Else If A_PriorHotkey = +¥     ; grave
    BSUnicode("√í")
  Else If A_PriorHotkey = <^>!+  ; Schr‰gstrich
    BSUnicode("√ò")
  Else If A_PriorHotkey = +      ; tilde
    BSUnicode("√ï")
  Else If A_PriorHotkey = #^++   ; doppelakut
    BSUnicode("≈ê")
  Else If A_PriorHotkey = #^+    ; Diaerese
    send {bs}÷
  Else If A_PriorHotkey = ++     ; macron 
    BSUnicode("≈å")
  Else If A_PriorHotkey = #^^    ; brevis 
    BSUnicode("≈é")
  Else
    sendinput {blind}O
Return

+h::
  If A_PriorHotkey = ^           ; circumflex
    BSUnicode("≈ú")
  Else If A_PriorHotkey = +^     ; caron
    BSUnicode("≈†")
  Else If A_PriorHotkey = ¥      ; akut 
    BSUnicode("≈ö")
  Else If A_PriorHotkey = #^¥    ; cedilla 
    BSUnicode("≈û")
  Else If A_PriorHotkey = <^>!¥  ; punkt dar¸ber 
    BSUnicode("·π")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("·π¢")
  Else
    sendinput {blind}S
Return

+j::
  If A_PriorHotkey = +^         ; caron
    BSUnicode("≈á")
  Else If A_PriorHotkey = +     ; tilde
    BSUnicode("√ë")
  Else If A_PriorHotkey = ¥     ; akut 
    BSUnicode("≈É")
  Else If A_PriorHotkey = #^¥   ; cedilla 
    BSUnicode("≈Ö")
  Else If A_PriorHotkey = <^>!¥ ; punkt dar¸ber 
    BSUnicode("·πÑ")
  Else
    sendinput {blind}N
Return

+k::
  If A_PriorHotkey = +^          ; caron
    BSUnicode("≈ò")
  Else If A_PriorHotkey = ¥      ; akut 
    BSUnicode("≈î")
  Else If A_PriorHotkey = #^¥    ; cedilla 
    BSUnicode("≈ñ")
  Else If A_PriorHotkey = <^>!¥  ; punkt dar¸ber 
    BSUnicode("·πò")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("·πö")
  Else 
    sendinput {blind}R
Return

+l::
  If A_PriorHotkey = +^          ; caron
    BSUnicode("≈§")
  Else If A_PriorHotkey = #^¥    ; cedilla 
    BSUnicode("≈¢")
  Else If A_PriorHotkey = #^+^   ; Querstrich
    BSUnicode("≈¶")
  Else If A_PriorHotkey = <^>!¥  ; punkt dar¸ber 
    BSUnicode("·π™")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("·π¨")
  Else 
    sendinput {blind}T
Return


+ˆ::
  If A_PriorHotkey = #^+^        ; Querstrich
    BSUnicode("ƒê")
  Else If A_PriorHotkey = <^>!+  ; Schr‰gstrich
    BSUnicode("√ê")
  Else If A_PriorHotkey = +^     ; caron 
    BSUnicode("ƒé")
  Else If A_PriorHotkey = <^>!¥  ; punkt dar¸ber 
    BSUnicode("·∏ä")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("·∏å")
  Else sendinput {blind}D
Return

+‰::  
  If A_PriorHotkey = ¥           ; akut 
    BSUnicode("√ù")
  Else If A_PriorHotkey = #^+    ; Diaerese
    Send {bs}ü
  Else If A_PriorHotkey = ^      ; circumflex
    BSUnicode("≈∂")
  Else
    sendinput {blind}Y
Return

+y::sendinput {blind}÷
+x::sendinput {blind}‹
+c::sendinput {blind}ƒ

+v::
  If A_PriorHotkey = <^>!¥      ; punkt dar¸ber 
    BSUnicode("·πñ")
  Else 
    sendinput {blind}P
Return

+b::  
  If A_PriorHotkey = +^         ; caron  
    BSUnicode("≈Ω")
  Else If A_PriorHotkey = ¥     ; akut 
    BSUnicode("≈π")
  Else If A_PriorHotkey = <^>!¥ ; punkt dar¸ber 
    BSUnicode("≈ª")
  Else
    sendinput {blind}Z
Return

+n::
  If A_PriorHotkey = <^>!¥       ; punkt dar¸ber 
    BSUnicode("·∏Ç")
  Else 
    sendinput {blind}B
Return

+m::
  If A_PriorHotkey = <^>!¥       ; punkt dar¸ber 
    BSUnicode("·πÄ")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("·πÇ")
  Else 
    sendinput {blind}M
Return

+,::return
+.::Unicode("‚Ä¶")  ; ellipse

+-::
  If A_PriorHotkey = ^            ; circumflex
    BSUnicode("ƒ¥")
  Else
    sendinput {blind}J
Return


;3. Ebene: Mod3
;(Win+Ctrl)
;----------------

#^^::Unicode("Àò")   ; brevis
#^1::return
#^2::return 
#^3::return 
#^4::send • 
#^5::send £  
#^6::send Ê 
#^7::send ú 
#^8::send Ç
#^9::send ë
#^0::send í
#^ﬂ::Unicode("‚Äî")
#^¥::send ∏ ; cedilla

#^q::send @ 
#^w::send _
#^e::send [
#^r::send ]
#^t::send {^}{space} ; untot
#^z::sendraw !
#^u::
  If A_PriorHotkey = #^+^    ; Querstrich
    BSUnicode("‚â§")
  Else
    send <
return

#^i::
  If A_PriorHotkey = #^+^    ; Querstrich
    BSUnicode("‚â•")
  Else
    send >
return

#^o::
  If A_PriorHotkey = ^            ; circumflex 
    BSUnicode("‚âô")
  Else If A_PriorHotkey = +       ; tilde 
    BSUnicode("‚âÖ")
  Else If A_PriorHotkey = <^>!+   ; Schr‰gstrich 
    BSUnicode("‚â†")
  Else If A_PriorHotkey = #^+^    ; Querstrich
    BSUnicode("‚â°")
  Else If A_PriorHotkey = +^      ; caron 
    BSUnicode("‚âö")
  Else If A_PriorHotkey = <^>!+¥  ; ring dr¸ber 
    BSUnicode("‚âó")
  Else If A_PriorHotkey = +1      ; Grad
    BSUnicode("‚âó")
  Else   
    send `=
Return

#^p::send {&}
#^¸::Unicode("ƒ≥")   ; ij
#^+::Unicode("¬®")   ; Diaerese

#^a::send \
#^s::send `/
#^d::sendraw { 
#^f::sendraw } 
#^g::send *
#^h::send ?
#^j::send (
#^k::send )
#^l::send - ; Bind
#^ˆ::send :
#^‰::return

#^y::send {#}  
#^x::send $
#^c::send |

#^v::
  If A_PriorHotkey = +    ; tilde
    BSUnicode("‚âà")
  Else
    sendraw ~ 
Return

#^b::send ``{space} ; untot
#^n::send {+}
#^m::send `% 
#^,::send '
#^.::send "
#^-::send `;



;4. Ebene: Mod3+Shift
;(Win+Ctrl+Shift)
;---------------------

#^+^::send - ; querstrich, tot
#^+1::send º
#^+2::send Ω
#^+3::send æ
#^+4::send ¢ 
#^+5::send § 
#^+6::send ∆ 
#^+7::send å 
#^+8::send ª 
#^+9::send ´ 
#^+0::send õ 
#^+ﬂ::send ã 
#^+¥::Unicode("Àõ") ; ogonek

#^+q::Unicode("Œæ") ;xi
#^+w::return
#^+e::Unicode("Œª") ;lambda
#^+r::Unicode("œá") ;chi 
#^+t::return
#^+z::Unicode("Œ∫") ;kappa
#^+u::Unicode("œà") ;psi
#^+i::Unicode("Œ≥") ;gamma
#^+o::Unicode("œÜ") ;phi
#^+p::return
#^+¸::Unicode("ƒ≤") ;IJ
#^++::send "        ;doppelakut

#^+a::return
#^+s::Unicode("Œπ") ;iota 
#^+d::Unicode("Œ±") ;alpha
#^+f::Unicode("Œµ") ;epsilon
#^+g::Unicode("œâ") ;omega 
#^+h::Unicode("œÉ") ;sigma
#^+j::Unicode("ŒΩ") ;nu
#^+k::Unicode("œÅ") ;rho
#^+l::Unicode("œÑ") ;tau
#^+ˆ::Unicode("Œ¥") ;delta
#^+‰::Unicode("œÖ") ;upsilon

#^+y::return
#^+x::return
#^+c::Unicode("Œ∑") ;eta
#^+v::Unicode("œÄ") ;pi
#^+b::Unicode("Œ∂") ;zeta
#^+n::Unicode("Œ≤") ;beta
#^+m::Unicode("¬µ") ;micro, mu w‰re Œº
#^+,::Unicode("œë") ;vartheta?
#^+.::Unicode("Œ∏") ;theta
#^+-::return



;5. Ebene: Mod5
;(AltGr)
;-----------------

<^>!^::Unicode("¬∑")  ; Mittenpunkt, tot
<^>!1::Unicode("‚Öõ") ; 1/8 
<^>!2::return
<^>!3::Unicode("‚Öú") ; 3/8
<^>!4::Send {PgUp}    ; Prev
<^>!5::Unicode("‚Öù") ; 5/8
<^>!6::return
<^>!7::Unicode("‚Öû") ; 7/8
<^>!8::Send /
<^>!9::Send *
<^>!0::Send -
<^>!ﬂ::return
<^>!¥::Unicode("Àô") ; punkt oben dr¸ber

<^>!q::return
<^>!w::Send {Backspace}
<^>!e::Send {Up}
<^>!r::Send {Tab}
<^>!t::Send {Insert}
<^>!z::Send °
<^>!u::Send 7
<^>!i::Send 8
<^>!o::Send 9
<^>!p::Send {+}
<^>!¸::Unicode("…ô") ; schwa
<^>!+::Unicode("/")  ; Schr‰gstrich, tot

<^>!a::Send {Home}
<^>!s::Send {Left}
<^>!d::Send {Down}
<^>!f::Send {Right}
<^>!g::Send {End}
<^>!h::Send ø
<^>!j::Send 4
<^>!k::Send 5
<^>!l::Send 6
<^>!ˆ::Send `,
<^>!‰::Send ˛         ; thorn


<^>!y::Send {Esc}
<^>!x::Send {Del}
<^>!c::Send {PgDn}    ; Next
<^>!v::Send {Enter}
<^>!b::return
<^>!n::Unicode("‚àû") ;infty
<^>!m::Send 1
<^>!,::Send 2
<^>!.::Send 3
<^>!-::Send .


;6. Ebene: Mod5+Shift
;(AltGr+Shift)
;-----------------------

<^>!+^::Send .         ; punkt darunter
<^>!+1::return
<^>!+2::return
<^>!+3::return
<^>!+4::Send +{Prev}
<^>!+5::Unicode("‚áí") ; Implikation
<^>!+6::Unicode("‚áî") ; ƒquivalenz
<^>!+7::return
<^>!+8::Unicode("‚àÉ") ; Existenzquantor
<^>!+9::Unicode("‚àÄ") ; Allquantor
<^>!+0::Send ¨
<^>!+ﬂ::Unicode("‚à®") ; logisch oder
<^>!+¥::Unicode("Àö")  ; ring obendrauf

<^>!+q::Unicode("Œû")  ; Xi
<^>!+w::Unicode("Œõ")  ; Lambda
<^>!+e::Send +{Up}
<^>!+r::Send +{Tab} 
<^>!+t::Send +{Insert}
<^>!+z::Send ©
<^>!+u::Unicode("Œ®")  ; Phi
<^>!+i::Unicode("Œì")  ; Gamma
<^>!+o::Unicode("Œ¶")  ; Psi
<^>!+p::Unicode("‚àß") ; logisches Und
<^>!+¸::Unicode("∆è")  ; Schwa
<^>!++::Unicode("Àè")  ; komma drunter, tot 

<^>!+a::Send +{Home}
<^>!+s::Send +{Left}
<^>!+d::Send +{Down}
<^>!+f::Send +{Right}
<^>!+g::Send +{End}
<^>!+h::Unicode("Œ£")  ; Sigma
<^>!+j::Unicode("‚Ññ") ; No
<^>!+k::Unicode("¬Æ")  ; (R)
<^>!+l::Unicode("‚Ñ¢") ; TM
<^>!+ˆ::Unicode("Œî")  ; Delta
<^>!+‰::Send ﬁ         ; Thorn 

<^>!+y::return
<^>!+x::Unicode("‚à´") ; Int
<^>!+c::Send +{PgDn}
<^>!+v::Unicode("Œ†")  ; Pi
<^>!+b::Unicode("Œ©")  ; Omega
<^>!+n::Unicode("‚Ä¢") ; bullet
<^>!+,::Unicode("‚àö") ; sqrt
<^>!+.::Unicode("Œò")  ; Theta 
<^>!+-::Unicode("‚àá") ; Nabla



;Strg/Ctrl
;---------

^1::send ^1
^2::send ^2
^3::send ^3
^4::send ^4
^5::send ^5
^6::send ^6
^7::send ^7
^8::send ^8
^9::send ^9
^0::send ^0
^ﬂ::send ^-

^q::send ^x
^w::send ^v
^e::send ^l
^r::send ^c
^t::send ^w
^z::send ^k
^u::send ^h
^i::send ^g
^o::send ^f
^p::send ^q
^¸::send ^ﬂ
^+::send ^{+} ;z.B. Firefox Schrift grˆﬂer

^a::send ^u
^s::send ^i
^d::send ^a
^f::send ^e
^g::send ^o
^h::send ^s
^j::send ^n
^k::send ^r
^l::send ^t
^ˆ::send ^d
^‰::send ^y


^y::send ^ˆ
^x::send ^¸
^c::send ^‰
^v::send ^p
^b::send ^z
^n::send ^b
^m::send ^m
^-::send ^- ;z.B. Firefox Schrift kleiner


;Alt-Ebene
;---------

<!1::send {altdown}1
<!2::send {altdown}2
<!3::send {altdown}3
<!4::send {altdown}4
<!5::send {altdown}5
<!6::send {altdown}6
<!7::send {altdown}7
<!8::send {altdown}8
<!9::send {altdown}9
<!0::send {altdown}0

<!q::send {altdown}x
<!w::send {altdown}v
<!e::send {altdown}l
<!r::send {altdown}c
<!t::send {altdown}w
<!z::send {altdown}k
<!u::send {altdown}h
<!i::send {altdown}g
<!o::send {altdown}f
<!p::send {altdown}q
<!¸::send {altdown}ﬂ

<!a::send {altdown}u
<!s::send {altdown}i
<!d::send {altdown}a
<!f::send {altdown}e
<!g::send {altdown}o
<!h::send {altdown}s
<!j::send {altdown}n
<!k::send {altdown}r
<!l::send {altdown}t
<!ˆ::send {altdown}d
<!‰::send {altdown}y

<!y::send {altdown}ˆ
<!x::send {altdown}¸
<!c::send {altdown}‰
<!v::send {altdown}p
<!b::send {altdown}z
<!n::send {altdown}b
<!m::send {altdown}m
<!-::send {altdown}j


;Win-Ebene
;---------

#1::sendevent #1
#2::sendevent #2
#3::sendevent #3
#4::sendevent #4
#5::sendevent #5
#6::sendevent #6
#7::sendevent #7
#8::sendevent #8
#9::sendevent #9
#0::sendevent #0
#ﬂ::sendevent #-

#q::sendevent #x
#w::sendevent #v

#e::
  Run,%A_WinDir%\System32\Rundll32.exe User32.dll`,LockWorkStation 
  return
  ;sendevent #l  

#r::sendevent #c
#t::sendevent #w
#z::sendevent #k
#u::sendevent #h
#i::sendevent #g
#o::sendevent #f
#p::sendevent #q
#¸::sendevent #ﬂ

#a::sendevent #u
#s::sendevent #i
#d::sendevent #a
#f::sendevent #e
#g::sendevent #o
#h::sendevent #s
#j::sendevent #n
#k::sendevent #r
#l::sendevent #t

#ˆ:: ;  sendevent #d
  FileAppend,
    (
    [Shell]
    Command=2
    [Taskbar]
    Command=ToggleDesktop
    ), DRT.scf
  Run DRT.scf
  FileDelete, DRT.scf
Return 

#‰::sendevent #y

#y::sendevent #ˆ
#x::sendevent #¸
#c::sendevent #‰
#v::sendevent #p
#b::sendevent #z
#n::sendevent #b
#m::sendevent #m
#-::sendevent #j


;Strg-Shift-Ebene
;-----------------

^+1::send ^+1
^+2::send ^+2
^+3::send ^+3
^+4::send ^+4
^+5::send ^+5
^+6::send ^+6
^+7::send ^+7
^+8::send ^+8
^+9::send ^+9
^+0::send ^+0

^+q::send ^+x
^+w::send ^+v
^+e::send ^+l
^+r::send ^+c
^+t::send ^+w
^+z::send ^+k
^+u::send ^+h
^+i::send ^+g
^+o::send ^+f
^+p::send ^+q
^+¸::send ^+ﬂ

^+a::send ^+u
^+s::send ^+i
^+d::send ^+a
^+f::send ^+e
^+g::send ^+o
^+h::send ^+s
^+j::send ^+n
^+k::send ^+r
^+l::send ^+t
^+ˆ::send ^+d
^+‰::send ^+y


^+y::send ^+ˆ
^+x::send ^+¸
^+c::send ^+‰
^+v::send ^+p
^+b::send ^+z
^+n::send ^+b
^+m::send ^+m
^+-::send ^+j


; -----------------------------------------
; Nummernblock
; -----------------
;
; 1. Ebene
; NumLock On
; --> Zahlenblock
; ------------------
;
; 2. Ebene
; NumLock Off 
; oder NumLock On + Shift
; --> Cursortasten
; -----------------

; 3. Ebene
; NumLock on + Mod3
; --> Pfeile
; -----------------

#^NumpadDiv::send ˜
#^NumpadMult::send ◊
#^NumpadSub::send -
#^NumpadAdd::send ±
#^NumpadEnter::Unicode("‚â†") ; neq

#^Numpad7::return
#^Numpad8::Unicode("‚Üë")     ; uparrow
#^Numpad9::return
#^Numpad4::Unicode("‚Üê")     ; leftarrow
#^Numpad5::send Ü
#^Numpad6::Unicode("‚Üí")     ; rightarrow
#^Numpad1::return
#^Numpad2::Unicode("‚Üì")     ; downarrow
#^Numpad3::return
#^Numpad0::send `%
#^NumPadDot::send .




; ---------------------------
; 4. Ebene
; NumLock off + Mod3 + Shift
; --> Br¸che
; ---------------------------

#^+NumpadDiv::Unicode("‚àï")   ; slash
#^+NumpadMult::Unicode("‚ãÖ")  ; cdot
#^+NumpadSub::return
#^+NumpadAdd::Unicode("‚àì")   ; -+
#^+NumpadEnter::Unicode("‚âà") ; approx

#^+NumpadHome::Unicode("‚â™")  ; ll
#^+NumpadUp::Unicode("‚à©")    ;
#^+NumpadPgUp::Unicode("‚â´")  ; gg
#^+NumpadLeft::Unicode("‚äÇ")  ;
#^+NumpadClear::Unicode("‚àä") ;
#^+NumpadRight::Unicode("‚äÉ") ;
#^+NumpadEnd::Unicode("‚â§")   ; leq
#^+NumpadDown::Unicode("‚à™")  ;
#^+NumpadPgDn::Unicode("‚â•")  ; geq
#^+NumpadIns::send â 
#^+NumPadDel::send `,



; ------------------------------
; 5. Ebene
; NumLock on + Mod5 
; --> Br¸che (genau wie Ebene 4)
; ------------------------------


<^>!NumpadDiv::Unicode("‚àï")   ; slash
<^>!NumpadMult::Unicode("‚ãÖ")  ; cdot
<^>!NumpadSub::return
<^>!NumpadAdd::Unicode("‚àì")   ; -+
<^>!NumpadEnter::Unicode("‚âà") ; approx


<^>!Numpad7::Unicode("‚â™")  ; ll
<^>!Numpad8::Unicode("‚à©")  ;
<^>!Numpad9::Unicode("‚â´")  ; gg
<^>!Numpad4::Unicode("‚äÇ")  ;
<^>!Numpad5::Unicode("‚àä")  ;
<^>!Numpad6::Unicode("‚äÉ")  ;
<^>!Numpad1::Unicode("‚â§")  ; leq
<^>!Numpad2::Unicode("‚à™")  ;
<^>!Numpad3::Unicode("‚â•")  ; geq
<^>!Numpad0::send â 
<^>!NumPadDot::send `,


; ------------------------------------

Unicode(code)
   {
   saved_clipboard := ClipboardAll
   Transform, Clipboard, Unicode, %code%
   send ^v
   Clipboard := saved_clipboard
   }

BSUnicode(code)
   {
   saved_clipboard := ClipboardAll
   Transform, Clipboard, Unicode, %code%
   send {bs}^v
   Clipboard := saved_clipboard
   }

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

EncodeInteger(ref, val)
   {
   DllCall("ntdll\RtlFillMemoryUlong", "Uint", ref, "Uint", 4, "Uint", val)
   } 


; ------------------------------------

togglesuspend:
   if state <>
   {
      state =
      menu, tray, rename, %enable%, %disable%
   }
   else
   {
      state = : Deaktiviert
      menu, tray, rename, %disable%, %enable%
   }

   menu, tray, tip, %name%%state%
   suspend
return


help:
   Run, %A_WinDir%\hh mk:@MSITStore:autohotkey.chm
return


about:
   msgbox, 64, %name%, 
   (
   %name% 
   `nDas NEO-Layout ersetzt das ¸bliche deutsche 
   Tastaturlayout mit der Alternative NEO, 
   beschrieben auf http://www.neo-layout.org/. 
   `nDazu sind keine Administratorrechte nˆtig. 
   `nWenn Autohotkey aktiviert ist, werden alle Tastendrucke 
   abgefangen und statt dessen eine ‹bersetzung weitergeschickt. 
   `nDies geschieht transparent f¸r den Anwender, 
   es muss nichts installiert werden. 
   `nDie Zeichen¸bersetzung kann leicht ¸ber das Icon im 
   Systemtray deaktiviert werden.  `n
   )
return


neo:
   run http://www.neo-layout.org/
return

autohotkey:
   run http://autohotkey.com/
return

open:
   ListLines ; shows the Autohotkey window
return

edit:
   edit
return

reload:
   Reload
return

hide:
   menu, tray, noicon
return

exitprogram:
   exitapp
return