;NSIS-Installer für alle Windowstreiber
;Geschrieben von Florian Janßen
;
; Offene Punkte:
; - Rechteverwaltung bei Vista und 7
; - Uninstaller
; - Keine Ordnerabfrage bei Installation ohne AHK
; - Startmenu
;- Autostart (Abfrage)
; 
; Status:
; - Installiert bislang nur kbdneo (mit und ohne Zustatzskript)
; - Benötigt Admin-Rechte
; - Erkennt 32- und 64bit Systeme und wählt entsprechenden Treiber aus.
; - Kann auf die 64bit Registry und 64bit-Systemordner von Vista und 7 zugreifen


;--------------------------------
;MUI Oberfläche
;Nur eine Section auswählbar
;64bit Zauberei

  !include "MUI2.nsh"
  !include "Sections.nsh"
  !include "x64.nsh"

;--------------------------------
;Allgemeines

;Name und Name der Datei
  Name "Neo 2.0 - Das ergonomische Tastaturlayout"
  OutFile "Neo2.0_installer.exe"

;Standardordner (für AHK)
  InstallDir "$PROGRAMFILES\Neo2"

;Mal sehen ob Neo schon mal da war
  InstallDirRegKey HKCU "Software\Neo 2.0" ""

;Rechte anfordern
  RequestExecutionLevel admin

;Warnung bei Abbruch
  !define MUI_ABORTWARNING

;--------------------------------
;Seiten des Installers
!define WELCOME_TITLE 'Willkommen zum Installations-  Assistenten für Neo 2.0'
!define UNWELCOME_TITLE 'Willkommen zum Deinstallations-  Assistenten für Neo 2.0'
!define FINISH_TITLE 'Die Installation von Neo 2.0 wurde erfolgreich beendet.'
!define UNFINISH_TITLE 'Die Deinstallation von Neo 2.0 wurde erfolgreich beendet.'
!define MUI_COMPONENTSPAGE_SMALLDESC 

  !define MUI_WELCOMEPAGE_TITLE '${WELCOME_TITLE}'
  !define MUI_WELCOMEPAGE_TITLE_3LINES
  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "lizenz.txt"
  !insertmacro MUI_PAGE_COMPONENTS
;  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !define MUI_FINISHPAGE_TITLE '${FINISH_TITLE}'
  !define MUI_FINISHPAGE_TITLE_3LINES
  !insertmacro MUI_PAGE_FINISH

  !define MUI_WELCOMEPAGE_TITLE '${UNWELCOME_TITLE}'
  !define MUI_WELCOMEPAGE_TITLE_3LINES
  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !define MUI_FINISHPAGE_TITLE '${UNFINISH_TITLE}'
  !define MUI_FINISHPAGE_TITLE_3LINES
  !insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Deutsche Oberflächen

  !insertmacro MUI_LANGUAGE "German"

;--------------------------------
;Installer Sections

;Verschiedene Installationstypen
InstType  "Vollständig" 
InstType  "Nur Teiber kein Skript"
;InstType  "Nur neo20.exe"
;InstType /NOCUSTOM


