/* 
  All.ahk:
  Diese Datei ist für Entwickler zum schnellen Testen von Änderungen vorgesehen. Bei Syntaxfehlern bietet sie zudem den Vorteil, dass die Zeilennummern relativ zu den einzelnen Modulen angezeigt werden.
  Die Reihenfolge der Includes *ist* relevant! Denn: Vor dem Menü in der Global-Part.ahk dürfen keine Tastenkombinationen definiert werden. Ansonsten können Sie die Dateien hier beliebig anordnen.
*/

#Include %a_scriptdir%\Warning.ahk
#Include %a_scriptdir%\Global-Part.ahk
#Include %a_scriptdir%\Methods-Layers.ahk
#Include %a_scriptdir%\Keys-Qwert-to-Neo.ahk
#Include %a_scriptdir%\Keys-Neo.ahk
#Include %a_scriptdir%\Methods-Lights.ahk
#Include %a_scriptdir%\Methods-Other.ahk
#Include %a_scriptdir%\Compose.ahk
#Include %a_scriptdir%\Methods-Unicode.ahk
#Include %a_scriptdir%\Methods-ScreenKeyboard.ahk
; Eines schönen Tages sollten auch die Compose-Kombinationen automatisch aus der Referenz erzeugt werden. 
; Derzeitig gibt es nur den (höchst instabilen und experimentellen!) Compose-Playground:
; #Include *i %a_scriptdir%\..\Compose\Compose-all-in-one.ahk
