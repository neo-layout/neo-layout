/*
   NEO-Layout
    nach NoAdmin-Svorak von Simon Griph, 2004
   3./4. Ebene funktioniert über AltGr, 
    5./6. Ebene über Win+Ctrl
   Zur Umbelegung auf CapsLock und AltGr 
    verwende neo20-remap.ahk
*/

;#InstallKeybdHook
#usehook on
#singleinstance force
#LTrim 
  ; Quelltext kann eingerückt werden, msgbox ist trotzdem linksbündig

SendMode InputThenPlay	

name    = NEO-Layout 2.0
enable  = Aktiviere %name%
disable = Deaktiviere %name%


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

SC029::send {^} ;tot
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
SC00D::send {´} ;tot

q::send x
w::send v
e::send l
r::send c
t::send w
z::send k
u::send h
i::send g
o::send f
p::send q
ü::send ß
SC01B::send {~} ;soll tot, ist aber nicht -> extra definieren?

a::send u
s::send i
d::send a
f::send e
g::send o
h::send s
j::send n
k::send r
l::send t
ö::send d
ä::send y
;SC02B (#) wird zu AltGr

;SC056 (<) wird zu Mod5
y::send ö
x::send ü
c::send ä
v::send p
b::send z
n::send b
m::send m
SC033::send `,
SC034::send .
SC035::send j

;2. Ebene (Shift)
;---------

+SC029::  ; soll tot
MyUTF_String = Ë‡
Gosub Unicode
return

+1::send °
+2::send 2 
+3::send §
+4::send $
+5::send €
+6::send ª
+7::send º
+8::send „
+9::send “
+0::send ”

+ß:: 
MyUTF_String = â€“
Gosub Unicode
return

+SC00D::send `` ;tot

+q::send X
+w::send V
+e::send L
+r::send C
+t::send W
+z::send K
+u::send H
+i::send G
+o::send F
+p::send Q
+ü::send ß

+SC01B::  ; sollte tot sein...
MyUTF_String = Ë‰ 
Gosub Unicode
return

+a::send U
+s::send I
+d::send A
+f::send E
+g::send O
+h::send S
+j::send N
+k::send R
+l::send T
+ö::send D
+ä::send Y
;SC02B (#) wird zu AltGr

;SC056 (<) wird zu Mod5
+y::send Ö
+x::send Ü
+c::send Ä
+v::send P
+b::send Z
+n::send B
+m::send M
+SC033::send `;
+SC034::send :
+SC035::send J

;3. Ebene (AltGr)
;---------

<^>!SC029:: ; soll tot
MyUTF_String = Ë˜
Gosub Unicode
return

<^>!1:: 
MyUTF_String = Â¬ 
Gosub Unicode
return

<^>!2::send {^} 
<^>!3::send 3 
<^>!4::send ¥ 
<^>!5::send £  
<^>!6::send æ 
<^>!7::send œ 
<^>!8::send ‚
<^>!9::send ‘
<^>!0::send ’

<^>!ß::
MyUTF_String = â€” 
Gosub Unicode
return

<^>!SC00D::send ¸ ; soll tot

<^>!q::send @ 
<^>!w::send _
<^>!e::send [
<^>!r::send ]
<^>!t::send {^} ; tot, soll untot sein
<^>!z::sendraw !
<^>!u::send <
<^>!i::send >
<^>!o::send `=
<^>!p::send `;

<^>!ü::
MyUTF_String = Ä³
Gosub Unicode
return

<^>!SC01B:: ; ??
MyUTF_String = 
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
<^>!ö::send :
<^>!ä::send y


<^>!y::sendraw ~ 
<^>!x::send $
<^>!c::send |
<^>!v::send {#}
<^>!b::send `` ; tot, soll untot sein
<^>!n::send {+}
<^>!m::send `% 
<^>!SC033::send {&}
<^>!SC034::send "
<^>!SC035::send '

<^>!NumpadDiv::send ?
<^>!NumpadMult::send ?
<^>!NumpadSub::send ?
<^>!Numpad8::send ?
<^>!Numpad9::send ?
<^>!NumpadAdd::send ?
<^>!Numpad4::send ?
<^>!Numpad5::send ?
<^>!Numpad6::send ?
<^>!Numpad1::send ?
<^>!Numpad2::send ?
<^>!Numpad3::send ?
<^>!NumpadEnter::send ?
<^>!Numpad0::send `%
<^>!NumpadDot::send .
<^>!Numpad7::send ?



;4. Ebene (AltGr+Shift)
;---------

<^>!+SC029::send ¶ 
<^>!+1::send ¹ 
<^>!+2::send ²
<^>!+3::send ³
<^>!+4::send ¢ 
<^>!+5::send ¤ 
<^>!+6::send Æ 
<^>!+7::send Œ 
<^>!+8::send » 
<^>!+9::send « 
<^>!+0::send › 
<^>!+ß::send ‹ 

<^>!+SC00D:: ; nicht tot
MyUTF_String = Ë›
Gosub Unicode
return


<^>!+q::  ;xi
MyUTF_String = Î¾ 
Gosub Unicode
return

<^>!+w::send v

<^>!+e::  ;lambda
MyUTF_String = Î» 
Gosub Unicode
return

<^>!+r::  ;chi 
MyUTF_String = Ï‡
Gosub Unicode
return

<^>!+t::send w

<^>!+z:: ;kappa
MyUTF_String = Îº
Gosub Unicode
return

<^>!+u:: ;psi
MyUTF_String = Ïˆ
Gosub Unicode
return

<^>!+i:: ;gamma
MyUTF_String = Î³
Gosub Unicode
return

<^>!+o:: ;phi
MyUTF_String = Ï†
Gosub Unicode
return

<^>!+p::send q

<^>!+ü:: ;IJ
MyUTF_String = Ä²
Gosub Unicode
return

<^>!+SC01B::send " ;soll tot

<^>!+a::send u

<^>!+s:: ;iota
MyUTF_String = Î¹
Gosub Unicode
return

<^>!+d:: ;alpha
MyUTF_String = Î±
Gosub Unicode
return

<^>!+f:: ;epsilon
MyUTF_String = Îµ
Gosub Unicode
return

<^>!+g:: ;omega
MyUTF_String = Ï‰
Gosub Unicode
return

<^>!+h:: ;sigma
MyUTF_String = Ïƒ
Gosub Unicode
return

<^>!+j:: ;nu
MyUTF_String = Î½
Gosub Unicode
return

<^>!+k:: ;rho
MyUTF_String = Ï
Gosub Unicode
return

<^>!+l:: ;tau
MyUTF_String = Ï„
Gosub Unicode
return

<^>!+ö:: ;delta
MyUTF_String = Î´
Gosub Unicode
return

<^>!+ä:: ;upsilon
MyUTF_String = Ï…
Gosub Unicode
return



<^>!+y::send ö
<^>!+x::send ü

<^>!+c:: ;eta
MyUTF_String = Î·
Gosub Unicode
return

<^>!+v:: ;pi
MyUTF_String = Ï€
Gosub Unicode
return

<^>!+b:: ;zeta
MyUTF_String = Î¶
Gosub Unicode
return

<^>!+n:: ;beta
MyUTF_String = Î²
Gosub Unicode
return

<^>!+m:: ;mu
MyUTF_String = Î¼
Gosub Unicode
return

<^>!+SC033:: ;vartheta?
MyUTF_String = 
Gosub Unicode
return

<^>!+SC034:: ;theta
MyUTF_String = Î¸
Gosub Unicode
return

<^>!+SC035::send j

<^>!+NumpadDiv::send /
<^>!+NumpadMult::send ?
<^>!+NumpadSub::send ?
<^>!+Numpad8::send ?
<^>!+Numpad9::send ?
<^>!+NumpadAdd::send ?
<^>!+Numpad4::send ?
<^>!+Numpad5::send ?
<^>!+Numpad6::send ?
<^>!+Numpad1::send ?
<^>!+Numpad2::send ?
<^>!+Numpad3::send ?
<^>!+NumpadEnter::send ?
<^>!+Numpad0::send ?
<^>!+NumpadDot::send `,
<^>!+Numpad7::send ?



;5. Ebene (Win + Ctrl)
;---------

#^4::Send {PgUp} ;Prev
#^8::Send /
#^9::Send *
#^0::Send -

#^SC00D:: ;soll tot
MyUTF_String = Ë™
Gosub Unicode
return


#^q::Send {Esc}
#^w::Send {Backspace}
#^e::Send {Up}
#^t::Send {Insert}
#^z::Send ¡
#^u::Send 7
#^i::Send 8
#^o::Send 9
#^p::Send {+}

#^ü:: 
MyUTF_String = É™
Gosub Unicode
return

#^SC01B:: ;soll tot
MyUTF_String = /
Gosub Unicode
return

#^a::Send {Home}
#^s::Send {Left}
#^d::Send {Down}
#^f::Send {Right}
#^g::Send {End}
#^h::Send ¿
#^j::Send 4
#^k::Send 5
#^l::Send 6
#^ö::Send `,

#^ä:: ; ş ( Ş? )
MyUTF_String = Ã¾
Gosub Unicode
return


#^y::Send {Tab}
#^x::Send {Del}
#^c::Send {PgDn} ;Next
#^n::Send ±
#^m::Send 1
#^SC033::Send 2
#^SC034::Send 3
#^SC035::Send .


;6. Ebene (Win + Ctrl & Shift)
;-----------------------

#^+4::Send +{Prev}

#^+SC00D:: ; soll tot
MyUTF_String = Ëš
Gosub Unicode
return

#^+q:: ; Xi?
MyUTF_String = Î
Gosub Unicode
return
 
#^+w:: ; Lambda
MyUTF_String = Î›
Gosub Unicode
return

#^+e::Send +{Up}
#^+r::Send © 
#^+t::Send +{Insert}

#^+u:: ; Phi
MyUTF_String = Î¨
Gosub Unicode
return

#^+i:: ; Gamma
MyUTF_String = Î“
Gosub Unicode
return

#^+o:: ; Psi
MyUTF_String = Î¦
Gosub Unicode
return

#^+ü:: ; ?
MyUTF_String = Æ
Gosub Unicode
return

#^+SC01B::  ; soll tot 
MyUTF_String = Ë
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
MyUTF_String = â„–
Gosub Unicode
return

#^+k:: ; (R)
MyUTF_String = Â®
Gosub Unicode
return

#^+l:: ; TM
MyUTF_String = â„¢
Gosub Unicode
return

#^+ö:: ; Delta
MyUTF_String = Î”
Gosub Unicode
return

#^+ä:: ; Ş ( ş? )
MyUTF_String = Ã
Gosub Unicode
return


#^+y::Send +{Tab}

#^+c::Send +{PgDn}

#^+v:: ; Pi
MyUTF_String = Î 
Gosub Unicode
return

#^+b:: ; Omega
MyUTF_String = Î©
Gosub Unicode
return

#^+SC034:: ; Theta 
MyUTF_String = Î˜
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
^SC035::send ^j


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
<!ü::send {altdown}ß

<!a::send {altdown}u
<!s::send {altdown}i
<!d::send {altdown}a
<!f::send {altdown}e
<!g::send {altdown}o
<!h::send {altdown}s
<!j::send {altdown}n
<!k::send {altdown}r
<!l::send {altdown}t
<!ö::send {altdown}d
<!ä::send {altdown}y

<!y::send {altdown}ö
<!x::send {altdown}ü
<!c::send {altdown}ä
<!v::send {altdown}p
<!b::send {altdown}z
<!n::send {altdown}b
<!m::send {altdown}m
<!SC035::send {altdown}j


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
#SC035::send #j

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
^+SC035::send ^+j




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
   Sleep 1000 
   ; If successful, the reload will close this instance 
   ; during the Sleep, so the line below will never be reached.
   MsgBox, 4,, 
   (
   The script could not be reloaded. 
   Would you like to open it for editing?
   )
   IfMsgBox, Yes, Edit
   return
return

hide:
   menu, tray, noicon
return

exitprogram:
   exitapp
return
