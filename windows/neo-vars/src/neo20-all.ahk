SetWorkingDir, %A_ScriptDir%
#include %A_ScriptDir%\


; Revision Information (don't moun)
#include *i source\_subwcrev1.generated.ahk

; die Compose-Definitionen
#include *i source\compose.generated.ahk
#include *i source\compose-tainted.generated.ahk
#include    source\compose-gen.ahk

; Hier liegt die Tastaturbelegung
#include    source\keydefinitions.ahk

; Shortcuts, um die Zeichen wieder sauber zur Applikation bringen zu können
#include    source\performance.ahk
#include    source\shortcuts.ahk

; Good-old AHK-Skripts, enthalten die ersten Key-Hooks für Mod-Tasten
; Achtung: Hinter dem ersten Keyboard-Hook werden keine globalen Variablen
; mehr gesetzt!
#include    source\initialize.ahk
#include    source\resources.ahk

; Das Herz von neo20.ahk: die Tasten- und Zeichen-Behandlungsroutinen
#include    source\varsfunctions.ahk

; Die Bildschirmtastatur
#include    source\screenkeyboard.ahk
#include    source\screenkeyboard_old.ahk

; Mitgelieferte Belegungsvarianten
#include    source\langstastatur.ahk
#include    source\einhandneo.ahk
#include    source\lernmodus.ahk
#include    source\tools.ahk

; individuelle Einstellungen
#include *i %A_AppData%\Neo2\custom.ahk

#include    source\tray.ahk
#include    source\keyhooks.ahk
#include    source\levelfunctions.ahk
#include    source\keyboardleds.ahk

