== Neo 2.0 Autohotkey-Treiber für Windows ==


== Hinweise für Nutzer ==

=== Direkte Installation ===
Einfach die Datei neo20.exe herunterladen und die Datei irgendwo 
speichern (bspw. auf dem Desktop oder in dem Order »Eigenen Dateien«). Nach einem einfachen Doppelklick auf diese .exe-Datei steht NEO in voller Funktionalität zur Verfügung! Das alles geht ohne Administratoren-Rechte und ist auf jedem Rechner sofort ausführbar.

=== Rückkehr zum normalen Tastaturlayout ===
Um kurzzeitig zwischen QWERTZ und NEO hin- und herzuwechseln, kann mit der Tastenkombination Shift+Pause das Skript pausiert bzw. wieder gestartet werden. Die Möglchkeit, Autohotkey dauerhaft zu deaktivieren, erhält man hingegen mit einem Rechtsklick auf das rote/weiße NEO-Icon im Traybereich (bei der Uhr).

=== Bildschirmtastatur oder: Wo ist bloß XYZ abgeblieben? ===
Mit den Tastenkominationen Mod4+F1 bis Mod4+F8 (Mod4 ist beim normalen Tastaturlayout die "<" Taste rechts neben der linken Großschreibetaste) erhalten sie eine graphische Zusammenfassung der Neo-Tastatur. Die erleichert das Finden eines noch nicht so vertrauten Zeichen und hilft zudem beim Erlernen des Blindschreibens, da der Blick auf den Bildschirm und nicht auf die Tastatur gerichtet ist.

=== Automatischer Start ===
Bei Bedarf kann man sich eine Verknüpfung mit neo20.exe in den Autostart-Ordner im Startmenü legen, dann hat man die Belegung direkt bei der Anmeldung. In diesem Fall sollte man jedoch auch einen Umstieg auf den nativen kbdneo2-Treiber erwägen.

=== Temporäre Dateien und gründliche Deinstallation ===
Die exe-Datei entpackt bei der ersten Ausführung Bilder für die Tray-Icons und die Bildschirmtastatur in einen NEO2-Unterordner des temporären Windows(Umgebungsvariablen-)Ordners (unter Windows XP ist dies etwa C:\Dokumente und Einstellungen\Mario Mustermann\Lokale Einstellungen\Temp\NEO2). Diese Dateien bitte während der Dateiausführung nicht verschieben oder löschen, ansonsten treten Laufzeitfehler auf.

== FAQ ==
Bei vielen Problemen hilt es weiter, ersteinmal in die allgemeine NEO-FAQ zu schauen, viele bekannte Probleme und Fragen sind dort mit entsprechendene Lösungshinweisen dokumentiert.

=== Hinweis zur Aktualität ===
Achtung: Da sich NEO in aktiven Weiterentwicklung befindet, kann es vorkommen, dass die Bildschirmtastatur oder die neo20.exe gegenüber der aktuellen Referenz leicht veraltet sind. Scheuen sie sich nicht, uns über die Homepage des NEO-Layouts Verbesserungsvorschläge zukommen zu lassen!

=== Was noch nicht funktioniert ===
Derzeitig sind erst einige wenige Compose-Funktionen im Treiber implementiert. Genaure Informationen finden sie in der Datei source\Changelog-and-Todo.ahk.


== Hinweise für Entwickler ==

