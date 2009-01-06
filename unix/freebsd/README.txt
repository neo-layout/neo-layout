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

=== Hinweis ===
FreeBSD sieht nicht vor dass UTF-8 an der regulären Konsole verwendet wird.
Dadurch ist es nicht möglich die meisten Sonderzeichen die Neo erlaubt zu
implementerien. Einige ISO-8859 Zeichen, wie Umlaute und Akzentvokale, sind
implementiert aber ein grosser Teil von Neo ist hier nicht zugänglich ohne
grundlegender Überarbeitung des Konsolenmodus unter FreeBSD. Dieser Treiber
ist also nicht als vollständiger Ersatz gedacht, sondern nur um grundlegende
Systemadministration durch Ebene 1-3 möglich zu machen ohne in X zu wechseln.

Dies trifft nicht zu wenn ein Terminalfenster (lokal oder entfernt) unter
X verwendet wird. Das korrekte Charset zu setzen bleibt aber nicht aus.

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

== Todo  ==

* Funktionierender X-Treiber
* Test der Treiber auf Systemen die auf FreeBSD beruhen wie PC-BSD, etc
