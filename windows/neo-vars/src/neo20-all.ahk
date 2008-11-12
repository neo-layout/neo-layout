SetWorkingDir, %A_ScriptDir%
#Include %A_ScriptDir%\


; Revision Information (don't moun)
#Include *i Source\_subwcrev1.ahk

; die Compose-Definitionen
#Include *i Source\Compose.generated.ahk
#Include *i Source\Compose-tainted.generated.ahk
#Include    Source\neovarscomp.ahk

; Hier liegt die Tastaturbelegung
#Include    Source\keydefinitions.ahk

; Shortcuts, um die Zeichen wieder sauber zur Applikation bringen zu können
#Include    Source\shortcuts.ahk

; Good-old AHK-Skripts, enthalten die ersten Key-Hooks für Mod-Tasten
; Achtung: Hinter dem ersten Keyboard-Hook werden keine globalen Variablen
; mehr gesetzt!
#Include    Source\recycle.ahk

; Normale Keyboard-Hooks
#Include    Source\keyhooks.ahk

; Das Herz von neo20.ahk: die Tasten- und Zeichen-Behandlungsroutinen
#Include    Source\varsfunctions.ahk
