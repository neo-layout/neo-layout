;;
;; NoAdmin-NEO -- Simon Griph, 2004
;;

;#InstallKeybdHook
#singleinstance force
#persistent
#notrayicon
#hotkeyinterval 1024
#maxhotkeysperinterval 64
setstorecapslockmode, off

name    = NEO-Layout
enable  = Aktiviere &NEO
disable = Deaktiviere &NEO
ctrls   = &Strg Standard	

regread, inputlocale, HKEY_CURRENT_USER, Keyboard Layout\Preload, 1
regread, inputlocalealias, HKEY_CURRENT_USER, Keyboard Layout\Substitutes, inputlocale
if inputlocalealias <>
   inputlocale = inputlocalealias
if inputlocale <> 00000407
{
   suspend   
   regread, inputlocale, HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Control\Keyboard Layouts\inputlocale, Layout Text
   msgbox, 48, Warning!, Incompatible keybord layout:   `n`n      "inputlocale"   `n`nGerman QWERTZ has to be the standardlayout for   `nname works as expected.   `n`nChange the standard layout under control panel   `n-> Local and language settings   `n-> Language -> Information...   `n
   exitapp
}

stringtrimright, inifile, a_scriptname, 4
inifile = inifile.ini
iniread, firstrun, inifile, environment, firstRun, on
if firstrun <> off
{
   iniwrite, off, inifile, environment, firstRun
   gosub help
}

menu, tray, nostandard
menu, tray, add, disable, toggleneo
menu, tray, default, disable
;menu, tray, add, ctrls, togglectrl
   menu, helpmenu, add, &Hilfe, help
   menu, helpmenu, add
   menu, helpmenu, add, http://&autohotkey.com/, autohotkey
   menu, helpmenu, add, http://www.eigenheimstrasse.de:8668/space/Computerecke/NEO-Tastaturlayout, neo
   menu, helpmenu, add, http://aoeu.&info/, aoeu
menu, tray, add, &Dokumentation, :helpmenu
menu, tray, add
menu, tray, add, Nicht &im &Systray &anzeigen, hide
menu, tray, add, NEO beenden, exitprogram
menu, tray, tip, NEO

iniread, scc, inifile, environment, neoCtrlChars, on
;gosub, setctrl
menu, tray, icon
blockinput, send

#usehook on

;1. Ebene
;---------

SC029::send {^} ;
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
SC00D::send {´} ;

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
SC01B::send {~} ;

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
;SC02B (#) wird zu Mod5

y::send ö
x::send ü
c::send ä
v::send p
b::send z
n::send b
m::send m
SC033::send {,}
SC034::send .
SC035::send j

;2. Ebene (Shift)
;---------

+SC029::send {^} ;
+1::send ° ;
+2::send 2 ;
+3::send §
+4::send $
+5::send €
+6::send ²
+7::send ° ;
+8::send „
+9::send “
+0::send ”
+ß::send – 
+SC00D::send {´} ;

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
+SC01B::send - ;

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
;+SC02B::send {#} 

+y::send Ö
+x::send Ü
+c::send Ä
+v::send P
+b::send Z
+n::send B
+m::send M
+SC033::send {;}
+SC034::send :
+SC035::send J

;3. Ebene (AltGr)
;---------
<^>!SC029::send ? ;
<^>!1::send ¬
<^>!2::send ^
<^>!3::send 3
<^>!4::send ¥
<^>!5::send £
<^>!6::send æ
<^>!7::send œ
<^>!8::send ‚
<^>!9::send ‘
<^>!0::send ’
<^>!ß::send —
<^>!SC00D::send ¸ ;

<^>!q::send @
<^>!w::send _
<^>!e::send [
<^>!r::send ]
<^>!t::send {^}
<^>!z::send {!}
<^>!u::send {<}
<^>!i::send {>}
<^>!o::send =
<^>!p::send {;}
<^>!ü::send ?
<^>!SC01B::send ? ;

<^>!a::send \
<^>!s::send /
<^>!d::send {
<^>!f::send }
<^>!g::send *
<^>!h::send ?
<^>!j::send (
<^>!k::send )
<^>!l::send -
<^>!ö::send :
<^>!ä::send y
;SC02B (#) wird zu Mod5

<^>!y::send ~
<^>!x::send $
<^>!c::send |
<^>!v::send {#}
<^>!b::send {`}
<^>!n::send {+}
<^>!m::send 0/0 ;
<^>!SC033::send {&}
<^>!SC034::send "
<^>!SC035::send '


;4. Ebene (AltGr+Shift)
;---------

<^>!+SC029::send ¶ ;
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
;SC02B (#) wird zu Mod5

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

SC02B & a::
CapsLock & a::
send Pos1
return



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
;SC02B (#) wird zu Mod5

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
;SC02B (#) wird zu Mod5

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
;SC02B (#) wird zu Mod5

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
;SC02B (#) wird zu Mod5

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

toggleneo:
   if state <>
   {
      state =
      menu, tray, rename, enable, disable
      menu, tray, enable, ctrls
   }
   else
   {
      state = : Inaktiverad
      menu, tray, rename, disable, enable
      menu, tray, disable, ctrls
   }

   menu, tray, tip, namestate
   suspend
return

togglectrl:
   if scc <> off
      scc = off
   else
      scc = on
   iniwrite, scc, inifile, environment, neoCtrlChars
;   gosub, setctrl
return


help:
   msgbox, 64, name, NEO-Layout ohne Administratorrechte.   `n`nname ersetzt das übliche deutsche   `nTastaturlayout mit der Alternative NEO,   `nbeschrieben auf http://www.de.   `n`nWenn Autohotkey aktiviert ist, werden alle Tastendrucke `nabgefangen und statt dessen eine Übersetzung weitergeschickt. `nDies geschieht transparent für den Anwender,  `nes muss nichts installiert werden.   `n`nDie Zeichenübersetzung kann leicht über ein Icon im `nSystemtray deaktiviert werden.  `nAußerdem kann dort ausgewählt werden, ob die Strg-Tasten `nebenfalls übersetzt werden sollen. `n`n`nSimon Griph, 2004-10-25   `n
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
