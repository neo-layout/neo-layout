#ifndef _KeyBuddy2_includes_h_
#define _KeyBuddy2_includes_h_

// custom #defines:
//#define DEBUG

#ifdef DEBUG
	//#define SRCPATH "C:/Eigene Dateien/c-gefrickel/KeyBuddy2/"
	#define SRCPATH ""
#else
	#define SRCPATH ""
#endif

#define HOTSTRING 0x80 // random number

#include "keydefines.inc"
#include "mousedefines.inc"

// includes and functional defines

#define WINVER 0x0500 // otherwise SendInput and KEYEVENTF_UNICODE are unknown
#include <CtrlLib/CtrlLib.h>
using namespace Upp;

#include "keyButton.h"

#ifdef DEBUG
	#define LAYOUTFILE <KeyBuddy2/KeyBuddy2_debug.lay>
#else
	#define LAYOUTFILE <KeyBuddy2/KeyBuddy2.lay>
#endif

#include <CtrlCore/lay.h>

#include <windows.h>
#include <stdio.h>
#include <stdlib.h>

#include "hookfuncs.h" // windows api specific functions needed for keyboard hook
#include "KeyBuddy2.h" // programm class
#include "logger.h" // logging functions for debug
#include "hotstrings.h" // logging and replacing for hotstrings
#include "mousecontrol.h" // well, mouse control

#endif
