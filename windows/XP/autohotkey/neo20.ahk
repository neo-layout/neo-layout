/*
   NEO-Layout
    Version vom 30.04.2007
   3./4. Ebene funktioniert ¸ber AltGr, 
    5./6. Ebene ¸ber Win+Ctrl
   Zur Umbelegung auf CapsLock und AltGr 
    verwende neo20-remap.ahk
*/

;#InstallKeybdHook
#usehook on
#singleinstance force
#LTrim 
  ; Quelltext kann einger¸ckt werden, 
  ; msgbox ist trotzdem linksb¸ndig

SendMode InputThenPlay	

name    = NEO-Layout 2.0
enable  = Aktiviere %name%
disable = Deaktiviere %name%


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
     `nƒndere die Tastatureinstellung unter 
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
ﬂ::send - 
¥::send {¥} ; akut, tot

q::send x
w::send v

e::
  If A_PriorHotkey = #^+ ; durchgestrichen
    {
    Send {bs}
    MyUTF_String = ≈Ç
    Gosub Unicode
    }
  Else send l
Return 

r::
  If A_PriorHotkey = ^ ; circumflex
    {
    Send {bs}
    MyUTF_String = ƒâ
    Gosub Unicode
    }
  Else If A_PriorHotkey = +^ ; caron
    {
    Send {bs}
    MyUTF_String = ƒç
    Gosub Unicode
    }
  Else If A_PriorHotkey = ¥ ; akut
    {
    Send {bs}
    MyUTF_String = ƒá
    Gosub Unicode
    }
  Else If A_PriorHotkey = <^>!¥ ; cedilla
    {
    Send {bs}
    MyUTF_String = √ß
    Gosub Unicode
    }
  Else 
    Send c
Return 

t::send w
z::send k
u::
  If A_PriorHotkey = ^ ; circumflex
    {
    Send {bs}
    MyUTF_String = ƒ•
    Gosub Unicode
    }
  Else send h
Return

i::
  If A_PriorHotkey = ^ ; circumflex
    {
    Send {bs}
    MyUTF_String = ƒù
    Gosub Unicode
    }
  Else send g
Return

o::
  If A_PriorHotkey = #^+ ; durchgestrichen
    {
    Send {bs}
    MyUTF_String = ∆í
    Gosub Unicode
    }
  Else send f
Return

p::send q
¸::send ﬂ
+::send ~ ; tilde, soll tot

a::
  If A_PriorHotkey = <^>!+ ; Diaerese
    Send, {bs}¸
  Else If A_PriorHotkey = <^>!++ ; doppelakut
    {
    Send {bs}
    MyUTF_String = ≈±
    Gosub Unicode
    }
;  Else If A_PriorHotkey = +^ ; caron
;    {
;    Send {bs}
;    MyUTF_String = 
;    Gosub Unicode
;    }
  Else If A_PriorHotkey = <^>!^ ; brevis
    {
    Send {bs}
    MyUTF_String = ≈≠ 
    Gosub Unicode
    }
  Else If A_PriorHotkey = ++ ; macron
    {
    Send {bs}
    MyUTF_String = ≈´
    Gosub Unicode
    }
  Else
    send u
Return

s::
  If A_PriorHotkey = <^>!+ ; Diaerese
    Send, {bs}Ô
  Else If A_PriorHotkey = ++ ; macron
    {
    Send {bs}
    MyUTF_String = ƒ´
    Gosub Unicode
    }
  Else 
    Send i
Return

d::
  If A_PriorHotkey = <^>!+ ; Diaerese
    Send {bs}‰
  Else If A_PriorHotkey = #^+¥ ; Ring drauf
    Send {bs}Â
  Else If A_PriorHotkey = + ; tilde
    {
    Send {bs}
    MyUTF_String = √£
    Gosub Unicode
    }
  Else If A_PriorHotkey = <^>!+¥ ; ogonek
    {
    Send {bs}
    MyUTF_String = ƒÖ
    Gosub Unicode
    }
  Else If A_PriorHotkey = ++ ; macron
    {
    Send {bs}
    MyUTF_String = ƒÅ
    Gosub Unicode
    }
  Else 
    Send a
Return 

f::
  If A_PriorHotkey = <^>!+ ; Diaerese
    Send, {bs}Î
  Else If A_PriorHotkey = <^>!+¥ ; ogonek
    {
    Send {bs}
    MyUTF_String = ƒô
    Gosub Unicode
    }
  Else If A_PriorHotkey = ++ ; macron
    {
    Send {bs}
    MyUTF_String = ƒì
    Gosub Unicode
    }
  Else 
    Send e
Return 

g::
  If A_PriorHotkey = <^>!+ ; Diaerese
    Send, {bs}ˆ
  Else If A_PriorHotkey = + ; tilde
    {
    Send {bs}
    MyUTF_String = √µ
    Gosub Unicode
    }
  Else If A_PriorHotkey = <^>!++ ; doppel akut
    {
    Send {bs}
    MyUTF_String = ≈ë
    Gosub Unicode
    }
  Else If A_PriorHotkey = #^+ ; durchgestrichen
    {
    Send {bs}
    MyUTF_String = √∏
    Gosub Unicode
    }
  Else If A_PriorHotkey = ++ ; macron
    {
    Send {bs}
    MyUTF_String = ≈ç
    Gosub Unicode
    }
  Else 
    send o
Return

h::
  If A_PriorHotkey = ^ ; circumflex
    {
    Send {bs}
    MyUTF_String = ≈ù
    Gosub Unicode
    }
  Else If A_PriorHotkey = ¥ ; akut
    {
    Send {bs}
    MyUTF_String = ≈õ
    Gosub Unicode
    }
  Else If A_PriorHotkey = +^ ; caron
    {
    Send {bs}
    MyUTF_String = ≈°
    Gosub Unicode
    }
  Else   
    send s
Return

j::
  If A_PriorHotkey = ¥ ; akut
    {
    Send {bs}
    MyUTF_String = ≈Ñ
    Gosub Unicode
    }
  Else If A_PriorHotkey = + ; tilde
    {
    Send {bs}
    MyUTF_String = √±
    Gosub Unicode
    }
  Else
    send n
Return

k::send r
l::send t

ˆ::
  If A_PriorHotkey = #^+ ; durchgestrichen
    {
    Send {bs}
    MyUTF_String = √∞
    Gosub Unicode
    }
  Else 
    send d
Return

‰::  
  If A_PriorHotkey = <^>!+ ; Diaerese
    Send {bs}ˇ
  Else
    send Y
Return

;SC02B (#) wird zu AltGr

;SC056 (<) wird zu Mod5
y::send ˆ
x::send ¸
c::send ‰
v::send p

b::
  If A_PriorHotkey = +^ ; caron
    {
    Send {bs}
    MyUTF_String = ≈æ
    Gosub Unicode
    }
  Else If A_PriorHotkey = ¥ ; akut
    {
    Send {bs}
    MyUTF_String = ≈∫
    Gosub Unicode
    }
  Else If A_PriorHotkey = #^¥ ; punkt dr¸ber
    {
    Send {bs}
    MyUTF_String = ≈º
    Gosub Unicode
    }
  Else 
    Send z
Return 

n::send b
m::send m
,::send `,
.::send .

