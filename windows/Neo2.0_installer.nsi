;NSIS-Installer für alle Windowstreiber
;Geschrieben von Florian Janßen
;
; Offene Punkte:
; - Uninstaller
; - bislang keine Abfrage ob Autostart
; 
; Status:
; - Installiert kbdneo (mit und ohne Zustatzskript)
; - Fällt bei Bedarf auf NeoVars-Installation zurück
; - Erkennt 32- und 64bit Systeme und wählt entsprechenden Treiber aus.
; - Kann auf die 64bit Registry und 64bit-Systemordner von Vista und 7 zugreifen
; - Rechteverwaltung bei XP, Vista und 7
; - Autostart wird angelegt



;--------------------------------
;MUI Oberfläche
;Nur eine Section auswählbar
;64bit Zauberei
;bisschen Logik
;Benutzerkontensteuerung
	!include "MUI2.nsh"
	!include "Sections.nsh"
	!include "x64.nsh"
	!include "LogicLib.nsh"
	!include "UAC.nsh"



;--------------------------------
;Allgemeines

;Name und Name der Datei

	!define /date ZEIT "%y%m%d.%H"
	Name "Neo2.0 - Das ergonomische Tastaturlayout"
	OutFile "Neo2.0_setup.exe"

;Standardordner (für AHK)
	InstallDir "$PROGRAMFILES\Neo2"

;Mal sehen ob Neo schon mal da war
	InstallDirRegKey HKCU "Software\Neo 2.0" ""

;Rechte anfordern
	RequestExecutionLevel user ;Muss „user“ sein, Admin wird nachträglich gerufen

;Zeige was geschieht
	ShowInstDetails show

;Warnung bei Abbruch
	!define MUI_ABORTWARNING ;Warnt falls Installations abgebrochen wird



;--------------------------------
;Seiten des Installers

	!define WELCOME_TITLE "Willkommen zum Installations-  Assistenten für Neo 2.0"
	!define UNWELCOME_TITLE "Willkommen zum Deinstallations-  Assistenten für Neo 2.0"
	!define FINISH_TITLE "Die Installation von Neo 2.0 wurde erfolgreich beendet."
	!define UNFINISH_TITLE "Die Deinstallation von Neo 2.0 wurde erfolgreich beendet."
	!define MUI_COMPONENTSPAGE_SMALLDESC
	
	!define MUI_WELCOMEPAGE_TITLE "${WELCOME_TITLE}"
	!define MUI_WELCOMEPAGE_TITLE_3LINES ;3 Zeilen für den Titel
	!insertmacro MUI_PAGE_WELCOME
	
	!insertmacro MUI_PAGE_LICENSE "lizenz.txt"
	
	!define MUI_PAGE_CUSTOMFUNCTION_PRE preComp
	!define MUI_PAGE_CUSTOMFUNCTION_LEAVE leaveComp
	!insertmacro MUI_PAGE_COMPONENTS
	
	!define MUI_PAGE_CUSTOMFUNCTION_PRE preDir
	!insertmacro MUI_PAGE_DIRECTORY
	
	!define MUI_PAGE_CUSTOMFUNCTION_LEAVE leaveInst
	!insertmacro MUI_PAGE_INSTFILES
	
	!define MUI_FINISHPAGE_TITLE "${FINISH_TITLE}"
	!define MUI_FINISHPAGE_TITLE_3LINES
	!insertmacro MUI_PAGE_FINISH



;Deutsche Oberfläche
	!insertmacro MUI_LANGUAGE "German"



;---------------------------------
;Ein paar Variablen
	!define KLF_REORDER		8
	!define KLF_ACTIVATE	1



;--------------------------------
;Installer Sections

;Verschiedene Installationstypen
	InstType  "Vollständig" 
	InstType  "Nur Teiber kein Skript"
	InstType  "Nur NeoVars"
	;InstType /NOCUSTOM

;Die eigentlichen Sections
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
		
		!insertmacro UAC_AsUser_Call Function makeKBDactive ${UAC_SYNCREGISTERS}
		
	SectionEnd


	Section /o "Neo-2.0-Treiber und AHK-Erweiterung" installiereKbdneoPlusAHK
	SectionIn 1
		SetOutPath "$INSTDIR"
		
	;Zustatz Skript kopieren (immer als 32bit)
		file kbdneo2\Treiber\AHK_für_kbdneo2\kbdneo_ahk.exe
		
	;Erstellt eine Verknüpfung im Autostart-Ordner  
		!insertmacro UAC_AsUser_Call Function goUserDir ${UAC_SYNCREGISTERS}
		
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
		
		; !insertmacro UAC_AsUser_Call Function makeKBDactive ${UAC_SYNCREGISTERS}
		
	SectionEnd


	Section /o "Eigenständiges Neo2.0-AHK-Skript (NeoVars)" installiereAHK
	SectionIn 3
		SetOutPath "$INSTDIR"
		file neo-vars\out\neo20.exe
		createShortCut "$SMPROGRAMS\Startup\Neo2.0 (AHK).lnk"  "$INSTDIR\neo20.exe"
		WriteRegStr HKCU "Software\Neo 2.0" "" $INSTDIR
		
	SectionEnd



;--------------------------------
; Functions

;nur ein Installationszweig auswählbar
	Function .onSelChange
		!insertmacro StartRadioButtons $1
		!insertmacro RadioButton ${installiereKbdneoOhneAHK}
		!insertmacro RadioButton ${installiereKbdneoPlusAHK}
		!insertmacro RadioButton ${installiereAHK}
		!insertmacro EndRadioButtons
	FunctionEnd