Section /o "Neo-2.0-Treiber" installiereKbdneoOhneAHK
SectionIn  2

  SetOutPath "$SYSDIR"
  ${If} ${RunningX64}
	SetRegView 64
	WriteRegStr HKEY_LOCAL_MACHINE "SYSTEM\CurrentControlSet\Control\Keyboard Layouts\b0000407" "Layout Text" "Deutsch (Neo 2.0 ergonomisch)"
	WriteRegStr HKEY_LOCAL_MACHINE "SYSTEM\CurrentControlSet\Control\Keyboard Layouts\b0000407" "Layout File" "kbdneo2.dll"
	WriteRegStr HKEY_LOCAL_MACHINE "SYSTEM\CurrentControlSet\Control\Keyboard Layouts\b0000407" "Layout Id" "00c0"
	WriteRegStr HKEY_LOCAL_MACHINE "SYSTEM\CurrentControlSet\Control\Keyboard Layouts\b0000407" "Layout Display Name" "@%SystemRoot%\system32\kbdneo2.dll,-1000"
	WriteRegStr HKEY_LOCAL_MACHINE "SYSTEM\CurrentControlSet\Control\Keyboard Layouts\b0000407" "Custom Language Name" "German (Germany)"
	WriteRegStr HKEY_LOCAL_MACHINE "SYSTEM\CurrentControlSet\Control\Keyboard Layouts\b0000407" "Custom Language Display Name" "@%SystemRoot%\system32\kbdneo2.dll,-1100"
	SetRegView 32
	${DisableX64FSRedirection}
	file kbdneo2\Treiber\64bit_Windows\kbdneo2.dll
  ${Else}
	SetRegView 32 
	WriteRegStr HKEY_LOCAL_MACHINE "SYSTEM\CurrentControlSet\Control\Keyboard Layouts\b0000407" "Layout Text" "Deutsch (Neo 2.0 ergonomisch)"
	WriteRegStr HKEY_LOCAL_MACHINE "SYSTEM\CurrentControlSet\Control\Keyboard Layouts\b0000407" "Layout File" "kbdneo2.dll"
	WriteRegStr HKEY_LOCAL_MACHINE "SYSTEM\CurrentControlSet\Control\Keyboard Layouts\b0000407" "Layout Id" "00c0"
	WriteRegStr HKEY_LOCAL_MACHINE "SYSTEM\CurrentControlSet\Control\Keyboard Layouts\b0000407" "Layout Display Name" "@%SystemRoot%\system32\kbdneo2.dll,-1000"
	WriteRegStr HKEY_LOCAL_MACHINE "SYSTEM\CurrentControlSet\Control\Keyboard Layouts\b0000407" "Custom Language Name" "German (Germany)"
	WriteRegStr HKEY_LOCAL_MACHINE "SYSTEM\CurrentControlSet\Control\Keyboard Layouts\b0000407" "Custom Language Display Name" "@%SystemRoot%\system32\kbdneo2.dll,-1100"
	${EnableX64FSRedirection}
	file kbdneo2\Treiber\32bit_Windows\kbdneo2.dll
  ${EndIf}

;Keyboardlayout wird aktiviert
  System::Call "user32::LoadKeyboardLayout (b0000407,KLF_ACTIVATE)"

;UnInstaller erstellen
  WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd

Section "Neo-2.0-Treiber und AHK-Erweiterung" installiereKbdneoPlusAHK
SectionIn 1 
  SetOutPath "$INSTDIR"
;Zustatz Skript kopieren (immer als 32bit)
  file kbdneo2\Treiber\AHK_für_kbdneo2\kbdneo_ahk.exe

;Installationspfad speichern (immer 32bit)
  WriteRegStr HKCU "Software\Neo 2.0" "" $INSTDIR

  SetOutPath "$SYSDIR"
  ${If} ${RunningX64}
	SetRegView 64
	WriteRegStr HKEY_LOCAL_MACHINE "SYSTEM\CurrentControlSet\Control\Keyboard Layouts\b0000407" "Layout Text" "Deutsch (Neo 2.0 ergonomisch)"
	WriteRegStr HKEY_LOCAL_MACHINE "SYSTEM\CurrentControlSet\Control\Keyboard Layouts\b0000407" "Layout File" "kbdneo2.dll"
	WriteRegStr HKEY_LOCAL_MACHINE "SYSTEM\CurrentControlSet\Control\Keyboard Layouts\b0000407" "Layout Id" "00c0"
	WriteRegStr HKEY_LOCAL_MACHINE "SYSTEM\CurrentControlSet\Control\Keyboard Layouts\b0000407" "Layout Display Name" "@%SystemRoot%\system32\kbdneo2.dll,-1000"
	WriteRegStr HKEY_LOCAL_MACHINE "SYSTEM\CurrentControlSet\Control\Keyboard Layouts\b0000407" "Custom Language Name" "German (Germany)"
	WriteRegStr HKEY_LOCAL_MACHINE "SYSTEM\CurrentControlSet\Control\Keyboard Layouts\b0000407" "Custom Language Display Name" "@%SystemRoot%\system32\kbdneo2.dll,-1100"
	SetRegView 32
	${DisableX64FSRedirection}
	file kbdneo2\Treiber\64bit_Windows\kbdneo2.dll
  ${Else}
	SetRegView 32 
	WriteRegStr HKEY_LOCAL_MACHINE "SYSTEM\CurrentControlSet\Control\Keyboard Layouts\b0000407" "Layout Text" "Deutsch (Neo 2.0 ergonomisch)"
	WriteRegStr HKEY_LOCAL_MACHINE "SYSTEM\CurrentControlSet\Control\Keyboard Layouts\b0000407" "Layout File" "kbdneo2.dll"
	WriteRegStr HKEY_LOCAL_MACHINE "SYSTEM\CurrentControlSet\Control\Keyboard Layouts\b0000407" "Layout Id" "00c0"
	WriteRegStr HKEY_LOCAL_MACHINE "SYSTEM\CurrentControlSet\Control\Keyboard Layouts\b0000407" "Layout Display Name" "@%SystemRoot%\system32\kbdneo2.dll,-1000"
	WriteRegStr HKEY_LOCAL_MACHINE "SYSTEM\CurrentControlSet\Control\Keyboard Layouts\b0000407" "Custom Language Name" "German (Germany)"
	WriteRegStr HKEY_LOCAL_MACHINE "SYSTEM\CurrentControlSet\Control\Keyboard Layouts\b0000407" "Custom Language Display Name" "@%SystemRoot%\system32\kbdneo2.dll,-1100"
	${EnableX64FSRedirection}
	file kbdneo2\Treiber\32bit_Windows\kbdneo2.dll
  ${EndIf}

