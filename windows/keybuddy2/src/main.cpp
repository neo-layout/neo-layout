
#include "includes.h"

#define IMAGECLASS KB2Images
#define IMAGEFILE <KeyBuddy2/kb2images.iml>

#include <Draw/iml.h>

KeyBuddy2* KeyBuddy2::pKB2=NULL;
LineEdit* KeyBuddy2::pdisplay=NULL; // pointer to the display
keyButton* KeyBuddy2::pKeyButton[256]={0}; // pointers to gui key buttons
BYTE KeyBuddy2::keyFinger[256]={0}; // which finger is associated to this key (=style index)
bool KeyBuddy2::neoLevelsActive=true; // whether the additional layers of neo are active
bool KeyBuddy2::neoRemapActive=false; // false=qwertz layout, true=neo layout
bool KeyBuddy2::cyrillicActive=false; // if roman letters are translated into cyrillic
bool KeyBuddy2::capslockActive=false; // if capital letters shall be sent
bool KeyBuddy2::lockLayer4Active=false; // if neo layer 4 is locked
bool KeyBuddy2::mouseControlActive=false; // if mouse control via keyboard is active
bool KeyBuddy2::dummySwitch=false; // that is switched by badly assigned switch pointers to prevent memory access violation
bool KeyBuddy2::keyPressed[256]={0}; // key states
wchar KeyBuddy2::lastDeadKey; // buffer that stores which dead key was pressed	
wchar KeyBuddy2::ruDeadChar[2]; // the dead characters for the russian keyboard (small and capital)
wchar KeyBuddy2::map[256][7]={0}; // character to send = map[vkCode][mod]
wchar KeyBuddy2::symbolMap[256][7]={0}; // character to draw on keyboard = symbolMap[vkCode][mod]
BYTE KeyBuddy2::neoRemap[256]={0}; // vkNeoKey = neoRemap[vkQWERTZKey]
wchar KeyBuddy2::rumap[256][2]={0}; // cyrillic character = rumap[ansi of latin character][ruDeadKey toggled]
bool* KeyBuddy2::pSwitch[256]={0}; // pointer to the switches
WString KeyBuddy2::keyNames[256]; // names of unmodified keys
wchar KeyBuddy2::upperCaseMap[1023][2]={0}; // mapping lowercase unicode characters to uppercase

KeyBuddy2::KeyBuddy2()
{
	pKB2 = this;
	#ifdef DEBUG
		pdisplay = &display;
	#endif
	
	STARTLOG(SRCPATH "log.html");
	loadMaps();
	hotString::loadHotStrings();
	
	int i;
	for(i=0;i<=255;i++){
		pSwitch[i]=&dummySwitch;
	}
	pSwitch[1]=&neoLevelsActive;
	pSwitch[2]=&neoRemapActive;
	pSwitch[3]=&cyrillicActive;
	pSwitch[4]=&capslockActive;
	pSwitch[5]=&lockLayer4Active;
	pSwitch[6]=&mouseControlActive;

	KeyBuddy2::Zoomable();
	
	Icon(KB2Images::tray(),KB2Images::tray());
	trayicon.Icon(KB2Images::tray());
	trayicon.WhenBar=THISBACK(traymenu);
	trayicon.WhenLeftDown=THISBACK(trayclick);
	trayicon.Tip("KeyBuddy2 (verändert Tastatur)");
	
	CtrlLayout(*this, "KeyBuddy2");
	releaseAllKeys();
	SetHook();
	initKeyButtons();

	NoAccessKeysDistribution();
	
	#ifndef DEBUG
		WhenClose=THISBACK(Hide);
	#endif
	
	ToolWindow();
	TopMost();
}

KeyBuddy2::~KeyBuddy2()
{
	releaseAllKeys();
	RemoveHook();
	ENDLOG;
}

