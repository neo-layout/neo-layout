SetWorkingDir, %A_ScriptDir%
#include %A_ScriptDir%\


; Revision Information (don't moun)
#include *i source_\_subwcrev1.ahk

; die Compose-Definitionen
#include *i source_\compose.generated.ahk_
#include *i source_\compose-tainted.generated.ahk
#include    source_\neovarscompose.ahk

; Hier liegt die Tastaturbelegung
#include    source_\keydefinitions.ahk

; Shortcuts, um die Zeichen wieder sauber zur Applikation bringen zu können
#include    source_\performance.ahk
#include    source_\shortcuts.ahk

; Good-old AHK-Skripts, enthalten die ersten Key-Hooks für Mod-Tasten
; Achtung: Hinter dem ersten Keyboard-Hook werden keine globalen Variablen
; mehr gesetzt!
#include    source_\initialize.ahk
#include    source_\resources.ahk
#include    source_\tray.ahk
#include    source_\keyhooks.ahk
#include    source_\trayfunctions.ahk
#include    source_\levelfunctions.ahk
#include    source_\keyboardleds.ahk
#include    source_\screenkeyboard.ahk

; Das Herz von neo20.ahk: die Tasten- und Zeichen-Behandlungsroutinen
#include    source_\varsfunctions.ahk
