#ifndef _KeyBuddy2_hotstrings_h_
#define _KeyBuddy2_hotstrings_h_

#include "includes.h"

// when certain strings are typed ("hotstrings"), they get replaced or they launch programs

class hotString{
	public:
	WString hs; // string that activates this hotstring when typed
	WString winTitle; // only if the window that has the focus contains this string
	WString winClass; // only if the window that has the focus is of this class
	WString value; // string that is to be sent / program that is to be launched
	bool launch; // false = send the string in value, true = launch program with name value
	//launching: "xxx|yyy|zzz" will run program yyy with parameters zzz in working directory xxx

	static hotString* pHotStrings; // pointer to the array of hotstrings
	static int numHotStrings; // number of hotstrings
	static WString hsBuffer; // the buffer that is filled with letters while typing
	// after each sent character, the end of the buffer is compared to all the hotstrings in the list
	// if there is a match, the hotstring is activated
	static int bufferLen; // number of letters in the buffer
	static long lastFocusPtr; // the window that had the focus while the last character was typed
	// if the window changes, the hotstring buffer is cleared
	
	static void loadHotStrings();
	static void clearBuffer(){hsBuffer = WString(0,bufferLen);};
	static void appendBuffer(wchar c){ // appends one character to the buffer
		int i;
		for(i=0;i<bufferLen-1;i++){
			hsBuffer.Set(i,(int)hsBuffer[i+1]);
		}
		hsBuffer.Set(bufferLen-1,(int)c);
	};
	
	// compare the length of two hotstrings and return the difference, so qsort can sort the hotstringlist by length
	static int compareHotStrings(const void * pa, const void * pb){
		hotString* a=(hotString*)pa;
		hotString* b=(hotString*)pb;
		
		return b->hs.GetLength() - a->hs.GetLength();
	}
	// the list needs to be sorted: if the user types "abcde" and both "cde" and "de" are hotstrings,
	// always the longer one is to be used and will be picked when the list is checked from long to short
	
	static void checkHotStrings(); // check if the typed characters activate a hotstring and activates it
	static long getFocusWindowPtr(); // get the pointer to the object that has the focus
	static void getFocusInfo(WString& objectClass, WString& parentTitle); // get classname of this object
	                                                                      // and the title of its parent window
	
};

#endif