bool KeyBuddy2::ProcessKbdEvent(
		WPARAM upDownInfo,
		DWORD vkCode,
		DWORD scanCode,
		bool isExtended,
		bool isInjected,
		bool isAltDown,
		bool isReleased,
		ULONG_PTR dwExtraInfo)
{

	if(scanCode==0x21d){ // AltGr also presses left Strg but with scancode 0x21d, filter that out, it sucks
		return false;
	}
	if(!isInjected){ // memorize physical key states
		keyPressed[vkCode]=!isReleased;
		if(isReleased){pKeyButton[vkCode]->simUp();}
		else{pKeyButton[vkCode]->simDown();}
	}

	// log information about captured event:
	
	char udi[14]; // up down info string
	char buffer[512];
	//bool forceRedraw=false; // force keyboard redraw
	
	switch(upDownInfo){
		case WM_KEYDOWN:
			sprintf(udi,"WM_KEYDOWN");
			break;
		case WM_KEYUP:
			sprintf(udi,"WM_KEYUP");
			break;
		case WM_SYSKEYDOWN:
			sprintf(udi,"WM_SYSKEYDOWN");
			break;
		case WM_SYSKEYUP:
			sprintf(udi,"WM_SYSKEYUP");
			break;			
		default:
			sprintf(udi,"UNKNOWN");
	}
	
	sprintf(buffer,"upDownInfo: %s\tvkCode: %d (0x%X)\tscanCode: %d (0x%X)\textended: %d\tinjected: %d\taltdown: %d\tup: %d\tdwExtraInfo: %d",
	        udi,vkCode,vkCode,scanCode,scanCode,(int)isExtended,(int)isInjected,(int)isAltDown,(int)isReleased,dwExtraInfo);
	
	LOGG(buffer);
	LOGGNL;

	if(dwExtraInfo==HOTSTRING){ // a hotstring is being sent, dont do anything
		return true;
	}

	// flush the hotstring buffer if certain navi or special keys are pressed (even if they are injected)
	if(vkCode==VK_UP || vkCode==VK_LEFT || vkCode==VK_RIGHT || vkCode==VK_DOWN
		|| vkCode==VK_PRIOR || vkCode==VK_NEXT || vkCode==VK_END || vkCode==VK_HOME
		|| keyPressed[VK_LCONTROL] || keyPressed[VK_RCONTROL]
		|| keyPressed[VK_LWIN] || keyPressed[VK_RWIN] || keyPressed[VK_LMENU]){
			
		hotString::clearBuffer();		
	}
	
	// delete one key from hotstring buffer if backspace is pushed
	if(vkCode==VK_BACK && !isReleased){
		int i;
		for(i=hotString::bufferLen-1;i>0;i--){
			hotString::hsBuffer.Set(i,(int)hotString::hsBuffer[i-1]);
		}
		hotString::hsBuffer.Set(0,(int)0);
	}

	if(isInjected){ // dont stop or change generated key events
		return true;
	}

	// check if the key combination would activate the neo levels
	if(!neoLevelsActive && !isReleased){

		neoLevelsActive=true; // only simulative to fool getNeoMod
		int mod=getNeoMod();
		WORD vkCode_neo;
		
		if(neoRemapActive && (mod==1 || mod==2 || mod==5 || mod==6) || mod==3 || mod==4 || mod==7){
			vkCode_neo=neoRemap[vkCode];
		}
		else{
			vkCode_neo=vkCode;
		}		
		if(map[vkCode_neo][mod-1]!=0xF801){ // keystroke would not activate layers, leave true otherwise
			neoLevelsActive=false; // deactivate again
		}
		else{ // leave activated
			pKB2->drawKeyButtons();
			return false;
		}
	}
	
	// check if the key combination turns off mouse control
	if(mouseControlActive && !isReleased){
		int mod=getNeoMod();
		WORD vkCode_neo;
		
		if(neoRemapActive && (mod==1 || mod==2 || mod==5 || mod==6) || mod==3 || mod==4 || mod==7){
			vkCode_neo=neoRemap[vkCode];
		}
		else{
			vkCode_neo=vkCode;
		}		
		if(map[vkCode_neo][mod-1]==0xF806){ // keystroke deactivates mouse control
			mouseControlActive=false; // deactivate again
			pKB2->drawKeyButtons();
			return false;
		}
	}
	
	// dont do substitutions if neolevels are off or
	// certain functional keys are being pressed or held (getNeoMod returns 0)
	// this means that ctrl+a/x/c/v/z... remain on their standard position
	// also clear hotstring buffer then
	if(getNeoMod()==0 
		|| vkCode==VK_LCONTROL || vkCode==VK_RCONTROL
		|| vkCode==VK_LWIN || vkCode==VK_RWIN
		|| vkCode==VK_LMENU){
			
		// redraw keyboard
		pKB2->drawKeyButtons();	

		return true;
	}

	// capslock
	if(keyPressed[VK_LSHIFT] && keyPressed[VK_RSHIFT]
		&& (vkCode==VK_LSHIFT || vkCode==VK_RSHIFT)
		&& !isReleased){
			capslockActive=!capslockActive;
			pKB2->drawKeyButtons();
	}
	
	// lock 4th layer
	if(keyPressed[VK_MOD_41] && keyPressed[VK_MOD_42]
		&& (vkCode==VK_MOD_41 || vkCode==VK_MOD_42)
		&& !isReleased){
			lockLayer4Active=!lockLayer4Active;
			pKB2->drawKeyButtons();
	}

	// number keys, letter keys, ",", "-", ".", dead keys, space
	if((vkCode>=VK_A && vkCode<=VK_Z) || (vkCode>=VK_0 && vkCode<=VK_9)
		|| vkCode==VK_AE || vkCode==VK_OE || vkCode==VK_UE || vkCode==VK_SZ
		|| vkCode==VK_COMMA || vkCode==VK_DASH || vkCode==VK_DOT
		|| vkCode==VK_CIRCUMFLEX || vkCode==VK_ACUT || vkCode==VK_PLUS
		|| vkCode==VK_SPACE || vkCode==VK_TAB){

		if(mouseControlActive){	
			mouseController::mouseEvent(vkCode,isReleased);
			return false;
		}

		WORD vkCode_neo;
		int mod=getNeoMod();
		
		if(neoRemapActive && (mod==1 || mod==2 || mod==5 || mod==6) || mod==3 || mod==4 || mod==7){
			vkCode_neo=neoRemap[vkCode];
		}
		else{
			vkCode_neo=vkCode;
		}
		
		LOGG("vkCode: ");
		LOGG((int)vkCode);
		LOGG("   vkCode_neo: ");
		LOGG((int)vkCode_neo);
		LOGG("   mod: ");
		LOGG(mod);
				
		if(mod>=1 && mod<=7){
			wchar charToSend=map[vkCode_neo][mod-1];
			
			if(cyrillicActive){
				if(charToSend==ruDeadChar[0] || charToSend==ruDeadChar[1]){
					lastDeadKey=charToSend;
					pKB2->drawKeyButtons();
					return false;
				}
				if(charToSend>0 && charToSend<256){
					if(lastDeadKey==ruDeadChar[0] || lastDeadKey==ruDeadChar[1]){
						charToSend=rumap[charToSend][1];
						lastDeadKey=0;	
						pKB2->drawKeyButtons();
					}
					else{
						charToSend=rumap[charToSend][0];
						lastDeadKey=0;
					}
				}
			}

			if(capslockActive){
				charToSend=upperCase(charToSend);
			}

			LOGG("   sending: ");
			LOGG(charToSend);
			LOGG(" (U+");
			LOGG((int)charToSend);
			LOGG(")");
			LOGGNL;
			
			SendUNIKey(charToSend,isReleased);
			if(!isReleased){
				long focusPtr=hotString::getFocusWindowPtr();
				
				if(focusPtr!=hotString::lastFocusPtr){ // if a new window has the focus, clear the buffer
					hotString::clearBuffer();
					hotString::lastFocusPtr=focusPtr;
				}
				
				hotString::appendBuffer(charToSend);
				hotString::checkHotStrings();
			}
		}
		
		return false;
	}
	
	if(!neoLevelsActive){
		return true;
	}

	// redraw keyboard
	if(vkCode==VK_LSHIFT || vkCode==VK_RSHIFT
		|| vkCode==VK_MOD_31 || vkCode==VK_MOD_32
		|| vkCode==VK_MOD_41 || vkCode==VK_MOD_42
		|| vkCode==VK_LCONTROL || vkCode==VK_RCONTROL){
		pKB2->drawKeyButtons();
	}
	
	// block mod keys that have symbols
	if(vkCode==VK_MOD_32 || vkCode==VK_MOD_41){
		return false;
	}
	
	return true;
}