=== Autohotkey herunter laden ===
Man sollte als erstes das Programm namens »Autohotkey« (http://www.autohotkey.com/download/AutohotkeyInstall.exe) herunterlanden. Es wird empfohlen, dieses Programm möglichst in dem vorgeschlagenen Standardverzeichnis zu installieren.
Wenn man jedoch über KEINE Administratorrechte verfügt, kann man das Programm jedoch beispielsweise auch in das Verzeichnis »Eigene Dateien/NEO«  (oder in ein anderes Verzeichnis, für das man Schreibrechte hat) installieren.
In diesem Fall muss dann für eine Kompilierung des Skriptes noch die Datei Build-Update.bat lokal entsprechend angepasst werden (diese lokale Änderung der Build-Update.bat aber bitte nicht einchecken, da die allermeisten Entwickler Autohotkey im vorgeschlagenen Standardverzeichnis installiert haben!).

=== Die ausführbare Datei aktualisieren ===
Um die neo20-all-in-one.exe auf den neuesten Stand zu bringen, reicht (wenn Autohotkey im Standardverzeichnis installiert wurde) ein Doppelklick auf die Batch-Datei
Build-Update.bat
Es ist empfohlen, diese Batch-Datei stets vor einem Comit auszuführen, damit die .exe-Datei stets auf dem aktuellsten Stand ist.

=== Den Sourcecode bearbeiten ===
Die Datei neo20.ahk  sollte auf keinen Fall mehr direkt bearbeitet oder gestartet werden, da sie inzwischen automatisch generiert und regelmäßig überschrieben wird.

Stattdessen müssen die Dateien/Module im Source-Unterverzeichnis bearbeitet werden, etwa:
Source\Changelog-and-Todo.ahk
Source\Keys-Neo.ahk
Source\Keys-Qwert-to-Neo.ahk
Source\Methods-Layers.ahk
Source\Methods-Lights.ahk

Um die gemachten Änderungen zu testen, sollte die Datei
Source\All.ahk
verwendet werden, die alle Module einbindet und regulär durch einen Doppelklick mit dem AHK-Interpreter gestartet werden kann.

Der grosse Vorteil dieser Methode liegt daran, dass sich die Zeilennummern eventueller Fehlermeldungen nicht mehr auf die grosse "vereinigte" AHK-Datei, sondern auf die tatsächlich relevanten Module beziehen, z.B.:
Error at line 64 in #include file "C:\...\autohotkey\Source\Methods-Lights.ahk"
Line Text: CTL_CODE_LED(p_device_type, p_function, p_method, p_access)
Error: Functions cannot contain functions.
The programm will exit.

Zudem ist angedacht, den AHK in voneinander möglichst unabhängige Teile aufzusplitten, um so die Übersichtlichkeit zu erhöhen und die Komplexität des Codes zu verringern.

=== Links zur AHK/Autohotkey-Skriptsprache ===
Eine kurze Einführung (Installation und Beispielscipt) findet man etwa auf
http://www.kikizas.net/en/usbapps.ahk.html

Eine alphabetische Liste aller erlaubten Kommandos findet man online unter
http://www.autohotkey.com/docs/commands.htm

=== Wie es funktioniert ===
Das Programm kann alle Tastendrucke abfangen und statt dessen andere Tasten  simulieren. Die Zeile
a::send b
fängt z. B. die Taste »a« ab und sendet statt dessen ein »b«. Die ahk-Dateien lassen sich mit einem Texteditor bearbeiten, man muss dann nur das Skript neu starten um die Änderungen zu übernehmen.

==== Bekannte Fehler ====
Da die Compose-Taste auf rechter Mod3 + Tab liegt, mußte die Tabulator-Taste umgemappt werden. Dadurch funktioniert leider die ShiftAltTab nicht mehr. AltTab reagiert hingegen wie gewohnt.

Bisher reagieren nur die Buchstaben der 1. und 2. Ebene richtig auf CapsLock (also immer groß schreiben – CapsLock erreicht man unter Neo, wenn man beide Shift-Tasten gleichzeitig drückt).

== Ziffernblock ==
Der Ziffernblock reagiert nicht auf Tastenkombinationen mit Strg, Alt usw.

Der Ziffernblock auf der 2. Ebene ist wahlweise
- bei AUSgeschaltetem Numlock
- bei EINgeschaltetem Numlock mit Shift
zu erreichen.
Der Ziffernblock auf der 3. Ebene funktioniert bei EINgeschaltetem Numlock mit Mod3 (Caps/#).
Der Ziffernblock auf der 4. Ebene ist wahlweise
- bei AUSgeschaltetem Numlock mit Mod3 + Shift
- bei EINgeschaltetem Numlock über Mod4
zu erreichen.
Da die 2. Ebene über Shift ebenfalls bei EINgeschaltetem Numlock funktioniert ist das Ausschalten des Ziffernblocks nicht unbedingt nötig.

==== Besonderheiten bei der ahk-Windowsversion von Neo ====
Ebene 5 des Ziffernblocks lässt sich außer über Mod3+Shift auch über
Mod4 ansprechen.

==== Warnung ====
ACHTUNG! Unter Windows ist folgendes festgelegt:
AltGr + Pos1 = Abmelden
AltGr + Ende = Computer ausschalten
--> diese Kombinationen treten auf bei AUSgeschaltetem Numlock mit Mod4.
