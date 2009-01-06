== installiere_neo ==
Das Skript ›installiere_neo‹ erlaubt eine einfache und saubere Installation von NEO
für einen Benutzer (keine root-Rechte erforderlich)


== Skriptordner in .profile eintragen ==
Der Ordner mit diesen Skripten sollte in der Variable $PATH eingetregen sein, um von überall verfügbar zu sein
Dazu sollte in der Datei ›.profile‹, die beim Login gelesen wird, folgende Zeilen eingetragen sein:
-------------------------------
# NEO:
PATH=$PATH:$(Pfad zu den Skripten)	# für NEO-Skripte wie ›asdf‹ und ›uiae‹
export PATH				# für NEO-Skripte wie ›asdf‹ und ›uiae‹
# asdf					# mit einem # am Zeilenanfang bleibt QWERTZ das Standardlayout, sonst ist es NEO
-------------------------------

Man beachte, dass die Skripte ausführbar sein müssen (chmod u+x ›Datei‹)


== uiae, asdf ==
asdf (linke Hand auf der Grundreihe abrollen) schaltet von QWERTZ zu Neo um.
uiae ( “      “   “   “       “        “    )    “      “  Neo zu QWERTZ um.

Verwendung:
asdf [Variante]
uiae [Belegung]

Bei beiden Angaben (Variante, Belegung) gelten folgende Prioritäten:
ⅰ) direkte Angabe hinter dem Skriptnamen
ⅱ) Definition in der persönlichen $HOME/.neorc
ⅲ) Definition in der systemweiten neo.conf
ⅳ) in der Skriptdatei angegebene Standardbelegung

Die Skripte ›asdf‹ und ›uiae‹ benutzten folgende Programme, die gegebenenfalls installiert werden müssen:
• numlockx
• setleds
• xset
• setxkbmap
• loadkeys (nur als root möglich)


== neo ==
Gibt die Neo-Tastaturbelegung des Buchstabenfeldes aus. Beispiele:
  »neo«		gibt die Tastaturbelegung mit allen Ebenen aus
  »neo 1«	gibt die erste Ebene der Tastaturbelegung aus
  »neo 3«	gibt die dritte Ebene der Tastaturbelegung aus
  »neo 2 3 6«	gibt die zweite, dritte und sechste Ebene aus
usw.

== num ==
Gibt die Neo-Tastaturbelegung des Ziffernblocks aus. Beispiele:
  »num« – gibt die Tastaturbelegung mit allen Ebenen aus
  »num 1« – gibt die erste Ebene der Tastaturbelegung aus
  »num 3« – gibt die dritte Ebene der Tastaturbelegung aus
  »num 2 3 6« – gibt die zweite, dritte und sechste Ebene aus
usw.


== wiemitneo ==
Gibt an, ob und wie ein Zeichen mit NEO ermöglicht werden kann.
Beispiel:  »wiemitneo @«
-------------------------------
• @ gibt es direkt auf der NEO-Tastatur:
@ erreicht man mit Mod3+y

• @ ist über Compose folgendermaßen darstellbar:
<Multi_key> + <A> + <T>
-------------------------------

== beschreibe ==
Versucht, Zeichen anhand einer Beschreibung zu erraten und ruft »wiemitneo« auf
Beispiel:  »beschreibe face«
-------------------------------
1) ☺
2) ☹
welches Zeichen suchen Sie: 1


• ☺ ist über Compose folgendermaßen darstellbar:
<Multi_key> + <colon> + <parenright>
-------------------------------


== neo-compose ==
Erstellt aus der originalen Compose und den Neo-Ergänzungen eine lokale
Compose-Datei (~/XCompose).