WString KeyBuddy2::buttonLabel(DWORD vkCode){
	
	wchar res=0;

	if(getNeoMod()==0){
		return keyNames[vkCode];
	}

	// number keys, letter keys, ",", "-", ".", dead keys, tab, space
	if((vkCode>=VK_A && vkCode<=VK_Z) || (vkCode>=VK_0 && vkCode<=VK_9)
		|| vkCode==VK_AE || vkCode==VK_OE || vkCode==VK_UE || vkCode==VK_SZ
		|| vkCode==VK_COMMA || vkCode==VK_DASH || vkCode==VK_DOT
		|| vkCode==VK_CIRCUMFLEX || vkCode==VK_ACUT || vkCode==VK_PLUS
		|| vkCode==VK_TAB || vkCode==VK_SPACE){
		
		WORD vkCode_neo;
		int mod=getNeoMod();
		
		if(mouseControlActive){
			int i;
			for(i=0;i<9;i++){
				if(vkCode==mouseController::mouseKeys[i]){
					res=mouseController::mouseSymbols[i];
					return WString((int)res,1);
				}
			}
			return "";
		}
		
		if(neoRemapActive && (mod==1 || mod==2 || mod==5 || mod==6) || mod==3 || mod==4 || mod==7){
			vkCode_neo=neoRemap[vkCode];
		}
		else{
			vkCode_neo=vkCode;
		}
	
		if(mod>=1 && mod<=7){
			res=symbolMap[vkCode_neo][mod-1];
			
			if(cyrillicActive){
				if(res==ruDeadChar[0] || res==ruDeadChar[1]){
					return WString((int)res,1);
				}
				if(res>0 && res<256){
					if(lastDeadKey==ruDeadChar[0] || lastDeadKey==ruDeadChar[1]){
						res=rumap[res][1];
					}
					else{
						res=rumap[res][0];
					}
				}
			}
			
			if(capslockActive){
				res=upperCase(res);
			}
			
			return WString((int)res,1);
		}
		
	}
	
	switch(vkCode){ // layer-independent keys
		case VK_LSHIFT: case VK_RSHIFT: return WString(0x21e7,1); break;
		case VK_MOD_31: case VK_MOD_32: return WString("Mod3"); break;
		case VK_MOD_41: case VK_MOD_42: return WString("Mod4"); break;
		case VK_RETURN: return WString(0x23cE,1); break;
		case VK_BACK: return WString(0x232b,1); break;
		case VK_LCONTROL: case VK_RCONTROL: return WString("Strg"); break;
		case VK_LMENU: return WString("Alt"); break;
		case VK_LWIN: case VK_RWIN: return WString(0x229e,1)+WString(0x224b,1); break;
		case VK_APPS: return WString(0x2338,1)+WString(0x21d6,1); break;
	}

	return WString("");	
	
}

