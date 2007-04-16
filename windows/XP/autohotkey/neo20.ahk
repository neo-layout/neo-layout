/*
   NEO-Layout
   nach NoAdmin-Svorak von Simon Griph, 2004
   3./4. Ebene funktioniert nur über AltGr, nicht über CapsLock
   5./6. Ebene noch gar nicht
*/

;#InstallKeybdHook
;#singleinstance force
;#notrayicon
#hotkeyinterval 1024
#maxhotkeysperinterval 64
setstorecapslockmode, on

name    = &NEO-Layout
enable  = Aktiviere &NEO
disable = Deaktiviere &NEO
;ctrls   = &Strg Standard	

regread, inputlocale, HKEY_CURRENT_USER, Keyboard Layout\Preload, 1
regread, inputlocalealias, HKEY_CURRENT_USER, Keyboard Layout\Substitutes, %inputlocale%
if inputlocalealias <>
   inputlocale = %inputlocalealias%
if inputlocale <> 00000407
{
   suspend   
   regread, inputlocale, HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Control\Keyboard Layouts\%inputlocale%, Layout Text
   msgbox, 48, Warning!, Incompatible keybord layout:   `n`n      "inputlocale"   `n`nGerman QWERTZ has to be the standardlayout for   `n%name% works as expected.   `n`nChange the standard layout under control panel   `n-> Local and language settings   `n-> Language -> Information...   `n
   exitapp
}

stringtrimright, inifile, a_scriptname, 4
inifile = %inifile%.ini
iniread, firstrun, %inifile%, environment, firstRun, on
if firstrun <> off
{
   iniwrite, off, %inifile%, environment, firstRun
   gosub help
}

;menu, tray, nostandard
menu, tray, add
menu, tray, add, %disable%, toggleneo
menu, tray, default, %disable%
;menu, tray, add, %ctrls%, togglectrl
   menu, helpmenu, add, &Hilfe, help
   menu, helpmenu, add
   menu, helpmenu, add, http://&autohotkey.com/, autohotkey
   menu, helpmenu, add, http://www.eigenheimstrasse.de:8668/space/Computerecke/NEO-Tastaturlayout, neo
   ;menu, helpmenu, add, http://aoeu.&info/, aoeu
menu, tray, add, &Dokumentation, :helpmenu
menu, tray, add
menu, tray, add, Nicht &im &Systray &anzeigen, hide
menu, tray, add, %name% beenden, exitprogram
menu, tray, tip, %name%

/*
iniread, scc, %inifile%, environment, neoCtrlChars, on
gosub, setctrl
menu, tray, icon
blockinput, send
*/

/*
;Senden von Unicode:
Hotkey::
MyUTF_String = {ASC xy}
Gosub Unicode
return
*/