-::
  If A_PriorHotkey = ^ ; circumflex
    {
    Send {bs}
    MyUTF_String = ƒµ
    Gosub Unicode
    }
  Else
    send j
Return



;2. Ebene (Shift)
;---------

+^::  ; caron, soll tot
   MyUTF_String = Àá
   Gosub Unicode
   return

+1::send ∞
+2::send 2 
+3::send ß
+4::send $
+5::send Ä
+6::send ™
+7::send ∫
+8::send Ñ
+9::send ì
+0::send î

+ﬂ::    ; Ged
MyUTF_String = ‚Äì
Gosub Unicode
return

+¥::send `` ; gravis, tot

+q::send X
+w::send V
+e::send L

+r::
  If A_PriorHotkey = ^ ; circumflex
    {
    Send {bs}
    MyUTF_String = ƒà
    Gosub Unicode
    }
  Else If A_PriorHotkey = +^ ; caron
    {
    Send {bs}
    MyUTF_String = ƒå
    Gosub Unicode
    }
  Else If A_PriorHotkey = ¥ ; akut
    {
    Send {bs}
    MyUTF_String = ƒÜ
    Gosub Unicode
    }
  Else If A_PriorHotkey = <^>!¥ ; cedille
    {
    Send {bs}
    MyUTF_String = √á
    Gosub Unicode
    }
  Else 
    Send C
