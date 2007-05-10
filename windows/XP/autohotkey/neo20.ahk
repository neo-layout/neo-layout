/*
   NEO-Layout - Version vom 08.05.2007
   Mod3 (3./4. Ebene) funktioniert über Win+Ctrl, 
    Mod5 (5./6. Ebene) über AltGr.
   Zur Umbelegung von Mod3 auf CapsLock und #
    und für einen zweiten Mod5 auf <
    verwende neo20-remap.ahk
*/

;#InstallKeybdHook
#usehook on
#singleinstance force
#LTrim 
  ; Quelltext kann eingerückt werden, 
  ; msgbox ist trotzdem linksbündig

SendMode InputThenPlay	

name    = NEO-Layout 2.0
enable  = Aktiviere %name%
disable = Deaktiviere %name%

; ToDo
; --------
; nobreakspace und schmales Leerzeichen


; ANSI-Darstellung von beliebigen Unicode-Zeichen
; -----------------------------------------------
; (benötigt für MyUTF_String):
;  - die untenstehende Definition auskommentieren
;  - gewünschtes Zeichen in die Zwischenablage befördern
;  - ^!u (Control+Alt+U) drücken
;  - die ANSI-Darstellung aus der Zwischenablage an die 
;    gewünschte Stelle ins Skript einfügen
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


; Überprüfung auf deutsches Tastaturlayout 
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
     `nÄndere die Tastatureinstellung unter 
     `tSystemsteuerung   
     `t-> Regions- und Sprachoptionen   
     `t-> Sprachen 
     `t-> Details...   `n
     )
   exitapp
}


; Menü des Systray-Icons 
; ----------------------

menu, tray, nostandard
menu, tray, add, Öffnen, open
   menu, helpmenu, add, About, about
   menu, helpmenu, add, Autohotkey-Hilfe, help
   menu, helpmenu, add
   menu, helpmenu, add, http://&autohotkey.com/, autohotkey
   menu, helpmenu, add, http://www.neo-layout.org/, neo
menu, tray, add, Hilfe, :helpmenu
menu, tray, add
menu, tray, add, %disable%, toggleneo
menu, tray, default, %disable%
menu, tray, add
menu, tray, add, Edit, edit
menu, tray, add, Reload, reload
menu, tray, add
menu, tray, add, Nicht im Systray anzeigen, hide
menu, tray, add, %name% beenden, exitprogram
menu, tray, tip, %name%



;1. Ebene
;---------

^::send {^} ; circumflex, tot
1::send 1
2::send 2
3::send 3
4::send 4
5::send 5
6::send 6
7::send 7
8::send 8
9::send 9
0::send 0
ß::send - 
´::send {´} ; akut, tot

q::send x

w::
  If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("á¹¿")
  Else 
    send v
Return

e::
  If A_PriorHotkey = <^>!+ ; Schrägstrich
    BSUnicode("Å‚")
  Else If A_PriorHotkey = ´ ; akut 
    BSUnicode("Äº")
  Else If A_PriorHotkey = +^ ; caron 
    BSUnicode("Ä¾")
  Else If A_PriorHotkey = #^´ ; cedilla
    BSUnicode("Ä¼")
  Else If A_PriorHotkey = <^>!^ ; Mittenpunkt
    BSUnicode("Å€")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("á¸·")
  Else 
    send l
Return 

r::
  If A_PriorHotkey = ^ ; circumflex
    BSUnicode("Ä‰")
  Else If A_PriorHotkey = +^ ; caron
    BSUnicode("Ä")
  Else If A_PriorHotkey = ´ ; akut
    BSUnicode("Ä‡")
  Else If A_PriorHotkey = #^´ ; cedilla
    BSUnicode("Ã§")
  Else If A_PriorHotkey = <^>!´ ; punkt darüber 
    BSUnicode("Ä‹")
  Else 
    Send c
Return 

t::
  If A_PriorHotkey = ^ ; circumflex
    BSUnicode("Åµ")
  Else
    send w
Return

z::
  If A_PriorHotkey = #^´ ; cedilla
    BSUnicode("Ä·")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("á¸³")
  Else
    send k
Return

u::
  If A_PriorHotkey = ^           ; circumflex
    BSUnicode("Ä¥")
  Else If A_PriorHotkey = #^+^   ; Querstrich 
    BSUnicode("Ä§")
  Else If A_PriorHotkey = <^>!´  ; punkt darüber 
    BSUnicode("á¸£")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("á¸¥")
  Else send h