;UAC Zauberei
	Function .onInit
		StrCpy $1 ${installiereKbdneoPlusAHK}
		
		uac_tryagain:
		!insertmacro UAC_RunElevated
		#MessageBox mb_TopMost "0=$0 1=$1 2=$2 3=$3"
		${Switch} $0
		${Case} 0
			${IfThen} $1 = 1 ${|} Quit ${|} ;we are the outer process, the inner process has done its work, we are done
			${IfThen} $3 <> 0 ${|} ${Break} ${|} ;we are admin, let the show go on
			${If} $1 = 3 ;RunAs completed successfully, but with a non-admin user
				MessageBox mb_IconExclamation|mb_TopMost|mb_SetForeground "Dieser Installationsassistent benötigt Adminrechte, bitte erneut versuchen." /SD IDNO IDOK uac_tryagain IDNO 0
			${EndIf}
			;fall-through and die
		${Case} 1223 ;hier kommt der Ausstieg falls der User keine Adminrechte erwerben kann.
			MessageBox MB_YESNO|mb_IconStop|mb_TopMost|mb_SetForeground "Für die Installation des Windowstreibers werden Adminrechte benötigt. Mit NeoVars kann jedoch auch ohne Adminrechte das Neo2.0-Tastaturlayout installiert werden. Bitte die Hinweise auf der Website beachten. Soll Neo-Vars gestartet werden?" IDYES gogogo
			ExecShell "open" "http://neo-layout.org/windows"
			Quit
			gogogo:
			ExecShell "open" http://neo-layout.org/windows
			goto end
		${Case} 1062
			MessageBox mb_IconStop|mb_TopMost|mb_SetForeground "Logon-Dienst nicht verfügbar, Abbruch!"
			Quit
		${Default}
			MessageBox mb_IconStop|mb_TopMost|mb_SetForeground "Ups , Error $0"
			Quit
		${EndSwitch}
			end:
	FunctionEnd


;Sperrt ohne Adminrechte alles außer NeoVars
	Function preComp
		userInfo::getAccountType
		pop $R0
		strCmp $R0 "Admin" +5 ;falls Admin hüpf 5 Commandozeilen weiter
		;wenn kein Admin wird das hier angezeigt:
		messageBox MB_OK  "Wir sind kein Admin, sondern ›$R0‹"
			SectionSetFlags ${installiereKbdneoPlusAHK} ${SF_RO} ;Installationsarten mit Adminrechten werden gesperrt
			SectionSetFlags ${installiereKbdneoOhneAHK} ${SF_RO} ;Installationsarten mit Adminrechten werden gesperrt
			return
		messageBox MB_OK "Wir sind Admin"
	FunctionEnd


;Überspringt die Directory-Seite falls kein AHK installiert wird
	Function leaveComp
		SectionGetFlags ${installiereKbdneoOhneAHK} $0
		IntOp $1 $0 & ${SF_SELECTED} 
		IntCmp $1 0 showDir
		push "skip components" ;schiebt es auf den Stack
		showDir:
	FunctionEnd
 
	Function preDir
		pop $R0 ;holt es sich vom Stack zurück
		StrCmp "$R0" "skip components" 0 end ;vergleicht es und springt zu Ende wenn es nicht passt
		abort ;hat gepasst, Components-Seite wird übersprungen.
		end:
	FunctionEnd


;Verschafft etwas Zeit zum Kucken
	Function leaveInst
		sleep 3000 ;Ein bisschen Pause, damit man was sieht.
	FunctionEnd
	
	
;Layout beim User Aktivieren (hoffentlich ;)
	Function makeKBDactive
		System::Call "user32::LoadKeyboardLayout(t "b0000407",${KLF_ACTIVATE})"
	FunctionEnd


;Datei beim User schreiben, obwohl als Admin eingeloggt
	Function goUserDir
		createShortCut "$SMPROGRAMS\Startup\AHK für kbdneo.lnk"  "$INSTDIR\kbdneo_ahk.exe"
	FunctionEnd



;--------------------------------
;Beschreibung der Installationstypen
;LangsStrings (nur Deutsch)
	LangString DESC_installiereKbdneoPlusAHK ${LANG_GERMAN} "System32-Test und bel. Ordner (hier sollten immer Adminrechte angefordert werden)"
	LangString DESC_installiereKbdneoOhneAHK ${LANG_GERMAN} "nur System32-Test (hier sollten immer Adminrechte angefordert werden)"
	LangString DESC_installiereAHK ${LANG_GERMAN} "Installiert den Neo2.0-AHK-Standalone-Treiber Neo-Vars (keine Adminrechte nötig)"


;LangsStrings den Sections zuordnen
	!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
		!insertmacro MUI_DESCRIPTION_TEXT ${installiereKbdneoPlusAHK} $(DESC_installiereKbdneoPlusAHK)
		!insertmacro MUI_DESCRIPTION_TEXT ${installiereKbdneoOhneAHK} $(DESC_installiereKbdneoOhneAHK)
		!insertmacro MUI_DESCRIPTION_TEXT ${installiereAHK} $(DESC_installiereAHK)	
	!insertmacro MUI_FUNCTION_DESCRIPTION_END



;---------------------------------
;Dateieigenschaften des Installers

VIAddVersionKey /LANG=${LANG_GERMAN} "ProductName" "Neo 2.0"
VIAddVersionKey /LANG=${LANG_GERMAN} "Comments" "Buy me a Caffè /;)"
VIAddVersionKey /LANG=${LANG_GERMAN} "FileDescription" "Neo 2.0 Installationsassistent"
VIAddVersionKey /LANG=${LANG_GERMAN} "FileVersion" "${ZEIT}"
VIProductVersion "2.0.${ZEIT}"