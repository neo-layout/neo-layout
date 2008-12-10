= Neo 2 für FreeBSD =
Von Haus aus bringt FreeBSD Unterstützung für Neo 1 in Xorg mit. Für die
Konsole und für Neo 2 in X muss also ein Treiber installiert werden.

== Neo auf der Konsole ==
Für FreeBSD an der Konsole muss die Treiberdatei mit folgendem Befehl geladen
werden:

$ kbdcontrol -l neo.kbd

Um das Layout permanent zu verwenden lohnt es sich die neo.kbd in das
Verzeichnis für Keymaps als root-Benutzer zu plazieren:
# cp neo.kbd /usr/share/syscons/keymaps/

Trägt man dann noch keymap="neo" in /etc/rc.conf ein sollte vom nächsten
Boot an immer das richtige Layout verwenden werden.

Achtung: Momentan funktionieren die Modifier noch nicht richtig, AltGR 
erzeugt jedoch M3 sodass grundlegende Aufgaben der Systemadministration
möglich sind.

== Neo unter X ==
=== Xkb ===
Es ist möglich die "de" Datei aus linux/X in FreeBSD zu installieren. Der
Standardordner hierfür ist in den meisten Fällen
/usr/local/share/X11/xkb/symbols oder /usr/share/X11/xkb/symbols.

Auch hier ergeben sich Probleme mit den Modifiern und bisher scheinen nur
Ebene 1 und 2 verfügbar zu sein.

=== Xmodmap ===
Auch das Laden von neo_de.xmodmap ist möglich aber es ergeben sich ähnliche
Probleme wie bei Xkb.
