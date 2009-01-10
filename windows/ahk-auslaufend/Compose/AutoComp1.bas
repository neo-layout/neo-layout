Rem Compose-AHK-Konverter
Rem © 2008 Martin Paul Roppelt (m.p.roppelt@web.de) – GPL 2/3
Rem 
Rem Basic-Datei für OpenOffice (2.4):
Rem Dateipfade an das Zielsystem anpassen!
Rem
Rem Anleitung: 
Rem OpenOffice-Basic aufrufen (Alt-x,m,v,m; Alt-n).
Rem Strg-a; Symbolleisten-Schaltfläche: BASIC-Quelltext einfügen, diese Datei auswählen.
Rem Skript ausführen (Alt-x,m,a oder F5).


Sub Main
  Open "C:\Users\Martin_2\NEO\Compose\Compose.neo" For Input Lock Write As #1
  Open "C:\Users\Martin_2\NEO\Compose\en_US.UTF-8" For Input Lock Write As #2 
  Open "C:\Users\Martin_2\Programmieren\NEO\ComposeList.txt" For Output Lock Read Write As #3
  
  LeseDatei(1)
  LeseDatei(2)  
  
  Close 1, 2, 3
End Sub

Sub LeseDatei(DateiNummer% as Integer)
  While Not Eof(DateiNummer%)
    Line Input #DateiNummer%, DateiZeile$
    Dateizeile$ = LTrim(DateiZeile$)
    If Left(DateiZeile$, 1) = "<" Then
      DoppelpunktPosition% = InStr(DateiZeile$, ":")
      Definition$ = RTrim( Left(DateiZeile$, DoppelpunktPosition% - 1) )
      KlammerAufPosition1% = InStr(Definition$, "<")
      KlammerZuPosition1% = InStr(Definition$, ">")
      Taste1$ = Mid(Definition$, KlammerAufPosition1% + 1, KlammerZuPosition1% - KlammerAufPosition1% - 1)
      If Taste1$ = "Multi_key" Then Print #3, DateiZeile$
    End If
  Wend
End Sub

