;== Fehlende Steuerbefehle hinzu ==

;SC138 ist VK_OEM_102 (rechts) ist Mod4
;»Bild auf«
~SC138 & 4::Sendinput {Blind}{PGUP}
;Cursor »Hoch«
~SC138 & l::Sendinput {Blind}{UP}
;»Entfernen«
~SC138 & c::Sendinput {Blind}{DEL}
;»Einfügen«
~SC138 & w::Sendinput {Blind}{INS}
;»Pos1«
~SC138 & u::Sendinput {Blind}{HOME}
;Cursor »Links«
~SC138 & i::Sendinput {Blind}{LEFT}
;Cursor »Runter«
~SC138 & a::Sendinput {Blind}{DOWN}
;Cursor »Rechts«
~SC138 & e::Sendinput {Blind}{RIGHT}
;»Ende«
~SC138 & o::Sendinput {Blind}{END}
;»Bild ab«
~SC138 & '::Sendinput {Blind}{PGDN}

;SC056 ist VK_OEM_102 (links) ist Mod4
;»Bild auf«		
~SC056 & 4::Sendinput {Blind}{PGUP}
;Cursor »Hoch«
~SC056 & l::Sendinput {Blind}{UP}
;»Entfernen«
~SC056 & c::Sendinput {Blind}{DEL}
;»Einfügen«
~SC056 & w::Sendinput {Blind}{INS}
;»Pos1«
~SC056 & u::Sendinput {Blind}{HOME}
;Cursor »Links«
~SC056 & i::Sendinput {Blind}{LEFT}
;Cursor »Runter«
~SC056 & a::Sendinput {Blind}{DOWN}
;Cursor »Rechts«
~SC056 & e::Sendinput {Blind}{RIGHT}
;»Ende«
~SC056 & o::Sendinput {Blind}{END}
;»Bild ab«
~SC056 & '::Sendinput {Blind}{PGDN}

;== Mod-Locks hinzu ==

;= CapsLock mit Shift+Shift =
;RShift wenn vorher LShift gedrückt wurde
LShift & ~RShift::	
	if GetKeyState("CapsLock","T")
		{
		setcapslockstate, off
		}
	else
		{
		setcapslockstate, on
		}
return

;LShift wenn vorher RShift gedrückt wurde
RShift & ~LShift::
	if GetKeyState("CapsLock","T")
		{
		setcapslockstate, off
		}
	else
		{
		setcapslockstate, on
		}
return

56()[{
IsMod4Locked := 0
Mod4LockAktion :=0
~SC056 & SC138::
	if (IsMod4Locked) 
		{
		IsMod4Locked = 0
		Mod4LockAktion = 0
;		MsgBox Mod4-Feststellung aufgebehoben
		sendinput {vke2 up}
		}
	else
		{
		IsMod4Locked = 1
		Mod4LockAktion = 1
		MsgBox Mod4 festgestellt: Um Mod4 wieder zu lösen drücke beide Mod4 Tasten gleichzeitig
		goto SendMod4
		}
return

~SC138 & SC056::
	if (IsMod4Locked) 
		{
		IsMod4Locked = 0
		Mod4LockAktion = 0
;		MsgBox Mod4-Feststellung aufgebehoben
		sendinput {vke2 up}
		}
	else
		{
		IsMod4Locked = 1
		Mod4LockAktion = 1
		MsgBox Mod4 festgestellt: Um Mod4 wieder zu lösen drücke beide Mod4 Tasten gleichzeitig
		goto SendMod4
		}
return

SendMod4:
	if(IsMod4Locked AND Mod4LockAktion)
		sendinput {vke2 down}
	else
		sendinput {vke2 up}
return


~Shift::
	if (IsMod4Locked)
		{
		Mod4LockAktion = 0
		goto SendMod4
		}
	else
return

~SHIFT UP::
	if (IsMod4Locked)
		{
		Mod4LockAktion = 1
		goto SendMod4
		}
	else
return

		
~vk15::
	if (IsMod4Locked)
		{
		Mod4LockAktion = 0
		goto SendMod4
		}
	else
return

~vk15 UP::
	if (IsMod4Locked)
		{
		Mod4LockAktion = 1
		goto SendMod4
		}
	else
return

		
~SC138::
	if (IsMod4Locked)
		{
		Mod4LockAktion = 0
		goto SendMod4
		}
	else
return

~SC138 UP::
	if (IsMod4Locked)
		{
		Mod4LockAktion = 1
		goto SendMod4
		}
	else
return

~SC056::
	if (IsMod4Locked)
		{
		Mod4LockAktion = 0
		goto SendMod4
		}
	else
return



~SC056 UP::
	if (IsMod4Locked)
		{
		Mod4LockAktion = 1
		goto SendMod4
		}
	else
return


~4::
if (Mod4LockAktion) 
Sendinput {Blind}{PGUP}
return

~l::
if (Mod4LockAktion)
Sendinput {Blind}{UP}
return

~c::
if (Mod4LockAktion)
Sendinput {Blind}{DEL}
return

~w::
if (Mod4LockAktion)
Sendinput {Blind}{INS}
return

~u::
if (Mod4LockAktion)
Sendinput {Blind}{HOME}
return

~i::
if (Mod4LockAktion)
Sendinput {Blind}{LEFT}
return

~a::
if (Mod4LockAktion)
Sendinput {Blind}{DOWN}
return

~e::
if (Mod4LockAktion)
Sendinput {Blind}{RIGHT}
return

~o::
if (Mod4LockAktion)
Sendinput {Blind}{END}
return

~'::
if (Mod4LockAktion)
Sendinput {Blind}{PGDN}
return