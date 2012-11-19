#include "includes.h"

int mouseController::vx=0;
int mouseController::vy=0;
	
byte mouseController::mouseKeys[9]={0};
bool mouseController::mouseButtonStates[3]={0};

wchar mouseController::mouseSymbols[9]={0x15CF,0x15CB,0x15CC,0x15CA,0x15E1,0x15DE,0x15DD,0x15E3,0x15E2};

// generate mouse event for the specified button
void mouseController::mouseEvent(DWORD vkCode, bool isReleased){
	
	INPUT in;
	memset(&in,0,sizeof(INPUT));
	in.type=INPUT_MOUSE;

	if(vkCode==mouseKeys[MOUSE_MOVE_L]){
			if(isReleased){
				vx=0;
				return;
			}
			if(vx>0){vx=0;}
			if(vx>-20){vx--;}
			in.mi.dx=vx;
			in.mi.dwFlags=MOUSEEVENTF_MOVE;
	}
	else if(vkCode==mouseKeys[MOUSE_MOVE_R]){
			if(isReleased){
				vx=0;
				return;
			}
			if(vx<0){vx=0;}
			if(vx<20){vx++;}
			in.mi.dx=vx;
			in.mi.dwFlags=MOUSEEVENTF_MOVE;
	}
	else if(vkCode==mouseKeys[MOUSE_MOVE_U]){
			if(isReleased){
				vy=0;
				return;
			}
			if(vy>0){vy=0;}
			if(vy>-20){vy--;}
			in.mi.dy=vy;
			in.mi.dwFlags=MOUSEEVENTF_MOVE;
	}
	else if(vkCode==mouseKeys[MOUSE_MOVE_D]){
			if(isReleased){
				vy=0;
				return;
			}
			if(vy<0){vy=0;}
			if(vy<20){vy++;}
			in.mi.dy=vy;
			in.mi.dwFlags=MOUSEEVENTF_MOVE;
	}
	else if(vkCode==mouseKeys[MOUSE_BUTTON_L]){
			if(!isReleased && mouseButtonStates[0]){return;} // dont resend clicks
			if(!isReleased){
				in.mi.dwFlags=MOUSEEVENTF_LEFTDOWN;
				mouseButtonStates[0]=true;
			}
			else{
				in.mi.dwFlags=MOUSEEVENTF_LEFTUP;
				mouseButtonStates[0]=false;
			}
	}
	else if(vkCode==mouseKeys[MOUSE_BUTTON_R]){
			if(!isReleased && mouseButtonStates[1]){return;} // dont resend clicks
			if(!isReleased){
				in.mi.dwFlags=MOUSEEVENTF_RIGHTDOWN;
				mouseButtonStates[1]=true;
			}
			else{
				in.mi.dwFlags=MOUSEEVENTF_RIGHTUP;
				mouseButtonStates[1]=false;
			}
	}
	else if(vkCode==mouseKeys[MOUSE_BUTTON_M]){
			if(!isReleased && mouseButtonStates[2]){return;} // dont resend clicks
			if(!isReleased){
				in.mi.dwFlags=MOUSEEVENTF_MIDDLEDOWN;
				mouseButtonStates[2]=true;
			}
			else{
				in.mi.dwFlags=MOUSEEVENTF_MIDDLEUP;
				mouseButtonStates[2]=false;
			}
	}
	else if(vkCode==mouseKeys[MOUSE_SCROLL_U]){
			if(isReleased){return;}
			in.mi.dwFlags=MOUSEEVENTF_WHEEL;
			in.mi.mouseData=WHEEL_DELTA;
	}
	else if(vkCode==mouseKeys[MOUSE_SCROLL_D]){
			if(isReleased){return;}
			in.mi.dwFlags=MOUSEEVENTF_WHEEL;
			in.mi.mouseData=-WHEEL_DELTA;
	}
	else{
		return; // do not call sendinput
	}
	
	// send mouse event
	SendInput(1,&in,sizeof(INPUT));
}
