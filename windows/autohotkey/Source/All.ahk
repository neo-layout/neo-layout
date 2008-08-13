/* 
   ------------------------------------------------------
   Liste der Module
   
   Die Reihenfolge der Includes *ist* relevant!
   
   Siehe auch:
   http://www.autohotkey.com/docs/commands/_Include.htm

   ------------------------------------------------------
*/


#Include %a_scriptdir%\Warning.ahk
#Include %a_scriptdir%\Changelog-and-Todo.ahk
#Include %a_scriptdir%\Global-Part.ahk
#Include %a_scriptdir%\Methods-Layers.ahk
#Include %a_scriptdir%\Keys-Qwert-to-Neo.ahk
#Include %a_scriptdir%\Keys-Neo.ahk
#Include %a_scriptdir%\Methods-Lights.ahk
#Include %a_scriptdir%\Methods-Other.ahk
#Include %a_scriptdir%\Methods-Unicode.ahk
#Include %a_scriptdir%\Methods-ScreenKeyboard.ahk

; Eines schönen Tages sollten auch die Compose-Kombinationen automatisch aus der Referenz erzeugt werden. Derzeitig gibt es nur den (höchst instabilen und experimentellen!) Compose-Playground:
;#Include *i %a_scriptdir%\..\Compose\Compose-all-in-one.ahk