;Keyboardlayout wird aktiviert
  System::Call "user32::LoadKeyboardLayout (b0000407,KLF_ACTIVATE)"

;UnInstaller erstellen
  WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd

; Section /o "Eigenständiges Neo2.0-AHK-Skript (neo-vars)" installiereAHK
; SectionIn 3
  ; SetOutPath "$INSTDIR"
  ; file neo-vars\out\neo20.exe


  ; WriteRegStr HKCU "Software\Neo 2.0" "" $INSTDIR


  ; WriteUninstaller "$INSTDIR\Uninstall.exe"

; SectionEnd

;--------------------------------
;Functions

Function .onInit
 
  StrCpy $1 ${installiereKbdneoPlusAHK}
 
FunctionEnd
 
Function .onSelChange
;  !insertmacro SectionRadioButtons "${installiereKbdneoPlusAHK}" "${installiereKbdneoPlusAHK},${installiereKbdneoOhneAHK},${installiereAHK}"

  !insertmacro StartRadioButtons $1
  !insertmacro RadioButton ${installiereKbdneoPlusAHK}
  !insertmacro RadioButton ${installiereKbdneoOhneAHK}
  ; !insertmacro RadioButton ${installiereAHK}
  !insertmacro EndRadioButtons
 
FunctionEnd



;--------------------------------
;Beschreibung der Installationstypen

  ;LangsStrings (nur Deutsch)
  LangString DESC_installiereKbdneoPlusAHK ${LANG_GERMAN} "Installiert den nativen Neo2.0-Treiber (kbdneo2.dll) und die AHK-Erweiterung (kbdneo.ahk) - Administratorrechte erforderlich!"
  LangString DESC_installiereKbdneoOhneAHK ${LANG_GERMAN} "Installiert nur den nativen Neo2.0-Treiber (kbdneo2.dll) - Administratorrechte erforderlich!"
  LangString DESC_installiereAHK ${LANG_GERMAN} "Installiert den Neo2.0-AHK-Standalone-Treiber Neo-Vars (keine Adminrechte nötig)"
  
  ;LangsStrings den Sections zuordnen
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${installiereKbdneoPlusAHK} $(DESC_installiereKbdneoPlusAHK)
	!insertmacro MUI_DESCRIPTION_TEXT ${installiereKbdneoOhneAHK} $(DESC_installiereKbdneoOhneAHK)
	; !insertmacro MUI_DESCRIPTION_TEXT ${installiereAHK} $(DESC_installiereAHK)	
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller Section (Nicht fertig)

Section "Uninstall"

  

  Delete "$INSTDIR\Uninstall.exe"

  RMDir "$INSTDIR"

  DeleteRegKey /ifempty HKCU "Software\Neo 2.0"

SectionEnd