#include "includes.h"

hotString* hotString::pHotStrings=NULL;
int hotString::numHotStrings=0;
WString hotString::hsBuffer;
int hotString::bufferLen=0;
long hotString::lastFocusPtr=0;

// load all hotstrings from file
void hotString::loadHotStrings(){
	
	// in a first pass, just rush through the file and count the number of hotstrings
	
	FILE* pFile;
	int i;
	char buffer;
	wchar unibuffer;
	
	#define FGETUC(pbuf,pfile) fread(pbuf,sizeof(wchar),1,pfile)

	numHotStrings=0;
	bool valueEnd;
	
	pFile = fopen(SRCPATH "hotstrings.txt", "rb");
	if (pFile==NULL) {PromptOK("Can't read hotstrings.txt"); exit(1);}	
	
	fgetc(pFile); // skip BOM
	fgetc(pFile);
	
	while(!feof(pFile)){
		FGETUC(&unibuffer,pFile); // read identifier
		if(	unibuffer>=97 && unibuffer<=122 ){
			
			FGETUC(&unibuffer,pFile); // read =
			FGETUC(&unibuffer,pFile); // read "
			
			valueEnd=false;
			while(!valueEnd){
				FGETUC(&unibuffer,pFile);
				if(unibuffer==34){valueEnd=true;} // read " -> end of value
				if(unibuffer==92){FGETUC(&unibuffer,pFile);} // read \ -> skip next character
			}
			FGETUC(&unibuffer,pFile); // read separator
			if(unibuffer==13){ // line break -> entry complete
				numHotStrings++;
				FGETUC(&unibuffer,pFile); // read chr10
			}
		}
	}

	// now allocate as much memory as needed
	pHotStrings = new hotString[numHotStrings];
	
	// now go through in a second pass and store hotstrings
	int iEntry=0;
	
	rewind(pFile);	
	
	fgetc(pFile); // skip BOM
	fgetc(pFile);
	
	WString* pTarget=NULL;
	fpos_t valueStart;
	int valueLength;
	bool isH;	
	
	while(!feof(pFile)){
		FGETUC(&unibuffer,pFile); // read identifier
		if(feof(pFile)){break;} // sometimes the first feof didnt indicate the end, so check again after read operatio

		isH=false;

		switch(unibuffer){
			case 'h':
			case 'H':
				pTarget=&(hotString::pHotStrings[iEntry].hs);
				isH=true;
				break;
			case 'c':
			case 'C':
				pTarget=&(hotString::pHotStrings[iEntry].winClass);
				break;
			case 't':
			case 'T':
				pTarget=&(hotString::pHotStrings[iEntry].winTitle);
				break;
			case 's':
			case 'S':
				pTarget=&(hotString::pHotStrings[iEntry].value);
				hotString::pHotStrings[iEntry].launch=false;
				break;											
			case 'l':
			case 'L':
				pTarget=&(hotString::pHotStrings[iEntry].value);
				hotString::pHotStrings[iEntry].launch=true;
				break;
			default:
				PromptOK("Error parsing hotstrings.txt: unknown element"); exit(1);
		}		
		
		FGETUC(&unibuffer,pFile); // read =
		FGETUC(&unibuffer,pFile); // read "
		
		fgetpos(pFile, &valueStart);
		
		// read value first to determine its length, then again and store

		valueEnd=false;
		valueLength=0;
		while(!valueEnd){
			FGETUC(&unibuffer,pFile);
			if(unibuffer==34){ // read " -> end of value
				valueEnd=true;
			}
			else{
				if(unibuffer==92){ // read \ -> dont check next character
					FGETUC(&unibuffer,pFile);
					valueLength++;
				}
				else{ // increase number of chars
					valueLength++;
				}
			}
		}
		
		if(isH && valueLength>bufferLen){
			bufferLen=valueLength;
		}
		
		*pTarget = WString(0,valueLength);
		fsetpos(pFile, &valueStart);
		for(i=0;i<valueLength;i++){
			FGETUC(&unibuffer,pFile);
			if(unibuffer==92){FGETUC(&unibuffer,pFile);} // read \ -> skip to next character
			pTarget->Set(i,unibuffer);
		}
		
		FGETUC(&unibuffer,pFile); // read "
		FGETUC(&unibuffer,pFile); // read separator
		if(unibuffer==13){ // line break -> entry complete
			LOGG("Read hotstring: hs=");LOGG(pHotStrings[iEntry].hs);
			LOGG(" winTitle=");LOGG(pHotStrings[iEntry].winTitle);
			LOGG(" winClass=");LOGG(pHotStrings[iEntry].winClass);
			LOGG(" value=");LOGG(pHotStrings[iEntry].value);LOGGNL;			
			iEntry++;
			FGETUC(&unibuffer,pFile); // read chr10
		}
	}
	fclose(pFile);
	
	// create log buffer as long as the longest hotstring
	hsBuffer = WString(0,bufferLen);

	// sort list
	qsort(pHotStrings,numHotStrings,sizeof(hotString),compareHotStrings);
	
}

