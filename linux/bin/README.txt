== uiae, asdf ==
asdf (linke Hand auf der Grundreihe abrollen) schaltet von QWERTZ zu Neo um.
uiae ( “      “   “   “       “        “    )    “      “  Neo zu QWERTZ um.

Verwendung:
asdf [Variante] (Standard wird in der Datei definiert)
uiae [Belegung] (Standard wird in der Datei definiert)

== neo ==
Gibt die Neo-Tastaturbelegung des Buchstabenfeldes aus. Beispiele:
  »neo« – gibt die Tastaturbelegung mit allen Ebenen aus
  »neo 1« – gibt die erste Ebene der Tastaturbelegung aus
  »neo 3« – gibt die dritte Ebene der Tastaturbelegung aus
  »neo 2 3 4« – gibt die zweite, dritte und vierte Ebene aus
usw.

== num ==
Gibt die Neo-Tastaturbelegung des Ziffernblocks aus. Beispiele:
  »num« – gibt die Tastaturbelegung mit allen Ebenen aus
  »num 1« – gibt die erste Ebene der Tastaturbelegung aus
  »num 3« – gibt die dritte Ebene der Tastaturbelegung aus
  »num 2 3 4« – gibt die zweite, dritte und vierte Ebene aus
usw.

== wiemitneo ==
Gibt an, ob und wie ein Zeichen mit NEO ermöglicht werden kann. Beispiele:
  »wiemitneo @« ergibt:
-------------------------------
@ erreicht man mit Mod3+y

Außerdem ist @ über Compose folgendermaßen darstellbar:
<Multi_key> + <A> + <T>
-------------------------------

== beschreibe ==
Versucht, Zeichen anhand einer Beschreibung zu erraten und ruft »wiemitneo« auf

== neo-compose ==
Erstellt aus der originalen Compose und den Neo-Ergänzungen eine lokale
Compose-Datei (~/XCompose).
