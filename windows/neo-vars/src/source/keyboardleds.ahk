UpdateOldLEDS() {
  global
  SwitchIsOn := 1
  SwitchIsOff := 0
  Num := SwitchIs%SavedScrollLockState% + 2*SwitchIs%SavedNumLockState% + 4*SwitchIs%SavedCapsLockState%
  KeyboardLED(Num,"switch")
}

UpdateNEOLEDS() {
  global
  SwitchIsOn := 1
  SwitchIsOff := 0
  Num := SwitchIs%NEOScrollLockLEDState% + 2*SwitchIs%NEONumLockLEDState% + 4*SwitchIs%NEOCapsLockLEDState%
  KeyboardLED(Num,"switch")
}


;ScrollLock=1, NumLock=2, CapsLock=4, bzw. eine beliebige Summe dieser Werte
KeyboardLED(LEDvalue, Cmd){ ; LEDvalue: ScrollLock=1, NumLock=2, CapsLock=4 ; Cmd = on/off/switch
  Static h_device
  If ! h_device ; initialise
  {
    device=\Device\KeyBoardClass0
    SetUnicodeStrLED(fn,device) 
    h_device:=NtCreateFileLED(fn,0+0x00000100+0x00000080+0x00100000,1,1,0x00000040+0x00000020,0)
  }
  VarSetCapacity(output_actual,4,0)
  input_size=4
  VarSetCapacity(input,input_size,0)
  If Cmd=switch ;switches every LED according to LEDvalue
   KeyLED:=LEDvalue
  If Cmd=on ;forces all choosen LED's to ON (LEDvalue= 0 ->LED's according to keystate)
   KeyLED:=LEDvalue | (GetKeyState("ScrollLock", "T") + 2*GetKeyState("NumLock", "T") + 4*GetKeyState("CapsLock", "T"))
  If Cmd=off ;forces all choosen LED's to OFF (LEDvalue= 0 ->LED's according to keystate)
    {
    LEDvalue:=LEDvalue ^ 7
    KeyLED:=LEDvalue & (GetKeyState("ScrollLock","T") + 2*GetKeyState("NumLock","T") + 4*GetKeyState("CapsLock","T"))
    }
  ; EncodeIntegerLED(KeyLED,1,&input,2) ;input bit pattern (KeyLED): bit 0 = scrolllock ;bit 1 = numlock ;bit 2 = capslock
  input:=Chr(1) Chr(1) Chr(KeyLED)
  input:=Chr(1)
  input=
  success:=DllCall("DeviceIoControl"
    , "uint", h_device
    , "uint", CTL_CODE_LED( 0x0000000b     ; FILE_DEVICE_KEYBOARD
              , 2
              , 0             ; METHOD_BUFFERED
              , 0  )          ; FILE_ANY_ACCESS
    , "uint", &input
    , "uint", input_size
    , "uint", 0
    , "uint", 0
    , "uint", &output_actual
    , "uint", 0 )
}

CTL_CODE_LED(p_device_type,p_function,p_method,p_access ){
  Return, ( p_device_type << 16 ) | ( p_access << 14 ) | ( p_function << 2 ) | p_method
}

NtCreateFileLED(ByRef wfilename,desiredaccess,sharemode,createdist,flags,fattribs){ 
  VarSetCapacity(fh,4,0) 
  VarSetCapacity(objattrib,24,0) 
  VarSetCapacity(io,8,0) 
  VarSetCapacity(pus,8) 
  uslen:=DllCall("lstrlenW","str",wfilename)*2 
  InsertIntegerLED(uslen,pus,0,2) 
  InsertIntegerLED(uslen,pus,2,2) 
  InsertIntegerLED(&wfilename,pus,4) 
  InsertIntegerLED(24,objattrib,0) 
  InsertIntegerLED(&pus,objattrib,8) 
  status:=DllCall("ntdll\ZwCreateFile","str",fh,"UInt",desiredaccess,"str",objattrib,"str",io,"UInt",0,"UInt",fattribs
                  ,"UInt",sharemode,"UInt",createdist,"UInt",flags,"UInt",0,"UInt",0, "UInt") 
  return ExtractIntegerLED(fh) 
} 

SetUnicodeStrLED(ByRef out, str_){ 
  VarSetCapacity(st1, 8, 0) 
  InsertIntegerLED(0x530025, st1) 
  VarSetCapacity(out, (StrLen(str_)+1)*2, 0) 
  DllCall("wsprintfW", "str", out, "str", st1, "str", str_, "Cdecl UInt") 
} 

ExtractIntegerLED(ByRef pSource, pOffset = 0, pIsSigned = false, pSize = 4){
; pSource is a string (buffer) whose memory area contains a raw/binary integer at pOffset. 
; The caller should pass true for pSigned to interpret the result as signed vs. unsigned. 
; pSize is the size of PSource's integer in bytes (e.g. 4 bytes for a DWORD or Int). 
; pSource must be ByRef to avoid corruption during the formal-to-actual copying process 
; (since pSource might contain valid data beyond its first binary zero). 
  Loop %pSize%  ; Build the integer by adding up its bytes. 
    result += *(&pSource + pOffset + A_Index-1) << 8*(A_Index-1) 
  if (!pIsSigned OR pSize > 4 OR result < 0x80000000) 
    return result  ; Signed vs. unsigned doesn't matter in these cases. 
  ; Otherwise, convert the value (now known to be 32-bit) to its signed counterpart: 
  return -(0xFFFFFFFF - result + 1) 
} 

InsertIntegerLED(pInteger, ByRef pDest, pOffset = 0, pSize = 4){ 
; The caller must ensure that pDest has sufficient capacity.  To preserve any existing contents in pDest, 
; only pSize number of bytes starting at pOffset are altered in it. 
  Loop %pSize%  ; Copy each byte in the integer into the structure as raw binary data. 
    DllCall("RtlFillMemory", "UInt", &pDest + pOffset + A_Index-1, "UInt", 1, "UChar", pInteger >> 8*(A_Index-1) & 0xFF) 
}