; Für 3. und 4. Ebene:
; nach http://www.autohotkey.com/forum/topic5370.html
; CapsLock und # werden zu AltGr:
; [this didn't work: *CapsLock::Send {LCtrl} ]

*CapsLock::
*SC02B::
Send {RAlt Down}
Send {LControl Down}
return

*CapsLock Up::
*SC02B Up::
Send {RAlt Up} 
Send {LControl Up} 
return

; Für 5. und 6. Ebene:
; < und AltGr werden zu LCtrl + RCtrl:
/*
*SC056::
*SC138::
Send {LControl Down}
Send {RControl Down}
return

*SC056 Up::
*SC138 Up::
Send {LControl Up} 
Send {RControl Up} 
return
*/

#usehook on

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
ß::send - ; Bind, Unicode?
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

+SC029::  ;? 
; 030C passiert bei mir nichts - 02C7 wäre untot, geht auch nicht
MyUTF_String = {ASC 2C7} 
Gosub Unicode
return

+1::send °
+2::send 2 
+3::send §
+4::send $
+5::send €
+6::send ª
+7::send º ; wo ist Unterschied zu +1?
+8::send „
+9::send “
+0::send ”
+ß::send – ; Ged, Unicode?
+SC00D::send `` 

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

+SC01B::  ; Macron?? sollte tot sein...
MyUTF_String = {ASC 0175} 
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

<^>!SC029::send ? ; Siehe 2. Ebene
<^>!1:: ; ¬
MyUTF_String = {ASC 172} 
Gosub Unicode
return

<^>!2::send ^  ;
<^>!3::send 3 ;
<^>!4::send ¥ ;
<^>!5::send £ ; 
<^>!6::send æ ;
<^>!7::send œ ;
<^>!8::send ‚
<^>!9::send ‘
<^>!0::send ’
<^>!ß::send — ; soll ganz langer Strich sein
<^>!SC00D::send ¸ ;

<^>!q::send @ 
<^>!w::send _
<^>!e::send [
<^>!r::send ]
<^>!t::send {^}
<^>!z::send {!}
<^>!u::send <
<^>!i::send >
<^>!o::send `=
<^>!p::send `;
<^>!ü::send ? ;
<^>!SC01B::send ? ;

<^>!a::send \
<^>!s::send /
<^>!d::sendraw { 
<^>!f::sendraw } 
<^>!g::send *
<^>!h::send ?
<^>!j::send (
<^>!k::send )
<^>!l::send -
<^>!ö::send :
<^>!ä::send y
;SC02B (#) wird zu AltGr

<^>!y::send ~
<^>!x::send $
<^>!c::send |
<^>!v::send {#}
<^>!b::send `` ; tot, soll der untot sein?
<^>!n::send {+}
<^>!m::send `% 
<^>!SC033::send {&}
<^>!SC034::send "
<^>!SC035::send '


;4. Ebene (AltGr+Shift)
;---------

<^>!+SC029::send ¶ ;
<^>!+1::send ¹ ;
<^>!+2::send ²
<^>!+3::send ³
<^>!+4::send ¢ ;
<^>!+5::send ¤ ;
<^>!+6::send Æ ;
<^>!+7::send Œ ;
<^>!+8::send » ;
<^>!+9::send « ;
<^>!+0::send › ;
<^>!+ß::send ‹ ;
<^>!+SC00D::send ´ ;

<^>!+q::send ?
<^>!+w::send v
<^>!+e::send ?
<^>!+r::send ?
<^>!+t::send w
<^>!+z::send ?
<^>!+u::send ?
<^>!+i::send ?
<^>!+o::send ?
<^>!+p::send q
<^>!+ü::send ?
<^>!+SC01B::send {~} ;

<^>!+a::send u
<^>!+s::send ?
<^>!+d::send ?
<^>!+f::send ?
<^>!+g::send ?
<^>!+h::send ?
<^>!+j::send ?
<^>!+k::send ?
<^>!+l::send ?
<^>!+ö::send ?
<^>!+ä::send ?
;SC02B (#) wird zu AltGr

<^>!+y::send ö
<^>!+x::send ü
<^>!+c::send ?
<^>!+v::send ?
<^>!+b::send ?
<^>!+n::send ?
<^>!+m::send ?
<^>!+SC033::send ?
<^>!+SC034::send ?
<^>!+SC035::send j

;5. Ebene
;---------

<>^4::Send 5

;SC056 & 8::
;RAlt & 8::
;Send {/}
;return

;SC056 & 9::
;RAlt & 9::
;Send {*}
;return

;SC056 & 0::
;RAlt & 0::
;Send {-}
;return


;SC056 & q::
;RAlt & q::
;Send {Esc}
;return

;SC056 & w::
;RAlt & w::
;Send {Backspace}
;return

;SC056 & e::
;RAlt & e::
;Send {Up}
;return

;SC056 & t::
;RAlt & t::
;Send {Insert}
;return

;SC056 & z::
;RAlt & z::
;Send {¡}
;return

;SC056 & u::
;RAlt & u::
;Send {7}
;return

;SC056 & i::
;RAlt & i::
;Send {8}
;return

;SC056 & o::
;RAlt & o::
;Send {9}
;return

;SC056 & p::
;RAlt & p::
;Send {+}
;return
;
;SC056 & ü::
;RAlt & ü::
;Send {?}
;return


;SC056 & a::
;RAlt & a::
;Send {Home}
;return

;SC056 & s::
;RAlt & s::
;Send {Left}
;return

;SC056 & d::
;RAlt & d::
;Send {Down}
;return

;SC056 & f::
;RAlt & f::
;Send {Right}
;return

;SC056 & g::
;RAlt & g::
;Send {End}
;return

;SC056 & h::
;RAlt & h::
;Send {¿}
;return

;SC056 & j::
;RAlt & j::
;Send {4}
;return

;SC056 & k::
;RAlt & k::
;Send {5}
;return

;SC056 & l::
;RAlt & l::
;Send {6}
;return

;SC056 & ö::
;RAlt & ö::
;Send {,}
;return

;SC056 & ä::
;RAlt & ä::
;Send {þ}
;return

;SC056 & y::
;RAlt & y::
;Send {Tab}
;return

;SC056 & x::
;RAlt & x::
;Send {Del}
;return

;SC056 & c::
;RAlt & c::
;Send {PgDn}
;return

;SC056 & n::
;RAlt & n::
;Send {±}
;return

;SC056 & m::
;RAlt & m::
;Send {1}
;return

;SC056 & SC033::
;RAlt & SC033::
;Send {2}
;return

;SC056 & SC034::
;RAlt & SC034::
;Send {3}
;return

;SC056 & SC035::
;RAlt & SC035::
;Send {.}
;return

;6. Ebene (Mod5 & Shift)
;-----------------------

;+SC056 & b::
;+RAlt & b::
;Send m
;return


;Strg/Ctrl
;---------

^SC029::send ^^ ;
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
^ß::send ^-
^SC00D::send ^´ ;

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
^SC01B::send ^~ ;

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
;SC02B (#) wird zu AltGr

^y::send ^ö
^x::send ^ü
^c::send ^ä
^v::send ^p
^b::send ^z
^n::send ^b
^m::send ^m
^SC033::send ^,
^SC034::send ^.
^SC035::send ^j

;Alt-Ebene
;---------

!SC029::send {altdown}^ ;
!1::send {altdown}1
!2::send {altdown}2
!3::send {altdown}3
!4::send {altdown}4
!5::send {altdown}5
!6::send {altdown}6
!7::send {altdown}7
!8::send {altdown}8
!9::send {altdown}9
!0::send {altdown}0
!ß::send {altdown}-
!SC00D::send {altdown}´ ;

!q::send {altdown}x
!w::send {altdown}v
!e::send {altdown}l
!r::send {altdown}c
!t::send {altdown}w
!z::send {altdown}k
!u::send {altdown}h
!i::send {altdown}g
!o::send {altdown}f
!p::send {altdown}q
!ü::send {altdown}ß
!SC01B::send {altdown}~ ;

!a::send {altdown}u
!s::send {altdown}i
!d::send {altdown}a
!f::send {altdown}e
!g::send {altdown}o
!h::send {altdown}s
!j::send {altdown}n
!k::send {altdown}r
!l::send {altdown}t
!ö::send {altdown}d
!ä::send {altdown}y
;SC02B (#) wird zu AltGr

!y::send {altdown}ö
!x::send {altdown}ü
!c::send {altdown}ä
!v::send {altdown}p
!b::send {altdown}z
!n::send {altdown}b
!m::send {altdown}m
!SC033::send {altdown},
!SC034::send {altdown}.
!SC035::send {altdown}j

;Win-Ebene
;---------

#SC029::send #^ ;
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
#SC00D::send #´ ;

#q::send #x
#w::send #v
#e::send #l
#r::send #c
#t::send #w
#z::send #k
#u::send #h
#i::send #g
#o::send #f
#p::send #q
#ü::send #ß
#SC01B::send #~ ;

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
;SC02B (#) wird zu AltGr

#y::send #ö
#x::send #ü
#c::send #ä
#v::send #p
#b::send #z
#n::send #b
#m::send #m
#SC033::send #,
#SC034::send #.
#SC035::send #j

;Strg-Shift-Ebene
;---------

^+SC029::send ^+^ ;
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
^+ß::send ^+-
^+SC00D::send ^+´ ;

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
^+SC01B::send ^+~ ;

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
;SC02B (#) wird zu AltGr

^+y::send ^+ö
^+x::send ^+ü
^+c::send ^+ä
^+v::send ^+p
^+b::send ^+z
^+n::send ^+b
^+m::send ^+m
^+SC033::send ^+,
^+SC034::send ^+.
^+SC035::send ^+j





#usehook off
return

Unicode:
; Place Unicode text onto the clipboard:
Transform, Clipboard, Unicode, %MyUTF_String%  
; Retrieve the clipboard's Unicode text as a UTF-8 string:
Transform, OutputVar, Unicode  
Send %OutputVar%
return

toggleneo:
   if state <>
   {
      state =
      menu, tray, rename, %enable%, %disable%
      menu, tray, enable, %ctrls%
   }
   else
   {
      state = : Inaktiverad
      menu, tray, rename, %disable%, %enable%
      menu, tray, disable, %ctrls%
   }

   menu, tray, tip, %name%%state%
   suspend
return

togglectrl:
   if scc <> off
      scc = off
   else
      scc = on
   iniwrite, %scc%, %inifile%, environment, svorakCtrlChars
   gosub, setctrl
return

setctrl:
   if scc <> off
      menu, tray, uncheck, %ctrls%
   else
      menu, tray, check, %ctrls%
return


help:
   msgbox, 64, name, NEO-Layout ohne Administratorrechte.   `n`n%name% ersetzt das übliche deutsche   `nTastaturlayout mit der Alternative NEO,   `nbeschrieben auf http://www.de.   `n`nWenn Autohotkey aktiviert ist, werden alle Tastendrucke `nabgefangen und statt dessen eine Übersetzung weitergeschickt. `nDies geschieht transparent für den Anwender,  `nes muss nichts installiert werden.   `n`nDie Zeichenübersetzung kann leicht über ein Icon im `nSystemtray deaktiviert werden.  `nAußerdem kann dort ausgewählt werden, ob die Strg-Tasten `nebenfalls übersetzt werden sollen. `n`n`nSimon Griph, 2004-10-25   `n
return

aoeu:
   run http://aoeu.info/
return

neo:
   run http://www.eigenheimstrasse.de:8668/space/Computerecke/NEO-Tastaturlayout
return

autohotkey:
   run http://autohotkey.com/
return

hide:
   menu, tray, noicon
return

exitprogram:
   exitapp
return
