## Neo in der Textkonsole (ohne X)
Die Datei neo.map enthält eine keymap, um die Neo-Tastaturbelegung auch ohne X
auf der Konsole benutzten zu können.

Dazu wird die keymap (nur als root möglich!!) mit »loadkeys PFAD/neo.map«
geladen.
Mit »loadkeys -d« wird wieder die Standardbelegung verwendet.

Der einfachste Weg ist jedoch die Verwendung des Skriptes ›asdf‹ (siehe Ordner
/linux/bin)


### Technische Hinweise
Soll Neo systemweit auf der Textkonsole zur Verfügung stehen, muss in der
Datei ›/etc/sysconfig/keyboard‹ die Zeile (oder eine ähnlich klingende):
```
KEYTABLE="de-latin1-nodeadkeys.map.gz"
```

ersetzen durch:
```
# KEYTABLE="de-latin1-nodeadkeys.map.gz"
KEYTABLE="/home/gerhard/neo/neo"
```

Statt /home/gerhard ist das eigene Homeverzeichnis einzugeben. Dadurch wird auf
die Datei ›neo.map‹ verwiesen, die zuvor nach $HOME/neo gelegt wurde.

Dennoch kann man mit »loadkeys -d« zur Standardbelegung wechseln, da diese als
defkeymap.map laut manpage unter /usr/share/keymaps oder
/usr/src/linux/drivers/char, bei mir aber unter /etc liegt.

Ergänzung: die keymaps liegen in folgenden Verzeichnissen:
- OpenSuSe: /usr/share/kbd/keymaps/i386/
- Gentoo, Ubuntu: /usr/share/keymaps/i386/
- Fedora, Red Hat: /lib/kbd/keymaps/i386/


### Unterstützte Funktionalität
Was schon geht:
- Prinzipiell gehen alle 6 Ebenen, auch wenn seltene Zeichen mit der
  Konsolenschriftart nicht dargestellt werden können.
- Die Konsolen-Compose-Kombinationen sind möglich.

Was (noch) nicht geht:
- Siehe im Quellcode der neo.map