int KeyBuddy2::getNeoMod(){
	
	if(keyPressed[VK_LCONTROL] || keyPressed[VK_RCONTROL] // functional keys, disable neo stuff
		|| keyPressed[VK_LWIN] || keyPressed[VK_RWIN]
		|| keyPressed[VK_LMENU] || !neoLevelsActive){
			
			return 0;
	}
	
	bool kp2=keyPressed[VK_MOD_21] || keyPressed[VK_MOD_22];
	bool kp3=keyPressed[VK_MOD_31] || keyPressed[VK_MOD_32];
	bool kp4=keyPressed[VK_MOD_41] || keyPressed[VK_MOD_42] || lockLayer4Active;

	if(!kp2 && !kp3 && !kp4){return 1;} // small letters
	
	if( kp2 && !kp3 && !kp4){return 2;} // capital letters
	
	if(!kp2 &&  kp3 && !kp4){return 3;} // special characters
	
	if(!kp2 && !kp3 &&  kp4){return 4;} // numbers/navi
	
	if( kp2 &&  kp3 && !kp4){return 5;} // small greek
	
	if(!kp2 &&  kp3 &&  kp4){return 6;} // capital greek/math
	
	if( kp2 && !kp3 &&  kp4){return 7;} // pseudo layer
	
	return 0;
		
}

