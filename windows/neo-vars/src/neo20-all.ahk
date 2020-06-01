; -*- encoding: utf-8 -*-

SetWorkingDir, %A_ScriptDir%
#include %A_ScriptDir%\


; Revision Information (don't moun)
#include *i _gitwcrev.generated.ahk

; die Compose-Definitionen
#include *i compose.generated.ahk
#include *i compose-tainted.generated.ahk
#include    compose-gen.ahk

; Hier liegt die Tastaturbelegung
#include    keydefinitions.ahk

; Shortcuts, um die Zeichen wieder sauber zur Applikation bringen zu können
#include    performance.ahk
#include    shortcuts.ahk

; Good-old AHK-Skripts, enthalten die ersten Key-Hooks für Mod-Tasten
; Achtung: Hinter dem ersten Keyboard-Hook werden keine globalen Variablen
; mehr gesetzt!
#include    initialize.ahk
#include    resources.ahk

; Das Herz von neo20.ahk: die Tasten- und Zeichen-Behandlungsroutinen
#include    varsfunctions.ahk

; Mitgelieferte Belegungsvarianten
#include    langstastatur.ahk
#include    einhandneo.ahk
#include    lernmodus.ahk
#include    qwertz.ahk
#include    tools.ahk

; Die Bildschirmtastatur
#include    screenkeyboard.ahk

; individuelle Einstellungen
#include *i %A_AppData%\Neo2\custom.ahk

#include    tray.ahk
#include    keyhooks.ahk
#include    levelfunctions.ahk
#include    keyboardleds.ahk

