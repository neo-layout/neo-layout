== Neo 2.0 Autohotkey-Treiber für Windows ==


== Hinweise für Nutzer ==

=== Direkte Installation === 
Einfach die Datei neo20.exe herunterladen und irgendwo speichern (bspw. auf dem Desktop oder in dem Order »Eigenen Dateien«). Nach einem einfachen Doppelklick auf diese .exe-Datei steht Neo in voller Funktionalität zur Verfügung! Das alles geht ohne Administrator-Rechte und ist auf jedem Rechner sofort ausführbar.

=== Rückkehr zum normalen Tastaturlayout ===
Um kurzzeitig zwischen QWERTZ und Neo hin- und herzuwechseln, kann mit der Tastenkombination Shift+Pause das Skript pausiert bzw. wieder gestartet werden. Gleiches erreicht man auch über einen Doppelklick auf das rote/weiße Neo-Icon im Traybereich (bei der Uhr).

=== Bildschirmtastatur oder: Wo ist bloß XYZ abgeblieben? ===
Mit den Tastenkominationen Mod4+F1 bis Mod4+F8 (Mod4 ist beim normalen Tastaturlayout AltGr oder die "<" Taste rechts neben der linken Großschreibetaste) erhält man eine graphische Zusammenfassung der Neo-Tastatur. Sie erleichert das Finden eines noch nicht so vertrauten Zeichens und hilft zudem beim Erlernen des Blindschreibens, da der Blick auf den Bildschirm und nicht auf die Tastatur gerichtet ist.

=== Globale Schalter und die Neo2.ini ===
Es besteht die Möglichkeit, beim Starten des AHK-Treibers individuelle Anfangswerte für die globalen Schalter des Programms vorzugeben.

Dies geschieht über die Konfigurationsdatei Neo2.ini (diese muss im gebräuchlichen INI-Format vorliegen, also insbesondere ANSI-kodiert sein). 
Eine Neo2.ini, die alle Werte auf die Standardwerte »ändert«, sähe etwa so aus:
[Global]
# Im folgenden gilt (soweit nicht anders angegeben) Ja = 1, Nein = 0:

ahkTreiberKombi=0
einHandNeo=0
lernModus=0
zeigeLockBox=1
UseMod4Light=1
LangSTastatur=0
DeadSilence=0
DeadCompose=0

Diese Datei muss manuell (etwa mit Notepad) in dem richtigen Verzeichnis innerhalb der Anwendungsdaten des aktuellen Nutzers angelegt werden. Unter Windows Vista ist dies etwa das Verzeichnis
C:\Users\<BENUTZERNAME>\AppData\Roaming\Neo2\Neo2.ini
unter Windows XP hingegen das Verzeichnis
C:\Dokumente und Einstellungen\<BENUTZERNAME>\Anwendungsdaten\Neo2\Neo2.ini 
usw.

=== Automatischer Start ===
Bei Bedarf kann man sich eine Verknüpfung mit neo20.exe in den Autostart-Ordner im Startmenü legen, dann hat man die Belegung direkt nach der Anmeldung. In diesem Fall sollte man jedoch auch einen Umstieg auf den nativen kbdNeo2-Treiber erwägen (der jedoch noch nicht vollständig umgesetzt ist).

=== Temporäre Dateien und gründliche Deinstallation ===
Die .exe-Datei entpackt beim Ausführen Bilder für die Tray-Icons und die Bildschirmtastatur in einen Neo2-Unterordner des temporären Windows(Umgebungsvariablen-)Ordners (unter Windows XP ist dies etwa C:\Dokumente und Einstellungen\Mario Mustermann\Lokale Einstellungen\Temp\Neo2). Diese Dateien bitte während der Dateiausführung nicht verschieben oder löschen, ansonsten können Laufzeitfehler auftreten.

=== Lang-S-Tastatur ===
Um den korrekten Satz des langen S (»?«) zu erleichtern, wurde der Lang-S-Modus geschaffen. Er ist über die Tastenkombination Mod4+F11 ein- und ausschaltbar. Er vertauscht zyklisch s ? ß ? ? ? s.

=== FAQ ===
Bei vielen Problemen hilt es weiter, zunächst in die allgemeine Neo-FAQ zu schauen; viele bekannte Probleme und Fragen sind dort mit entsprechendenen Lösungshinweisen dokumentiert.