void KeyBuddy2::loadMaps(){
	FILE* pFile;
	int i;
	BYTE buffer;
	wchar unibuffer;
	
	#define FGETUC(pbuf,pfile) fread(pbuf,sizeof(wchar),1,pfile)
	
	// QWERTZ keycode -> neo keycode
	
	pFile = fopen(SRCPATH "neomap.txt", "rb");
	if (pFile==NULL) {PromptOK("Can't read neomap.txt"); exit(1);}	
	
	neoRemap[0]=0;
	
	for(i=1;i<=255;i++){ // assuming that no key has keycode 0. Otherwise the linenumber in map.txt does not match the keycode
		buffer=fgetc(pFile);
		if(buffer==13){ // line break, no mapping
			neoRemap[i]=i;
			fgetc(pFile); // skip second line break character
		}
		else{
			neoRemap[i]=buffer;
			fgetc(pFile); // skip line break characters
			fgetc(pFile);
		}
		LOGG("neoRemap ");LOGG(i);LOGG("->");LOGG(neoRemap[i]);LOGGNL;
	}
	fclose(pFile);
		
	
	// keycode -> unicode character to send
	
	pFile = fopen(SRCPATH "sendmap.txt", "rb");
	if (pFile==NULL) {PromptOK("Can't read sendmap.txt"); exit(1);}
	
	fgetc(pFile); // skip BOM
	fgetc(pFile);
	
	memset(map[0],0,7);
	
	for(i=1;i<=255;i++){ // assuming that no key has keycode 0. Otherwise the linenumber in sendmap.txt does not match the keycode
		fread(map[i],sizeof(wchar),7,pFile); // read from file
		fgetc(pFile); // skip line break (make sure to have a line break at the end of the file)
		fgetc(pFile);
		fgetc(pFile);
		fgetc(pFile);
		
		LOGG("key ");LOGG(i);LOGG(": ");LOGG(map[i][0]);LOGG(map[i][1]);LOGG(map[i][2]);LOGG(map[i][3]);LOGG(map[i][4]);LOGG(map[i][5]);LOGG(map[i][6]);LOGGNL;
	}
	fclose(pFile);


	// keycode -> unicode character to draw on keyboard
	
	pFile = fopen(SRCPATH "symbolmap.txt", "rb");
	if (pFile==NULL) {PromptOK("Can't read symbolmap.txt"); exit(1);}
	
	fgetc(pFile); // skip BOM
	fgetc(pFile);
	
	memset(symbolMap[0],0,7);
	
	for(i=1;i<=255;i++){ // assuming that no key has keycode 0. Otherwise the linenumber in symbolmap.txt does not match the keycode
		fread(symbolMap[i],sizeof(wchar),7,pFile); // read from file
		fgetc(pFile); // skip line break (make sure to have a line break at the end of the file)
		fgetc(pFile);
		fgetc(pFile);
		fgetc(pFile);
		
		LOGG("key ");LOGG(i);LOGG(": ");LOGG(map[i][0]);LOGG(map[i][1]);LOGG(map[i][2]);LOGG(map[i][3]);LOGG(map[i][4]);LOGG(map[i][5]);LOGG(map[i][6]);LOGGNL;
	}
	fclose(pFile);


	// latin character -> cyrillic character
	pFile = fopen(SRCPATH "rumap.txt", "rb");
	if (pFile==NULL) {PromptOK("Can't read rumap.txt"); exit(1);}
	
	fgetc(pFile); // skip BOM
	fgetc(pFile);

	rumap[0][0]=0;
	rumap[0][1]=0;

	int idead=0;

	for(i=1;i<=255;i++){
		FGETUC(&unibuffer,pFile);
		if(unibuffer==13){ // line break, no mapping
			rumap[i][0]=i;
			rumap[i][1]=i;
			FGETUC(&unibuffer,pFile); // skip second line break character
		}
		else{
			if(unibuffer==0x2020){ // dagger, symbol for the dead character
				rumap[i][0]=0;
				rumap[i][1]=0;
				ruDeadChar[idead]=i;
				idead++;
				FGETUC(&unibuffer,pFile); // skip line break characters
				FGETUC(&unibuffer,pFile);									
			}
			else{
				rumap[i][0]=unibuffer;
				rumap[i][1]=unibuffer;
				FGETUC(&unibuffer,pFile);
				if(unibuffer==13){ // line break, no special character if dead key is toggled
					FGETUC(&unibuffer,pFile); // skip second line break character
				}
				else{ // special character if cyrillic dead key is toggled
					rumap[i][1]=unibuffer;
					FGETUC(&unibuffer,pFile); // skip line break characters
					FGETUC(&unibuffer,pFile);				
				}
			}
		}
		LOGG("russianRemap ");LOGG(i);LOGG("->");LOGG(rumap[i][0]);LOGG("/");LOGG(rumap[i][1]);LOGGNL;
	}
	fclose(pFile);

	// keycode -> keyname
	
	pFile = fopen(SRCPATH "keynames.txt", "rb");
	if (pFile==NULL) {PromptOK("Can't read keynames.txt"); exit(1);}
	
	fgetc(pFile); // skip BOM
	fgetc(pFile);

	keyNames[0]="";
	for(i=1;i<=255;i++){
		keyNames[i]="";
		
		FGETUC(&unibuffer,pFile);
		while(unibuffer!=13){ // line break
			keyNames[i]=keyNames[i]+unibuffer;
			FGETUC(&unibuffer,pFile);
		}

		FGETUC(&unibuffer,pFile); // skip second line break character
	}
	fclose(pFile);
	
	// lowercase -> uppercase
	
	pFile = fopen(SRCPATH "uppercase.txt", "rb");
	if (pFile==NULL) {PromptOK("Can't read uppercase.txt"); exit(1);}
	
	fgetc(pFile); // skip BOM
	fgetc(pFile);

	i=0;
	while(!feof(pFile) && i<1023){
		FGETUC(&(upperCaseMap[i][0]),pFile);
		FGETUC(&(upperCaseMap[i][1]),pFile);
		i++;
	}
	fclose(pFile);
	
	while(i<1023){
		upperCaseMap[i][0]=0xFFFF;
		upperCaseMap[i][1]=0xFFFF;
		i++;
	}
	   
	// keycode -> mouseevent
	
	pFile = fopen(SRCPATH "mousemap.txt", "rb");
	if (pFile==NULL) {PromptOK("Can't read mousemap.txt"); exit(1);}
	
	fread(mouseController::mouseKeys,sizeof(byte),9,pFile);
	fclose(pFile);
}

