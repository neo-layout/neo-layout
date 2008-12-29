# Parser für die NEO-Referenz, erzeugt eine YAML-Datei.
# Copyright 2008 Martin Roppelt
# E-Mail: m.p.roppelt@web.de

# This file is part of the German NEO-Layout Version 2.
# German NEO-Layout Version 2 is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
# You should have received a copy of the GNU General Public License along with German NEO-Layout Version 2.  If not, see <http://www.gnu.org/licenses/>.

import io, yaml

a = [[0, 2, 6], [1, 5, 7]]

try:
    # s: Quelldatei (source) öffnen:
    s = io.open('../A-REFERENZ-A/neo20.txt', 'r', 2, 'utf8').readlines()
    # g: Wörterbuch-Datei (Gerüst) öffnen:
    g = yaml.load(open('ref.skel'))
    
    # Tastaturfelder parsen:
    # Erzeuge Liste für die Tastaturfelder:
    # d: Liste der kombinierten Tastaturfelder („Alle Ebenen“)
    # m: Liste der Mini-Tastaturfelder
    d = m = [[], []]
    # Durchlaufe Tastaturfelder („Alle Ebenen“):
    # f: Iterator Tastaturfeld (field)
    # q: Feld der Such-Schlüssel (query)
    q = ['Ha', 'Za']
    for f in range(2):
        # Bestimme Zeile l (line): Position des Schlüssels q[f] in der Quelldatei (Beginn des Tastaturfeldes)
        l = s.index(g[q[f]])
        # Durchlaufe die Tastaturreihen:
        # r: Iterator Tastaturreihe (row)
        for r in range(6):
            # Erzeuge Liste für Tastaturreihe:
            d[f].append([])
            # Erzeuge Liste für die zeilenweise Beschriftung der Tasten der Tastaturreihe:
            z = [[], []]
            # i: Iterator Tastenzeile (iterator)
            for i in range(2):
                z[i] = s[l + (r + 1) * 3 - 1 -i].split(u'│')[1:-1]
            # Wenn die Zeilen einer Tastenreihe nicht gleich viele Tasten enthalten, gebe eine Fehlermeldung aus und beende das Skript:
            if len(z[0]) != len(z[1]):
                print u'Die Zeilen der %s. Reihe im Feld »%s« enthalten unterschiedlich viele Tasten!' % (1 + r, f)
                quit()
            # Durchlaufe die Zeilen der Tastaturreihe:
            # k: Iterator Tasten (key)
            for k in range(len(z[0])):
                # Erzeuge Wörterbuch für Taste:
                d[f][r].append({})
                # Schreibe Vollbreite der Taste:
                d[f][r][k]['v'] = len(z[0][k])
                # Wenn die Breite der Taste 5 bzw 7 ist (Normale Taste),
                #   schreibe die Zeichen der Ebenen der Taste:
                #   schreibe die Beschriftung der Taste:
                if len(z[0][k]) == 5 + 2 * f:
                    # i: Iterator Tastenzeile
                    for i in range(2):
                        # j: Iterator Ebene
                        for j in range(3):
                            # Erzeuge Wörterbuch für Ebene der Taste:
                            d[f][r][k][1 + i * 3 + j] = {}
                            if f:
                                if z[i][k][0] == ' ' and z[i][k][-1] == ' ':
                                    d[f][r][k][1 + i * 3 + j]['i'] = z[i][k][j * 2 + 1]
                                else:
                                    d[f][r][k][1 + i * 3 + j]['i'] = z[i][k][a[0][j]: a[1][j]]
                            else:
                                d[f][r][k][1 + i * 3 + j]['i'] = z[i][k][j * 2]
                    # Kopiere das Zeichen der 1. Ebene in die Beschriftung der Taste:
                    # d[f][r][k]['i'] = d[f][r][k][1]['i']
                else:
                    d[f][r][k]['i'] = z[1][k] + z[0][k]
    
    yaml.dump(d, open('ref.parse', 'w'))
except IOError:
    print "I/O-Fehler"
except yaml.YAMLError, exc:
    if hasattr(exc, 'problem_mark'):
        mark = exc.problem_mark
        print "YAML-Parserfehler: (%s:%s)" % (mark.line+1, mark.column+1)
