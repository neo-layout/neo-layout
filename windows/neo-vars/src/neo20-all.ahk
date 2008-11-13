SetWorkingDir, %A_ScriptDir%
#include %A_ScriptDir%\


; Revision Information (don't moun)
#include *i source\_subwcrev1.ahk

; die Compose-Definitionen
#include *i source\compose.generated.ahk_
#include *i source\compose-tainted.generated.ahk
#include    source\neovarscompose.ahk

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
#include    source\tray.ahk
#include    source\keyhooks.ahk
#include    source\trayfunctions.ahk
#include    source\levelfunctions.ahk
#include    source\keyboardleds.ahk
#include    source\screenkeyboard.ahk

; Das Herz von neo20.ahk: die Tasten- und Zeichen-Behandlungsroutinen
#include    source\varsfunctions.ahk