Return

i::
  If A_PriorHotkey = ^          ; circumflex
    BSUnicode("Ä")
  Else If A_PriorHotkey = #^^   ; brevis
    BSUnicode("ÄŸ")
  Else If A_PriorHotkey = #^´   ; cedilla
    BSUnicode("Ä£")
  Else If A_PriorHotkey = <^>!´ ; punkt darüber 
    BSUnicode("Ä¡")
  Else send g
Return

o::
  If A_PriorHotkey = <^>!+      ; durchgestrichen
    BSUnicode("Æ’")
  Else If A_PriorHotkey = <^>!´ ; punkt darüber 
    BSUnicode("á¸Ÿ")
  Else send f
Return

p::send q
ü::send ß
+::send ~ ; tilde, soll tot

a::
  If A_PriorHotkey = #^+         ; Diaerese
    Send, {bs}ü
  Else If A_PriorHotkey = #^++   ; doppelakut 
    BSUnicode("Å±")
  Else If A_PriorHotkey = #^^    ; brevis
    BSUnicode("Å­")
  Else If A_PriorHotkey = ++     ; macron
    BSUnicode("Å«")
  Else If A_PriorHotkey = #^+´   ; ogonek
    BSUnicode("Å³")
  Else If A_PriorHotkey = <^>!+´ ; Ring
    BSUnicode("Å¯")
  Else If A_PriorHotkey = +      ; tilde
    BSUnicode("Å©")
  Else
    send u
Return

s::
  If A_PriorHotkey = #^+        ; Diaerese
    Send, {bs}ï
  Else If A_PriorHotkey = ++    ; macron
    BSUnicode("Ä«")
  Else If A_PriorHotkey = #^^   ; brevis
    BSUnicode("Ä­")
  Else If A_PriorHotkey = #^+´  ; ogonek
    BSUnicode("Ä¯")
  Else If A_PriorHotkey = +     ; tilde
    BSUnicode("Ä©")
  Else If A_PriorHotkey = <^>!´ ; (ohne) punkt darüber 
    BSUnicode("Ä±")
  Else 
    Send i
Return

d::
  If A_PriorHotkey = #^+         ; Diaerese
    Send {bs}ä
  Else If A_PriorHotkey = <^>!+´ ; Ring 
    Send {bs}å
  Else If A_PriorHotkey = +      ; tilde
    BSUnicode("Ã£")
  Else If A_PriorHotkey = #^+´   ; ogonek
    BSUnicode("Ä…")
  Else If A_PriorHotkey = ++     ; macron
    BSUnicode("Ä")
  Else If A_PriorHotkey = #^^    ; brevis
    BSUnicode("Äƒ")
  Else 
    Send a
Return 

f::
  If A_PriorHotkey = #^+        ; Diaerese
    Send, {bs}ë
  Else If A_PriorHotkey = #^+´  ; ogonek
    BSUnicode("Ä™")
  Else If A_PriorHotkey = ++    ; macron
    BSUnicode("Ä“")
  Else If A_PriorHotkey = #^^   ; brevis
    BSUnicode("Ä•")
  Else If A_PriorHotkey = +^    ; caron
    BSUnicode("Ä›")
  Else If A_PriorHotkey = <^>!´ ; punkt darüber 
    BSUnicode("Ä—")
  Else 
    Send e
Return 

g::
  If A_PriorHotkey = #^+         ; Diaerese
    Send, {bs}ö
  Else If A_PriorHotkey = +      ; tilde
    BSUnicode("Ãµ")
  Else If A_PriorHotkey = #^++   ; doppelakut
    BSUnicode("Å‘")
  Else If A_PriorHotkey = <^>!+  ; Schrägstrich
    BSUnicode("Ã¸")
  Else If A_PriorHotkey = ++     ; macron
    BSUnicode("Å")
  Else If A_PriorHotkey = #^^    ; brevis 
    BSUnicode("Å")
  Else 
    send o
Return

h::
  If A_PriorHotkey = ^           ; circumflex
    BSUnicode("Å")
  Else If A_PriorHotkey = ´      ; akut 
    BSUnicode("Å›")
  Else If A_PriorHotkey = +^     ; caron
    BSUnicode("Å¡")
  Else If A_PriorHotkey = #^´    ; cedilla
    BSUnicode("ÅŸ")
  Else If A_PriorHotkey = <^>!´  ; punkt darüber 
    BSUnicode("á¹¡")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("á¹£")
  Else   
    send s
