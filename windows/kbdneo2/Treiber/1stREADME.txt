== Installation der Windows-Treiber ==
Zur Zeit gibt es leider noch keine eigene Installationsroutine für diese Treiber.
Deshalb muss der Treiber noch von Hand registriert werden.

Installation:
1.) reg_backup.bat ausführen.
    Dies sichert einen bereits vorhandenen Schlüssel. Wenn der Schlüssel bislang
    noch nicht vorhanden war wird auch keine Sicherungsdatei angelegt.
2.) kbdneo2.dll (Windowsversion beachten) nach \%SystemRoot%\system32\ (in der
    Regel C:\Windows\system32\) kopieren.
3.) kbdneo2_install.reg ausführen.
4.) Nun kann das in den Sprachoptionen Neo 2.0 ausgewählt werden. D(Start->
    Einstellungen->Systemsteuerung) unter »Regions- und Sprachoptionen«-> Reiter
    »Sprachen« -> »Details« -> »Hinzufügen« -> »Tastaturlayout/IME« -> »Deutsch
    (NEO ergonomisch 2.0)« hinzugefügt werden.

Deinstallation:
1.) Neo 2.0 nicht mehr als Tastaturlayout verwenden. Dazu das Layout in den
    »Regions- und Sprachoptionen« entfernen.
2.) kbdneo2_uninstall.reg ausführen. Hierbei werden alle vorgenommenen Einträge in
    der Registry gelöscht.
3.) Falls vorhanden die gesicherten Schlüssel zurückspielen (backup1.reg,
    backup2.reg und backup3reg – soweit vorhanden – ausführen)

Je nach Windows-Version sind für die einzelnen Schritte Administrator-Rechte nötig.


== Einschränkungen dieser Treiberversion ==
1.) Einige spezielle Funktionen lassen sich nicht belegen und sind deshalb nicht
    verfügbar.
    Dazu gehören leider die Pfeiltasten, Entf, Seite hoch/runter, Einfg, Pos1 und
    Ende.
2.) Ein Einrasten von Modifiern ist treibertechnisch leider nicht möglich.
3.) Die Kombo-/Komponier-/Compose-Taste wird von Windows nicht unterstützt.

Diese Mängel sollen durch einen spezielle AutoHotKey-Treiber noch behoben werden.


== Entfernen einer evtl. vorhandenen MSKLC-Treibers ==
1. Setup des MSKLC aufrufen
2. »Remove the keyboard layout« auswählen und mit »Finish« bestätigen.


== NEO auf dem Benutzerkonto-Anmeldebildschirm verfügbar machen (Vista) ==
Vista erlaubt jedem Benutzer, die Regions- Sprachoptionen individuell anzupassen. Allerdings ist der Zugriff auf Systemkonten aus Sicherheitsgründen beschränkt, deshalb müssen die Einstellungen manuell und mit Adminrechten auf das allgemeine Systemkonto übertragen werden: 

Start / Systemsteuerung / Regions- und Sprachoptionen / Reiter »Verwaltung« / Button »Zu reservierten Konten kopieren« / »Systemkonten« markieren / OK

Ausführlich steht das ganze in der Windows-Hilfe unter dem Titel »Ändern des Tastaturlayouts«.

