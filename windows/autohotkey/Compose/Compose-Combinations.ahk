/*
*******************************************
 Compose-Kombinationen
*******************************************

Diese sollen später automatisch generiert werden.


********************************************
* Zu Testzwecken aufgenommene Kombinationen
* (in der Linux-Schreibweise)
********************************************

<Multi_key> <o> <c> "©" # copyright
<Multi_key> <1> <2> "½" # FRACTION 1/2
<Multi_key> <r> <2> <0> "xx" # SMALL ROMAN NUMERAL 20
<Multi_key> <r> <2> <0> <0> "cc" # SMALL ROMAN NUMERAL 200
<Multi_key> <r> <2> <0> <0> <0> "mm" # SMALL ROMAN NUMERAL 2000
<Multi_key> <r> <3> <9> <9> <9> "mmmcmxcix" # SMALL ROMAN NUMERAL 3999
<Multi_key> <R> <2> <0> <0> <0> "\u216f\u216f" # ROMAN NUMERAL 2000


********************************************
* Bedeutung der Parameter im Keystring
* (Quelle: http://www.autohotkey.com/docs/Hotstrings.htm)
********************************************

* (asterisk): An ending character (e.g. space, period, or enter) is not  required to trigger the hotstring.
O: Omit the ending character of auto-replace hotstrings when the replacement is produced. This is useful when you want a hotstring to be kept unambiguous by still requiring an ending character, but don't actually want the ending character to be shown on the screen.
? (question mark): The hotstring will be triggered even when it is inside another word; that is, when the character typed immediately before it is alphanumeric.
Z: This rarely-used option resets the hotstring recognizer after each triggering of the hotstring. In other words, the script will begin waiting for an entirely new hotstring, eliminating from consideration anything you previously typed. This can prevent unwanted triggerings of hotstrings.
ob * und O gleichzeitig gebraucht werden... vielleicht ist das O überflüssig :)
Beim Z bin ich mir auch nicht ganz sicher. Aber es funktioniert halt ;)

*******************************************
 Hier beginnt der eigentliche Code
*******************************************
*/


; <Multi_key> <o> <c> "©" # copyright
:*O?ZC:oc::
  if (composeActive) {
     send ©
     composeActive := 0
  } else {
     send oc
  }
Return

; <Multi_key> <1> <2> "½" # FRACTION 1/2
:*O?ZC:12::
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

; <Multi_key> <R> <2> <0> <0> <0> "\u216f\u216f" # ROMAN NUMERAL 2000
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