Return

j::
  If A_PriorHotkey = ´          ; akut
    BSUnicode("Å„")
  Else If A_PriorHotkey = +     ; tilde
    BSUnicode("Ã±")
  Else If A_PriorHotkey = +^    ; caron
    BSUnicode("Åˆ")
  Else If A_PriorHotkey = #^´   ; cedilla
    BSUnicode("Å†")
  Else If A_PriorHotkey = <^>!´ ; punkt darüber 
    BSUnicode("á¹…")
  Else
    send n
Return

k::
  If A_PriorHotkey = ´           ; akut 
    BSUnicode("Å•")
  Else If A_PriorHotkey = +^     ; caron
    BSUnicode("Å™")
  Else If A_PriorHotkey = #^´    ; cedilla
    BSUnicode("Å—")
  Else If A_PriorHotkey = <^>!´  ; punkt darüber 
    BSUnicode("á¹™")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("á¹›")
  Else 
    send r
Return

l::  
  If A_PriorHotkey = +^          ; caron 
    BSUnicode("Å¥")
  Else If A_PriorHotkey = #^´    ; cedilla
    BSUnicode("Å£")
  Else If A_PriorHotkey = #^+^   ; Querstrich
    BSUnicode("Å§")
  Else If A_PriorHotkey = <^>!´  ; punkt darüber 
    BSUnicode("á¹«")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("á¹­")
  Else 
    send t
Return

ö::
  If A_PriorHotkey = #^+^        ; Querstrich
    BSUnicode("Ä‘")
  Else If A_PriorHotkey = +^     ; caron
    BSUnicode("Ä")
  Else If A_PriorHotkey = <^>!´  ; punkt darüber 
    BSUnicode("á¸‹")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("á¸")
  Else 
    send d
Return

ä::  
  If A_PriorHotkey = #^+       ; Diaerese
    Send {bs}ÿ
  Else If A_PriorHotkey = ^    ; circumflex
    BSUnicode("Å·")
  Else
    send y
Return

