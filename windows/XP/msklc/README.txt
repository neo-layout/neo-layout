NEO Tastaturlayout 2.0 (Version für Windows XP)
===============================================

== Allgemeines ==
Mit dem msklc-Treiber allein stehen nur die ersten 4 Ebenen von NEO2.0 zur
Verfügung. Dies liegt an der technischen Beschränkung der Software.
Um den vollen Umfang nutzen zu können, muss ein ahk-Skript zusätzlich verwendet werden.

== Installieren (nur als Admin möglich!)  ==
Zur Installation einfach Doppelklick auf die Datei „neo20.msi“ (ggf. nur als
„neo20“ angezeigt). Anschließend in der Systemsteuerung
(Start->Einstellungen->Systemsteuerung) unter „Regions- und Sprachoptionen“ im
Reiter „Sprachen“ auf „Details“ klicken. Dort auf „Hinzufügen“ und dann unter
„Tastaturlayout/IME“ „Deutsch (NEO ergonomisch 2.0)“ auswählen. Soll NEO die
Standardbelegung sein, so nun die bisherigen alle entfernen und erneut
hinzufügen. (Falls Windows zickt, ggf. mehrfach versuchen und/oder neu
starten).

== Aktualisieren ==
Achtung: NEO 2.0 befindet sich noch in Entwicklung. Falls eine neuere Version
von NEO 2.0 installiert werden soll, so muss evtl. die bereits installierte
zunächst entfernt werden (wie oben beschrieben).
Wenn bei der Installation dennoch Probleme auftreten, muss über die System-
steuerung -> Software der Eintrag „Deutsch (NEO ergonomisch 2.0)“ gelöscht
werden.

== Modifier (AltGr und Mod5) einrichten ==
Um die Belegung der Modifier (AltGr, Mod5) zu erreichen, muss die Datei
„AltGr_Mod5_neo20.reg“ (bzw. „AltGr_Mod5_neo20“) runtergeladen und installiert
werden. Die Änderung wirkt sich erst nach einer Neuanmeldung des Benutzers
aus!
WARNUNG: Diese Änderung (der Modifier) wirkt sich auf alle Benutzer und alle
Tastaturlayouts aus!

== Deinstallation ==
Rückgängig gemacht wird die Umstellung, indem die Datei
„reset_CapsLock_AltGr.reg“ (bzw. „reset_CapsLock_AltGr“) installiert wird.
