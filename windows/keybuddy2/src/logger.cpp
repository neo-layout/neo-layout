
#include "includes.h"

FILE* plogfile;
char linebuffer[2048]={0};

void startLog(const char* fname){
	plogfile=fopen(fname, "wb");
}

void logg(const char* txt){
	fprintf(plogfile,"%s",txt);
	sprintf(linebuffer,"%s%s",linebuffer,txt);
}

void logg(WString txt){
	String utf8=ToUtf8(txt);
	fprintf(plogfile,"%s",utf8.Begin());
	sprintf(linebuffer,"%s%s",linebuffer,utf8.Begin());
}

void logg(bool b){
	if(b){
		fprintf(plogfile,"true");
		strcat(linebuffer,"true");
	}
	else{
		fprintf(plogfile,"false");
		strcat(linebuffer,"false");	
	}
}

void logg(int num){
	fprintf(plogfile,"%d",num);
	sprintf(linebuffer,"%s%d",linebuffer,num);	
}

void logg(double num){
	fprintf(plogfile,"%f",num);
	sprintf(linebuffer,"%s%f",linebuffer,num);		
}

void logg(wchar uni){
	fprintf(plogfile,"&#%d;",uni);
	sprintf(linebuffer,"%s[U+%d]",linebuffer,uni);
}

void loggnl(){
	fprintf(plogfile,"<br>\n");
	sprintf(linebuffer,"%s\n",linebuffer);
	KeyBuddy2::pdisplay->Insert(0,linebuffer);
	memset(linebuffer,0,sizeof(linebuffer));
}

void endLog(){
	fclose(plogfile);
}
