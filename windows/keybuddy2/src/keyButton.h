#ifndef _KeyBuddy2_keyButton_h_
#define _KeyBuddy2_keyButton_h_

// custom button class, that is extended by simulated pushes and releases
class keyButton:public Button{
public:
	int finger; // for which finger is this button? (determines the drawing color)
	void simDown(){
		if(IsReadOnly() || !IsEnabled() || IsPush()) return;
		KeyPush();
		Sync();
	}
	void simUp(){
		if(!IsPush()) return;
		FinishPush();
		Sync();
	}
	bool isPushed(){
		return IsPush();
	}
	void LeftDown(Point, dword){}; // overwrite mouse action so buttons do not react to clicking
	void LeftUp(Point, dword){};
};

#endif
