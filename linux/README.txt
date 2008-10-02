== Neo 2.0 für Linux ==
Für viele Linuxdistributionen sind hier Treiber zu finden.

=== X ===
Dieser Treiber ersetzt die veraltete Neo Version 1.0, die bei allen
Linuxdistributionen schon dabei ist. Zur sauberen Installation braucht man
Administrator-Rechte (root-Rechte).

=== xmodmap ===
Dieser Treiber nutzt das Programm xmodmap des X-Servers. Man braucht also
keine Administrator-Rechte (root-Rechte), um diesen zu nutzen. Allerdings hat
man hiermit bei der Anmeldung keine Neo-Tastaturbelegung (bei der
Passworteingabe bedenken!). Jedoch hat man hiermit den Vorteil hoher
Portabilität: Beispielsweise die Xmodmap-Datei auf einen USB-Stick kopieren
und in den fremden Linux-Rechner einstecken, schon kann man mit Neo tippen.

=== console ===
Dieser Ordner enthält eine keymap, um die NEO-Tastaturbelegung auch ohne X auf der Konsole benutzten zu können. Diese kann mithilfe einige Skripte automatisch aus der »normalen« xmodmap erstellt werden.

=== bin ===
Dieses Verzeichnis enthält einige nützliche Shell-Befehle zur Ausgabe der
Neo-Tastaturbelegung (auch einzelne Ebenen) sowie die Möglichkeit, über »uiae«
bzw. »asdf« einfach zwischen NEO und QWERT* hin- und herzuwechseln.



=== Verwenden von NEO ===
Vorab: zwischen den Strichzeilen (--------------------------) stehen Zeilen, die in Dateien stehen, dort eingegeben oder verändert werden müssen. Die Strichzeilen selbst sind jedoch nie mit einzugeben!

Diese Anleitung beschreibt am Beispiel der xmodmap, wie man NEO problemlos einrichten kann:
ⅰ) Die Verzeichnisse $HOME/neo (z.B. /home/gerhard/neo) und $HOME/neo/bin anlegen
ⅱ) die Dateien ›neo_de.xmodmap‹ und ›neo.map‹ in das Verzeichnis $HOME/neo (also z.B. /home/gerhard/neo) legen
ⅲ) die Skripte ›asdf‹ und ›uiae‹ in das Verzeichnis $HOME/neo/bin legen und ausführbar machen mit:
  chmod u+x asdf && chmod u+x uiae
ⅳ) in der Datei ›.profile‹ (zu finden im Homeverzeichnis) folgende Zeilen hinzufügen:
  --------------------------
  # Neo:
  PATH=$PATH:$HOME/neo/bin
  export PATH
  asdf xmodmap
  --------------------------
ⅴ) in der Datei ›.bashrc‹ (zu finden im Homeverzeichnis) (die Bash ist die Standardshell unter den meisten Linuxen) folgende Zeile hinzufügen
  --------------------------
  # Neo:
  alias asdf="/home/pascal/neo/bin/asdf xmodmap"
  --------------------------
ⅵ) alternativ zu ⅴ) kann in der Datei ›asdf‹ die Standardbelegung auf „xmodmap“ geändert werden
  --------------------------
  NEO_X_VARIANTE="xmodmap"
  --------------------------


=== NEO in der Textkonsole ===
Zunächst werden die gleichen Schritte wie im Abschnitt „Verwenden von NEO“ durchgeführt!
Insbesondere muss die Datei ›neo.map‹ unter $HOME/neo und die Dateien ›asdf‹ und ›uiae‹ under $HOME/neo/bin liegen! 

Um zu vermeiden, dass Linux durch irgend einen Benutzer unbedienbar gemacht werden kann, darf nur root die Belegung der Textkonsole ändern.
• Soll NEO nur für den eigenen Benutzer verfügbar gemacht werden, ist das Vorgehen identisch zum Abschnitt „Verwenden von NEO“. Es ist darauf zu achten, dass das Benutztername und Passwort unter qwertz eingegeben werden müssen. Nach dem Login wird man aufgefordert, das root-Passwort einzugeben (ebenfalls unter qwertz). Dadurch wird NEO automatisch aktiviert.
• Soll NEO systemweit auf der Textkonsole zur Verfügung stehen, muss in der Datei ›/etc/sysconfig/keyboard‹ die Zeile (oder eine ähnlich klingende):
  --------------------------
  KEYTABLE="de-latin1-nodeadkeys.map.gz"
  --------------------------
ersetzen durch:
  --------------------------
  # KEYTABLE="de-latin1-nodeadkeys.map.gz"
  KEYTABLE="/home/gerhard/neo/neo"
  --------------------------
Statt /home/gerhard ist das eigene Homeverzeichnis einzugeben. Dadurch wird auf die Datei ›neo.map‹ verwiesen, die zuvor nach $HOME/neo gelegt wurde.
