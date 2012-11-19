#ifndef _KeyBuddy2_hookfuncs_h_
#define _KeyBuddy2_hookfuncs_h_

#include "includes.h"

int SetHook();
int RemoveHook();
LRESULT CALLBACK LowLevelKeyboardProc(int nCode, WPARAM wParam, LPARAM lParam);

#endif