=== Hinweis zur Aktualität ===
Achtung: Da sich Neo in aktiver Weiterentwicklung befindet, kann es vorkommen, dass die Bildschirmtastatur oder die neo20.exe mit der aktuellen Referenz (noch) nicht übereinstimmt. Scheuen Sie sich nicht, uns über die Homepage des Neo-Layouts (http://neo-layout.org) Verbesserungsvorschläge zukommen zu lassen!

=== Was noch nicht funktioniert ===
Derzeit sind erst einige wenige Compose-Funktionen im Treiber implementiert. Genauere Informationen befinden sich in der Datei Changelog-and-Todo.txt.


== Hinweise für Entwickler ==

=== AutoHotkey herunter laden ===
Man sollte als erstes das Programm namens »AutoHotkey« (http://www.autohotkey.com/download/AutoHotkeyInstall.exe) herunterlanden. Es wird empfohlen, dieses Programm möglichst in dem vorgeschlagenen Standardverzeichnis zu installieren.
Wenn man jedoch über KEINE Administratorrechte verfügt, kann man das Programm beispielsweise auch in das Verzeichnis »Eigene Dateien/Neo«  (oder in ein anderes Verzeichnis, für das man Schreibrechte hat) installieren.
In diesem Fall muss dann für eine Kompilierung des Skriptes noch die Datei Build-Update.bat lokal entsprechend angepasst werden (diese lokale Änderung der Build-Update.bat aber bitte nicht einchecken, da die allermeisten Entwickler Autohotkey im vorgeschlagenen Standardverzeichnis installiert haben!).

=== Die ausführbare Datei aktualisieren ===
Um die neo20.exe auf den neuesten Stand zu bringen, reicht (wenn Autohotkey im Standardverzeichnis installiert wurde) ein Doppelklick auf die Batch-Datei Build-Update.bat
Es ist empfehlenswert, diese Batch-Datei stets vor einem Commit auszuführen, damit die .exe-Datei immer auf dem aktuellsten Stand ist.

=== Den Sourcecode bearbeiten ===
Die Datei neo20.ahk sollte auf keinen Fall mehr direkt bearbeitet werden, da sie inzwischen automatisch generiert und regelmäßig überschrieben wird.

Stattdessen müssen die Dateien/Module im Source-Unterverzeichnis bearbeitet werden, etwa:
Source\Keys-Neo.ahk
Source\Keys-Qwert-to-Neo.ahk
Source\Methods-Layers.ahk
Source\Methods-Lights.ahk

Um die gemachten Änderungen zu testen, sollte die Datei Source\All.ahk verwendet werden, die alle Module einbindet und regulär durch einen Doppelklick mit dem AHK-Interpreter gestartet werden kann.

Der große Vorteil dieser Methode liegt darin, dass sich die Zeilennummern eventueller Fehlermeldungen nicht mehr auf die große »vereinigte« AHK-Datei, sondern auf die tatsächlich relevanten Module beziehen, z. B. :
Error at line 64 in #include file "C:\...\autohotkey\Source\Methods-Lights.ahk"
Line Text: CTL_CODE_LED(p_device_type, p_function, p_method, p_access)
Error: Functions cannot contain functions.
The programm will exit.

Zudem ist angedacht, den AHK-Treiber in voneinander möglichst unabhängige Teile aufzusplitten, um so die Übersichtlichkeit zu erhöhen und die Komplexität des Codes zu verringern.

=== Links zur AHK/Autohotkey-Skriptsprache ===
Eine kurze Einführung (Installation und Beispielskript) findet man etwa auf
http://www.kikizas.net/en/usbapps.ahk.html

Eine alphabetische Liste aller erlaubten Kommandos findet man online unter
http://www.autohotkey.com/docs/commands.htm

=== Wie es funktioniert ===
Das Programm kann alle Tastendrucke abfangen und stattdessen andere Tasten simulieren. Die Zeile
a::send b
fängt z.?B. die Taste »a« ab und sendet stattdessen ein »b«. Die AHK-Dateien lassen sich mit einem Texteditor bearbeiten, man muss dann nur das Skript neu starten, um die Änderungen zu übernehmen.

=== ... ===
