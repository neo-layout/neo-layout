#ifndef _KeyBuddy2_mousecontrol_h_
#define _KeyBuddy2_mousecontrol_h_

#include "includes.h"

class mouseController{
	
public:
	static int vx,vy; // mouse velocity
	
	static byte mouseKeys[9];
	static bool mouseButtonStates[3];
	static wchar mouseSymbols[9];
	
	static void mouseEvent(DWORD vkCode, bool isReleased);
	
};






#endif
