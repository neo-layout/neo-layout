== Neo 2.0 für Linux ==
Für viele Linuxdistributionen sind hier Treiber zu finden.

=== X ===
Dieser Treiber ersetzt die veraltete Neo Version 1.0, die bei allen
Linuxdistributionen schon dabei ist. Zur sauberen und systemweiten Installation
braucht man Administrator-Rechte (root-Rechte).

=== xmodmap ===
Dieser Treiber nutzt das Programm xmodmap des X-Servers. Man braucht also
keine Administrator-Rechte (root-Rechte), um diesen zu nutzen. Allerdings hat
man hiermit bei der Anmeldung keine Neo-Tastaturbelegung (bei der
Passworteingabe bedenken!).
Vorteile der Xmodmap sind:
• hoher Portabilität: 
  Beispielsweise die Xmodmap-Datei auf einen USB-Stick kopieren und in den
  fremden Linux-Rechner einstecken, schon kann man mit Neo tippen.
• einfache Installation:
  für einen Benutzer kann NEO komplett und sauber durch das Skript ›installiere_neo‹
  zum Testen und zur permanenten Benutzung eingerichtet werden.

=== console ===
Dieser Ordner enthält eine keymap, um die NEO-Tastaturbelegung auch ohne X auf
der Konsole benutzten zu können. Diese kann mithilfe von Skripten automatisch
aus der »normalen« xmodmap erstellt werden.

=== bin ===
Dieses Verzeichnis enthält einige nützliche Shell-Befehle zur Ausgabe der
Neo-Tastaturbelegung (auch einzelne Ebenen) sowie die Möglichkeit, über ›uiae‹
bzw. ›asdf‹ einfach zwischen NEO und QWERT* hin- und herzuwechseln.


=== Verwenden von NEO ===
Ein einfacher Weg, NEO unter dem eigenen Benutzer zu testen oder zu verwenden, ist,
die Datei ›installiere_neo‹ herunterzuladen, ausführbar zu machen und auszuführen:

wget http://neo-layout.org/installiere_neo
chmod u+x installiere_neo
./installiere_neo

Die Installation stellt mehrere Optionen vor – u.a. NEO nur zu testen, die
Standartbelegung aber bei QWERTZ zu belassen.

Der Vorteil von ›installiere_neo‹ ist, dass NEO im vollem Umfang genutzt wird;
dazu zählt z.B.: NEO-Tastaturbelegung, Compose-Erweiterung von NEO, Skripte
zum Darstellen der NEO-Belegung und zum leichten Wechel zwischen NEO und QWERTZ

Ein weiter Aufruf von ›installiere_neo‹ bietet u.a. die Optionen, NEO gänzlich
vom eigenen System zu entfernen, sofern NEO zuvor auch mit ›installiere_neo‹
eingerichtet worden ist.