void KeyBuddy2::SendUNIKey(wchar key, bool release, ULONG_PTR extraInfo){

	// use unicodes Personal Usage Area (E000-F8FF) specially
	if(key/256>=0xE0 && key/256<=0xF8){ // send keystroke instead of unicode
		byte flags=key/256;
		bool onlyDown=flags<=0xE7;
		bool onlyUp=flags>=0xE8 && flags<=0xEF;
		bool swtch=(flags==0xF8);
		bool shift=(flags & 1)!=0;
		bool ctrl=(flags & 2)!=0;
		bool alt=(flags & 4)!=0;
				
		// E0-E7: only down event gets sent
		// E8-EF: only up event gets sent (but if key is pushed down)
		// F0-F7: down and up according to release parameter
		// F8: switch
		// unicode AND 0x0100 = shift also pressed
		// unicode AND 0x0200 = ctrl also pressed
		// unicode AND 0x0400 = alt also pressed

		if(swtch && !release){
			if(key % 256==0){ // end program
				KeyBuddy2::pKB2->Break();
			}
			if(key % 256==7){ // show / hide GUI
				KeyBuddy2::pKB2->Show(!KeyBuddy2::pKB2->IsShown());
				return;
			}			
			*(KeyBuddy2::pSwitch[key % 256])=!*(KeyBuddy2::pSwitch[key % 256]);
			return;
		}
		
		if((onlyDown || onlyUp) && release){return;}
		
		// first release all other keys
		byte keyboardStateBuffer[256];
		byte allUp[256];
		DWORD unused;
		
		memset(keyboardStateBuffer,0,256);
		memset(allUp,0,256);

		long myThread=GetWindowThreadProcessId(KeyBuddy2::pKB2->GetHWND(),&unused);
		long otherThread=GetWindowThreadProcessId(GetForegroundWindow(),&unused);
		
		if(myThread!=otherThread){
			AttachThreadInput(otherThread,myThread,true);
		}
		
		GetKeyboardState(keyboardStateBuffer);
		SetKeyboardState(allUp);		
		
		// then send the key
		
		INPUT in[4];
		int iIn=0;
		
		for(iIn=0;iIn<4;iIn++){
			in[iIn].type=INPUT_KEYBOARD;
			in[iIn].ki.dwExtraInfo=extraInfo;
			in[iIn].ki.time=0;
			in[iIn].ki.wScan=0;
			in[iIn].ki.dwFlags=0;
			if(release){in[iIn].ki.dwFlags=KEYEVENTF_KEYUP;}
		}
		
		iIn=0;
		
		if(release){ // if we release the buttons, release the key of interest first, then ctrl, alt or shift
			in[iIn].ki.wVk=key % 256;
			iIn++;
		}
		if(ctrl){
			in[iIn].ki.wVk=VK_LCONTROL;
			iIn++;
		}
		if(shift){
			in[iIn].ki.wVk=VK_LSHIFT;
			iIn++;
		}
		if(alt){
			in[iIn].ki.wVk=VK_LMENU;
			iIn++;
		}
		if(!release){ // if we push the buttons, push ctrl alt shift first, then the key of interest
			in[iIn].ki.wVk=key % 256;
			iIn++;
		}			
		
		SendInput(iIn,in,sizeof(INPUT));
		
		Sleep(1); // otherwise the other thread does not see the changed keyboard state
		
		// revert keyboard to its original state
		SetKeyboardState(keyboardStateBuffer);
		
		if(myThread!=otherThread){
			AttachThreadInput(otherThread,myThread,false);
		}
	}
	else{ // only send unicode character
		INPUT in[1];
		in[0].type=INPUT_KEYBOARD;
		in[0].ki.dwExtraInfo=extraInfo;		
		in[0].ki.wVk=0;
		in[0].ki.wScan=key;
		in[0].ki.dwFlags=KEYEVENTF_UNICODE;
		if(release){in[0].ki.dwFlags=in[0].ki.dwFlags | KEYEVENTF_KEYUP;}
		SendInput(1,in,sizeof(INPUT));
	}
}

