/*
   ------------------------------------------------------
   Methoden zum Senden von Unicode-Zeichen
   ------------------------------------------------------
*/


/************************************************************
  Alter Weg – Copy/Paste über die Zwischenablage
************************************************************/
/*
Diese Variante sollte nicht mehr verwendet werden (könnte jedoch unter Umständen noch zu Testzwecken hilfreich sein).

hat den Vorteil, dass sie etwas kompatibler ist (es ist kein separater GTK-Workarround notwendig). Stefan zufolge wurde sie schon einmal getestet, dann jedoch wieder verworfen.

Das Problem war vor allem, daß bei einer etwas größeren Rechnerauslastung kein normales Schreiben mehr möglich war. Nicht nur, daß die Perfomanz sehr schlecht war (es dauerte lange, bis die Buchstaben überhaupt erschienen) -- viel schlimmer war, daß die Reihenfolge der Tastatureingabe nicht mehr eingehalten wurde, sondern die genommen wurde, die in der Zwischenablage war: genau umgekehrt.
*/

/*
Unicode(code)
{
   saved_clipboard := ClipboardAll
   Transform, Clipboard, Unicode, %code%
   sendplay ^v
   Clipboard := saved_clipboard
}

BSUnicode(code)
{
   saved_clipboard := ClipboardAll
   Transform, Clipboard, Unicode, %code%
   sendplay {bs}^v
   Clipboard := saved_clipboard
}
*/


/************************************************************
  Neuer Weg – Benutzung der entsprechenden Win32-API-Methode
************************************************************/

/*
Über den GTK-Workaround:
Dieser basiert auf http://www.autohotkey.com/forum/topic32947.html
Der Aufruf von »SubStr(charCode,3)« geht davon aus, dass alle charCodes in Hex mit führendem „0x“ angegeben sind. Die abenteuerliche „^+u“-Konstruktion benötigt im Übrigen den Hex-Wert in Kleinschrift, was derzeit nicht bei den Zeichendefinitionen umgesetzt ist, daher zentral und weniger fehlerträchtig an dieser Stelle. Außerdem ein abschließend gesendetes Space, sonst bleibt der „eingetippte“ Unicode-Wert noch kurz sichtbar stehen, bevor er sich GTK-sei-dank in das gewünschte Zeichen verwandelt.
*/

SendUnicodeChar(charCode)
{
   IfWinActive, ahk_class gdkWindowToplevel
   {
      StringLower, charCode, charCode
      send % "^+u" . SubStr(charCode,3) . " "
   } else {
      VarSetCapacity(ki, 28 * 2, 0)

      EncodeInteger(&ki + 0, 1)
      EncodeInteger(&ki + 6, charCode)
      EncodeInteger(&ki + 8, 4)
      EncodeInteger(&ki +28, 1)
      EncodeInteger(&ki +34, charCode)
      EncodeInteger(&ki +36, 4|2)

      DllCall("SendInput", "UInt", 2, "UInt", &ki, "Int", 28)
   }
}

EncodeInteger(ref, val)
{
   DllCall("ntdll\RtlFillMemoryUlong", "Uint", ref, "Uint", 4, "Uint", val)
}

