== Installation ==
Hierfür braucht man keine Administratorrechte, es muss jedoch zuerst das
Programm namens „autohotkey“
(http://www.autohotkey.com/download/AutohotkeyInstall.exe) installiert werden.
Dazu benötigt man KEINE Administratorrechte, wenn man das Programm
beispielsweise in das Verzeichnis „Eigene Dateien/NEO“ installiert.

=== ahk-Dateien ===
Danach kann man .ahk-Skripte mit einem Doppelklick starten. Man erhält 
dann ein Systray-Icon, mit dem man das Skript vorübergehend deaktivieren 
(Suspend) oder komplett beenden kann.
Wenn das Öffnen nicht direkt funktioniert: Öffnen mit -> Autohotkey.exe
auswählen -> Immer mit diesem Programm öffnen.

=== Automatischer Start ===
Bei Bedarf kann man sich eine Verknüpfung mit neo20.ahk in den 
Autostart-Ordner legen, dann hat man das Layout direkt bei der Anmeldung.

== Wie es funktioniert ==
Das Programm kann alle Tastendrucke abfangen und statt dessen andere Tasten
simulieren. Die Zeile
  a::send b
fängt z. B. die Taste a ab und sendet statt dessen ein b.
Die ahk-Dateien lassen sich mit einem Texteditor bearbeiten, man muss dann 
nur das Skript neu starten um die Änderungen zu übernehmen.

== Bekannte Fehler ==
Das Umbelegen der Funktionstasten ist etwas ‚buggy‘ (siehe
http://www.autohotkey.com/forum/topic10169.html) und wurde deshalb in 
eine Extradatei ausgelagert (neo20-remap.ahk). 
Verwendung auf eigene Gefahr, einfach beide Skripte starten.

Problem: Auf der 5. und 6. Ebene kommt (bei Verwendung von AltGr) nur 
Control Down an, aber nicht das Up, dann bleibt Control aktiv. 
Lösung ist dann, einmal die normale Controltaste zu drücken.
Mod5 auf < hat das Problem nicht.

Ohne die Remap-Datei kann die 5. Ebene mit Ctrl+Win erreicht werden
(6. entsprechend mit Ctrl-Win-Shift).

== Nummernblock ==
Der Nummernblock auf der 3. Ebene ist bei eingeschaltetem Numlock mit AltGr 
zu erreichen. Achtung! Bei ausgeschaltetem Numlock fährt AltGr + Ende den
Computer herunter!!
Der Nummernblock auf der 4. Ebene ist bei ausgeschaltetem Numlock mit AltGr 
+ Shift zu erreichen. Achtung! Bei eingeschaltetem Numlock fährt AltGr + Shift 
+ Ende den Computer herunter!!
Sicherer: 
Der Nummernblock der 4. Ebene ist bei eingeschaltetem Numlock auch 
über Mod5 zu erreichen, die 2. Ebene über Shift. Damit ist weder das Ausschalten
des Nummernblocks noch die Verwendung von AltGr + Shift nötig und der
Computer wird nicht versehentlich heruntergefahren.

== To Do ==
Dead Keys: Bislang funktionieren nur die Deadkeys, die auch im 
normalen deutschen qwertz-Layout vorkommen.
Alle anderen können über Hotstrings definiert werden:
  ::~a::ã 
usw.