// compare the hotstringbuffer to all hotstrings and fire if there is a match
// to be more efficient, this could be done using a trie
// however, c++ takes very few time to compare thousands of strings, so this was
// not considered necessary
void hotString::checkHotStrings(){
	int i,k;
	bool hit;
	
	for(i=0;i<numHotStrings;i++){
		
		if(pHotStrings[i].hs.IsEqual(hsBuffer.Right(pHotStrings[i].hs.GetLength()))){ // current hotstring matches typed letters
			
			hit=false;
			
			if(pHotStrings[i].winClass.IsEmpty() && pHotStrings[i].winTitle.IsEmpty()){ // no further conditions, send
				hit=true;
			}
			else{ // check if focus object class and foreground window title match
				WString wt,oc;
				getFocusInfo(oc,wt);

				if( (pHotStrings[i].winClass.IsEmpty() || pHotStrings[i].winClass.IsEqual(oc)) 
					&& (pHotStrings[i].winTitle.IsEmpty() || wt.Find(pHotStrings[i].winTitle)>-1) ){ // ok, everything matches, fire!
					
					hit=true;
				}
			}
			
			if(hit){
							
				for(k=0;k<pHotStrings[i].hs.GetLength();k++){ // backspaces to delete the typement
					KeyBuddy2::SendUNIKey(0xF008,false,HOTSTRING);
					KeyBuddy2::SendUNIKey(0xF008,true,HOTSTRING);
				}
				
				if(!pHotStrings[i].launch){ // send string
					for(k=0;k<pHotStrings[i].value.GetLength();k++){
						KeyBuddy2::SendUNIKey(pHotStrings[i].value[k],false,HOTSTRING);
						KeyBuddy2::SendUNIKey(pHotStrings[i].value[k],true,HOTSTRING);
					}
					break;
					clearBuffer();
				}
				else{ // launch program
					WString cmd=pHotStrings[i].value;

					WString path,exe,params;
					int delim1=-2,delim2=-2;
					
					delim1=cmd.Find("|");
					if(delim1==-1){
						path="";
						exe=cmd;
						params="";
					}
					else{
						delim2=cmd.Find("|",delim1+1);

						if(delim2==-1){
							path=cmd.Left(delim1);
							exe=cmd.Mid(delim1+1);;
							params="";
						}
						else{
							path=cmd.Left(delim1);
							exe=cmd.Mid(delim1+1,delim2-delim1-1);
							params=cmd.Mid(delim2+1);
						}
					}

					ShellExecuteW( NULL, NULL, exe, params, path, SW_SHOWNORMAL );

					LOGG("working directory: ");LOGG(path);LOGGNL;
					LOGG("exe: ");LOGG(exe);LOGGNL;
					LOGG("params: ");LOGG(params);LOGGNL;
				}
			}
		}
	}
}

long hotString::getFocusWindowPtr(){

	DWORD unused;

	long myThread=GetWindowThreadProcessId(KeyBuddy2::pKB2->GetHWND(),&unused);
	long otherThread=GetWindowThreadProcessId(GetForegroundWindow(),&unused);
	
	if(myThread!=otherThread){
		AttachThreadInput(otherThread,myThread,true);
	}
	
	long result=(long)GetFocus();
	
	if(myThread!=otherThread){
		AttachThreadInput(otherThread,myThread,false);
	}

	return result;
}

void hotString::getFocusInfo(WString& objectClass, WString& parentTitle){

	char buffer[256];
	GetClassName((HWND)getFocusWindowPtr(),buffer,255);
	objectClass=WString(buffer);

	GetWindowText(GetForegroundWindow(),buffer,255);
	parentTitle=WString(buffer);
}
