## installiere_neo
Das Skript ›installiere_neo‹ erlaubt eine einfache und saubere Installation von Neo
für einen Benutzer (keine root-Rechte erforderlich).


## Skriptordner in .profile eintragen
Der Ordner mit diesen Skripten sollte in der Variable $PATH eingetregen sein, um von überall verfügbar zu sein
Dazu sollte in der Datei ›.profile‹, die beim Login gelesen wird, folgende Zeilen eingetragen sein:
```
# Neo:
PATH=$PATH:$(Pfad zu den Skripten)	# für Neo-Skripte wie ›asdf‹ und ›uiae‹
export PATH				# für Neo-Skripte wie ›asdf‹ und ›uiae‹
# asdf					# mit einem # am Zeilenanfang bleibt Qwertz das Standardlayout, sonst ist es Neo
```

Man beachte, dass die Skripte ausführbar sein müssen (chmod u+x ›Datei‹)


## uiae, asdf
asdf (linke Hand auf der Grundreihe abrollen) schaltet von Qwertz zu Neo um.  
uiae (linke Hand auf der Grundreihe abrollen) schaltet von Neo zu Qwertz um.

Verwendung:
```
asdf [Variante]
uiae [Belegung]
```

Bei beiden Angaben (Variante, Belegung) gelten folgende Prioritäten:
  1. direkte Angabe hinter dem Skriptnamen
  1. Definition in der persönlichen $HOME/.neorc
  1. Definition in der systemweiten neo.conf
  1. in der Skriptdatei angegebene Standardbelegung

Die Skripte ›asdf‹ und ›uiae‹ benutzten folgende Programme, die gegebenenfalls installiert werden müssen:
- numlockx
- setleds
- xset
- setxkbmap
- loadkeys (nur als root möglich)


## neo
Gibt die Neo-Tastaturbelegung des Buchstabenfeldes aus. Beispiele:
| Befehl | Ausgabe |
| --- | --- |
|  `neo`       | gibt die Tastaturbelegung mit allen Ebenen aus
|  `neo 1`     | gibt die erste Ebene der Tastaturbelegung aus
|  `neo 3`     | gibt die dritte Ebene der Tastaturbelegung aus
|  `neo 2 3 6` | gibt die zweite, dritte und sechste Ebene aus
usw.

## num
Gibt die Neo-Tastaturbelegung des Ziffernblocks aus. Beispiele:
| Befehl | Ausgabe |
| --- | --- |
|  `num`       | gibt die Tastaturbelegung mit allen Ebenen aus
|  `num 1`     | gibt die erste Ebene der Tastaturbelegung aus
|  `num 3`     | gibt die dritte Ebene der Tastaturbelegung aus
|  `num 2 3 6` | gibt die zweite, dritte und sechste Ebene aus
usw.


## wiemitneo
Gibt an, ob und wie ein Zeichen mit Neo ermöglicht werden kann.

Beispiel:  »wiemitneo @«
```
• @ gibt es direkt auf der Neo-Tastatur:
@ erreicht man mit Mod3+y

• @ ist über Compose folgendermaßen darstellbar:
<Multi_key> + <A> + <T>
```

## beschreibe
Versucht, Zeichen anhand einer Beschreibung zu erraten und ruft »wiemitneo« auf.

Beispiel:  »beschreibe face«
```
1) ☺
2) ☹
welches Zeichen suchen Sie: 1


• ☺ ist über Compose folgendermaßen darstellbar:
<Multi_key> + <colon> + <parenright>
```

## neo-compose
Erstellt aus der originalen Compose und den Neo-Ergänzungen eine lokale
Compose-Datei (~/XCompose).