Return 

+t::send W
+z::send K
+u::
  If A_PriorHotkey = ^ ; circumflex
    {
    Send {bs}
    MyUTF_String = ƒ§
    Gosub Unicode
    }
  Else send H
Return

+i::
  If A_PriorHotkey = ^ ; circumflex
    {
    Send {bs}
    MyUTF_String = ƒú
    Gosub Unicode
    }
  Else send G
Return

+o::
  If A_PriorHotkey = #^+ ; durchgestrichen
    {
    Send {bs}
    MyUTF_String = ‚Ç£
    Gosub Unicode
    }
  Else send F
Return

+p::send Q
+¸::send ﬂ

++::  ; macron, soll tot 
MyUTF_String = Àâ 
Gosub Unicode
return

+a::
  If A_PriorHotkey = <^>!+ ; Diaerese
    Send, {bs}‹
;  Else If A_PriorHotkey = #^+¥ ; ring dr¸ber
;    {
;    Send {bs}
;    MyUTF_String = ≈Æ
;    Gosub Unicode
;    }
  Else If A_PriorHotkey = <^>!^ ; brevis
    {
    Send {bs}
    MyUTF_String = ≈¨ 
    Gosub Unicode
    }
  Else If A_PriorHotkey = +^ ; caron
    {
    Send {bs}
    MyUTF_String = ≈Æ
    Gosub Unicode
    }
  Else If A_PriorHotkey = ++ ; macron
    {
    Send {bs}
    MyUTF_String = ≈™
    Gosub Unicode
    }
  Else
    send U
Return

+s::
  If A_PriorHotkey = <^>!+ ; Diaerese
    Send, {bs}œ
  Else If A_PriorHotkey = ++ ; macron
    {
    Send {bs}
    MyUTF_String = ƒ™
    Gosub Unicode
    }
  Else 
    Send I
Return

+d::
  If A_PriorHotkey = <^>!+ ; Diaerese
    Send {bs}ƒ
  Else If A_PriorHotkey = + ; tilde
    {
    Send {bs}
    MyUTF_String = √É
    Gosub Unicode
    }
  Else If A_PriorHotkey = #^+¥ ; Ring drauf
    Send {bs}≈
  Else If A_PriorHotkey = ++ ; macron
    {
    Send {bs}
    MyUTF_String = ƒÄ
    Gosub Unicode
    }
  Else 
    Send A
Return 

+f::
  If A_PriorHotkey = <^>!+ ; Diaerese
    Send, {bs}À
  Else If A_PriorHotkey = +^ ; caron
    {
    Send {bs}
    MyUTF_String = ƒö
    Gosub Unicode
    }
  Else If A_PriorHotkey = ++ ; macron
    {
    Send {bs}
    MyUTF_String = ƒí
    Gosub Unicode
    }
  Else 
    Send E
Return 

+g::
  If A_PriorHotkey = #^+ ; durchgestrichen
    {
    Send {bs}
    MyUTF_String = √ò
    Gosub Unicode
    }
  Else If A_PriorHotkey = + ; tilde
    {
    Send {bs}
    MyUTF_String = √ï
    Gosub Unicode
    }
  Else If A_PriorHotkey = <^>!+ ; Diaerese
    Send {bs}÷
  Else If A_PriorHotkey = ++ ; macron
    {
    Send {bs}
    MyUTF_String = ≈å
    Gosub Unicode
    }
  Else
    send O
Return

