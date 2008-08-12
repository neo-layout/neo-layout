
     Treiber zur Benutzung einer PLUM-Tastatur als Matrixtastatur
               Hans-Christoph Wirth <hcw*at*gmx*dot*de>

* Was ist eine PLUM-Tastatur?

  Der interessante Aspekt ist die physikalische Anordnung der Tasten.
  Während bei einer herkömmlichen Tastatur die Reihen horizontal
  gegeneinander versetzt liegen, bildet die PLUM-Tastatur eine Matrix,
  d.h. die Tastenspalten liegen streng gerade untereinander.

  Für uns an der PLUM-Tastatur weniger interessant ist die Belegung
  der Tasten, die in der oberen Reihe das Wort PLUM und auf der
  Grundlinie die Wörter READONTHIS bildet.

  Die Tastatur ist günstig und preiswert bei www.plum.bz zu beziehen
  und wird per USB-Kabel angeschlossen.

* Wofür brauche ich einen Treiber?

  Das PLUM-Layout ist fest verdrahtet, d.h. die Tastatur sendet
  verdrehte Scancodes.  Um ein Layout, welches auf einer herkömmlichen
  105-Tasten-PC-Tastatur läuft, mit der Plum-Tastatur zu nutzen,
  müssen die verdrehten Scancodes angepasst werden.

* Kann ich PLUM nur mit NEO nutzen?

  Die Nutzung ist völlig unabhängig von dem gewählten Layout.  Der
  Treiber sorgt nur dafür, dass sich die PLUM-Tastatur möglichst so
  verhält wie eine klassische QWERT-Tastatur.

* Welche Einschränkungen bestehen?

  Die PLUM-Tastatur hat weniger Tasten, und manche müssen umgeordnet
  werden, damit das Blindschreiben im Zentralen weiterhin ermöglicht
  wird.  Im Einzelnen:

  - die Taste '^' links von der '1' wandert neben die rechte
    Shifttaste
  - die Taste '<' zwischen Shift und 'y' wandert nach unten
  - es gibt keine linke Windowstaste und keine Menü-Taste mehr
  - die Taste 'return' nimmt die linke Hälfte der Leertaste ein

  Herkömmliche Tastatur

     +---+   +---+---+---+---+ +---+---+---+---+ +---+---+---+---+
     |esc|   |f1 |f2 |f3 |f4 | |f5 |f6 |f7 |f8 | |f9 |f10|f11|f12|
     +---+---+---+---+---+---+-+-+-+-+-+-+-+-+-+-+---+---+---+---+
     | ^ | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 0 | ß | ' |  bsp  |
     +---+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+---+
     | tab | q | w | e | r | t | z | u | i | o | p | ü | + | ret |
     +-----++--++--++--++--++--++--++--++--++--++--++--++--++    |
     | lock | a | s | d | f | g | h | j | k | l | ö | ä | # |    |
     +----+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+----+
     |shf | < | y | x | c | v | b | n | m | , | . | - |    shf   |
     +----+---++--+-+-+---+---+---+---+---+--++---+---++----+----+
     |ctrl| win| alt|           spc          |agr | win|menu|ctrl|
     +----+----+----+------------------------+----+----+----+----+


  PLUM-Belegung nach Installation des Treibers

     +---+---+---+---+---+---+---+---+---+---+---+---+---+
     |esc|f1 |f2 |f3 |f4 |f5 |f6 |f7 |f8 |f9 |f10|f11|f12|
     +---+---+---+---+---+---+---+---+---+---+---+---+---+
     | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 0 | ß | ' |bsp|
     +---+---+---+---+---+---+---+---+---+---+---+---+---+
     |tab| q | w | e | r | t | z | u | i | o | p | ü | + |
     +---+---+---+---+---+---+---+---+---+---+---+---+---+
     |lck| a | s | d | f | g | h | j | k | l | ö | ä | # |
     +---+---+---+---+---+---+---+---+---+---+---+---+---+
     |shf| y | x | c | v | b | n | m | , | . | - |shf| ^ |
     +---+---+---+---+---+---+---+---+---+---+---+---+---+
     |ctr| < |alt|    ret    |    spc    |agr|win|ctl|
     +---+---+---+-----------+-----------+---+---+---+    
