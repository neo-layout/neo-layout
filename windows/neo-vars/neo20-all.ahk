; Revision Information
#Include %a_scriptdir%\_subwcrev.ahk

; die Compose-Definitionen
#Include %a_scriptdir%\en_us.ahk
#Include %a_scriptdir%\neocomp.ahk
#Include %a_scriptdir%\neovarscomp.ahk

; Hier liegt die Tastaturbelegung
#Include %a_scriptdir%\keydefinitions.ahk

; Shortcuts, um die Zeichen wieder sauber zur Applikation bringen zu können
#Include %a_scriptdir%\shortcuts.ahk

; Good-old AHK-Skripts, enthalten die ersten Key-Hooks für Mod-Tasten
; Achtung: Hinter dem ersten Keyboard-Hook werden keine globalen Variablen
; mehr gesetzt!
#Include %a_scriptdir%\recycle.ahk

; Normale Keyboard-Hooks
#Include %a_scriptdir%\keyhooks.ahk

; Das Herz von neo20.ahk: die Tasten- und Zeichen-Behandlungsroutinen
#Include %a_scriptdir%\varsfunctions.ahk
