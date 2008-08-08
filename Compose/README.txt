== Ergänzungen der Compose-Datei unter Linux/BSD ==
Die Datei Compose.neo enthält Ergänzungen von Tastenkombinationen für die
Compose-Taste bzw. tote Tasten für Linux.

Die Kombinationen der gängigien Compose verändert NEO im Sinne erhaltender 
Kompatibilität nicht!

=== Bereits vorhandene Tastenkombinationen (unter Linux) ===
Diese sind in der Datei en_US.UTF-8 gesammelt und hier im SVN für die
Windows-Nutzer lokal gespiegelt.

Im Internet gibt es die stets aktuellste Originaldatei unter
  http://cvsweb.xfree86.org/cvsweb/xc/nls/Compose/en_US.UTF-8?rev=
   HEAD&content-type=text/vnd.viewcvs-markup

Unter Linux (beispielsweise unter Fedora) ist die zu ergänzende Datei auch
direkt verfügbar unter
  /usr/share/X11/locale/en_US.UTF-8/Compose

=== Installation/Anleitung zur Benutzung ===
==== Mit Root-/Administrator-Rechten ====
Um die Ergänzungen zu benutzen muss man den Inhalt der Compose.neo in die
vorhandene Compose einfügen bzw. die Datei Compose.neo an die alte Compose
anhängen. So geht das:
cp /usr/share/X11/locale/en_US.UTF-8/Compose \
/usr/share/X11/locale/en_US.UTF-8/Compose.original
cat /usr/share/X11/locale/en_US.UTF-8/Compose.original Compose.neo > \
/usr/share/X11/locale/en_US.UTF-8/Compose

==== Ohne Root-Rechte/lokal ====
Einfach den Inhalt der originalen Compose-Datei und die Compose.neo in eine
Datei namens ~/.XCompose (also im HOME-Verzeichnis) kopieren. So geht das:
cat /usr/share/X11/locale/en_US.UTF-8/Compose Compose.neo > ~/.XCompose

==== Gnome macht Probleme ====
Wenn man unter Gnome Kombinationen wie ^+1, ^+2 oder ^+3 eingibt, erscheinen
die entsprechenden Hochgestellten ¹²³. Aber mit ^+4, ^+5 geht das nicht. Ebenso
mit viele anderen eingentlich definierten Kombinationen. Das liegt daran, dass
Gnome da noch irgendwas eigenes vorschaltet. Aber nach:
  export GTK_IM_MODULE=xim
klappt auch das. Siehe auch:
  https://help.ubuntu.com/community/ComposeKey
Zudem scheint dieses Problem in aktuellen Gnome-Version behoben worden zu sein:
  http://blogs.gnome.org/simos/2008/01/30/improving-input-method-support-in-gtk-
   based-apps/
  http://blogs.gnome.org/simos/2008/03/05/testing-the-updated-im-support-in-gtk/

=== compose_und_deadkeys.txt ===
Die Datei compose_und_deadkeys.txt fasst Änderungs- und Erweiterungsvorschläge
für die Compose-Datei zusammen, in der unter Linux auch die Deadkeys (tote
Tasten) definiert sind.


=== Zusätzliche Compose-Kombinationen (Cokos) ===
Im dem Archiv »Numericals.tar.bz2« befinden sich optionale Compose-Kombinationen für Römische (r1-r3999, R1-R3999) und klingonische Zahlen (k1-k-3999). Diese können – wenn gewünscht – wie oben beschrieben installiert werden. Ist die eingegebene Zahl nicht vierstellig, muss die Eingabe mit einem <SPACE> terminiert werden.

Beispiele:
<Multi_key> <R> <1> <9> <9> <9> : "ⅯⅭⅯⅩⅭⅠⅩ" # ROMAN NUMERAL 1999
<Multi_key> <r> <1> <9> <9> <9> : "ⅿⅽⅿⅹⅽⅰⅹ" # SMALL ROMAN NUMERAL 1999
<Multi_key> <k> <1> <9> <9> <9> : "wa'SaD Hutvatlh HutmaH Hut" # KLINGON NUMERAL 1999
<Multi_key> <R> <8> <SPACE> : "ⅤⅠⅠⅠ" # ROMAN NUMERAL 8

