/*
    Titel:        NEO 2.0 beta Autohotkey-Treiber
    $Revision:    624 $
    $Date:        2008-07-08 18:50:00 +0200 (Di, 07 Jul 2008) $
    Autor:        Stefan Mayer <stm (at) neo-layout.org>
    Basiert auf:  neo20-all-in-one.ahk vom 29.06.2007
        
    TODO:         - ausgiebig testen... (besonders Vollständigkeit bei Deadkeys)
                  - Bessere Lösung für das leeren von PriorDeadKey finden, damit die Sondertasten
                    nicht mehr abgefangen werden müssen.
                  - Testen ob die Capslocklösung (siehe *1:: ebene 1) auch für Numpad gebraucht wird
                  - Sind Ebenen vom Touchpad noch richtig?
                  - Die Bildschirmtastatur mit Mod4 deaktiviert den Mod4-Lock
    
    Ideen:        - Symbol ändern (Neo-Logo abwarten)
                  - bei Ebene 4 rechte Hand (Numpad) z.B. Numpad5 statt 5 senden

    CHANGEHISTORY:

                  Revision 624(von Martin Roppelt):
                  - Lang-s-Tastatur (ein- und auszuschalten durch Mod4+ß)
                  Revision 616 (von Dennis Heidsiek):
                  - Der nicht funktionierende Mod5-Lock-Fix wurde wieder entfernt, da
                    er sogar neue Fehler produzierte.
                  Revision 615 (von Dennis Heidsiek):
                  - Erfolgloser Versuch, den Mod4-Lock wiederherzustellen
                    (durch eine Tilde vor den Scancodes der Bildschirmtastatur).
                  - Rechtschreibfehler korrigiert.
                  - Zwei AHK-Links eingefügt.
                  Revision 609 (von Dennis Heidsiek):
                  - Vorläufiger Abschluss der AHK-Modularisierung.
                  - Bessere Testmöglichkeit »All.ahk« für AHK-Entwickler hinzugefügt, bei der
                    sich die Zeilenangaben in Fehlermeldungen auf die tatsächlichen Module und
                    nicht auf das große »vereinigte« Skript beziehen.
                  Revision 608 (von Martin Roppelt):
                  - Rechtschreibfehler korrigiert und Dateinamen aktualisiert und sortiert.
                  Revision 590 (von Dennis Heidsiek):
                  - Erste technische Vorarbeiten zur logischen Modularisierung des viel
                    zu lange gewordenen AHK-Quellcodes.
                  - Neue Batch-Datei Build-Update.bat zur einfachen Aktualisierung der EXE-Datei
                  Revision 583 (von Dennis Heidsiek):
                  - Kleinere Korrekturen (Mod3+Numpad5, Mod5+Numpad5 und Mod3+Numpad9
                    stimmen wieder mit der Referenz überein).
                  Revision 580 (von Matthias Berg):
                  - Bildschirmtastatur jetzt mit Mod4+F* statt Strg+F*, dies deaktiviert
                    jedoch leider den Mod4-Lock
                  Revision 570 (von Matthias Berg):
                  - Hotkeys für einHandNeo und lernModus durch entsprechende ScanCodes ersetzt 
                  Revision 568 (von Matthias Berg):
                  - Sonderzeichen, Umlaute, z und y durch ScanCodes ersetzt
                    * jetzt wird auch bei eingestelltem US Layout Neo verwendet.
                      (z.B. für Chinesische InputMethodEditors)
                    * rechter Mod3 geht noch nicht bei US Layout (weder ScanCode noch "\")
                  Revision 567 (von Dennis Heidsiek):
                  - Aktivierter Mod4 Lock wird jetzt über die Rollen-LED des Keybord angezeigt
                    (analog zu CapsLock), die NUM-LED behält ihr bisheriges Verhalten
                  - Neue Option im Skript: UseMod4Light
                  Revision 561 (von Matthias Berg):
                  - Ebene 4 Tab verhält sich jetzt wie das andere Tab dank "goto neo_tab"
                  Revision 560 (von Dennis Heidsiek):
                  - Neue Option im Skript: bildschirmTastaturEinbinden bindet die PNG-Bilder der
                    Bildschirmtastur mit in die exe-Datei ein, so dass sich der Benutzer nur eine Datei
                    herunterladen muss
                  Revision 559 (von Matthias Berg):
                  - Shift+Alt+Tab Problem gelöst (muss noch mehr auf Nebeneffekte getestet werden)
                  Revision 558 (von Matthias Berg):
                  - Icon-Bug behoben
                    * Hotkeys dürfen nicht vor der folgenden Zeile stehen:
                     "menu, tray, icon, neo.ico,,1"
                  - lernModus-Konfigurations-Bug behoben: or statt and(not)
                  - Ein paar leere Else-Fälle eingebaut (Verständlichkeit, mögliche Compilerprobleme vermeiden)   
                  Revision 556 (von Matthias Berg):
                  - lernModus (an/aus mit Strg+Komma)
                    * im Skript konfigurierbar
                    * Schaltet z.B. Qwertz Tasten aus, die es auf der 4. Ebene gibt (Return, Backspace,...)
                    * Kann auch Backspace und/oder Entfernen der 4. Ebene ausschalten (gut zum Lernen richtig 
                      zu schreiben)
                  - Bug aufgetaucht: Icons werden nicht mehr angezeigt
                  Revision 544 (von Stefan Mayer):
                  - ,.:; auf dem Mod4-Ziffernblock an die aktuelle Referenz angepasst
                  - Versionen von rho, theta, kappa und phi an die aktuelle Referenz angepasst
                  Revision 542 (von Matthias Berg):
                  - bei EinHandNeo ist jetzt Space+y auch Mod4
                  - AltGr-Bug  hoffentlich wieder behoben. Diesmal mit extra altGrPressed Variable
                  - nurEbenenFuenfUndSechs umbenannt in ahkTreiberKombi und auf Ebene 4 statt 5 und 6 geändert
                  Revision 540 (von Matthias Berg):
                  - stark überarbeitet um Wartbarkeit zu erhöhen und Redundanz zu veringern
                  - nurEbenenFuenfUndSechs sollte nun auch auf Neo Treiber statt Qwertz laufen
                    * aber es muss noch jemand testen
                    * Problem: was kann man abfangen, wenn eine tote Taste gedrückt wird
                 - einHandNeo:
                    * An-/Ausschalten mit STRG+Punkt
                    * Buchstaben der rechten Hand werden mit Space zur linken Hand
                    * Nebeneffekt: es gibt beim Festhalten von Space keine wiederholten Leerzeichen mehr
                  Revision 532 (von Matthias Berg):
                  - BildschirmTastatur 
                    * aktiviert mit strg+F1 bis 7 schaltet Keyboard ein oder aus
                    * strg+F7 zeigt die zuletzt angezeigte Ebene an (und wieder aus).
                    * strg+F8 schaltet AlwaysOnTop um    
                  Revision 529 (von Stefan Mayer):
                  - Icon wird automatisch geladen, falls .ico-Dateien im selbem Ordner
                  - in der .exe sind die .ico mitgespeichert und werden geladen
                  Revision 528 (von Matthias Berg):
                  - Neo-Icon
                  - Neo-Prozess jetzt automatisch auf hoher Prioritaet
                    (siehe globale Schalter)
                  - Mod3-Lock (nur wenn rechtes Mod3 zuerst gedrückt wird, andere Lösung führte zum Caps-Bug)
                  - Mod4-Lock (nur wenn das linke Mod4 zuerst gedrückt wird, andere Lösung fühte zum AltGr-Bug)
                  - Ein paar falsche Zeichen korrigiert
                  Revision 527 (von Matthias Berg):
                  - AltGr Problem hoffentlich behoben
                  - Umschalt+Mod4 Bug behoben
                  Revision 526 (von Matthias Berg):
                  - Ebenen 1 bis 4 ausschalten per Umschalter siehe erste Codezeile
                     nurEbenenFuenfUndSechs = 0
                  - Mod4-Lock durch Mod4+Mod4
                  - EbenenAktualisierung neu geschrieben
                  - Ebene 6 über Mod3+Mod4
                  - Ebenen (besonders Matheebene) an Referenz angepasst
                    (allerdings kaum um Ebenen 1&2 gekümmert, besonders Compose könnte noch überholt werden)
                  Revision 525 (von Matthias Berg):
                  - Capslock bei Zahlen und Sonderzeichen berücksichtigt
                  Revision 524 (von Matthias Berg):
                  - umgekehrtes ^ für o, a, ü,i  sowie für die grossen vokale ( 3. ton chinesisch)
                    • damit wird jetzt PinYin vollständig unterstützt caron, macron, akut, grave auf uiaeoü
                  - Sonderzeichen senden wieder blind -> Shortcuts funktionieren, Capslock ist leider Shiftlock
                  Revision 523 (von Matthias Berg):
                        - CapsLock geht jetzt auch bei allen Zeichen ('send Zeichen' statt 'send {blind} Zeichen')
                  - vertikale Ellipse eingebaut
                  - Umschalt+Umschalt für Capslock statt Mod3+Mod3
                  - bei Suspend wird jetzt wirklich togglesuspend aufgerufen (auch beim aktivieren per shift+pause)
                  Revsion 490 (von Stefan Mayer): 
                  - SUBSCRIPT von 0 bis 9 sowie (auf Ziffernblock) + und -
                    • auch bei Ziffernblock auf der 5. Ebene
                  - Kein Parsen über die Zwischenablage mehr
                  - Vista-kompatibel
                  - Compose-Taste
                    • Brüche (auf Zahlenreihe und Hardware-Ziffernblock)
                    • römische Zahlen
                    • Ligaturen und Copyright
*/