void KeyBuddy2::releaseAllKeys(){
	BYTE zeros[256]={0};
	SetKeyboardState(zeros);
	for(int i=0;i<256;i++){
		keyPressed[i]=false;
	}
}

void KeyBuddy2::initKeyButtons(){
	int i,j;
	
	for(i=0; i<7; i++){
		buttonStyle[i] = Button::StyleNormal();
		for(j=0;j<4;j++){
			buttonStyle[i].look[j] = KB2Images::Get(i);
		}
		buttonStyle[i].look[2] = KB2Images::Get(1);
		buttonStyle[i].pressoffset = Point(0,0);
	}
	
	for(i=0;i<256;i++){
		pKeyButton[i]=&but_invis;
		keyFinger[i]=0;
	}
	
	but_invis.Hide();

	#include "keybuttons.inc"
	
	int bfid=buttonFont.FindFaceNameIndex("unifont");
	buttonFont.Face(bfid);
	buttonFontU.Face(bfid);
	buttonFontU.Underline();
	smallButtonFont.Face(bfid);
	buttonFont.Height(32);
	buttonFontU.Height(32);
	smallButtonFont.Height(16);
	
	for(i=0;i<256;i++){
		pKeyButton[i]->SetStyle(buttonStyle[keyFinger[i]]);
		if(i==VK_MOD_31 || i==VK_MOD_32 || i==VK_MOD_41 || i==VK_MOD_42
			|| i==VK_LMENU || i==VK_LCONTROL || i==VK_RCONTROL){
			pKeyButton[i]->SetFont(smallButtonFont);
		}
		else{
			if(i==VK_A || i==VK_S || i==VK_D || i==VK_F
				|| i==VK_J || i==VK_K || i==VK_L || i==VK_OE){
				pKeyButton[i]->SetFont(buttonFontU);
			}
			else{
				pKeyButton[i]->SetFont(buttonFont);
			}
		}
		
		pKeyButton[i]->SetLabel(ToUtf8(buttonLabel(i)));
		//pKeyButton[i]->Disable();
	}
}

void KeyBuddy2::drawKeyButtons(){
	int i;
	String newLabel,oldLabel;

	for(i=0;i<256;i++){
		newLabel=ToUtf8(buttonLabel(i));
		oldLabel=pKeyButton[i]->GetLabel();
		if(!newLabel.IsEqual(oldLabel)){
			if(!pKeyButton[i]->isPushed()){
				pKeyButton[i]->SetLabel(newLabel);
			}
			else{
				pKeyButton[i]->simUp();
				pKeyButton[i]->SetLabel(newLabel);
				pKeyButton[i]->simDown();
			}
		}
	}
}

wchar KeyBuddy2::upperCase(wchar letter){
	int a=0,b=1022,c;
	
	while(a<=b){
		c=(a+b)/2;
		if( letter< upperCaseMap[c][0] ){b=c-1; continue;}
		if( letter> upperCaseMap[c][0] ){a=c+1; continue;}
		if( letter==upperCaseMap[c][0] ){return upperCaseMap[c][1];}
	}
	
	return letter;
}

GUI_APP_MAIN
{
	KeyBuddy2().Run();	
}

