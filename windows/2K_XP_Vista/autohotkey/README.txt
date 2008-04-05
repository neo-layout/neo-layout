Version 24.02.2008

== Installation ==
=== Direkte Installation ===
Einfach das Archiv neo20-all-in-one.exe herunterladen und die Datei irgendwo 
speichern (am besten auf dem Desktop z.B.). Danach einen Doppelklick auf 
diese .exe-Datei und NEO steht in voller Funktionalität zur Verfügung!
Das alles geht ohne Admin-Rechte und ist auf jedem Rechner sofort ausführbar.
Achtung: Da sich NEO in der Entwicklung befindet, kann es vorkommen, dass die
exe-Datei gegenüber der Datei neo20-all-in-one.ahk leicht veraltet sein kann.
Entwickler sollten daher Autohotkey selbst runterladen, wie unten beschrieben.

Um kurzzeitig zu QWERTZ zu wechseln, kann mit Shift+Pause das Skript pausiert
werden.

Momentan befindet sich in der Testphase, ob die 6. Ebene über Shift+Mod4 oder
über Mod3+Mod4 angesprochen werden soll (Shift+Mod4 zum Markieren bleibt
erhalten). Die Datei neo20_mod-test.ahk spricht die 6. Ebene über Mod3+Mod4 an,
ist jedoch nicht aktuell.

=== Autohotkey herunter laden ===
Man braucht als erstes das Programm namens »autohotkey«
(http://www.autohotkey.com/download/AutohotkeyInstall.exe).
Um dieses zu installieren benötigt man KEINE Administratorrechte, wenn man das
Programm beispielsweise in das Verzeichnis »Eigene Dateien/NEO« installiert.
Oder in ein anderes Verzeichnis, für das man Schreibrechte hat.

=== ahk-Dateien ===
Danach kann man das ahk-Skript »neo20-all-in-one.ahk«
mit einem Doppelklick starten. Man erhält dann ein Systray-Icon, mit dem man
das Skript vorübergehend deaktivieren (Suspend) oder komplett beenden kann.

Wenn das Öffnen nicht direkt funktioniert: Öffnen mit -> Autohotkey.exe
auswählen -> Immer mit diesem Programm öffnen.

=== Automatischer Start ===
Bei Bedarf kann man sich eine Verknüpfung mit neo20-all-in-one.ahk in den
Autostart-Ordner legen, dann hat man die Belegung direkt bei der Anmeldung.

== Wie es funktioniert ==
Das Programm kann alle Tastendrucke abfangen und statt dessen andere Tasten 
simulieren. Die Zeile
  a::send b
fängt z. B. die Taste »a« ab und sendet statt dessen ein »b«.
Die ahk-Dateien lassen sich mit einem Texteditor bearbeiten, man muss
dann nur das Skript neu starten um die Änderungen zu übernehmen.

== Bekannte Fehler ==
Da die Compose-Taste auf rechter Mod3 + Tab liegt, mußte die Tabulator-Taste
umgemappt werden. Dadurch funktioniert leider die ShiftAltTab nicht mehr.
AltTab reagiert hingegen wie gewohnt.

Bisher reagieren nur die Buchstaben der 1. und 2. Ebene richtig auf
CapsLock (also immer groß schreiben – CapsLock erreicht man unter Neo, wenn 
man erst die rechte und dann die linke Mod3-Tasten gleichzeitig drückt).

== Nummernblock ==
Der Nummernblock reagiert nicht auf Tastenkombinationen mit Strg, Alt usw.

Der Nummernblock auf der 2. Ebene ist wahlweise
- bei AUSgeschaltetem Numlock
- bei EINgeschaltetem Numlock mit Shift
zu erreichen.
Der Nummernblock auf der 3. Ebene funktioniert bei EINgeschaltetem
Numlock mit Mod3 (Caps/#).
Der Nummernblock auf der 4. Ebene ist wahlweise
- bei AUSgeschaltetem Numlock mit Mod3 + Shift
- bei EINgeschaltetem Numlock über Mod4
zu erreichen.
Da die 2. Ebene über Shift ebenfalls bei EINgeschaltetem Numlock
funktioniert ist das Ausschalten des Nummernblocks nicht unbedingt
nötig.

== Besonderheiten bei der ahk-Windowsversion von Neo ==
Ebene 4 des Nummernblocks lässt sich außer über Mod3+Shift auch über
Mod4 ansprechen.

== Warnung ==
ACHTUNG! Bei Windows ist folgendes festgelegt:
AltGr + Pos1 = Abmelden
AltGr + Ende = Computer ausschalten
--> diese Kombinationen treten auf bei AUSgeschaltetem Numlock mit Mod4

== FAQ ==
Bei Problemen erst mal in die FAQ schauen, das meiste ist bekannt.
Hier: https://neo.eigenheimstrasse.de/svn/FAQ.txt