;SC02B (#) wird zu AltGr

;SC056 (<) wird zu Mod5
y::send ö
x::send ü
c::send ä
v::
  If A_PriorHotkey = <^>!´      ; punkt darüber 
    BSUnicode("á¹—")
  Else
    send p
Return

b::
  If A_PriorHotkey = +^         ; caron
    BSUnicode("Å¾")
  Else If A_PriorHotkey = ´     ; akut
    BSUnicode("Åº")
  Else If A_PriorHotkey = <^>!´ ; punkt drüber
    BSUnicode("Å¼")
  Else If A_PriorHotkey = <^>!´ ; punkt darüber 
    BSUnicode("Å¼")
  Else 
    Send z
Return 

n::
  If A_PriorHotkey = <^>!´      ; punkt darüber 
    BSUnicode("á¸ƒ")
  Else 
    send b
Return

m::
  If A_PriorHotkey = <^>!´       ; punkt darüber 
    BSUnicode("á¹")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("á¹ƒ")
  Else 
    send m
Return

,::send `,
.::send .

-::
  If A_PriorHotkey = ^           ; circumflex
    BSUnicode("Äµ")
  Else
    send j
Return

Space::
  If A_PriorHotkey = ^           ; circumflex
    BSUnicode("Ë†")
  Else If A_PriorHotkey = +      ; tilde 
    BSUnicode("Ëœ")
  Else
    Send {Space}
Return

Enter::Send {Enter}
Esc::Send {Esc}


;2. Ebene (Shift)
;---------

+^::Unicode("Ë‡")  ; caron, tot
+1::send °
+2::send ¶
+3::send §
+4::send $
+5::send €
+6::send ª
+7::send º
+8::send „
+9::send “
+0::send ”
+ß::Unicode("â€“") ; Ged
+´::send `` 

+q::send X
+w::
  If A_PriorHotkey = <^>!+^      ; punkt darunter
    BSUnicode("á¹¾")
  Else 
    send V
Return

+e::
  If A_PriorHotkey = ´           ; akut 
    BSUnicode("Ä¹")
  Else If A_PriorHotkey = +^     ; caron 
    BSUnicode("Ä½")
  Else If A_PriorHotkey = #^´    ; cedilla
    BSUnicode("Ä»")
  Else If A_PriorHotkey = <^>!+  ; Schrägstrich 
    BSUnicode("Å")
  Else If A_PriorHotkey = <^>!^  ; Mittenpunkt 
    BSUnicode("Ä¿")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("á¸¶")
  Else 
    send L
return

+r::
  If A_PriorHotkey = ^          ; circumflex 
    BSUnicode("Äˆ")
  Else If A_PriorHotkey = +^    ; caron 
    BSUnicode("ÄŒ")
  Else If A_PriorHotkey = ´     ; akut 
    BSUnicode("Ä†")
  Else If A_PriorHotkey = #^´   ; cedilla 
    BSUnicode("Ã‡")
  Else If A_PriorHotkey = <^>!´ ; punkt darüber 
    BSUnicode("ÄŠ")
  Else 
    Send C
Return 

+t::
  If A_PriorHotkey = ^           ; circumflex
    BSUnicode("Å´")
  Else
    send W
Return

+z::  
  If A_PriorHotkey = #^´         ; cedilla 
    BSUnicode("Ä¶")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("á¸²")
  Else
    send K
Return

+u::
  If A_PriorHotkey = ^           ; circumflex
    BSUnicode("Ä¤")
  Else If A_PriorHotkey = #^+^   ; Querstrich
    BSUnicode("Ä¦")
  Else If A_PriorHotkey = <^>!´  ; punkt darüber 
    BSUnicode("á¸¢")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("á¸¤")
  Else send H
Return

+i::
  If A_PriorHotkey = ^          ; circumflex
    BSUnicode("Äœ")
  Else If A_PriorHotkey = #^^   ; brevis 
    BSUnicode("Ä")
  Else If A_PriorHotkey = #^´   ; cedilla 
    BSUnicode("Ä¢")
  Else If A_PriorHotkey = <^>!´ ; punkt darüber 
    BSUnicode("Ä ")
  Else send G
Return

+o::
  If A_PriorHotkey = <^>!+       ; durchgestrichen
    BSUnicode("â‚£")
  Else If A_PriorHotkey = <^>!´  ; punkt darüber 
    BSUnicode("á¸")
  Else send F
Return

+p::send Q
+ü::send ß

++::Unicode("Ë‰")  ; macron, tot 

+a::
  If A_PriorHotkey = #^+         ; Diaerese
    Send, {bs}Ü
  Else If A_PriorHotkey = <^>!+´ ; Ring
    BSUnicode("Å®")
  Else If A_PriorHotkey = #^^    ; brevis
    BSUnicode("Å¬")
  Else If A_PriorHotkey = #^++   ; doppelakut
    BSUnicode("Å°")
  Else If A_PriorHotkey = +^     ; caron 
    BSUnicode("Å®")
  Else If A_PriorHotkey = ++     ; macron
    BSUnicode("Åª")
  Else If A_PriorHotkey = #^^    ; brevis 
    BSUnicode("Å¬")
  Else If A_PriorHotkey = #^+´   ; ogonek
    BSUnicode("Å²")
  Else If A_PriorHotkey = +      ; tilde
    BSUnicode("Å¨")
  Else
    send U
Return

+s::
  If A_PriorHotkey = #^+ ; Diaerese
    Send, {bs}Ï
  Else If A_PriorHotkey = ++ ; macron
    BSUnicode("Äª")
  Else If A_PriorHotkey = #^^ ; brevis 
    BSUnicode("Ä¬")
  Else If A_PriorHotkey = #^+´ ; ogonek
    BSUnicode("Ä®")
  Else If A_PriorHotkey = + ; tilde
    BSUnicode("Ä¨")
  Else If A_PriorHotkey = <^>!´ ; punkt darüber 
    BSUnicode("Ä°")
  Else 
    Send I
Return

+d::
  If A_PriorHotkey = #^+ ; Diaerese
    Send {bs}Ä
  Else If A_PriorHotkey = + ; tilde
    BSUnicode("Ãƒ")
  Else If A_PriorHotkey = <^>!+´ ; Ring 
    Send {bs}Å
  Else If A_PriorHotkey = ++ ; macron
    BSUnicode("Ä€")
  Else If A_PriorHotkey = #^^ ; brevis 
    BSUnicode("Ä‚")
  Else If A_PriorHotkey = #^+´ ; ogonek
    BSUnicode("Ä„")
  Else 
    Send A
Return 

+f::
  If A_PriorHotkey = #^+ ; Diaerese
    Send, {bs}Ë
  Else If A_PriorHotkey = +^ ; caron
    BSUnicode("Äš")
  Else If A_PriorHotkey = ++ ; macron
    BSUnicode("Ä’")
  Else If A_PriorHotkey = #^^ ; brevis 
    BSUnicode("Ä”")
  Else If A_PriorHotkey = #^+´ ; ogonek 
    BSUnicode("Ä˜")
  Else If A_PriorHotkey = <^>!´ ; punkt darüber 
    BSUnicode("Ä–")
  Else 
    Send E
Return 

+g::
  If A_PriorHotkey = <^>!+ ; Schrägstrich
    BSUnicode("Ã˜")
  Else If A_PriorHotkey = + ; tilde
    BSUnicode("Ã•")
  Else If A_PriorHotkey = #^++ ; doppelakut
    BSUnicode("Å")
  Else If A_PriorHotkey = #^+ ; Diaerese
    Send {bs}Ö
  Else If A_PriorHotkey = ++ ; macron 
    BSUnicode("ÅŒ")
  Else If A_PriorHotkey = #^^ ; brevis 
    BSUnicode("Å")
  Else
    send O
Return

+h::
  If A_PriorHotkey = ^ ; circumflex
    BSUnicode("Åœ")
  Else If A_PriorHotkey = +^ ; caron
    BSUnicode("Å ")
  Else If A_PriorHotkey = ´ ; akut 
    BSUnicode("Åš")
  Else If A_PriorHotkey = #^´ ; cedilla 
    BSUnicode("Å")
  Else If A_PriorHotkey = <^>!´ ; punkt darüber 
    BSUnicode("á¹")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("á¹¢")
  Else
    send S
Return

+j::
  If A_PriorHotkey = +^ ; caron
    BSUnicode("Å‡")
  Else If A_PriorHotkey = + ; tilde
    BSUnicode("Ã‘")
  Else If A_PriorHotkey = ´ ; akut 
    BSUnicode("Åƒ")
  Else If A_PriorHotkey = #^´ ; cedilla 
    BSUnicode("Å…")
  Else If A_PriorHotkey = <^>!´ ; punkt darüber 
    BSUnicode("á¹„")
  Else
    send N
Return

+k::
  If A_PriorHotkey = +^ ; caron
    BSUnicode("Å˜")
  Else If A_PriorHotkey = ´ ; akut 
    BSUnicode("Å”")
  Else If A_PriorHotkey = #^´ ; cedilla 
    BSUnicode("Å–")
  Else If A_PriorHotkey = <^>!´ ; punkt darüber 
    BSUnicode("á¹˜")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("á¹š")
  Else 
    send R
Return

+l::
  If A_PriorHotkey = +^ ; caron
    BSUnicode("Å¤")
  Else If A_PriorHotkey = #^´ ; cedilla 
    BSUnicode("Å¢")
  Else If A_PriorHotkey = #^+^ ; Querstrich
    BSUnicode("Å¦")
  Else If A_PriorHotkey = <^>!´ ; punkt darüber 
    BSUnicode("á¹ª")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("á¹¬")
  Else 
    send T
Return


+ö::
  If A_PriorHotkey = #^+^ ; Querstrich
    BSUnicode("Ä")
  Else If A_PriorHotkey = +^ ; caron 
    BSUnicode("Ä")
  Else If A_PriorHotkey = <^>!´ ; punkt darüber 
    BSUnicode("á¸Š")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("á¸Œ")
  Else send D
Return

+ä::  
  If A_PriorHotkey = #^+ ; Diaerese
    Send {bs}Ÿ
  Else If A_PriorHotkey = ^ ; circumflex
    BSUnicode("Å¶")
  Else
    send Y
Return

+y::send Ö
+x::send Ü
+c::send Ä

+v::
  If A_PriorHotkey = <^>!´ ; punkt darüber 
    BSUnicode("á¹–")
  Else 
    send P
Return

+b::  
  If A_PriorHotkey = +^ ; caron  
    BSUnicode("Å½")
  Else If A_PriorHotkey = ´ ; akut 
    BSUnicode("Å¹")
  Else If A_PriorHotkey = <^>!´ ; punkt darüber 
    BSUnicode("Å»")
  Else
    send Z
Return

+n::
  If A_PriorHotkey = <^>!´ ; punkt darüber 
    BSUnicode("á¸‚")
  Else 
    send B
Return

+m::
  If A_PriorHotkey = <^>!´ ; punkt darüber 
    BSUnicode("á¹€")
  Else If A_PriorHotkey = <^>!+^ ; punkt darunter 
    BSUnicode("á¹‚")
  Else 
    send M
Return

+,::send `;
+.::send :

+-::
  If A_PriorHotkey = ^ ; circumflex
    BSUnicode("Ä´")
  Else
    send J
Return


;3. Ebene: Mod3
;(Win+Ctrl)
;----------------

#^^::Unicode("Ë˜") ; brevis, soll tot
#^1::Unicode("Â¬")
#^2::send {^}{space} 
#^3::send 3 
#^4::send ¥ 
#^5::send £  
#^6::send æ 
#^7::send œ 
#^8::send ‚
#^9::send ‘
#^0::send ’
#^ß::Unicode("â€”")
#^´::send ¸ ; cedilla, soll tot

#^q::send @ 
#^w::send _
#^e::send [
#^r::send ]
#^t::send {^}{space} ; untot
#^z::sendraw !
#^u::send <
#^i::send >
#^o::send `=
#^p::send `;
#^ü::Unicode("Ä³")  ;ij
#^+::Unicode("Â¨") ; Diaerese, soll tot

#^a::send \
#^s::send `/
#^d::sendraw { 
#^f::sendraw } 
#^g::send *
#^h::send ?
#^j::send (
#^k::send )
#^l::send -
#^ö::send :
#^ä::send y

#^y::sendraw ~ 
#^x::send $
#^c::send |
#^v::send {#}
#^b::send ``{space} ; untot
#^n::send {+}
#^m::send `% 
#^,::send {&}
#^.::send "
#^-::send '



;4. Ebene: Mod3+Shift
;(Win+Ctrl+Shift)
;---------------------

#^+^::send - 
#^+1::send ¹ 
#^+2::send ²
#^+3::send ³
#^+4::send ¢ 
#^+5::send ¤ 
#^+6::send Æ 
#^+7::send Œ 
#^+8::send » 
#^+9::send « 
#^+0::send › 
#^+ß::send ‹ 
#^+´::Unicode("Ë›") ; ogonek, soll tot

#^+q::Unicode("Î¾")  ;xi
#^+w::send v
#^+e::Unicode("Î»")  ;lambda
#^+r::Unicode("Ï‡")  ;chi 
#^+t::send w
#^+z::Unicode("Îº") ;kappa
#^+u::Unicode("Ïˆ") ;psi
#^+i::Unicode("Î³") ;gamma
#^+o::Unicode("Ï†") ;phi
#^+p::send q
#^+ü::Unicode("Ä²") ;IJ
#^++::send " ;doppelakut, soll tot

#^+a::send u
#^+s::Unicode("Î¹") ;iota
#^+d::Unicode("Î±") ;alpha
#^+f::Unicode("Îµ") ;epsilon
#^+g::Unicode("Ï‰") ;omega
#^+h::Unicode("Ïƒ") ;sigma
#^+j::Unicode("Î½") ;nu
#^+k::Unicode("Ï") ;rho
#^+l::Unicode("Ï„") ;tau
#^+ö::Unicode("Î´") ;delta
#^+ä::Unicode("Ï…") ;upsilon

#^+y::send ö
#^+x::send ü
#^+c::Unicode("Î·") ;eta
#^+v::Unicode("Ï€") ;pi
#^+b::Unicode("Î¶") ;zeta
#^+n::Unicode("Î²") ;beta
#^+m::Unicode("Î¼") ;mu
#^+,::Unicode("Ï‘") ;vartheta?
#^+.::Unicode("Î¸") ;theta
#^+-::send j

;#^+space::    ; geschütztes Leerzeichen




;5. Ebene: Mod5
;(AltGr)
;-----------------

<^>!^::Unicode("Â·") ; Mittenpunkt, tot mit l und L
<^>!4::Send {PgUp} ;Prev
<^>!8::Send /
<^>!9::Send *
<^>!0::Send -
<^>!ß::Unicode("Ã°") ; eth
<^>!´::Unicode("Ë™") ; punkt oben drüber, soll tot

<^>!q::Send {Esc}
<^>!w::Send {Backspace}
<^>!e::Send {Up}
<^>!t::Send {Insert}
<^>!z::Send ¡
<^>!u::Send 7
<^>!i::Send 8
<^>!o::Send 9
<^>!p::Send {+}
<^>!ü::Unicode("É™") ; ?
<^>!+::Unicode("/") ; Schrägstrich, soll tot 

<^>!a::Send {Home}
<^>!s::Send {Left}
<^>!d::Send {Down}
<^>!f::Send {Right}
<^>!g::Send {End}
<^>!h::Send ¿
<^>!j::Send 4
<^>!k::Send 5
<^>!l::Send 6
<^>!ö::Send `,
<^>!ä::Send ş ; thorn


<^>!y::Send {Tab}
<^>!x::Send {Del}
<^>!c::Send {PgDn} ;Next
<^>!n::Send ±
<^>!m::Send 1
<^>!,::Send 2
<^>!.::Send 3
<^>!-::Send .

<^>!Space::Send 0
;<^>!SC138::Send {NumpadDot} 
  ; geht nicht, weil sonst AltGr nur noch , macht



;6. Ebene: Mod5+Shift
;(AltGr+Shift)
;-----------------------

<^>!+^::Send . ; punkt darunter
<^>!+4::Send +{Prev}
<^>!+ß::Unicode("Ã") ; Eth
<^>!+´::Unicode("Ëš") ; ring obendrauf

<^>!+q::Unicode("Î") ; Xi
<^>!+w::Unicode("Î›") ; Lambda
<^>!+e::Send +{Up}
<^>!+r::Send © 
<^>!+t::Send +{Insert}
<^>!+u::Unicode("Î¨") ; Phi
<^>!+i::Unicode("Î“") ; Gamma
<^>!+o::Unicode("Î¦") ; Psi
<^>!+ü::Unicode("Æ") ; ?
<^>!++::Unicode("Ë") ; komma drunter, soll tot 

<^>!+a::Send +{Home}
<^>!+s::Send +{Left}
<^>!+d::Send +{Down}
<^>!+f::Send +{Right}
<^>!+g::Send +{End}
<^>!+h::Unicode("Î£")  ; Sigma
<^>!+j::Unicode("â„–") ; No
<^>!+k::Unicode("Â®")  ; (R)
<^>!+l::Unicode("â„¢") ; TM
<^>!+ö::Unicode("Î”")  ; Delta
<^>!+ä::Send Ş         ; Thorn 

<^>!+y::Send +{Tab}
<^>!+c::Send +{PgDn}
<^>!+v::Unicode("Î ") ; Pi
<^>!+b::Unicode("Î©") ; Omega
<^>!+.::Unicode("Î˜") ; Theta 



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
^ü::send ^ß

^a::send ^u
^s::send ^i
^d::send ^a
^f::send ^e
^g::send ^o
^h::send ^s
^j::send ^n
^k::send ^r
^l::send ^t
^ö::send ^d
^ä::send ^y


^y::send ^ö
^x::send ^ü
^c::send ^ä
^v::send ^p
^b::send ^z
^n::send ^b
^m::send ^m
^-::send ^j


;Alt-Ebene
;---------

<!1::send !1
<!2::send !2
<!3::send !3
<!4::send !4
<!5::send !5
<!6::send !6
<!7::send !7
<!8::send !8
<!9::send !9
<!0::send !0

<!q::send !x
<!w::send !v
<!e::send !l
<!r::send !c
<!t::send !w
<!z::send !k
<!u::send !h
<!i::send !g
<!o::send !f
<!p::send !q
<!ü::send !ß

<!a::send !u
<!s::send !i
<!d::send !a
<!f::send !e
<!g::send !o
<!h::send !s
<!j::send !n
<!k::send !r
<!l::send !t
<!ö::send !d
<!ä::send !y

<!y::send !ö
<!x::send !ü
<!c::send !ä
<!v::send !p
<!b::send !z
<!n::send !b
<!m::send !m
<!-::send !j


;Win-Ebene
;---------

#1::send #1
#2::send #2
#3::send #3
#4::send #4
#5::send #5
#6::send #6
#7::send #7
#8::send #8
#9::send #9
#0::send #0
#ß::send #-

#q::send #x
#w::send #v

#e::  
  Run,%A_WinDir%\System32\Rundll32.exe User32.dll`,LockWorkStation 
  return
   ; #e::send #l  funktioniert nicht, Computer wird nicht gesperrt
   ; http://www.autohotkey.com/forum/viewtopic.php?p=66937#66937

#r::send #c
#t::send #w
#z::send #k
#u::send #h
#i::send #g
#o::send #f
#p::send #q
#ü::send #ß

#a::send #u
#s::send #i
#d::send #a
#f::send #e
#g::send #o
#h::send #s
#j::send #n
#k::send #r
#l::send #t
#ö::send #d
#ä::send #y

#y::send #ö
#x::send #ü
#c::send #ä
#v::send #p
#b::send #z
#n::send #b
#m::send #m
#-::send #j

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
^+ü::send ^+ß

^+a::send ^+u
^+s::send ^+i
^+d::send ^+a
^+f::send ^+e
^+g::send ^+o
^+h::send ^+s
^+j::send ^+n
^+k::send ^+r
^+l::send ^+t
^+ö::send ^+d
^+ä::send ^+y


^+y::send ^+ö
^+x::send ^+ü
^+c::send ^+ä
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

#^NumpadDiv::send ÷
#^NumpadMult::send ×
#^NumpadSub::send -
#^NumpadAdd::send ±
#^NumpadEnter::Unicode("â‰") ; neq

#^Numpad7::Unicode("â…")   ; 7/8
#^Numpad8::Unicode("â†‘")   ; uparrow
#^Numpad9::Unicode("â…œ")   ; 3/8
#^Numpad4::Unicode("â†?")   ; leftarrow
#^Numpad5::send †
#^Numpad6::Unicode("â†’")   ; rightarrow
#^Numpad1::send ¹ 
#^Numpad2::Unicode("â†“")   ; downarrow
#^Numpad3::send ³
#^Numpad0::send `%
#^NumPadDot::send .




; ---------------------------
; 4. Ebene
; NumLock off + Mod3 + Shift
; --> Brüche
; ---------------------------

#^+NumpadDiv::Unicode("âˆ•")   ; slash
#^+NumpadMult::Unicode("â‹…")  ; cdot
#^+NumpadSub::send -           ; eig. unbelegt
#^+NumpadAdd::Unicode("âˆ“")   ; -+
#^+NumpadEnter::Unicode("â‰ˆ") ; approx

#^+NumpadHome::Unicode("â…›")  ; 1/8
#^+NumpadUp::Unicode("â…?")    ; 5/8
#^+NumpadPgUp::Unicode("â…œ")  ; 3/8
#^+NumpadLeft::send ¼
#^+NumpadClear::send ½
#^+NumpadRight::send ¾
#^+NumpadEnd::send ¹ 
#^+NumpadDown::send ² 
#^+NumpadPgDn::send ³ 
#^+NumpadIns::send ‰ 
#^+NumPadDel::send `,
  


; ------------------------------
; 5. Ebene
; NumLock on + Mod5 
; --> Brüche (genau wie Ebene 4)
; ------------------------------


<^>!NumpadDiv::send / 
<^>!NumpadMult::Unicode("â‹…")   ; cdot
<^>!NumpadSub::send -            ; eig. unbelegt
<^>!NumpadAdd::Unicode("âˆ“")    ; -+
<^>!NumpadEnter::Unicode("â‰ˆ")  ; approx


<^>!Numpad7::Unicode("â…›")  ; 1/8
<^>!Numpad8::Unicode("â…?")  ; 5/8
<^>!Numpad9::Unicode("â…œ")  ; 3/8
<^>!Numpad4::send ¼
<^>!Numpad5::send ½
<^>!Numpad6::send ¾
<^>!Numpad1::send ¹ 
<^>!Numpad2::send ² 
<^>!Numpad3::send ³ 
<^>!Numpad0::send ‰ 
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


toggleneo:
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
   `nDas NEO-Layout ersetzt das übliche deutsche 
   Tastaturlayout mit der Alternative NEO, 
   beschrieben auf http://www.neo-layout.org/. 
   `nDazu sind keine Administratorrechte nötig. 
   `nWenn Autohotkey aktiviert ist, werden alle Tastendrucke 
   abgefangen und statt dessen eine Übersetzung weitergeschickt. 
   `nDies geschieht transparent für den Anwender, 
   es muss nichts installiert werden. 
   `nDie Zeichenübersetzung kann leicht über das Icon im 
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