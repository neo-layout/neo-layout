REM  *****  BASIC  *****

'Programm zur Umwandlung einer ComposeList.txt-Datei in eine Compose.ahk-Datei.
'© 14. - 16. Sept. 2008, Martin Paul Roppelt (m.p.roppelt@web.de) – GPL 2/3

'Anleitung:
'Pfade anpassen :-)
'Alle Tabulatoren durch ein /einzelnes/ Leerzeichen ersetzen.
'Quelldatei als UTF16-Little-Endian speichern.
'Skript ausführen.
'Korrektur von ein paar ungelösten Problemen:
'Letzte Zeile der Ausgabedatei durch "}" ersetzen.
'Folgende Zeilen abändern:
'CheckCompUni("<t> <z>", 0xE04A", 0x) ->
'CheckCompUni("<?> <?>:????) ->
'CheckCompUni("<t> <z>", 0xE04A)
'CheckCompUni("<?> <?>", 0x????)

Sub Main
  Open "C:\Users\Martin_2\Programmieren\NEO\ComposeList16.txt" For Binary Lock Write As #1
  Open "C:\Users\Martin_2\NEO\windows\autohotkey\Source\Composet.ahk" For Output Lock Read Write As #2
  Print #2, "CheckCompose() {"
  Print #2, "CheckCompUni("; chr(34);
  For Position& = 1 To Lof(1) Step 2
    Get #1, Position&, a%
    If a% = 10 Then
     Print #2, ")" : Klammer% = 0: Kommentar% = 0: Quotedbl% = 0
     Print #2, "CheckCompUni("; chr(34);
    ElseIf a%=asc(":") and Zeichen% <> 1 Then
     Print #2, chr(34); ", 0x";
     Zeichen% = 1
    ElseIf a%=asc(" ") Then
    ElseIf a%=asc("<") Then
     Klammer% = Klammer% + 1
     If Klammer% > 2 Then Print #2, " ";
     If Klammer% <> 1 and Kommentar% <> 1 Then Print #2, "<";
    ElseIf a% = 34 Then
     Quotedbl% = Quotedbl% + 1
     If Quotedbl% = 2 Then
       Kommentar% = 1
       Zeichen = 0
     EndIf
    ElseIf Klammer% <> 1 and a% < 255 and a% > 0 and Kommentar% <> 1 Then
     Print #2, Chr(a%);
    ElseIf Klammer% <> 1 and Kommentar% <> 1 Then
     If a% <> -257 Then Print #2, Iif(Len(Hex(a%))>4, Right(Hex(a%),4),Hex(a%));
    End If
  Next
  Print #2, "}"
  Close 1, 2
End Sub
