/*
*******************************************
; Über dieses Skript
*******************************************
Dies ist ein experimentelles Minimalbeispiel, um die noch fehlende Compose-Funktionalität in der neo20-all-in-one.ahk zu implementieren.

Konkret werden dafür die sog. Hotstrings genutzt:
http://www.autohotkey.com/docs/Hotstrings.htm

Die eigentlichen Kombinationen sollen später aus den Linux-Sourcen
automatisch generiert werden.

Autoren: Matthias Berg, Dennis Heidsiek


*******************************************
; Kurze Beschreibung der Funktionsweise
*******************************************

compose aktiviert die hotstrings und die nächsten gr (copyright) oder 12
(einhalb) werden ersetzt und deaktivieren es aber sofort.

Also {compose}neogrneo12  wird zu neo©neo12  (einhalb wird nicht ersetzt).
damit dies aber nicht unendlich lange geht (also erst ein paar Wörter später
eine Ersetzung erfolgt, weil nach Compose doch umentschieden wurde), wird mit
Space (vielleicht auch später mit anderen Tasten) compose wieder deaktiviert.


;*******************************************
; Zu Testzwecken aufgenommene Kombinationen
; (in der Linux-Schreibweise)
;*******************************************
; 
; <Multi_key> <o> <c> "©" # copyright
; <Multi_key> <1> <2> "½" # FRACTION 1/2
; <Multi_key> <r> <2> <0> "xx" # SMALL ROMAN NUMERAL 20
; <Multi_key> <r> <2> <0> <0> "cc" # SMALL ROMAN NUMERAL 200
; <Multi_key> <r> <2> <0> <0> <0> "mm" # SMALL ROMAN NUMERAL 2000
; <Multi_key> <r> <3> <9> <9> <9> "mmmcmxcix" # SMALL ROMAN NUMERAL 3999
; <Multi_key> <K> <2> <0> <0> <0> "\u216f\u216f" # ROMAN NUMERAL 2000
; 
*******************************************
; Offene und noch zu lösende Probleme:
*******************************************

- {compose}r200 und {compose}r2000 können nicht eingegeben werden,
  da zuvor {compose}r20 erkannt wird
  
- Unbedingt die folgende noch fehlende Dokumentation ergänzen, damit die
  Compose-Kombinationen von Dennis automatisch aus den Linux-Sourcen generiert
  werden können: Wann/wofür benutzt man:
  
  send a
  
  
  send {blind} a
  
  
  SendUnicodeChar(0x0061)
  
  
  BSSendUnicodeChar(0x0061)
  
  
  CompUnicodeChar(0x0061)
  
  
  Comp3UnicodeChar(0x0061)
  
  
  
  
  
*******************************************
; Gelöste Probleme:
*******************************************

  - {compose}r2000 und {compose}R2000 werden jetzt unterschieden
  
*/




;*******************************************/
; Compose-Methoden 
;*******************************************/

composeActive := 0  ; unsere neue Variable

~Space::composeActive := 0   ; Space und später andere Tasten sollten es deaktivieren
*CapsLock::return    ; capslock soll ja nichts einrasten :)

*tab::    ; Dies ist so ähnlich wie neo_tab:
  if (IsMod3Pressed()) { ;#
        composeActive := 1
      PriorDeadKey := "comp"
      CompKey := ""
   }
   else {
      send {blind}{Tab}
      PriorDeadKey := ""
      CompKey := ""
   }
return

IsMod3Pressed()
{
    return ( GetKeyState("CapsLock","P") or GetKeyState("#","P") )  ; # = SC02B
}


;*******************************************/
; Unicode-Methoden
;*******************************************/
SendUnicodeChar(charCode)
{
   VarSetCapacity(ki, 28 * 2, 0)

   EncodeInteger(&ki + 0, 1)
   EncodeInteger(&ki + 6, charCode)
   EncodeInteger(&ki + 8, 4)
   EncodeInteger(&ki +28, 1)
   EncodeInteger(&ki +34, charCode)
   EncodeInteger(&ki +36, 4|2)

   DllCall("SendInput", "UInt", 2, "UInt", &ki, "Int", 28)
}

BSSendUnicodeChar(charCode)
{
   send {bs}
   SendUnicodeChar(charCode)
}

CompUnicodeChar(charCode)
{
   send {bs}
	 SendUnicodeChar(charCode)
}

Comp3UnicodeChar(charCode)
{
   send {bs}
   send {bs}
   SendUnicodeChar(charCode)
}


EncodeInteger(ref, val)
{
   DllCall("ntdll\RtlFillMemoryUlong", "Uint", ref, "Uint", 4, "Uint", val)
}


;*******************************************/
; Compose-Kombinationen
; (werden später automatisch generiert)
;*******************************************/

; <Multi_key> <o> <c> "©" # copyright
:*O?Z:oc::
  if (composeActive) {
     send ©
     composeActive := 0
  } else {
     send oc
  }
Return

; <Multi_key> <1> <2> "½" # FRACTION 1/2
:*O?Z:12::
  if (composeActive) {
     send ½
     composeActive := 0
  } else {
     send 12
  }
Return


; <Multi_key> <r> <2> <0> "xx" # SMALL ROMAN NUMERAL 20
:*O?ZC:r20::
  if (composeActive) {
     send xx
     composeActive := 0
  } else {
     send 20
  }
Return

; <Multi_key> <r> <2> <0> <0> "cc" # SMALL ROMAN NUMERAL 200
:*O?ZC:r200::
  if (composeActive) {
     send cc
     composeActive := 0
  } else {
     send 200
  }
Return

; <Multi_key> <r> <2> <0> <0> <0> "mm" # SMALL ROMAN NUMERAL 2000
:*O?ZC:r2000::
  if (composeActive) {
     send mm
     composeActive := 0
  } else {
     send 2000
  }
Return

; <Multi_key> <r> <3> <9> <9> <9> "mmmcmxcix" # SMALL ROMAN NUMERAL 3999
:*O?ZC:r3999::
  if (composeActive) {
     send mmmcmxcix
     composeActive := 0
  } else {
     send 3999
  }
Return

; <Multi_key> <K> <2> <0> <0> <0> "\u216f\u216f" # ROMAN NUMERAL 2000
:*O?ZC:R2000::
  if (composeActive) {
     SendUnicodeChar(0x216F)
     SendUnicodeChar(0x216f)
     composeActive := 0
  } else {
     send 2000
  }
Return

;*******************************************/
; Ende
;*******************************************/

