#ifndef _KeyBuddy2_logger_h_
#define _KeyBuddy2_logger_h_

#include "includes.h"

// Logging functions
// if DEBUG is enabled, these functions display debug messages in the GUI and into an html file

#ifdef DEBUG
	#define STARTLOG(FNAME) startLog(FNAME)
	#define LOGG(ARG) logg(ARG)
	#define LOGGNL loggnl()
	#define ENDLOG endLog()
	
	void startLog(const char* fname);
	void logg(const char* txt);
	void logg(WString txt);
	void logg(int num);
	void logg(double num);
	void logg(wchar uni);
	void loggnl();
	void endLog();	
#else
	#define STARTLOG(FNAME)  
	#define LOGG(ARG)
	#define LOGGNL
	#define ENDLOG  
#endif

#endif
