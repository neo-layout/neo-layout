
#include "includes.h"

HHOOK hHookKB2=NULL;

// install low level keyboard hook
int SetHook()
{
    int err = 0;
    hHookKB2 = SetWindowsHookEx(WH_KEYBOARD_LL, (HOOKPROC)LowLevelKeyboardProc, GetModuleHandle( NULL ),0);
    if(hHookKB2==NULL)
    {
        err = (int)GetLastError();
        return err;
    }
    return 0;
}

// remove low level keyboard hook
int RemoveHook()
{
    BOOL Hbool = 0;
    int err = 0;
    Hbool = UnhookWindowsHookEx(hHookKB2);
    if(Hbool == 0)
    {
        err = (int)GetLastError();
        return err;
    }
    return 0;
}

// this function is called by windows if a key is pressed
LRESULT CALLBACK LowLevelKeyboardProc(int nCode, WPARAM wParam, LPARAM lParam)
{
    KBDLLHOOKSTRUCT *kbdl_struct;
    
    if(nCode != HC_ACTION){
	    return ( CallNextHookEx(hHookKB2, nCode, wParam, lParam) );
    }

    kbdl_struct = (KBDLLHOOKSTRUCT*) lParam;

	if(KeyBuddy2::ProcessKbdEvent(
		wParam,
		kbdl_struct->vkCode,
		kbdl_struct->scanCode,
		(kbdl_struct->flags & LLKHF_EXTENDED) !=0,
		(kbdl_struct->flags & LLKHF_INJECTED) !=0,
		(kbdl_struct->flags & LLKHF_ALTDOWN) !=0,
		(kbdl_struct->flags & LLKHF_UP) !=0,
		kbdl_struct->dwExtraInfo))
	{
		return ( CallNextHookEx(hHookKB2, nCode, wParam, lParam) );
	}
	else
	{
		return 1;
	}
}
