Version 19.05.2007

== Installation ==

Hierfür braucht man keine Administratorrechte, es muss jedoch 
zuerst das Programm namens „autohotkey“
(http://www.autohotkey.com/download/AutohotkeyInstall.exe) 
installiert werden.
Dazu benötigt man KEINE Administratorrechte, wenn man das Programm
beispielsweise in das Verzeichnis „Eigene Dateien/NEO“ installiert.

=== ahk-Dateien ===

Danach kann man die .ahk-Skripte (neo20.ahk und neo20-remap.ahk) 
mit einem Doppelklick starten. 
Man erhält dann ein Systray-Icon, mit dem man das Skript vorübergehend 
deaktivieren (Suspend) oder komplett beenden kann.
Wenn das Öffnen nicht direkt funktioniert: Öffnen mit -> Autohotkey.exe
auswählen -> Immer mit diesem Programm öffnen.

=== Automatischer Start ===

Bei Bedarf kann man sich Verknüpfungen mit neo20.ahk und 
neo20-remap.ahk in den Autostart-Ordner legen, dann hat man das 
Layout direkt bei der Anmeldung.

== Wie es funktioniert ==

Das Programm kann alle Tastendrucke abfangen und statt dessen andere 
Tasten simulieren. Die Zeile
  a::send b
fängt z. B. die Taste a ab und sendet statt dessen ein b.
Die ahk-Dateien lassen sich mit einem Texteditor bearbeiten, man muss 
dann nur das Skript neu starten um die Änderungen zu übernehmen.

== Bekannte Fehler ==

Das Umbelegen der Funktionstasten ist etwas ‚buggy‘ (siehe
http://www.autohotkey.com/forum/topic10169.html) und wurde deshalb 
in eine Extradatei ausgelagert (neo20-remap.ahk). 
Einfach beide Skripte starten.

Problem: Manchmal kommt nur Control Down an, aber nicht das Up, 
dann bleibt Control aktiv. 
Lösung ist dann, einmal die normale Controltaste zu drücken.
--> taucht bei mir inzwischen nicht mehr auf *auf Holz klopf*

Ohne die Remap-Datei können 
die 3. Ebene mit Ctrl+Win 
die 4. mit Ctrl+Win+Shift
die 5. mit AltGr 
die 6. mit AltGr+Shift
erreicht werden.

== Nummernblock ==

Der Nummernblock auf der 2. Ebene ist wahlweise
- bei AUSgeschaltetem Numlock  
- bei EINgeschaltetem Numlock mit Shift 
zu erreichen.
Der Nummernblock auf der 3. Ebene funktioniert bei EINgeschaltetem 
Numlock mit Mod3 (Caps/#).
Der Nummernblock auf der 4. Ebene ist wahlweise
- bei AUSgeschaltetem Numlock mit Mod3 + Shift 
- bei EINgeschaltetem Numlock über Mod5 
zu erreichen.
Da die 2. Ebene über Shift ebenfalls bei EINgeschaltetem Numlock
funktioniert ist das Ausschalten des Nummernblocks nicht unbedingt
nötig.

Achtung!
AltGr + Pos1 = Abmelden
AltGr + Ende = Computer ausschalten
--> diese Kombinationen treten auf bei AUSgeschaltetem Numlock mit Mod5

== To Do ==

Lässt sich die neo20-remap.ahk in die Hauptdatei integrieren?
Ist mir bislang noch nicht gelungen.

Geschütztes Leerzeichen und schmales Leerzeichen auf 4./6. Ebene über 
Leertaste, finde ich keine ANSI-Darstellung für.

./, auf Mod5 5. Ebene

CapsLock auf Mod3 3. Ebene