+h::
  If A_PriorHotkey = ^ ; circumflex
    {
    Send {bs}
    MyUTF_String = ≈ú
    Gosub Unicode
    }
  Else If A_PriorHotkey = +^ ; caron
    {
    Send {bs}
    MyUTF_String = ≈†
    Gosub Unicode
    }
  Else
    send S
Return

+j::
  If A_PriorHotkey = +^ ; caron
    {
    Send {bs}
    MyUTF_String = ≈á
    Gosub Unicode
    }
  Else If A_PriorHotkey = + ; tilde
    {
    Send {bs}
    MyUTF_String = √ë
    Gosub Unicode
    }
  Else
    send N
Return

+k::
  If A_PriorHotkey = +^ ; caron
    {
    Send {bs}
    MyUTF_String = ≈ò
    Gosub Unicode
    }
  Else 
    send R
Return

+l::
  If A_PriorHotkey = +^ ; caron
    {
    Send {bs}
    MyUTF_String = ≈§
    Gosub Unicode
    }
  Else 
    send T
Return


+ˆ::
  If A_PriorHotkey = #^+ ; durchgestrichen
    {
    Send {bs}
    MyUTF_String = ƒê
    Gosub Unicode
    }
  Else If A_PriorHotkey = +^ ; caron
    {
    Send {bs}
    MyUTF_String = ƒé
    Gosub Unicode
    }
  Else send D
Return

+‰::  
  If A_PriorHotkey = <^>!+ ; Diaerese
    Send {bs}ü
  Else
    send Y
Return

+y::send ÷
+x::send ‹
+c::send ƒ
+v::send P

+b::  
  If A_PriorHotkey = +^ ; caron  
    {
    Send {bs}
    MyUTF_String = ≈Ω
    Gosub Unicode
    }
  Else
    send Z
Return

+n::send B
+m::send M
+,::send `;
+.::send :

+-::
  If A_PriorHotkey = ^ ; circumflex
    {
    Send {bs}
    MyUTF_String = ƒ¥
    Gosub Unicode
    }
  Else
    send J
Return

;3. Ebene (AltGr)
;---------

<^>!^:: ; brevis, soll tot
MyUTF_String = Àò
Gosub Unicode
return

<^>!1:: 
MyUTF_String = ¬¨ 
Gosub Unicode
return

<^>!2::send {^} 
<^>!3::send 3 
<^>!4::send • 
<^>!5::send £  
<^>!6::send Ê 
<^>!7::send ú 
<^>!8::send Ç
<^>!9::send ë
<^>!0::send í

<^>!ﬂ::
MyUTF_String = ‚Äî 
Gosub Unicode
return

<^>!¥::send ∏ ; cedillia, soll tot

<^>!q::send @ 
<^>!w::send _
<^>!e::send [
<^>!r::send ]
<^>!t::send {^}{space} ; untot
<^>!z::sendraw !
<^>!u::send <
<^>!i::send >
<^>!o::send `=
<^>!p::send `;

<^>!¸::  ;ij
MyUTF_String = ƒ≥
Gosub Unicode
return

<^>!+:: ; Diaerese, soll tot
MyUTF_String = ¬®
Gosub Unicode
return


<^>!a::send \
<^>!s::send `/
<^>!d::sendraw { 
<^>!f::sendraw } 
<^>!g::send *
<^>!h::send ?
<^>!j::send (
<^>!k::send )
<^>!l::send -
<^>!ˆ::send :
<^>!‰::send y


