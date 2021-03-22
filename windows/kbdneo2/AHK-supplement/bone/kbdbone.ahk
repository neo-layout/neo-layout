; -*- encoding:utf-8 -*-

;*********************
; Anfangsbedingungen *
;*********************
name=Bone (Erweiterung für nativen Treiber)
enable=Aktiviere %name%
disable=Deaktiviere %name%

; 5+5+4 Tasten der ersten drei Reihen eines Layouts
layoutstring := "jduaxctieofvüä"

TempFolder := A_Temp . "\Neo2"
FileCreateDir, %TempFolder%

; FileInstalls relativ zum aktuellen Skriptverzeichnis
#include %A_ScriptDir%\
; Hauptprogramm ist identisch für alle Tastaturlayouts
#include ..\common\base.ahk
