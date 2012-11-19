#ifndef _KeyBuddy2_KeyBuddy2_h
#define _KeyBuddy2_KeyBuddy2_h

#include "includes.h"

// main class of the program
class KeyBuddy2 : public WithKeyBuddy2Layout<TopWindow> {
public:

	typedef KeyBuddy2 CLASSNAME;
	KeyBuddy2(); // init stuff
	~KeyBuddy2(); // clean up stuff
	
	Button::Style buttonStyle[7]; // standard/pushed/index finger/middle finger/ring finger/small finger
	Font buttonFont;
	Font smallButtonFont;
	Font buttonFontU;
	
	TrayIcon trayicon;
	void trayclick(){Show(!IsShown());}
	void traymenu(Bar& bar){bar.Add(t_("Exit"), THISBACK(closeProgram));}
	void closeProgram(){Break();}

	static KeyBuddy2* pKB2; // pointer to the main class instance
	static LineEdit* pdisplay; // pointer to the display
	static keyButton* pKeyButton[256]; // pointers to gui key buttons
	static BYTE keyFinger[256]; // which finger is associated to this key (=style index)
	
	static bool neoLevelsActive; // whether the additional layers of neo are active
	static bool neoRemapActive; // false=qwertz layout, true=neo layout
	static bool cyrillicActive; // if roman letters are translated into cyrillic
	static bool capslockActive; // if capital letters shall be sent
	static bool lockLayer4Active; // if neo layer 4 is locked
	static bool mouseControlActive; // if mouse control via keyboard is active
	static bool dummySwitch; // that is switched by badly assigned switch pointers to prevent memory access violation
	static bool keyPressed[256]; // key state	
	static wchar lastDeadKey; // buffer that stores which dead key was pressed
	static wchar ruDeadChar[2]; // the dead characters for the russian keyboard (small and capital)
	static wchar map[256][7]; // character to send = map[vkCode][mod]
	static wchar symbolMap[256][7]; // character to draw on keyboard = map[vkCode][mod]
	static BYTE neoRemap[256]; // vkNeoKey = neoRemap[vkQWERTZKey]
	static wchar rumap[256][2]; // cyrillic character = rumap[ansi of latin character][ruDeadKey toggled]
	static bool* pSwitch[256]; // pointer to the switches
	static WString keyNames[256]; // names of unmodified keys
	static wchar upperCaseMap[1023][2]; // mapping lowercase unicode characters to uppercase
	
	// this function gets called by the hook callback procedure:
	static bool ProcessKbdEvent( // return true: pass event, return false: block event
		WPARAM upDownInfo, //WM_KEYDOWN, WM_KEYUP, WM_SYSKEYDOWN or WM_SYSKEYUP
		DWORD vkCode, // virtual keycode
		DWORD scanCode, // scancode
		bool isExtended, // no clue
		bool isInjected, // if it is a simulated keystroke
		bool isAltDown, // if alt is down
		bool isReleased, // if key was not pushed down but released
		ULONG_PTR dwExtraInfo);
	
	static WString buttonLabel(DWORD vkCode); // which char appears on the button with this keycode?
	
	static int getNeoMod(); // which mod key combination is pressed?
	
	static void SendUNIKey(wchar key, bool release, ULONG_PTR extraInfo=0); // send one virtual unicode key
		// if the first byte of 'key' is 0xF8, then the other byte
		// is interpreted as virtual keycode, not unicode character
		// F8 was chosen because it lies at the end of the "Private Use Area" of unicode
	
	static void releaseAllKeys(); // release all keys
	
	static void loadMaps(); // loads the maps
		// QWERTZ keycode -> neo keycode (neomap.txt, ANSI)
		// keycode -> character (charmap.txt, UCS-2 little endian)
		// latin character -> russian character (rumap.txt, UCS-2 little endian)
		// keycode -> keyname on unmodified keyboard

	void initKeyButtons();
	void drawKeyButtons();

	static wchar upperCase(wchar letter); // uppercase of unicode letter (for capslock)
};

#endif


