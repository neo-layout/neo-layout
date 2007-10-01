Version 16.06.2007

== Installation ==
=== Direkte Installation ===
Einfach das Archiv neo20-all-in-one.zip herunterladen, entpacken und die Datei
neo20-all-in-one.exe irgendwo speichern (am besten auf dem Desktop z.B.). Danach
einen Doppelklick auf diese .exe-Datei und NEO steht in voller Funktionalität
zur Verfügung! Das alles geht ohne Admin-Rechte und ist auf jedem Rechner sofort
ausführbar.
Achtung: Da sich NEO in der Entwicklung befindet, kann es vorkommen, dass die
exe-Datei gegenüber der Datei neo20-all-in-one.ahk leicht veraltet sein kann.
Entwickler sollten daher Autohotkey selbst runterladen, wie unten beschrieben.

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
Der Tabulator macht Probleme mit DeadKeys. Ein DeadKey gefolgt von Tab
und einer Taste, die mit dem DeadKey ein neues Zeichen ergibt, löscht
den Tab (Backslash) und sendet die Kombo.

Bisher reagieren nur die Buchstaben der 1. und 2. Ebene richtig auf
CapsLock (also immer groß schreiben – CapsLock erreicht man unter Neo, wenn 
man erst die rechte und dann die linke Mod3-Tasten gleichzeitig drückt).

Das Umbelegen der Modifikatoren (Mod3, Mod5) ist etwas fehlerhaft (siehe
http://www.autohotkey.com/forum/topic10169.html), hat aber mit der neuen
Version bisher trotzdem geklappt. Bei Fehlern bitte melden.

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
- bei EINgeschaltetem Numlock über Mod5
zu erreichen.
Da die 2. Ebene über Shift ebenfalls bei EINgeschaltetem Numlock
funktioniert ist das Ausschalten des Nummernblocks nicht unbedingt
nötig.

== Besonderheiten bei der ahk-Windowsversion von Neo ==
Ebene 4 des Nummernblocks lässt sich außer über Mod3+Shift auch über
Mod5 ansprechen.

Es gibt die Tastenkombination Shift+Pause, die das Script pausiert und
un-pausiert. Wenns nicht gefällt, lasst es mich über den Verteiler wissen.

== Warnung ==
ACHTUNG! Bei Windows ist folgendes festgelegt:
AltGr + Pos1 = Abmelden
AltGr + Ende = Computer ausschalten
--> diese Kombinationen treten auf bei AUSgeschaltetem Numlock mit Mod5