<^>!y::sendraw ~ 
<^>!x::send $
<^>!c::send |
<^>!v::send {#}
<^>!b::send ``{space} ; untot
<^>!n::send {+}
<^>!m::send `% 
<^>!,::send {&}
<^>!.::send "
<^>!-::send '



;4. Ebene (AltGr+Shift)
;---------

<^>!+^::send ∂ 
<^>!+1::send π 
<^>!+2::send ≤
<^>!+3::send ≥
<^>!+4::send ¢ 
<^>!+5::send § 
<^>!+6::send ∆ 
<^>!+7::send å 
<^>!+8::send ª 
<^>!+9::send ´ 
<^>!+0::send õ 
<^>!+ﬂ::send ã 

<^>!+¥:: ; ogonek, soll tot
MyUTF_String = Àõ
Gosub Unicode
return


<^>!+q::  ;xi
MyUTF_String = Œæ 
Gosub Unicode
return

<^>!+w::send v

<^>!+e::  ;lambda
MyUTF_String = Œª 
Gosub Unicode
return

<^>!+r::  ;chi 
MyUTF_String = œá
Gosub Unicode
return

<^>!+t::send w

<^>!+z:: ;kappa
MyUTF_String = Œ∫
Gosub Unicode
return

<^>!+u:: ;psi
MyUTF_String = œà
Gosub Unicode
return

<^>!+i:: ;gamma
MyUTF_String = Œ≥
Gosub Unicode
return

<^>!+o:: ;phi
MyUTF_String = œÜ
Gosub Unicode
return

<^>!+p::send q

<^>!+¸:: ;IJ
MyUTF_String = ƒ≤
Gosub Unicode
return

<^>!++::send " ;doppelakut, soll tot

<^>!+a::send u

<^>!+s:: ;iota
MyUTF_String = Œπ
Gosub Unicode
return

<^>!+d:: ;alpha
MyUTF_String = Œ±
Gosub Unicode
return

<^>!+f:: ;epsilon
MyUTF_String = Œµ
Gosub Unicode
return

<^>!+g:: ;omega
MyUTF_String = œâ
Gosub Unicode
return

<^>!+h:: ;sigma
MyUTF_String = œÉ
Gosub Unicode
return

<^>!+j:: ;nu
MyUTF_String = ŒΩ
Gosub Unicode
return

<^>!+k:: ;rho
MyUTF_String = œÅ
Gosub Unicode
return

<^>!+l:: ;tau
MyUTF_String = œÑ
Gosub Unicode
return

<^>!+ˆ:: ;delta
MyUTF_String = Œ¥
Gosub Unicode
return

<^>!+‰:: ;upsilon
MyUTF_String = œÖ
Gosub Unicode
return



<^>!+y::send ˆ
<^>!+x::send ¸

<^>!+c:: ;eta
MyUTF_String = Œ∑
Gosub Unicode
return

<^>!+v:: ;pi
MyUTF_String = œÄ
Gosub Unicode
return

<^>!+b:: ;zeta
MyUTF_String = Œ∂
Gosub Unicode
return

<^>!+n:: ;beta
MyUTF_String = Œ≤
Gosub Unicode
return

<^>!+m:: ;mu
MyUTF_String = Œº
Gosub Unicode
return

<^>!+,:: ;vartheta?
MyUTF_String = 
Gosub Unicode
return

<^>!+.:: ;theta
MyUTF_String = Œ∏
Gosub Unicode
return

<^>!+-::send j



;5. Ebene (Win + Ctrl)
;---------

#^4::Send {PgUp} ;Prev
#^8::Send /
#^9::Send *
#^0::Send -

#^¥:: ; punkt oben dr¸ber, soll tot
MyUTF_String = Àô
Gosub Unicode
return


#^q::Send {Esc}
#^w::Send {Backspace}
#^e::Send {Up}
#^t::Send {Insert}
#^z::Send °
#^u::Send 7
#^i::Send 8
#^o::Send 9
#^p::Send {+}

#^¸:: 
MyUTF_String = …ô
Gosub Unicode
return

#^+:: ; durchgestrichen, soll tot
MyUTF_String = /
Gosub Unicode
return

#^a::Send {Home}
#^s::Send {Left}
#^d::Send {Down}
#^f::Send {Right}
#^g::Send {End}
#^h::Send ø
#^j::Send 4
#^k::Send 5
#^l::Send 6
#^ˆ::Send `,

#^‰:: ; ˛ ( ﬁ? )
MyUTF_String = √æ
Gosub Unicode
return


#^y::Send {Tab}
#^x::Send {Del}
#^c::Send {PgDn} ;Next
#^n::Send ±
#^m::Send 1
#^,::Send 2
#^.::Send 3
#^-::Send .


;6. Ebene (Win + Ctrl & Shift)
;-----------------------

#^+4::Send +{Prev}

#^+¥:: ; ring obendrauf, soll tot
MyUTF_String = Àö
Gosub Unicode
return

#^+q:: ; Xi?
MyUTF_String = Œû
Gosub Unicode
return
 
#^+w:: ; Lambda
MyUTF_String = Œõ
Gosub Unicode
return

#^+e::Send +{Up}
#^+r::Send © 
#^+t::Send +{Insert}

#^+u:: ; Phi
MyUTF_String = Œ®
Gosub Unicode
return

#^+i:: ; Gamma
MyUTF_String = Œì
Gosub Unicode
return

#^+o:: ; Psi
MyUTF_String = Œ¶
Gosub Unicode
return

#^+¸:: ; ?
MyUTF_String = ∆è
Gosub Unicode
return

#^++::  ; komma drunter, soll tot 
MyUTF_String = Àè
Gosub Unicode
return

#^+a::Send +{Home}
#^+s::Send +{Left}
#^+d::Send +{Down}
#^+f::Send +{Right}
#^+g::Send +{End}
#^+h:: ; Sigma
MyUTF_String = 
Gosub Unicode
return

#^+j:: ; No
MyUTF_String = ‚Ññ
Gosub Unicode
return

#^+k:: ; (R)
MyUTF_String = ¬Æ
Gosub Unicode
return

#^+l:: ; TM
MyUTF_String = ‚Ñ¢
Gosub Unicode
return

#^+ˆ:: ; Delta
MyUTF_String = Œî
Gosub Unicode
return

#^+‰:: ; ﬁ ( ˛? )
MyUTF_String = √û
Gosub Unicode
return


#^+y::Send +{Tab}

#^+c::Send +{PgDn}

#^+v:: ; Pi
MyUTF_String = Œ†
Gosub Unicode
return

#^+b:: ; Omega
MyUTF_String = Œ©
Gosub Unicode
return

#^+.:: ; Theta 
MyUTF_String = Œò
Gosub Unicode
return



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
^¸::send ^ﬂ

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
<!¸::send !ﬂ

<!a::send !u
<!s::send !i
<!d::send !a
<!f::send !e
<!g::send !o
<!h::send !s
<!j::send !n
<!k::send !r
<!l::send !t
<!ˆ::send !d
<!‰::send !y

<!y::send !ˆ
<!x::send !¸
<!c::send !‰
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
#ﬂ::send #-

#q::send #x
#w::send #v

#e::  
  ; #e::send #l  funktioniert nicht, Computer wird nicht gesperrt
Run,%A_WinDir%\System32\Rundll32.exe User32.dll`,LockWorkStation 
  ; http://www.autohotkey.com/forum/viewtopic.php?p=66937#66937
return

#r::send #c
#t::send #w
#z::send #k
#u::send #h
#i::send #g
#o::send #f
#p::send #q
#¸::send #ﬂ

#a::send #u
#s::send #i
#d::send #a
#f::send #e
#g::send #o
#h::send #s
#j::send #n
#k::send #r
#l::send #t
#ˆ::send #d
#‰::send #y

#y::send #ˆ
#x::send #¸
#c::send #‰
#v::send #p
#b::send #z
#n::send #b
#m::send #m
#-::send #j

;Strg-Shift-Ebene
;---------

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
;   oder NumLock On + Shift
; --> Cursortasten
; -----------------

; 3. Ebene
; NumLock on 
; + AltGr
; --> Pfeile
; -----------------

<^>!NumpadDiv::send ˜
<^>!NumpadMult::send ◊
<^>!NumpadSub::send -
<^>!NumpadAdd::send ±
<^>!NumpadEnter::    ; neq
  MyUTF_String = ‚â†
  Gosub Unicode
  return

<^>!Numpad7::  ;7/8
  MyUTF_String = ‚Öû 
  Gosub Unicode
  return
<^>!Numpad8::   ; uparrow
  MyUTF_String = ‚Üë
  Gosub Unicode
  return
<^>!Numpad9::   ;  3/8
  MyUTF_String = ‚Öú
  Gosub Unicode
  return
<^>!Numpad4::   ; leftarrow
  MyUTF_String = ‚Üê
  Gosub Unicode
  return
<^>!Numpad5::send Ü
<^>!Numpad6::   ; rightarrow
  MyUTF_String = ‚Üí
  Gosub Unicode
  return
<^>!Numpad1::send π 
<^>!Numpad2::   ; downarrow
  MyUTF_String = ‚Üì
  Gosub Unicode
  return
<^>!Numpad3::send ≥
<^>!Numpad0::send `%
<^>!NumPadDot::send .




; -----------------
; 4. Ebene
; NumLock off
; + AltGr + Shift
; --> Br¸che
; -----------------

;  Achtung! Wenn Numlock on:
;  <^>!+Numpad7       ; Log off (AltGr + Pos1)
;  <^>!+Numpad4       ; Ctrl + Left
;  <^>!+Numpad6       ; Ctrl + Right
;  <^>!+Numpad1       ; Shut down (AltGr + Ende)
;  (Shift schaltet Numpad aus)


<^>!+NumpadDiv::send / 
<^>!+NumpadMult::  ; cdot {ASC 0183}
  MyUTF_String = ‚ãÖ
  Gosub Unicode
  return
<^>!+NumpadSub::send - ; eig. unbelegt
<^>!+NumpadAdd::    ; -+
  MyUTF_String = ‚àì
  Gosub Unicode
  return 
<^>!+NumpadEnter::   ; approx
  MyUTF_String = ‚âà
  Gosub Unicode
  return  


<^>!+NumpadHome::  ; 1/8
  MyUTF_String = ‚Öõ
  Gosub Unicode
  return  
<^>!+NumpadUp::  ; 5/8
  MyUTF_String = ‚Öù
  Gosub Unicode
  return   
<^>!+NumpadPgUp::  ; 3/8
  MyUTF_String = ‚Öú
  Gosub Unicode
  return  
<^>!+NumpadLeft::send º
<^>!+NumpadClear::send Ω
<^>!+NumpadRight::send æ
<^>!+NumpadEnd::send π 
<^>!+NumpadDown::send ≤ 
<^>!+NumpadPgDn::send ≥ 
<^>!+NumpadIns::send â 
<^>!+NumPadDel::send `,
  


; -----------------
; 5. Ebene
; NumLock on
; + Mod5 (Win + Ctrl)
; --> Br¸che (genau wie Ebene 4)
; -----------------



^#NumpadDiv::send / 
^#NumpadMult::    ; cdot
 ; MyUTF_String = ¬∑ ; ={ASC 0183}, sollte eigentlich ‚ãÖ ??
 ; Gosub Unicode
 ; return∑
^#NumpadSub::send - ; eig. unbelegt
^#NumpadAdd::    ; -+
  MyUTF_String = ‚àì
  Gosub Unicode
  return 
^#NumpadEnter::   ; approx
  MyUTF_String = ‚âà
  Gosub Unicode
  return  


^#Numpad7::  ; 1/8
  MyUTF_String = ‚Öõ
  Gosub Unicode
  return  
^#Numpad8::  ; 5/8
  MyUTF_String = ‚Öù
  Gosub Unicode
  return   
^#Numpad9::  ; 3/8
  MyUTF_String = ‚Öú
  Gosub Unicode
  return  
^#Numpad4::send º
^#Numpad5::send Ω
^#Numpad6::send æ
^#Numpad1::send π 
^#Numpad2::send ≤ 
^#Numpad3::send ≥ 
^#Numpad0::send â 
^#NumPadDot::send `,


; ------------------------------------



Unicode:
; Place Unicode text onto the clipboard:
Transform, Clipboard, Unicode, %MyUTF_String%  
; Paste the clipboard's Unicode text: 
send ^v
return

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
