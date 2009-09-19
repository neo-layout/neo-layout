/***************************************************************************\
* Module Name: KBDNEO2.C
*
* keyboard layout for German NEO 2.0
*
* History:
\***************************************************************************/

#include <windows.h>
#include "kbd.h"
#include "kbdneo2.h"

#if defined(_M_IA64)
#pragma section(".data")
#define ALLOC_SECTION_LDATA __declspec(allocate(".data"))
#else
#pragma data_seg(".data")
#define ALLOC_SECTION_LDATA
#endif

/***************************************************************************\
* ausVK[] - Virtual Scan Code to Virtual Key conversion table for German
\***************************************************************************/

static ALLOC_SECTION_LDATA USHORT ausVK[] = {
    T00, T01, T02, T03, T04, T05, T06, T07,
    T08, T09, T0A, T0B, T0C, T0D, T0E, T0F,
    T10, T11, T12, T13, T14, T15, T16, T17,
    T18, T19, T1A, T1B, T1C, T1D, T1E, T1F,
    T20, T21, T22, T23, T24, T25, T26, T27,
    T28, T29, T2A, T2B, T2C, T2D, T2E, T2F,
    T30, T31, T32, T33, T34, T35,

    /*
     * Right-hand Shift key must have KBDEXT bit set.
     */
    T36 | KBDEXT,

    T37 | KBDMULTIVK,               // numpad_* + Shift/Alt -> SnapShot

    T38, T39, T3A, T3B, T3C, T3D, T3E,
    T3F, T40, T41, T42, T43, T44,

    /*
     * NumLock Key:
     *     KBDEXT     - VK_NUMLOCK is an Extended key
     *     KBDMULTIVK - VK_NUMLOCK or VK_PAUSE (without or with CTRL)
     */
    T45 | KBDEXT | KBDMULTIVK,

    T46 | KBDMULTIVK,

    /*
     * Number Pad keys:
     *     KBDNUMPAD  - digits 0-9 and decimal point.
     *     KBDSPECIAL - require special processing by Windows
     */
    T47 | KBDNUMPAD | KBDSPECIAL,   // Numpad 7 (Home)
    T48 | KBDNUMPAD | KBDSPECIAL,   // Numpad 8 (Up),
    T49 | KBDNUMPAD | KBDSPECIAL,   // Numpad 9 (PgUp),
    T4A,
    T4B | KBDNUMPAD | KBDSPECIAL,   // Numpad 4 (Left),
    T4C | KBDNUMPAD | KBDSPECIAL,   // Numpad 5 (Clear),
    T4D | KBDNUMPAD | KBDSPECIAL,   // Numpad 6 (Right),
    T4E,
    T4F | KBDNUMPAD | KBDSPECIAL,   // Numpad 1 (End),
    T50 | KBDNUMPAD | KBDSPECIAL,   // Numpad 2 (Down),
    T51 | KBDNUMPAD | KBDSPECIAL,   // Numpad 3 (PgDn),
    T52 | KBDNUMPAD | KBDSPECIAL,   // Numpad 0 (Ins),
    T53 | KBDNUMPAD | KBDSPECIAL,   // Numpad . (Del),

    T54, T55, T56, T57, T58, T59, T5A, T5B,
    T5C, T5D, T5E, T5F, T60, T61, T62, T63,
    T64, T65, T66, T67, T68, T69, T6A, T6B,
    T6C, T6D, T6E, T6F, T70, T71, T72, T73,
    T74, T75, T76, T77, T78, T79, T7A, T7B,
    T7C, T7D, T7E

};

static ALLOC_SECTION_LDATA VSC_VK aE0VscToVk[] = {
        { 0x10, X10 | KBDEXT              },  // Speedracer: Previous Track
        { 0x19, X19 | KBDEXT              },  // Speedracer: Next Track
        { 0x1D, X1D | KBDEXT              },  // RControl
        { 0x20, X20 | KBDEXT              },  // Speedracer: Volume Mute
        { 0x21, X21 | KBDEXT              },  // Speedracer: Launch App 2
        { 0x22, X22 | KBDEXT              },  // Speedracer: Media Play/Pause
        { 0x24, X24 | KBDEXT              },  // Speedracer: Media Stop
        { 0x2E, X2E | KBDEXT              },  // Speedracer: Volume Down
        { 0x30, X30 | KBDEXT              },  // Speedracer: Volume Up
        { 0x32, X32 | KBDEXT              },  // Speedracer: Browser Home
        { 0x35, X35 | KBDEXT              },  // Numpad Divide
        { 0x37, X37 | KBDEXT              },  // Snapshot
        { 0x38, X38 | KBDEXT              },  // RMenu
        { 0x47, X47 | KBDEXT              },  // Home
        { 0x48, X48 | KBDEXT              },  // Up
        { 0x49, X49 | KBDEXT              },  // Prior
        { 0x4B, X4B | KBDEXT              },  // Left
        { 0x4D, X4D | KBDEXT              },  // Right
        { 0x4F, X4F | KBDEXT              },  // End
        { 0x50, X50 | KBDEXT              },  // Down
        { 0x51, X51 | KBDEXT              },  // Next
        { 0x52, X52 | KBDEXT              },  // Insert
        { 0x53, X53 | KBDEXT              },  // Delete
        { 0x5B, X5B | KBDEXT              },  // Left Win
        { 0x5C, X5C | KBDEXT              },  // Right Win
        { 0x5D, X5D | KBDEXT              },  // Application
        { 0x5F, X5F | KBDEXT              },  // Speedracer: Sleep
        { 0x65, X65 | KBDEXT              },  // Speedracer: Browser Search
        { 0x66, X66 | KBDEXT              },  // Speedracer: Browser Favorites
        { 0x67, X67 | KBDEXT              },  // Speedracer: Browser Refresh
        { 0x68, X68 | KBDEXT              },  // Speedracer: Browser Stop
        { 0x69, X69 | KBDEXT              },  // Speedracer: Browser Forward
        { 0x6A, X6A | KBDEXT              },  // Speedracer: Browser Back
        { 0x6B, X6B | KBDEXT              },  // Speedracer: Launch App 1
        { 0x6C, X6C | KBDEXT              },  // Speedracer: Launch Mail
        { 0x6D, X6D | KBDEXT              },  // Speedracer: Launch Media Selector
        { 0x1C, X1C | KBDEXT              },  // Numpad Enter
        { 0x46, X46 | KBDEXT              },  // Break (Ctrl + Pause)
        { 0,      0                       }
};

static ALLOC_SECTION_LDATA VSC_VK aE1VscToVk[] = {
        { 0x1D, Y1D                       },  // Pause
        { 0   ,   0                       }
};

/***************************************************************************\
* aVkToBits[]  - map Virtual Keys to Modifier Bits
*
* See kbd.h for a full description.
\***************************************************************************/
// Es wird nicht zwischen linken und/oder rechtem Modifier unterschieden
static ALLOC_SECTION_LDATA VK_TO_BIT aVkToBits[] = {
    { VK_SHIFT		,	KBDSHIFT	},
    { VK_CONTROL	,	KBDCTRL		},    
    { VK_MENU		,	KBDALT		},
    { VK_OEM_8		,	KBDKANA		}, //Mod 4
    { VK_OEM_102	,	16			}, //Mod 3
    { 0				,	0			}
};

/***************************************************************************\
* aModification[]  - map character modifier bits to modification number
*
* See kbd.h for a full description.
*
\***************************************************************************/

static ALLOC_SECTION_LDATA MODIFIERS CharModifiers = {
	&aVkToBits[0],
	25, //Anzahl der verwendeten Ebenen (inklusive der INVALIDen!)
	{
	//  Modifier NEO 
	//  Ebene 0 - nix
	//  Ebene 1 - Shift
	//  Ebene 2 - Neu = Mod 3
	//  Ebene 3 - Kana = Mod 4
	//  Ebene 4 - Neu+Shift 
	//  Ebene 5 - Kasa+Neu
	//  
	//  Modification#	// Keys Pressed
	//  ===============	//=======================================
						//	Neu		Kana	Alt		Strg	Shift
		0,				//	0		0		0		0		0
		1,				//	0		0		0		0		1
		6,				//	0		0		0		1		0
		7,				//	0		0		0		1		1
		SHFT_INVALID,	//	0		0		1		0		0
		SHFT_INVALID,	//	0		0		1		0		1
		SHFT_INVALID,	//	0		0		1		1		0
		SHFT_INVALID,	//	0		0		1		1		1
		3,				//	0		1		0		0		0
		8,				//	0		1		0		0		1
		SHFT_INVALID,	//	0		1		0		1		0
		SHFT_INVALID,	//	0		1		0		1		1
		SHFT_INVALID,	//	0		1		1		0		0
		SHFT_INVALID,	//	0		1		1		0		1
		SHFT_INVALID,	//	0		1		1		1		0
		SHFT_INVALID,	//	0		1		1		1		1
		2,				//	1		0		0		0		0
		4,				//	1		0		0		0		1
		SHFT_INVALID,	//	1		0		0		1		0
		SHFT_INVALID,	//	1		0		0		1		1
		SHFT_INVALID,	//	1		0		1		0		0
		SHFT_INVALID,	//	1		0		1		0		1
		SHFT_INVALID,	//	1		0		1		1		0
		SHFT_INVALID,	//	1		0		1		1		1
		5,				//	1		1		0		0		0
	}
};

/***************************************************************************\
*
* aVkToWch2[]  - Virtual Key to WCHAR translation for 2 shift states
* aVkToWch3[]  - Virtual Key to WCHAR translation for 3 shift states
* aVkToWch4[]  - Virtual Key to WCHAR translation for 4 shift states
* aVkToWch5[]  - Virtual Key to WCHAR translation for 5 shift states
* aVkToWch6[]  - Virtual Key to WCHAR translation for 6 shift states
* aVkToWch7[]  - Virtual Key to WCHAR translation for 7 shift states
* aVkToWch8[]  - Virtual Key to WCHAR translation for 8 shift states
* aVkToWch9[]  - Virtual Key to WCHAR translation for 9 shift states
*
* Table attributes: Unordered Scan, null-terminated
*
* Search this table for an entry with a matching Virtual Key to find the
* corresponding unshifted and shifted WCHAR characters.
*
* Special values for VirtualKey (column 1)
*     0xff          - dead chars for the previous entry
*     0             - terminate the list
*
* Special values for Attributes (column 2)
*     CAPLOK bit    - CAPS-LOCK affect this key like SHIFT
*
* Special values for wch[*] (column 3 & 4)
*     WCH_NONE      - No character
*     WCH_DEAD      - Dead Key (diaresis) or invalid (US keyboard has none)
*     WCH_LGTR      - Ligature (generates multiple characters)
*
\***************************************************************************/

static ALLOC_SECTION_LDATA VK_TO_WCHARS6 aVkToWch6[] = {
// Reihenfolge der Ebene wie oben ( ALLOC_SECTION_LDATA MODIFIERS CharModifiers = {    &aVkToBits[0],)… festgelegt
//				| CapsLock			|			| SHIFT		| NEU		| KANA		| NEU+Shift	| KANA+NEU	|
//				|===================|===========|===========|===========|===========|===========|===========|
// Zeile 1
{VK_OEM_1		,0					,WCH_DEAD	,WCH_DEAD	,WCH_DEAD	,WCH_DEAD	,WCH_DEAD	,WCH_DEAD	},	//Tote Taste 1
{0xff			,0					,'^'		,'~'		,0x02da		,0x02c7		,0x02d8		,0x00af		}, 
{'1'			,KANALOK			,'1'		,0x00b0		,0x00B9		,0x00ba		,0x2081		,0x00ac		},
{'3'			,KANALOK			,'3'		,0x2113		,0x00b3		,0x2116		,0x2083		,0x2227		},
{'4'			,KANALOK			,'4'		,0x00bb		,0x203A		,WCH_NONE	,0x2640		,0x22a5		},	//WCH_NONE sollte »Bild auf« sein (AHK?)
{'5'			,KANALOK			,'5'		,0x00ab		,0x2039		,0x00b7		,0x2642		,0x2221		},
{'7'			,KANALOK			,'7'		,0x0024		,0x00a5		,0x00a4		,0x03ba		,0x2192		},
{'8'			,KANALOK			,'8'		,0x201E		,0x201A		,WCH_NONE	,0x27E8		,0x221e		},
{'9'			,KANALOK			,'9'		,0x201C		,0x2018		,'/'		,0x27E9		,0x220b		},
{'0'			,KANALOK			,'0'		,0x201D		,0x2019		,'*'		,0x2080		,0x2205		},
{VK_OEM_MINUS	,KANALOK			,'-'		,0x2014		,WCH_NONE	,'-'		,0x2011		,0x00ad		},
{VK_OEM_2		,0					,WCH_DEAD	,WCH_NONE	,WCH_DEAD	,WCH_DEAD	,WCH_DEAD	,WCH_NONE	},	//Tote Taste 2
{0xff			,0					,0x0060		,WCH_NONE	,0x00a8		,0x030f		,0x1ffe		,WCH_NONE	},
{VK_TAB			,0					,'\t'		,'\t'		,WCH_DEAD	,'\t'		,'\t'		,'\t'		},
{0xff			,0					,WCH_NONE	,WCH_NONE	,0x266b		,WCH_NONE	,WCH_NONE	,WCH_NONE	},
{'X'			,CAPLOK | KANALOK	,'x'		,'X'		,0x2026		,0x22ee		,0x03BE		,0x039E		},
{'V'			,CAPLOK | KANALOK	,'v'		,'V'		,'_'		,WCH_NONE	,WCH_NONE	,0x2259		},	//Kana: '\b' vom AHK übernommen
{'L'			,CAPLOK | KANALOK	,'l'		,'L'		,'['		,WCH_NONE	,0x03BB		,0x039b		},	//WCH_NONE sollte »Pfeil hoch« sein (AHK?)
{'C'			,CAPLOK | KANALOK	,'c'		,'C'		,']'		,0x007f		,0x03C7		,0x2102		},	//0x007f sollte »Entfernen« sein (AHK?)
{'W'			,CAPLOK | KANALOK	,'w'		,'W'		,0x005E		,WCH_NONE	,0x03c9		,0x222e		},	//WCH_NONE sollte »Einfügen« sein (AHK?)
{'K'			,CAPLOK | KANALOK	,'k'		,'K'		,'!'		,0x00A1		,0x03f0		,0x221a		},
{'H'			,CAPLOK | KANALOK	,'h'		,'H'		,'<'		,'7'		,0x03C8		,0x03A8		},
{'G'			,CAPLOK | KANALOK	,'g'		,'G'		,'>'		,'8'		,0x03B3		,0x0393		},
{'F'			,CAPLOK | KANALOK	,'f'		,'F'		,'='		,'9'		,0x03C6		,0x03A6		},
{'Q'			,CAPLOK | KANALOK	,'q'		,'Q'		,'&'		,'+'		,0x03d5		,0x211a		},
{'U'			,CAPLOK | KANALOK	,'u'		,'U'		,'\\'		,WCH_NONE	,WCH_NONE	,0x00b5		},	//WCH_NONE sollte »Pos 1« sein (AHK?)
{'I'			,CAPLOK | KANALOK	,'i'		,'I'		,'/'		,WCH_NONE	,0x03B9		,0x222b		},	//WCH_NONE sollte »Pfeil links« sein (AHK?)
{'A'			,CAPLOK | KANALOK	,'a'		,'A'		,'{'		,WCH_NONE	,0x03B1		,0x2200		},	//WCH_NONE sollte »Pfeil runter« sein (AHK?)
{'E'			,CAPLOK | KANALOK	,'e'		,'E'		,'}'		,WCH_NONE	,0x03B5		,0x2203		},	//WCH_NONE sollte »Pfeil rechts« sein (AHK?)
{'O'			,CAPLOK | KANALOK	,'o'		,'O'		,'*'		,WCH_NONE	,0x03bf		,0x2208		},	//WCH_NONE sollte »Ende« sein (AHK?)
{'S'			,CAPLOK | KANALOK	,'s'		,'S'		,'?'		,0x00BF		,0x03C3		,0x03A3		},
{'N'			,CAPLOK | KANALOK	,'n'		,'N'		,'('		,'4'		,0x03BD		,0x2115		},
{'R'			,CAPLOK | KANALOK	,'r'		,'R'		,')'		,'5'		,0x03f1		,0x211d		},
{'T'			,CAPLOK | KANALOK	,'t'		,'T'		,'-'		,'6'		,0x03C4		,0x2202		},
{'D'			,CAPLOK | KANALOK	,'d'		,'D'		,':'		,','		,0x03B4		,0x0394		},
{VK_OEM_5		,CAPLOK | KANALOK	,0x00FC		,0x00DC		,'#'		,WCH_NONE	,WCH_NONE	,0x211c		},
{VK_OEM_7		,CAPLOK | KANALOK	,0x00E4		,0x00C4		,'|'		,WCH_NONE	,0x03B7		,0x2135		},	//WCH_NONE sollte »Bild runter« sein (AHK?)
{'P'			,CAPLOK | KANALOK	,'p'		,'P'		,'~'		,WCH_NONE	,0x03C0		,0x03A0		},	//Kana: '\r' vom AHK übernommen		
{'Z'			,CAPLOK | KANALOK	,'z'		,'Z'		,'`'		,WCH_NONE	,0x03B6		,0x2124		},
{'B'			,CAPLOK | KANALOK	,'b'		,'B'		,'+'		,':'		,0x03B2		,0x21d0		},
{'M'			,CAPLOK | KANALOK	,'m'		,'M'		,'%'		,'1'		,0x00b5		,0x21d4		},
{VK_OEM_COMMA	,KANALOK			,','		,0x2013		,'\"'		,'2'		,0x03c1		,0x21d2		},
{VK_OEM_PERIOD	,KANALOK			,'.'		,0x2022		,'\''		,'3'		,0x03d1		,0x0398		},
{0				,0					,0			,0			,0			,0			,0			,0			}
};

static ALLOC_SECTION_LDATA VK_TO_WCHARS7 aVkToWch7[] = {
//				| CapsLock			|			| SHIFT		| NEU		| KANA		| NEU+Shift	| KANA+NEU	| Control	|
//				|===================|===========|===========|===========|===========|===========|===========|===========|
{VK_OEM_3		,CAPLOK | KANALOK	,0x00df		,0x1E9E	 ,0x017F		,WCH_NONE	,0x03C2		,0x2218		,0x2218		},
{VK_OEM_4		,0					,WCH_DEAD	,WCH_DEAD	,WCH_DEAD	,WCH_DEAD	,WCH_DEAD	,WCH_DEAD	,0x001d		},	//Tote Taste 3
{0xff			,0					,0x00b4		,0x00b8		,'-'		,0x02dd		,0x1fbf		,0x02d9		,WCH_NONE	},
{'Y'			,CAPLOK | KANALOK	,'y'		,'Y'		,'@'		,'.'		,0x03C5		,0x2207		,0x001c		},
{VK_OEM_6		,CAPLOK | KANALOK	,0x00F6		,0x00D6		,'$'		,WCH_NONE	,0x0020		,0x2111		,WCH_NONE	},	//Kana: '\t' vom AHK übernommen
{VK_SPACE		,KANALOK			,' '		,' '		,' '		,'0'		,0x00a0		,0x202f		,' '		},
{VK_BACK		,0					,'\b'		,'\b'		,'\b'		,'\b'		,'\b'		,'\b'		,0x007f		},
{VK_ESCAPE		,0					,0x001b		,0x001b		,0x001b		,0x001b		,0x001b		,0x001b		,0x001b		},
{VK_RETURN		,0					,'\r'		,'\r'		,'\r'		,'\r'		,'\r'		,'\r'		,'\n'		},
{VK_CANCEL		,0					,0x0003		,0x0003		,WCH_NONE	,WCH_NONE	,WCH_NONE	,WCH_NONE	,0x0003		},
{0				,0					,0			,0			,0			,0			,0			,0			,0			}
};

static ALLOC_SECTION_LDATA VK_TO_WCHARS8 aVkToWch8[] = {
//				| CapsLock			|			| SHIFT		| NEU		| KANA		| NEU+Shift	| KANA+NEU	| Control	| Control+Shift|
//				|===================|===========|===========|===========|===========|===========|===========|===========|==============|
{'2'			,KANALOK			,'2'		,0x00a7		,0x00b2		,0x00aa		,0x2082		,0x2228		,WCH_NONE	,0x0000		},
{'6'			,KANALOK			,'6'		,0x20ac		,0x00A2		,0x00a3		,0x26a5		,0x2225		,WCH_NONE	,0x001e		},
{'J'			,CAPLOK | KANALOK	,'j'		,'J'		,';'		,';'		,0x03b8		,0x221d		,WCH_NONE	,0x001f		},
{0				,0					,0			,0			,0			,0			,0			,0			,0			,0			}
};

// Put this last so that VkKeyScan interprets number characters
// as coming from the main section of the kbd  before considering
// the numpad.

// Entgegen der neo20.txt vorgesehene Belegung 1,2,3,4,5,6 ist hier 1,4,3,2 umgesetzt:


static ALLOC_SECTION_LDATA VK_TO_WCHARS4 aVkToWch4[] = {
//				| CapsLock	|			| SHIFT		| KANA		| NEU		|
//				|===========|===========|===========|===========|===========|
{VK_ADD			,0			,'+'		,'+'		,0x00b1		,0x2213		},
{VK_DIVIDE		,0			,'/'		,'/'		,0x00f7		,0x2215		},
{VK_MULTIPLY	,0			,'*'		,'*'		,0x00d7		,0x2219		},
{VK_SUBTRACT	,0			,'-'		,'-'		,0x2052		,WCH_NONE	},
{VK_DECIMAL		,0			,','		,','		,'.'		,','		},
{VK_NUMPAD0		,0			,'0'		,'0'		,0x0025		,0x2030		},
{VK_NUMPAD1		,0			,'1'		,'1'		,0x2194		,0x2264		},
{VK_NUMPAD2		,0			,'2'		,'2'		,0x2193		,0x222a		},
{VK_NUMPAD3		,0			,'3'		,'3'		,0x21cc		,0x2265		},
{VK_NUMPAD4		,0			,'4'		,'4'		,0x2190		,0x2282		},
{VK_NUMPAD5		,0			,'5'		,'5'		,0x221e		,0x220B		},
{VK_NUMPAD6		,0			,'6'		,'6'		,0x2192		,0x2283		},
{VK_NUMPAD7		,0			,'7'		,'7'		,0x2195		,0x226a		},
{VK_NUMPAD8		,0			,'8'		,'8'		,0x2191		,0x2229		},
{VK_NUMPAD9		,0			,'9'		,'9'		,0x2297		,0x226b		},
{0				,0			,0			,0			,0			,0			}
};

// Hier müssen die verwendeten WChar_Tables vorkommen; Numpad MUSS letzte Zeile sein.
static ALLOC_SECTION_LDATA VK_TO_WCHAR_TABLE aVkToWcharTable[] = {
    {  (PVK_TO_WCHARS1)aVkToWch6, 6, sizeof(aVkToWch6[0]) },
    {  (PVK_TO_WCHARS1)aVkToWch7, 7, sizeof(aVkToWch7[0]) },
    {  (PVK_TO_WCHARS1)aVkToWch8, 8, sizeof(aVkToWch8[0]) },
    {  (PVK_TO_WCHARS1)aVkToWch4, 4, sizeof(aVkToWch4[0]) },
    {                       NULL, 0, 0                    },
};

/***************************************************************************\
* aKeyNames[], aKeyNamesExt[]  - Virtual Scancode to Key Name tables
*
* Table attributes: Ordered Scan (by scancode), null-terminated
*
* Only the names of Extended, NumPad, Dead and Non-Printable keys are here.
* (Keys producing printable characters are named by that character)
\***************************************************************************/

static ALLOC_SECTION_LDATA VSC_LPWSTR aKeyNames[] = {
    0x01,    L"ESC",
    0x0e,    L"R\x00DC" L"CKTASTE",
    0x0f,    L"TABULATOR",
    0x1c,    L"EINGABE",
    0x1d,    L"STRG",
    0x2a,    L"UMSCHALT",
    0x2b,    L"MOD 3 RECHTS",
    0x36,    L"UMSCHALT RECHTS",
    0x37,    L"* (ZEHNERTASTATUR)",
    0x38,    L"ALT",
    0x39,    L"LEER",
    0x3a,    L"MOD 3 LINKS",
    0x3b,    L"F1",
    0x3c,    L"F2",
    0x3d,    L"F3",
    0x3e,    L"F4",
    0x3f,    L"F5",
    0x40,    L"F6",
    0x41,    L"F7",
    0x42,    L"F8",
    0x43,    L"F9",
    0x44,    L"F10",
    0x45,    L"PAUSE",
    0x46,    L"ROLLEN-FESTSTELL",
    0x47,    L"7 (ZEHNERTASTATUR)",
    0x48,    L"8 (ZEHNERTASTATUR)",
    0x49,    L"9 (ZEHNERTASTATUR)",
    0x4a,    L"- (ZEHNERTASTATUR)",
    0x4b,    L"4 (ZEHNERTASTATUR)",
    0x4c,    L"5 (ZEHNERTASTATUR)",
    0x4d,    L"6 (ZEHNERTASTATUR)",
    0x4e,    L"+ (ZEHNERTASTATUR)",
    0x4f,    L"1 (ZEHNERTASTATUR)",
    0x50,    L"2 (ZEHNERTASTATUR)",
    0x51,    L"3 (ZEHNERTASTATUR)",
    0x52,    L"0 (ZEHNERTASTATUR)",
    0x53,    L"KOMMA (ZEHNERTASTATUR)",
    0x56,    L"MOD 4 LINKS",
    0x57,    L"F11",
    0x58,    L"F12",
    0   ,    NULL
};

static ALLOC_SECTION_LDATA VSC_LPWSTR aKeyNamesExt[] = {
    0x1c,    L"EINGABE (ZEHNERTASTATUR)",
    0x1d,    L"STRG-RECHTS",
    0x35,    L"/ (ZEHNERTASTATUR)",
    0x37,    L"DRUCK",
    0x38,    L"MOD 4 RECHTS",
    0x45,    L"NUM-FESTSTELL",
    0x46,    L"UNTBR",
    0x47,    L"POS1",
    0x48,    L"NACH-OBEN",
    0x49,    L"BILD-NACH-OBEN",
    0x4b,    L"NACH-LINKS",
    0x4d,    L"NACH-RECHTS",
    0x4f,    L"ENDE",
    0x50,    L"NACH-UNTEN",
    0x51,    L"BILD-NACH-UNTEN",
    0x52,    L"EINFG",
    0x53,    L"ENTF",
    0x54,    L"<00>",
    0x56,    L"HILFE",
    0x5b,    L"LINKE WINDOWS",
    0x5c,    L"RECHTE WINDOWS",
    0x5d,    L"ANWENDUNG",
    0   ,    NULL
};

static ALLOC_SECTION_LDATA DEADKEY_LPWSTR aKeyNamesDead[] = {
    L"^"        L"ZIRKUMFLEX",
    L"\x02C7"    L"CARON",
    L"\x02D8"    L"BREVIS",
    L"\x00B7"    L"DOT_MID",
    L"\x002D"    L"QUERSTRICH",
    L"\x002E"    L"DOT_BELOW",
        
    L"\x00B4"    L"AKUT",
    L"\x0060"    L"GRAVIS",
    L"\x00B8"    L"CEDILLA",
    L"\x02D9"    L"DOT_ABOVE",
    L"\x02BD"    L"OGONEK",
    L"\x02DA"    L"RING",
        
    L"\x007E"    L"TILDE",
    L"\x00AF"    L"MAKRON",
    L"\x00A8"    L"TREMA",
    L"\x00AF"    L"SCHRAEGSTRICH",
    L"\x02DD"    L"DOPPEL_AKUT", 
    L"\x002C"    L"KOMMA_BELOW",
        

    NULL
};

static ALLOC_SECTION_LDATA DEADKEY aDeadKey[] = {
// Schema:
//    Deadtrans( Name oder Unicode der normalen Taste,    Name oder Unicode der toten Taste,    Name oder Unicode der zu bildenden Taste,    0x0000 für  sichtbar, 0x0001 für tot)
//    0, 0    terminiert komplette Liste
//    
//    Bei Doppelbelegungen wird erster Treffer genommen
//    

//Deadkeys
// Nachfolgend Tafeln für die diakritschen Zeichen (alphabetisch)
// Kombinationen nur für „Latin Letters“, der rest ist im Deuschen selten und lässt sich über das Combiningszeichen (nachgestellt) bilden
// Mehrfachfunktionen siehe: http://wiki.neo-layout.org/wiki/Diakritika#DoppelfunktionToterTasten
//
// zu xx% fertig:
// Akut – fertig
// Brevis – fertig
// Gravis – fertig
// Makron – ferig
// Tilde – fertig
// 
//
//
//
//
//
//
//
// Zirkumflex + Superskript – fertig

// Akut (fertig)
DEADTRANS( L' '   , 0x00B4 , 0x00B4 , 0x0000),	//Akut
DEADTRANS( 0x00B4 , 0x00B4 , 0x0301 , 0x0000),	//2x für Combining
DEADTRANS( L'A'   , 0x00B4 , 0x00c1 , 0x0000),
DEADTRANS( L'a'   , 0x00B4 , 0x00e1 , 0x0000),
DEADTRANS( L'C'   , 0x00B4 , 0x0106 , 0x0000),
DEADTRANS( L'c'   , 0x00B4 , 0x0106 , 0x0000),
DEADTRANS( L'E'   , 0x00B4 , 0x00c9 , 0x0000),
DEADTRANS( L'e'   , 0x00B4 , 0x00e9 , 0x0000),
DEADTRANS( L'G'   , 0x00B4 , 0x01f4 , 0x0000),
DEADTRANS( L'g'   , 0x00B4 , 0x01f5 , 0x0000),
DEADTRANS( L'I'   , 0x00B4 , 0x00cd , 0x0000),
DEADTRANS( L'i'   , 0x00B4 , 0x00ed , 0x0000),
DEADTRANS( L'K'   , 0x00B4 , 0x1e30 , 0x0000),
DEADTRANS( L'k'   , 0x00B4 , 0x1e31 , 0x0000),
DEADTRANS( L'L'   , 0x00B4 , 0x0139 , 0x0000),
DEADTRANS( L'l'   , 0x00B4 , 0x013a , 0x0000),
DEADTRANS( L'M'   , 0x00B4 , 0x1e3e , 0x0000),
DEADTRANS( L'm'   , 0x00B4 , 0x1e3f , 0x0000),
DEADTRANS( L'N'   , 0x00B4 , 0x0143 , 0x0000),
DEADTRANS( L'n'   , 0x00B4 , 0x0144 , 0x0000),
DEADTRANS( L'O'   , 0x00B4 , 0x00d3 , 0x0000),
DEADTRANS( L'o'   , 0x00B4 , 0x00f3 , 0x0000),
DEADTRANS( L'P'   , 0x00B4 , 0x1e54 , 0x0000),
DEADTRANS( L'p'   , 0x00B4 , 0x1e55 , 0x0000),
DEADTRANS( L'R'   , 0x00B4 , 0x0154 , 0x0000),
DEADTRANS( L'r'   , 0x00B4 , 0x0155 , 0x0000),
DEADTRANS( L'S'   , 0x00B4 , 0x015a , 0x0000),
DEADTRANS( L's'   , 0x00B4 , 0x015b , 0x0000),
DEADTRANS( L'U'   , 0x00B4 , 0x00da , 0x0000),
DEADTRANS( L'u'   , 0x00B4 , 0x00fa , 0x0000),
DEADTRANS( L'W'   , 0x00B4 , 0x1e82 , 0x0000),
DEADTRANS( L'w'   , 0x00B4 , 0x1e83 , 0x0000),
DEADTRANS( L'Y'   , 0x00B4 , 0x00dd , 0x0000),
DEADTRANS( L'y'   , 0x00B4 , 0x00fd , 0x0000),
DEADTRANS( L'Z'   , 0x00B4 , 0x0179 , 0x0000),
DEADTRANS( L'z'   , 0x00B4 , 0x017a , 0x0000),
DEADTRANS( 0x00dc , 0x00B4 , 0x01d7 , 0x0000),	//Ü
DEADTRANS( 0x00fc , 0x00B4 , 0x01d8 , 0x0000),	//ü
DEADTRANS( 0x00c6 , 0x00B4 , 0x01fc , 0x0000),	//Æ
DEADTRANS( 0x00e6 , 0x00B4 , 0x01fd , 0x0000),	//æ


// Brevis (fertig)
	DEADTRANS( L' '   , 0x02D8 , 0x02D8 , 0x0000),	//Brevis
	DEADTRANS( 0x02D8 , 0x02D8 , 0x0306 , 0x0000),	//2x für Combining
	DEADTRANS( L'A'   , 0x02D8 , 0x0102 , 0x0000),
	DEADTRANS( L'a'   , 0x02D8 , 0x0103 , 0x0000),
	DEADTRANS( L'E'   , 0x02D8 , 0x0114 , 0x0000),
	DEADTRANS( L'e'   , 0x02D8 , 0x0115 , 0x0000),
	DEADTRANS( L'G'   , 0x02D8 , 0x011e , 0x0000),
	DEADTRANS( L'g'   , 0x02D8 , 0x011f , 0x0000),
	DEADTRANS( L'I'   , 0x02D8 , 0x012c , 0x0000),
	DEADTRANS( L'i'   , 0x02D8 , 0x012d , 0x0000),
	DEADTRANS( L'O'   , 0x02D8 , 0x014e , 0x0000),
	DEADTRANS( L'o'   , 0x02D8 , 0x014f , 0x0000),
	DEADTRANS( L'U'   , 0x02D8 , 0x016c , 0x0000),
	DEADTRANS( L'u'   , 0x02D8 , 0x016d , 0x0000),
	DEADTRANS( L'H'   , 0x02D8 , 0x1e2a , 0x0000),
	DEADTRANS( L'h'   , 0x02D8 , 0x1e2b , 0x0000),


// Gravis (fertig)
DEADTRANS( L' '   , 0x0060 , 0x0060 , 0x0000),	//Gravis
DEADTRANS( 0x0060 , 0x0060 , 0x0300 , 0x0000),	//2x für Combining
DEADTRANS( L'a'   , 0x0060 , 0x00e0 , 0x0000),			
DEADTRANS( L'A'   , 0x0060 , 0x00c0 , 0x0000),			
DEADTRANS( L'E'   , 0x0060 , 0x00c8 , 0x0000),			
DEADTRANS( L'e'   , 0x0060 , 0x00e8 , 0x0000),			
DEADTRANS( L'I'   , 0x0060 , 0x00cc , 0x0000),			
DEADTRANS( L'i'   , 0x0060 , 0x00ec , 0x0000),			
DEADTRANS( L'N'   , 0x0060 , 0x01f8 , 0x0000),			
DEADTRANS( L'n'   , 0x0060 , 0x01f9 , 0x0000),			
DEADTRANS( L'O'   , 0x0060 , 0x00d2 , 0x0000),			
DEADTRANS( L'o'   , 0x0060 , 0x00f2 , 0x0000),			
DEADTRANS( L'U'   , 0x0060 , 0x00d9 , 0x0000),			
DEADTRANS( L'u'   , 0x0060 , 0x00f9 , 0x0000),			
DEADTRANS( L'W'   , 0x0060 , 0x1e80 , 0x0000),			
DEADTRANS( L'w'   , 0x0060 , 0x1e81 , 0x0000),			
DEADTRANS( L'Y'   , 0x0060 , 0x1ef2 , 0x0000),			
DEADTRANS( L'y'   , 0x0060 , 0x1ef3 , 0x0000),			
DEADTRANS( 0x00dc , 0x0060 , 0x01db , 0x0000),	//Ü
DEADTRANS( 0x00fc , 0x0060 , 0x01dc , 0x0000),	//ü


// Makron (fertig)
DEADTRANS( L' '   , 0x00AF , 0x00AF , 0x0000),	//Makron
DEADTRANS( 0x00AF , 0x00AF , 0x0304 , 0x0000),	//2x für Combining
DEADTRANS( L'A'   , 0x00AF , 0x0100 , 0x0000),
DEADTRANS( L'a'   , 0x00AF , 0x0101 , 0x0000),
DEADTRANS( L'E'   , 0x00AF , 0x0112 , 0x0000),
DEADTRANS( L'e'   , 0x00AF , 0x0113 , 0x0000),
DEADTRANS( L'I'   , 0x00AF , 0x012a , 0x0000),
DEADTRANS( L'i'   , 0x00AF , 0x012b , 0x0000),
DEADTRANS( L'O'   , 0x00AF , 0x014c , 0x0000),
DEADTRANS( L'o'   , 0x00AF , 0x014d , 0x0000),
DEADTRANS( L'U'   , 0x00AF , 0x016a , 0x0000),
DEADTRANS( L'u'   , 0x00AF , 0x016b , 0x0000),
DEADTRANS( L'Y'   , 0x00AF , 0x0232 , 0x0000),
DEADTRANS( L'y'   , 0x00AF , 0x0233 , 0x0000),
DEADTRANS( L'G'   , 0x00AF , 0x1e20 , 0x0000),
DEADTRANS( L'g'   , 0x00AF , 0x1e21 , 0x0000),
DEADTRANS( 0x00dc , 0x00AF , 0x01d5 , 0x0000),	//Ü
DEADTRANS( 0x00fc , 0x00AF , 0x01d6 , 0x0000),	//ü
DEADTRANS( 0x00d6 , 0x00AF , 0x022a , 0x0000),	//Ö
DEADTRANS( 0x00f6 , 0x00AF , 0x022b , 0x0000),	//ö
DEADTRANS( L'b'   , 0x00AF , 0x1e07 , 0x0000),  // ab hier Makron darunter
DEADTRANS( L'B'   , 0x00AF , 0x1e06 , 0x0000),
DEADTRANS( L'd'   , 0x00AF , 0x1e0f , 0x0000),
DEADTRANS( L'D'   , 0x00AF , 0x1e0e , 0x0000),
DEADTRANS( L'k'   , 0x00AF , 0x1e35 , 0x0000),
DEADTRANS( L'K'   , 0x00AF , 0x1e34 , 0x0000),
DEADTRANS( L'l'   , 0x00AF , 0x1e3b , 0x0000),
DEADTRANS( L'L'   , 0x00AF , 0x1e3a , 0x0000),
DEADTRANS( L'n'   , 0x00AF , 0x1e49 , 0x0000),
DEADTRANS( L'N'   , 0x00AF , 0x1e48 , 0x0000),
DEADTRANS( L'r'   , 0x00AF , 0x1e5f , 0x0000),
DEADTRANS( L'R'   , 0x00AF , 0x1e5e , 0x0000),
DEADTRANS( L't'   , 0x00AF , 0x1e6f , 0x0000),
DEADTRANS( L'T'   , 0x00AF , 0x1e6e , 0x0000),
DEADTRANS( L'z'   , 0x00AF , 0x1e95 , 0x0000),
DEADTRANS( L'Z'   , 0x00AF , 0x1e94 , 0x0000),
DEADTRANS( L'h'   , 0x00AF , 0x1e96 , 0x0000),


// Tilde (fertig)
DEADTRANS( L' '   , L'~'   , L'~'   , 0x0000), //Tilde
DEADTRANS( L'~'   , L'~'   , 0x0303 , 0x0000), //2x für Combining
DEADTRANS( L'A'   , L'~'   , 0x00c3 , 0x0000),
DEADTRANS( L'a'   , L'~'   , 0x00e3 , 0x0000),
DEADTRANS( L'E'   , L'~'   , 0x1ebc , 0x0000),
DEADTRANS( L'e'   , L'~'   , 0x1ebd , 0x0000),
DEADTRANS( L'I'   , L'~'   , 0x0128 , 0x0000),
DEADTRANS( L'i'   , L'~'   , 0x0129 , 0x0000),
DEADTRANS( L'N'   , L'~'   , 0x00d1 , 0x0000),
DEADTRANS( L'n'   , L'~'   , 0x00f1 , 0x0000),
DEADTRANS( L'O'   , L'~'   , 0x00d5 , 0x0000),
DEADTRANS( L'o'   , L'~'   , 0x00f5 , 0x0000),
DEADTRANS( L'U'   , L'~'   , 0x0168 , 0x0000),
DEADTRANS( L'u'   , L'~'   , 0x0169 , 0x0000),
DEADTRANS( L'V'   , L'~'   , 0x1e7c , 0x0000),
DEADTRANS( L'v'   , L'~'   , 0x1e7d , 0x0000),
DEADTRANS( L'Y'   , L'~'   , 0x1ef8 , 0x0000),
DEADTRANS( L'y'   , L'~'   , 0x1ef9 , 0x0000),


// Zirkumflex und Superscript (fertig)
DEADTRANS( L' '   , L'^'   , L'^'   , 0x0000), //Zirkumflex
DEADTRANS( L'^'   , L'^'   , 0x0302 , 0x0000), //2x für Combining
DEADTRANS( L'A'   , L'^'   , 0x00c2 , 0x0000),
DEADTRANS( L'a'   , L'^'   , 0x00e2 , 0x0000),
DEADTRANS( L'C'   , L'^'   , 0x0108 , 0x0000),
DEADTRANS( L'c'   , L'^'   , 0x0109 , 0x0000),
DEADTRANS( L'E'   , L'^'   , 0x00ca , 0x0000),
DEADTRANS( L'e'   , L'^'   , 0x00ea , 0x0000),
DEADTRANS( L'G'   , L'^'   , 0x011c , 0x0000),
DEADTRANS( L'g'   , L'^'   , 0x011d , 0x0000),
DEADTRANS( L'H'   , L'^'   , 0x0124 , 0x0000),
DEADTRANS( L'h'   , L'^'   , 0x0125 , 0x0000),
DEADTRANS( L'I'   , L'^'   , 0x00ce , 0x0000),
DEADTRANS( L'i'   , L'^'   , 0x00ee , 0x0000),
DEADTRANS( L'J'   , L'^'   , 0x0134 , 0x0000),
DEADTRANS( L'j'   , L'^'   , 0x0135 , 0x0000),
DEADTRANS( L'O'   , L'^'   , 0x00d4 , 0x0000),
DEADTRANS( L'o'   , L'^'   , 0x00f4 , 0x0000),
DEADTRANS( L'S'   , L'^'   , 0x015c , 0x0000),
DEADTRANS( L's'   , L'^'   , 0x015d , 0x0000),
DEADTRANS( L'U'   , L'^'   , 0x00db , 0x0000),
DEADTRANS( L'u'   , L'^'   , 0x00fb , 0x0000),
DEADTRANS( L'W'   , L'^'   , 0x0174 , 0x0000),
DEADTRANS( L'w'   , L'^'   , 0x0175 , 0x0000),
DEADTRANS( L'Y'   , L'^'   , 0x0176 , 0x0000),
DEADTRANS( L'y'   , L'^'   , 0x0177 , 0x0000),
DEADTRANS( L'Z'   , L'^'   , 0x1e90 , 0x0000),
DEADTRANS( L'z'   , L'^'   , 0x1e91 , 0x0000),
DEADTRANS( L'1'   , L'^'   , 0x00b9 , 0x0000),	//ab hier hochgestelltes
DEADTRANS( L'2'   , L'^'   , 0x00b2 , 0x0000),
DEADTRANS( L'3'   , L'^'   , 0x00b3 , 0x0000),
DEADTRANS( L'4'   , L'^'   , 0x2074 , 0x0000),
DEADTRANS( L'5'   , L'^'   , 0x2075 , 0x0000),
DEADTRANS( L'6'   , L'^'   , 0x2076 , 0x0000),
DEADTRANS( L'7'   , L'^'   , 0x2077 , 0x0000),
DEADTRANS( L'8'   , L'^'   , 0x2078 , 0x0000),
DEADTRANS( L'9'   , L'^'   , 0x2079 , 0x0000),
DEADTRANS( L'0'   , L'^'   , 0x2070 , 0x0000),
DEADTRANS( L'+'   , L'^'   , 0x207a , 0x0000),
DEADTRANS( L'-'   , L'^'   , 0x207b , 0x0000),
DEADTRANS( L'='   , L'^'   , 0x207c , 0x0000),
DEADTRANS( L'('   , L'^'   , 0x207d , 0x0000),
DEADTRANS( L')'   , L'^'   , 0x207e , 0x0000),
DEADTRANS( L'n'   , L'^'   , 0x207f , 0x0000),





                 
//===================================================
//===================================================
	DEADTRANS( L' '   , 0x02DA , 0x02DA , 0x0000),	//Ring
	DEADTRANS( 0x02DA , 0x02DA , 0x030A , 0x0000),	//2x für Combining
	DEADTRANS( L'E'   , 0x02DA , 0x0116 , 0x0000),
	DEADTRANS( L'e'   , 0x02DA , 0x0117 , 0x0000),
	DEADTRANS( L'G'   , 0x02DA , 0x0120 , 0x0000),
	DEADTRANS( L'g'   , 0x02DA , 0x0121 , 0x0000),
	DEADTRANS( L'I'   , 0x02DA , 0x0130 , 0x0000),
	DEADTRANS( L'i'   , 0x02DA , 0x0131 , 0x0000),
	DEADTRANS( L'Z'   , 0x02DA , 0x017B , 0x0000),
	DEADTRANS( L'z'   , 0x02DA , 0x017C , 0x0000),
	DEADTRANS( L'A'   , 0x02DA , 0x0226 , 0x0000),
	DEADTRANS( L'a'   , 0x02DA , 0x0227 , 0x0000),
	DEADTRANS( L'O'   , 0x02DA , 0x022e , 0x0000),
	DEADTRANS( L'o'   , 0x02DA , 0x022f , 0x0000),
	DEADTRANS( L'B'   , 0x02DA , 0x1e02 , 0x0000),
	DEADTRANS( L'b'   , 0x02DA , 0x1e03 , 0x0000),
	DEADTRANS( L'D'   , 0x02DA , 0x1e0a , 0x0000),
	DEADTRANS( L'd'   , 0x02DA , 0x1e0b , 0x0000),
	DEADTRANS( L'F'   , 0x02DA , 0x1e1e , 0x0000),
	DEADTRANS( L'f'   , 0x02DA , 0x1e1f , 0x0000),
	DEADTRANS( L'H'   , 0x02DA , 0x1e22 , 0x0000),
	DEADTRANS( L'h'   , 0x02DA , 0x1e23 , 0x0000),
	DEADTRANS( L'M'   , 0x02DA , 0x1e40 , 0x0000),
	DEADTRANS( L'm'   , 0x02DA , 0x1e41 , 0x0000),
	DEADTRANS( L'N'   , 0x02DA , 0x1e44 , 0x0000),
	DEADTRANS( L'n'   , 0x02DA , 0x1e45 , 0x0000),
	DEADTRANS( L'P'   , 0x02DA , 0x1e56 , 0x0000),
	DEADTRANS( L'p'   , 0x02DA , 0x1e57 , 0x0000),
	DEADTRANS( L'R'   , 0x02DA , 0x1e58 , 0x0000),
	DEADTRANS( L'r'   , 0x02DA , 0x1e59 , 0x0000),
	DEADTRANS( L'S'   , 0x02DA , 0x1e60 , 0x0000),
	DEADTRANS( L's'   , 0x02DA , 0x1e61 , 0x0000),
	DEADTRANS( L'T'   , 0x02DA , 0x1e6a , 0x0000),
	DEADTRANS( L't'   , 0x02DA , 0x1e6b , 0x0000),
	DEADTRANS( L'W'   , 0x02DA , 0x1e86 , 0x0000),
	DEADTRANS( L'w'   , 0x02DA , 0x1e87 , 0x0000),
	DEADTRANS( L'X'   , 0x02DA , 0x1e8a , 0x0000),
	DEADTRANS( L'x'   , 0x02DA , 0x1e8b , 0x0000),
	DEADTRANS( L'Y'   , 0x02DA , 0x1e8e , 0x0000),
	DEADTRANS( L'y'   , 0x02DA , 0x1e8f , 0x0000),

	DEADTRANS( L' '   , 0x02c7 , 0x02c7 , 0x0000),	//Caron 
	DEADTRANS( 0x02c7 , 0x02c7 , 0x030C , 0x0000),	//2x für Combining
	DEADTRANS( L'C'   , 0x02c7 , 0x010c , 0x0000),
	DEADTRANS( L'c'   , 0x02c7 , 0x010d , 0x0000),
	DEADTRANS( L'D'   , 0x02c7 , 0x010e , 0x0000),
	DEADTRANS( L'd'   , 0x02c7 , 0x010f , 0x0000),
	DEADTRANS( L'E'   , 0x02c7 , 0x011a , 0x0000),
	DEADTRANS( L'e'   , 0x02c7 , 0x011b , 0x0000),
	DEADTRANS( L'L'   , 0x02c7 , 0x013d , 0x0000),
	DEADTRANS( L'l'   , 0x02c7 , 0x013e , 0x0000),
	DEADTRANS( L'N'   , 0x02c7 , 0x0147 , 0x0000),
	DEADTRANS( L'n'   , 0x02c7 , 0x0148 , 0x0000),
	DEADTRANS( L'R'   , 0x02c7 , 0x0158 , 0x0000),
	DEADTRANS( L'r'   , 0x02c7 , 0x0159 , 0x0000),
	DEADTRANS( L'S'   , 0x02c7 , 0x0160 , 0x0000),
	DEADTRANS( L's'   , 0x02c7 , 0x0161 , 0x0000),
	DEADTRANS( L'T'   , 0x02c7 , 0x0164 , 0x0000),
	DEADTRANS( L't'   , 0x02c7 , 0x0165 , 0x0000),
	DEADTRANS( L'Z'   , 0x02c7 , 0x017d , 0x0000),
	DEADTRANS( L'z'   , 0x02c7 , 0x017e , 0x0000),
	DEADTRANS( L'A'   , 0x02c7 , 0x01cd , 0x0000),
	DEADTRANS( L'a'   , 0x02c7 , 0x01ce , 0x0000),
	DEADTRANS( L'I'   , 0x02c7 , 0x01cf , 0x0000),
	DEADTRANS( L'i'   , 0x02c7 , 0x01d0 , 0x0000),
	DEADTRANS( L'O'   , 0x02c7 , 0x01d1 , 0x0000),
	DEADTRANS( L'o'   , 0x02c7 , 0x01d2 , 0x0000),
	DEADTRANS( L'U'   , 0x02c7 , 0x01d3 , 0x0000),
	DEADTRANS( L'u'   , 0x02c7 , 0x01d4 , 0x0000),
	DEADTRANS( L'G'   , 0x02c7 , 0x01e6 , 0x0000),
	DEADTRANS( L'g'   , 0x02c7 , 0x01e7 , 0x0000),
	DEADTRANS( L'K'   , 0x02c7 , 0x01e8 , 0x0000),
	DEADTRANS( L'k'   , 0x02c7 , 0x01e9 , 0x0000),
	DEADTRANS( L'j'   , 0x02c7 , 0x01f0 , 0x0000),
	DEADTRANS( L'H'   , 0x02c7 , 0x021e , 0x0000),
	DEADTRANS( L'h'   , 0x02c7 , 0x021f , 0x0000),
	DEADTRANS( 0x00fc , 0x02c7 , 0x01da , 0x0000),
	DEADTRANS( 0x00dc , 0x02c7 , 0x01d9 , 0x0000),





	DEADTRANS( L' '   , 0x00A8 , 0x00A8 , 0x0000),	//Trema
	DEADTRANS( 0x00A8 , 0x00A8 , 0x0308 , 0x0000),	//2x für Combining
	DEADTRANS( L'A'   , 0x00A8 , 0x00c4 , 0x0000),
	DEADTRANS( L'E'   , 0x00A8 , 0x00cb , 0x0000),
	DEADTRANS( L'I'   , 0x00A8 , 0x00cf , 0x0000),
	DEADTRANS( L'O'   , 0x00A8 , 0x00d6 , 0x0000),
	DEADTRANS( L'U'   , 0x00A8 , 0x00dc , 0x0000),
	DEADTRANS( L'a'   , 0x00A8 , 0x00e4 , 0x0000),
	DEADTRANS( L'e'   , 0x00A8 , 0x00eb , 0x0000),
	DEADTRANS( L'i'   , 0x00A8 , 0x00ef , 0x0000),
	DEADTRANS( L'o'   , 0x00A8 , 0x00f6 , 0x0000),
	DEADTRANS( L'u'   , 0x00A8 , 0x00fc , 0x0000),
	DEADTRANS( L'y'   , 0x00A8 , 0x0177 , 0x0000),
	DEADTRANS( L'Y'   , 0x00A8 , 0x0178 , 0x0000),
	DEADTRANS( L'H'   , 0x00A8 , 0x1e26 , 0x0000),
	DEADTRANS( L'h'   , 0x00A8 , 0x1e27 , 0x0000),
	DEADTRANS( L'W'   , 0x00A8 , 0x1e84 , 0x0000),
	DEADTRANS( L'w'   , 0x00A8 , 0x1e85 , 0x0000),
	DEADTRANS( L'X'   , 0x00A8 , 0x1e8c , 0x0000),
	DEADTRANS( L'x'   , 0x00A8 , 0x1e8d , 0x0000),
	DEADTRANS( L't'   , 0x00A8 , 0x1e97 , 0x0000),

	DEADTRANS( L' '   , 0x030f , 0x02F5 , 0x0000),	//Doppelgravis
	DEADTRANS( 0x030f , 0x030f , 0x030f , 0x0000),	//2x für Combining
	DEADTRANS( L'A'   , 0x030f , 0x0200 , 0x0000),
	DEADTRANS( L'E'   , 0x030f , 0x0204 , 0x0000),
	DEADTRANS( L'I'   , 0x030f , 0x0208 , 0x0000),
	DEADTRANS( L'O'   , 0x030f , 0x020c , 0x0000),
	DEADTRANS( L'R'   , 0x030f , 0x0210 , 0x0000),
	DEADTRANS( L'U'   , 0x030f , 0x0214 , 0x0000),
	DEADTRANS( L'a'   , 0x030f , 0x0201 , 0x0000),
	DEADTRANS( L'e'   , 0x030f , 0x0205 , 0x0000),
	DEADTRANS( L'i'   , 0x030f , 0x0209 , 0x0000),
	DEADTRANS( L'o'   , 0x030f , 0x020d , 0x0000),
	DEADTRANS( L'r'   , 0x030f , 0x0211 , 0x0000),
	DEADTRANS( L'u'   , 0x030f , 0x0215 , 0x0000),

	DEADTRANS( L' '   , 0x1ffe , 0x1ffe , 0x0000),	//Spiritus asper
	DEADTRANS( 0x1ffe , 0x1ffe , 0x0314 , 0x0000),	//2x für Combining
	DEADTRANS( 0x03b1 , 0x1ffe , 0x1f01 , 0x0000),
	DEADTRANS( 0x03b5 , 0x1ffe , 0x1f11 , 0x0000),
	DEADTRANS( 0x03b7 , 0x1ffe , 0x1f21 , 0x0000),
	DEADTRANS( 0x03b9 , 0x1ffe , 0x1f31 , 0x0000),
	DEADTRANS( 0x03bf , 0x1ffe , 0x1f41 , 0x0000),
	DEADTRANS( 0x03c5 , 0x1ffe , 0x1f51 , 0x0000),
	DEADTRANS( 0x03c9 , 0x1ffe , 0x1f61 , 0x0000),
	DEADTRANS( 0x03c1 , 0x1ffe , 0x1fe5 , 0x0000),
	DEADTRANS( 0x0391 , 0x1ffe , 0x1f09 , 0x0000),
	DEADTRANS( 0x0395 , 0x1ffe , 0x1f19 , 0x0000),
	DEADTRANS( 0x0397 , 0x1ffe , 0x1f29 , 0x0000),
	DEADTRANS( 0x0399 , 0x1ffe , 0x1f39 , 0x0000),
	DEADTRANS( 0x039f , 0x1ffe , 0x1f49 , 0x0000),
	DEADTRANS( 0x03a5 , 0x1ffe , 0x1f59 , 0x0000),
	DEADTRANS( 0x03a9 , 0x1ffe , 0x1f69 , 0x0000),
	DEADTRANS( 0x03a1 , 0x1ffe , 0x1fec , 0x0000),

//nicht belegt
//2x für Combining
// Ende von T2

// T3: rechts nebem ›ß‹
// Akut, Cedille, Quer-/Schrägstrich, Doppelakut, Spiritus lenis, Punkt darüber


	DEADTRANS( L' '   , 0x00b8 , 0x00b8 , 0x0000),	//Cedilla
	DEADTRANS( 0x00b8 , 0x00b8 , 0x0327 , 0x0000),	 //2x für Combining
	DEADTRANS( L'C'   , 0x00b8 , 0x00c7 , 0x0000),
	DEADTRANS( L'c'   , 0x00b8 , 0x00e7 , 0x0000),
	DEADTRANS( L'G'   , 0x00b8 , 0x0122 , 0x0000),
	DEADTRANS( L'g'   , 0x00b8 , 0x0123 , 0x0000),
	DEADTRANS( L'K'   , 0x00b8 , 0x0136 , 0x0000),
	DEADTRANS( L'k'   , 0x00b8 , 0x0137 , 0x0000),
	DEADTRANS( L'L'   , 0x00b8 , 0x013b , 0x0000),
	DEADTRANS( L'l'   , 0x00b8 , 0x013c , 0x0000),
	DEADTRANS( L'N'   , 0x00b8 , 0x0145 , 0x0000),
	DEADTRANS( L'n'   , 0x00b8 , 0x0146 , 0x0000),
	DEADTRANS( L'R'   , 0x00b8 , 0x0156 , 0x0000),
	DEADTRANS( L'r'   , 0x00b8 , 0x0157 , 0x0000),
	DEADTRANS( L'S'   , 0x00b8 , 0x015e , 0x0000),
	DEADTRANS( L's'   , 0x00b8 , 0x015f , 0x0000),
	DEADTRANS( L'T'   , 0x00b8 , 0x0162 , 0x0000),
	DEADTRANS( L't'   , 0x00b8 , 0x0163 , 0x0000),
	DEADTRANS( L'D'   , 0x00b8 , 0x1e10 , 0x0000),
	DEADTRANS( L'd'   , 0x00b8 , 0x1e11 , 0x0000),
	DEADTRANS( L'H'   , 0x00b8 , 0x1e28 , 0x0000),
	DEADTRANS( L'h'   , 0x00b8 , 0x1e29 , 0x0000),
    DEADTRANS( L'A'   , 0x00b8 , 0x0104 , 0x0000),	//Ogonek
    DEADTRANS( L'a'   , 0x00b8 , 0x0105 , 0x0000),
    DEADTRANS( L'E'   , 0x00b8 , 0x0118 , 0x0000),
    DEADTRANS( L'e'   , 0x00b8 , 0x0119 , 0x0000),
    DEADTRANS( L'I'   , 0x00b8 , 0x012e , 0x0000),
    DEADTRANS( L'i'   , 0x00b8 , 0x012f , 0x0000),
    DEADTRANS( L'U'   , 0x00b8 , 0x0172 , 0x0000),
    DEADTRANS( L'u'   , 0x00b8 , 0x0173 , 0x0000),
    DEADTRANS( L'O'   , 0x00b8 , 0x01ea , 0x0000),
    DEADTRANS( L'o'   , 0x00b8 , 0x01eb , 0x0000),
	
	DEADTRANS( L' '   , L'-'   , L'-'   , 0x0000),	//Quer-/Schrägstrich; mit Space wird echter Hyphen erzeugt
	DEADTRANS( L'-'   , L'-'   , 0x0335 , 0x0000),	//2x für Combining (Combining Short Stroke)
	DEADTRANS( L'1'   , L'-'   , 0x2081 , 0x0000),
	DEADTRANS( L'2'   , L'-'   , 0x2082 , 0x0000),
	DEADTRANS( L'3'   , L'-'   , 0x2083 , 0x0000),
	DEADTRANS( L'4'   , L'-'   , 0x2084 , 0x0000),
	DEADTRANS( L'5'   , L'-'   , 0x2085 , 0x0000),
	DEADTRANS( L'6'   , L'-'   , 0x2086 , 0x0000),
	DEADTRANS( L'7'   , L'-'   , 0x2087 , 0x0000),
	DEADTRANS( L'8'   , L'-'   , 0x2088 , 0x0000),
	DEADTRANS( L'9'   , L'-'   , 0x2089 , 0x0000),
	DEADTRANS( L'0'   , L'-'   , 0x2080 , 0x0000),
	DEADTRANS( L'+'   , L'-'   , 0x208a , 0x0000),
	DEADTRANS( L'-'   , L'-'   , 0x208b , 0x0000),
	DEADTRANS( L'='   , L'-'   , 0x208c , 0x0000),
	DEADTRANS( L'('   , L'-'   , 0x208d , 0x0000),
	DEADTRANS( L')'   , L'-'   , 0x208e , 0x0000),
	DEADTRANS( L'a'   , L'-'   , 0x2090 , 0x0000),
	DEADTRANS( L'e'   , L'-'   , 0x2091 , 0x0000),
	DEADTRANS( L'x'   , L'-'   , 0x2093 , 0x0000),
	DEADTRANS( L'O'   , L'-'   , 0x00d8 , 0x0000),	//Schrägstrich
	DEADTRANS( L'o'   , L'-'   , 0x00f8 , 0x0000),
	DEADTRANS( L'L'   , L'-'   , 0x0141 , 0x0000),
	DEADTRANS( L'l'   , L'-'   , 0x0142 , 0x0000),

	DEADTRANS( L' '   , 0x02DD , 0x02DD , 0x0000),	//Doppelakut
	DEADTRANS( 0x02DD , 0x02DD , 0x030B , 0x0000),	//2x für Combining
	DEADTRANS( L'O'   , 0x02DD , 0x0150 , 0x0000),
	DEADTRANS( L'o'   , 0x02DD , 0x0151 , 0x0000),
	DEADTRANS( L'U'   , 0x02DD , 0x0170 , 0x0000),
	DEADTRANS( L'u'   , 0x02DD , 0x0171 , 0x0000),





	DEADTRANS( L' '   , 0x02d9 , 0x02d9 , 0x0000),	//Dot Above
	DEADTRANS( 0x02d9 , 0x02d9 , 0x0307 , 0x0000),	//2x für Combining
	DEADTRANS( L'C'   , 0x02d9 , 0x010a , 0x0000),
	DEADTRANS( L'c'   , 0x02d9 , 0x010b , 0x0000),
	DEADTRANS( L'E'   , 0x02d9 , 0x0116 , 0x0000),
	DEADTRANS( L'e'   , 0x02d9 , 0x0117 , 0x0000),
	DEADTRANS( L'G'   , 0x02d9 , 0x0120 , 0x0000),
	DEADTRANS( L'g'   , 0x02d9 , 0x0121 , 0x0000),
	DEADTRANS( L'I'   , 0x02d9 , 0x0130 , 0x0000),
	DEADTRANS( L'i'   , 0x02d9 , 0x0131 , 0x0000),
	DEADTRANS( L'Z'   , 0x02d9 , 0x017b , 0x0000),
	DEADTRANS( L'z'   , 0x02d9 , 0x017c , 0x0000),
	DEADTRANS( L'A'   , 0x02d9 , 0x0226 , 0x0000),
	DEADTRANS( L'a'   , 0x02d9 , 0x0227 , 0x0000),
	DEADTRANS( L'O'   , 0x02d9 , 0x022e , 0x0000),
	DEADTRANS( L'o'   , 0x02d9 , 0x022f , 0x0000),
	DEADTRANS( L'B'   , 0x02d9 , 0x1e02 , 0x0000),
	DEADTRANS( L'b'   , 0x02d9 , 0x1e03 , 0x0000),
	DEADTRANS( L'D'   , 0x02d9 , 0x1e0a , 0x0000),
	DEADTRANS( L'd'   , 0x02d9 , 0x1e0b , 0x0000),
	DEADTRANS( L'F'   , 0x02d9 , 0x1e1e , 0x0000),
	DEADTRANS( L'f'   , 0x02d9 , 0x1e1f , 0x0000),
	DEADTRANS( L'H'   , 0x02d9 , 0x1e22 , 0x0000),
	DEADTRANS( L'h'   , 0x02d9 , 0x1e23 , 0x0000),
	DEADTRANS( L'M'   , 0x02d9 , 0x1e40 , 0x0000),
	DEADTRANS( L'm'   , 0x02d9 , 0x1e41 , 0x0000),
	DEADTRANS( L'N'   , 0x02d9 , 0x1e44 , 0x0000),
	DEADTRANS( L'n'   , 0x02d9 , 0x1e45 , 0x0000),
	DEADTRANS( L'P'   , 0x02d9 , 0x1e56 , 0x0000),
	DEADTRANS( L'p'   , 0x02d9 , 0x1e57 , 0x0000),
	DEADTRANS( L'R'   , 0x02d9 , 0x1e58 , 0x0000),
	DEADTRANS( L'r'   , 0x02d9 , 0x1e59 , 0x0000),
	DEADTRANS( L'S'   , 0x02d9 , 0x1e60 , 0x0000),
	DEADTRANS( L's'   , 0x02d9 , 0x1e61 , 0x0000),
	DEADTRANS( L'T'   , 0x02d9 , 0x1e6a , 0x0000),
	DEADTRANS( L't'   , 0x02d9 , 0x1e6b , 0x0000),
	DEADTRANS( L'W'   , 0x02d9 , 0x1e86 , 0x0000),
	DEADTRANS( L'w'   , 0x02d9 , 0x1e87 , 0x0000),
	DEADTRANS( L'X'   , 0x02d9 , 0x1e8a , 0x0000),
	DEADTRANS( L'x'   , 0x02d9 , 0x1e8b , 0x0000),
	DEADTRANS( L'Y'   , 0x02d9 , 0x1e8e , 0x0000),
	DEADTRANS( L'y'   , 0x02d9 , 0x1e8f , 0x0000),
	
	
	
    DEADTRANS( L' '   , 0x00b7 , 0x00b7 , 0x0000),	//Dot Middle
    DEADTRANS( 0x00b7 , 0x00b7 , 0x00b7 , 0x0000),	//kein Combining vorhanden
    DEADTRANS( L'L'   , 0x00b7 , 0x013F , 0x0000),
    DEADTRANS( L'l'   , 0x00b7 , 0x0140 , 0x0000),
    

    
                     	DEADTRANS( L' '   , L'.' , L'.'     , 0x0000),	//Dot Below
    DEADTRANS( L'.'   , L'.' , 0x0323   , 0x0000),	//2x für Combining
    DEADTRANS( L'B'   , L'.' , 0x1e04   , 0x0000),
    DEADTRANS( L'b'   , L'.' , 0x1e05   , 0x0000),
    DEADTRANS( L'D'   , L'.' , 0x1e0c   , 0x0000),
    DEADTRANS( L'd'   , L'.' , 0x1e0d   , 0x0000),
    DEADTRANS( L'H'   , L'.' , 0x1e24   , 0x0000),
    DEADTRANS( L'h'   , L'.' , 0x1e25   , 0x0000),
    DEADTRANS( L'K'   , L'.' , 0x1e32   , 0x0000),
    DEADTRANS( L'k'   , L'.' , 0x1e33   , 0x0000),
    DEADTRANS( L'L'   , L'.' , 0x1e36   , 0x0000),
    DEADTRANS( L'l'   , L'.' , 0x1e37   , 0x0000),
    DEADTRANS( L'M'   , L'.' , 0x1e42   , 0x0000),
    DEADTRANS( L'm'   , L'.' , 0x1e43   , 0x0000),
    DEADTRANS( L'N'   , L'.' , 0x1e46   , 0x0000),
    DEADTRANS( L'n'   , L'.' , 0x1e47   , 0x0000),
    DEADTRANS( L'R'   , L'.' , 0x1e5a   , 0x0000),
    DEADTRANS( L'r'   , L'.' , 0x1e5b   , 0x0000),
    DEADTRANS( L'S'   , L'.' , 0x1e62   , 0x0000),
    DEADTRANS( L's'   , L'.' , 0x1e63   , 0x0000),
    DEADTRANS( L'T'   , L'.' , 0x1e6c   , 0x0000),
    DEADTRANS( L't'   , L'.' , 0x1e6d   , 0x0000),
    DEADTRANS( L'V'   , L'.' , 0x1e7e   , 0x0000),
    DEADTRANS( L'v'   , L'.' , 0x1e7f   , 0x0000),
    DEADTRANS( L'W'   , L'.' , 0x1e88   , 0x0000),
    DEADTRANS( L'w'   , L'.' , 0x1e89   , 0x0000),
    DEADTRANS( L'Z'   , L'.' , 0x1e92   , 0x0000),
    DEADTRANS( L'z'   , L'.' , 0x1e93   , 0x0000),
    DEADTRANS( L'A'   , L'.' , 0x1ea0   , 0x0000),
    DEADTRANS( L'a'   , L'.' , 0x1ea1   , 0x0000),
    DEADTRANS( L'E'   , L'.' , 0x1eb8   , 0x0000),
    DEADTRANS( L'e'   , L'.' , 0x1eb9   , 0x0000),
    DEADTRANS( L'I'   , L'.' , 0x1eca   , 0x0000),
    DEADTRANS( L'i'   , L'.' , 0x1ecb   , 0x0000),
    DEADTRANS( L'O'   , L'.' , 0x1ecc   , 0x0000),
    DEADTRANS( L'o'   , L'.' , 0x1ecd   , 0x0000),
    DEADTRANS( L'Y'   , L'.' , 0x1ef4   , 0x0000),
    DEADTRANS( L'y'   , L'.' , 0x1ef5   , 0x0000),

                      


        



    // Ende der Taste zwei rechts neben der 0
    // Anfang der Taste rechts neben dem »ß«


    



    DEADTRANS( L' '   , 0x02DD , 0x02DD , 0x0000), //Doppel Akut
    DEADTRANS( 0x02DD , 0x02DD , 0x030B , 0x0000), //2x für Combining
    DEADTRANS( L'O'   , 0x02DD , 0x0150 , 0x0000),
    DEADTRANS( L'o'   , 0x02DD , 0x0151 , 0x0000),
    DEADTRANS( L'U'   , 0x02DD , 0x0170 , 0x0000),
    DEADTRANS( L'u'   , 0x02DD , 0x0171 , 0x0000),
    DEADTRANS( L' '   , 0x02DD , 0x02DD , 0x0000),

    DEADTRANS( L' '   , ',' , ','    , 0x0000), //Komma Below
    DEADTRANS( L','   , ',' , ','    , 0x0000),     //2x für Combining
    DEADTRANS( L'S'   , ',' , 0x0218 , 0x0000),
    DEADTRANS( L's'   , ',' , 0x0219 , 0x0000),
    DEADTRANS( L'T'   , ',' , 0x021a , 0x0000),
    DEADTRANS( L't'   , ',' , 0x021b , 0x0000),
    DEADTRANS( L' '   , ',' , 0x0326 , 0x0000),
// Ende der Tasten rechts neben dem »ß«



//Compose


DEADTRANS(    0x0073    ,0x266B ,    0x0073    ,0x0001    ),
DEADTRANS(    0x0046    ,0x266B ,    0x0046    ,0x0001    ),
DEADTRANS(    0x0066    ,0x266B ,    0x0066    ,0x0001    ),
DEADTRANS(    0x0054    ,0x266B ,    0x0054    ,0x0001    ),
DEADTRANS(    0x0051    ,0x266B ,    0x0051    ,0x0001    ),
DEADTRANS(    0x006C    ,0x266B ,    0x006C    ,0x0001    ),
DEADTRANS(    0x006D    ,0x266B ,    0x006D    ,0x0001    ),
DEADTRANS(    0x006B    ,0x266B ,    0x006B    ,0x0001    ),
DEADTRANS(    0x0063    ,0x266B ,    0x0063    ,0x0001    ),
DEADTRANS(    0x07EC    ,0x266B ,    0x07EC    ,0x0001    ),
DEADTRANS(    0x006E    ,0x266B ,    0x006E    ,0x0001    ),
DEADTRANS(    0x0064    ,0x266B ,    0x0064    ,0x0001    ),
DEADTRANS(    0x0048    ,0x266B ,    0x0048    ,0x0001    ),
DEADTRANS(    0x0022    ,0x266B ,    0x0022    ,0x0001    ),
DEADTRANS(    0x0034    ,0x266B ,    0x0034    ,0x0001    ),
DEADTRANS(    0x08BF    ,0x266B ,    0x08BF    ,0x0001    ),
DEADTRANS(    0x0AF7    ,0x266B ,    0x0AF7    ,0x0001    ),
DEADTRANS(    0x0AF8    ,0x266B ,    0x0AF8    ,0x0001    ),
DEADTRANS(    0x0023    ,0x266B ,    0x0023    ,0x0001    ),
DEADTRANS(    0x003A    ,0x266B ,    0x003A    ,0x0001    ),
DEADTRANS(    0x005F    ,0x266B ,    0x005F    ,0x0001    ),
DEADTRANS(    0x005E    ,0x266B ,    0x005E    ,0x0001    ),
DEADTRANS(    0x003C    ,0x266B ,    0x003C    ,0x0001    ),
DEADTRANS(    0x003E    ,0x266B ,    0x003E    ,0x0001    ),
DEADTRANS(    0x0033    ,0x266B ,    0x0033    ,0x0001    ),
DEADTRANS(    0x0032    ,0x266B ,    0x0032    ,0x0001    ),
DEADTRANS(    0x08D6    ,0x266B ,    0x08D6    ,0x0001    ),
DEADTRANS(    L'/'    ,0x266B ,    L'/'    ,0x0001    ),
DEADTRANS(    0x002F    ,0x266B ,    0x002F    ,0x0001    ),
DEADTRANS(    0x0072    ,0x266B ,    0x0072    ,0x0001    ),
DEADTRANS(    0x0052    ,0x266B ,    0x0052    ,0x0001    ),
DEADTRANS(    0x0031    ,0x266B ,    0x0031    ,0x0001    ),
DEADTRANS(    0x0037    ,0x266B ,    0x0037    ,0x0001    ),
DEADTRANS(    0x0035    ,0x266B ,    0x0035    ,0x0001    ),
DEADTRANS(    0x0074    ,0x266B ,    0x0074    ,0x0001    ),
DEADTRANS(    0x0053    ,0x266B ,    0x0053    ,0x0001    ),
DEADTRANS(    0x00B0    ,0x266B ,    0x00B0    ,0x0001    ),
DEADTRANS(    0x003D    ,0x266B ,    0x003D    ,0x0001    ),
DEADTRANS(    0x0057    ,0x266B ,    0x0057    ,0x0001    ),
DEADTRANS(    0x0050    ,0x266B ,    0x0050    ,0x0001    ),
DEADTRANS(    0x004E    ,0x266B ,    0x004E    ,0x0001    ),
DEADTRANS(    0x004C    ,0x266B ,    0x004C    ,0x0001    ),
DEADTRANS(    0x0043    ,0x266B ,    0x0043    ,0x0001    ),
DEADTRANS(    0x0BC6    ,0x266B ,    0x0BC6    ,0x0001    ),
DEADTRANS(    0x0021    ,0x266B ,    0x0021    ,0x0001    ),
DEADTRANS(    0x003F    ,0x266B ,    0x003F    ,0x0001    ),
DEADTRANS(    0x002E    ,0x266B ,    0x002E    ,0x0001    ),
DEADTRANS(    0x0077    ,0x266B ,    0x0077    ,0x0001    ),
DEADTRANS(    0x0025    ,0x266B ,    0x0025    ,0x0001    ),
DEADTRANS(    0x002C    ,0x266B ,    0x002C    ,0x0001    ),
DEADTRANS(    0x0027    ,0x266B ,    0x0027    ,0x0001    ),
DEADTRANS(    0x0020    ,0x266B ,    0x0020    ,0x0001    ),
DEADTRANS(    0x07E9    ,0x266B ,    0x07E9    ,0x0001    ),
DEADTRANS(    0x0060    ,0x266B ,    0x0060    ,0x0001    ),
DEADTRANS(    0x007E    ,0x266B ,    0x007E    ,0x0001    ),
DEADTRANS(    0x00A8    ,0x266B ,    0x00A8    ,0x0001    ),
DEADTRANS(    0x0028    ,0x266B ,    0x0028    ,0x0001    ),
DEADTRANS(    0x00AF    ,0x266B ,    0x00AF    ,0x0001    ),
DEADTRANS(    0x0062    ,0x266B ,    0x0062    ,0x0001    ),
DEADTRANS(    0x0055    ,0x266B ,    0x0055    ,0x0001    ),
DEADTRANS(    0x0029    ,0x266B ,    0x0029    ,0x0001    ),
DEADTRANS(    0x00B4    ,0x266B ,    0x00B4    ,0x0001    ),
DEADTRANS(    0x006F    ,0x266B ,    0x006F    ,0x0001    ),
DEADTRANS(    0x0061    ,0x266B ,    0x0061    ,0x0001    ),
DEADTRANS(    0x0047    ,0x266B ,    0x0047    ,0x0001    ),
DEADTRANS(    0x0065    ,0x266B ,    0x0065    ,0x0001    ),
DEADTRANS(    0x003B    ,0x266B ,    0x003B    ,0x0001    ),
DEADTRANS(    0x0044    ,0x266B ,    0x0044    ,0x0001    ),
DEADTRANS(    0x002B    ,0x266B ,    0x002B    ,0x0001    ),
DEADTRANS(    0x0045    ,0x266B ,    0x0045    ,0x0001    ),
DEADTRANS(    0x0075    ,0x266B ,    0x0075    ,0x0001    ),
DEADTRANS(    0x0069    ,0x266B ,    0x0069    ,0x0001    ),
DEADTRANS(    0x0049    ,0x266B ,    0x0049    ,0x0001    ),
DEADTRANS(    0x002D    ,0x266B ,    0x002D    ,0x0001    ),
DEADTRANS(    0x0078    ,0x266B ,    0x0078    ,0x0001    ),
DEADTRANS(    0x0041    ,0x266B ,    0x0041    ,0x0001    ),
DEADTRANS(    0x007C    ,0x266B ,    0x007C    ,0x0001    ),
DEADTRANS(    0x004F    ,0x266B ,    0x004F    ,0x0001    ),
DEADTRANS(    0x0070    ,0x266B ,    0x0070    ,0x0001    ),
DEADTRANS(    0x0059    ,0x266B ,    0x0059    ,0x0001    ),
DEADTRANS(    0x0076    ,0x266B ,    0x0076    ,0x0001    ),
DEADTRANS(    0x0056    ,0x266B ,    0x0056    ,0x0001    ),

DEADTRANS(    0x0074    ,    0x0073    ,    0xFB06    ,0x0000    ),
DEADTRANS(    0x006C    ,    0x0046    ,    0xFB04    ,0x0000    ),
DEADTRANS(    0x0069    ,    0x0046    ,    0xFB03    ,0x0000    ),
DEADTRANS(    0x006C    ,    0x0066    ,    0xFB02    ,0x0000    ),
DEADTRANS(    0x0069    ,    0x0066    ,    0xFB01    ,0x0000    ),
DEADTRANS(    0x0066    ,    0x0066    ,    0xFB00    ,0x0000    ),
DEADTRANS(    0x0068    ,    0x0054    ,    0xE049    ,0x0000    ),
DEADTRANS(    0x0075    ,    0x0051    ,    0xE048    ,0x0000    ),
DEADTRANS(    0x0074    ,    0x0066    ,    0xE039    ,0x0000    ),
DEADTRANS(    0x006B    ,    0x0066    ,    0xE038    ,0x0000    ),
DEADTRANS(    0x006A    ,    0x0066    ,    0xE037    ,0x0000    ),
DEADTRANS(    0x0068    ,    0x0066    ,    0xE036    ,0x0000    ),
DEADTRANS(    0x0074    ,    0x0046    ,    0xE035    ,0x0000    ),
DEADTRANS(    0x006B    ,    0x0046    ,    0xE034    ,0x0000    ),
DEADTRANS(    0x006A    ,    0x0046    ,    0xE033    ,0x0000    ),
DEADTRANS(    0x0068    ,    0x0046    ,    0xE032    ,0x0000    ),
DEADTRANS(    0x0062    ,    0x0046    ,    0xE031    ,0x0000    ),
DEADTRANS(    0x0062    ,    0x0066    ,    0xE030    ,0x0000    ),
DEADTRANS(    0x006E    ,    0x006C    ,    0x33D1    ,0x0000    ),
DEADTRANS(    0x0073    ,    0x006D    ,    0x33A7    ,0x0000    ),
DEADTRANS(    0x006D    ,    0x006B    ,    0x339E    ,0x0000    ),
DEADTRANS(    0x006D    ,    0x0063    ,    0x339D    ,0x0000    ),
DEADTRANS(    0x006D    ,    0x006D    ,    0x339C    ,0x0000    ),
DEADTRANS(    0x006D    ,    0x07EC    ,    0x339B    ,0x0000    ),
DEADTRANS(    0x006D    ,    0x006E    ,    0x339A    ,0x0000    ),
DEADTRANS(    0x006D    ,    0x0066    ,    0x3399    ,0x0000    ),
DEADTRANS(    0x2113    ,    0x006B    ,    0x3398    ,0x0000    ),
DEADTRANS(    0x006C    ,    0x006B    ,    0x3398    ,0x0000    ),
DEADTRANS(    0x2113    ,    0x0064    ,    0x3397    ,0x0000    ),
DEADTRANS(    0x006C    ,    0x0064    ,    0x3397    ,0x0000    ),
DEADTRANS(    0x2113    ,    0x006D    ,    0x3396    ,0x0000    ),
DEADTRANS(    0x006C    ,    0x006D    ,    0x3396    ,0x0000    ),
DEADTRANS(    0x2113    ,    0x07EC    ,    0x3395    ,0x0000    ),
DEADTRANS(    0x006C    ,    0x07EC    ,    0x3395    ,0x0000    ),
DEADTRANS(    0x007A    ,    0x0048    ,    0x3390    ,0x0000    ),
DEADTRANS(    0x0067    ,    0x006B    ,    0x338F    ,0x0000    ),
DEADTRANS(    0x0067    ,    0x006D    ,    0x338E    ,0x0000    ),
DEADTRANS(    0x0067    ,    0x07EC    ,    0x338D    ,0x0000    ),
DEADTRANS(    0x002F    ,    0x0022    ,    0x301e    ,0x0000    ),
DEADTRANS(    0x005C    ,    0x0022    ,    0x301d    ,0x0000    ),
DEADTRANS(    0x08BF    ,    0x0034    ,    0x2A0C    ,0x0000    ),
DEADTRANS(    0x0034    ,    0x08BF    ,    0x2A0C    ,0x0000    ),
DEADTRANS(    0x0AF8    ,    0x0AF7    ,    0x26A5    ,0x0000    ),
DEADTRANS(    0x0AF7    ,    0x0AF8    ,    0x26A4    ,0x0000    ),
DEADTRANS(    0x0AF7    ,    0x0AF7    ,    0x26A3    ,0x0000    ),
DEADTRANS(    0x0AF8    ,    0x0AF8    ,    0x26A2    ,0x0000    ),
DEADTRANS(    0x0023    ,    0x0023    ,    0x266f    ,0x0000    ),
DEADTRANS(    0x0066    ,    0x0023    ,    0x266e    ,0x0000    ),
DEADTRANS(    0x0062    ,    0x0023    ,    0x266d    ,0x0000    ),
DEADTRANS(    0x0029    ,    0x003A    ,    0x263A    ,0x0000    ),
DEADTRANS(    0x0028    ,    0x003A    ,    0x2639    ,0x0000    ),
DEADTRANS(    0x005D    ,    0x005F    ,    0x230B    ,0x0000    ),
DEADTRANS(    0x005B    ,    0x005F    ,    0x230A    ,0x0000    ),
DEADTRANS(    0x005D    ,    0x005E    ,    0x2309    ,0x0000    ),
DEADTRANS(    0x005B    ,    0x005E    ,    0x2308    ,0x0000    ),
DEADTRANS(    0x002E    ,    0x003C    ,    0x2235    ,0x0000    ),
DEADTRANS(    0x002E    ,    0x003E    ,    0x2234    ,0x0000    ),
DEADTRANS(    0x08BF    ,    0x0033    ,    0x2230    ,0x0000    ),
DEADTRANS(    0x0033    ,    0x08BF    ,    0x2230    ,0x0000    ),
DEADTRANS(    0x08BF    ,    0x08BF    ,    0x222F    ,0x0000    ),
DEADTRANS(    0x08BF    ,    0x0032    ,    0x222F    ,0x0000    ),
DEADTRANS(    0x0032    ,    0x08BF    ,    0x222F    ,0x0000    ),
DEADTRANS(    0x08BF    ,    0x0033    ,    0x222D    ,0x0000    ),
DEADTRANS(    0x0033    ,    0x08BF    ,    0x222D    ,0x0000    ),
DEADTRANS(    0x08BF    ,    0x08BF    ,    0x222C    ,0x0000    ),
DEADTRANS(    0x08BF    ,    0x0032    ,    0x222C    ,0x0000    ),
DEADTRANS(    0x0032    ,    0x08BF    ,    0x222C    ,0x0000    ),
DEADTRANS(    0x08D6    ,    0x0034    ,    0x221C    ,0x0000    ),
DEADTRANS(    0x0034    ,    0x08D6    ,    0x221C    ,0x0000    ),
DEADTRANS(    0x08D6    ,    0x0033    ,    0x221B    ,0x0000    ),
DEADTRANS(    0x0033    ,    0x08D6    ,    0x221B    ,0x0000    ),
DEADTRANS(    0x08FD    ,    L'/'    ,    0x219B    ,0x0000    ),
DEADTRANS(    0x08FD    ,    0x002F    ,    0x219B    ,0x0000    ),
DEADTRANS(    0x08FB    ,    L'/'    ,    0x219A    ,0x0000    ),
DEADTRANS(    0x08FB    ,    0x002F    ,    0x219A    ,0x0000    ),
DEADTRANS(    0x0039    ,    0x0072    ,    0x2178    ,0x0000    ),
DEADTRANS(    0x0038    ,    0x0072    ,    0x2177    ,0x0000    ),
DEADTRANS(    0x0037    ,    0x0072    ,    0x2176    ,0x0000    ),
DEADTRANS(    0x0036    ,    0x0072    ,    0x2175    ,0x0000    ),
DEADTRANS(    0x0035    ,    0x0072    ,    0x2174    ,0x0000    ),
DEADTRANS(    0x0034    ,    0x0072    ,    0x2173    ,0x0000    ),
DEADTRANS(    0x0033    ,    0x0072    ,    0x2172    ,0x0000    ),
DEADTRANS(    0x0032    ,    0x0072    ,    0x2171    ,0x0000    ),
DEADTRANS(    0x0039    ,    0x0052    ,    0x2168    ,0x0000    ),
DEADTRANS(    0x0038    ,    0x0052    ,    0x2167    ,0x0000    ),
DEADTRANS(    0x0037    ,    0x0052    ,    0x2166    ,0x0000    ),
DEADTRANS(    0x0036    ,    0x0052    ,    0x2165    ,0x0000    ),
DEADTRANS(    0x0035    ,    0x0052    ,    0x2164    ,0x0000    ),
DEADTRANS(    0x0034    ,    0x0052    ,    0x2163    ,0x0000    ),
DEADTRANS(    0x0033    ,    0x0052    ,    0x2162    ,0x0000    ),
DEADTRANS(    0x0032    ,    0x0052    ,    0x2161    ,0x0000    ),
DEADTRANS(    L'/'    ,    0x0031    ,    0x215F    ,0x0000    ),
DEADTRANS(    0x002F    ,    0x0031    ,    0x215F    ,0x0000    ),
DEADTRANS(    0x0038    ,    0x0037    ,    0x215E    ,0x0000    ),
DEADTRANS(    0x0038    ,    0x0035    ,    0x215D    ,0x0000    ),
DEADTRANS(    0x0038    ,    0x0033    ,    0x215C    ,0x0000    ),
DEADTRANS(    0x0038    ,    0x0031    ,    0x215B    ,0x0000    ),
DEADTRANS(    0x0038    ,    0x0031    ,    0x215B    ,0x0000    ),
DEADTRANS(    0x0036    ,    0x0035    ,    0x215A    ,0x0000    ),
DEADTRANS(    0x0036    ,    0x0031    ,    0x2159    ,0x0000    ),
DEADTRANS(    0x0035    ,    0x0034    ,    0x2158    ,0x0000    ),
DEADTRANS(    0x0035    ,    0x0033    ,    0x2157    ,0x0000    ),
DEADTRANS(    0x0035    ,    0x0032    ,    0x2156    ,0x0000    ),
DEADTRANS(    0x0035    ,    0x0031    ,    0x2155    ,0x0000    ),
DEADTRANS(    0x0033    ,    0x0032    ,    0x2154    ,0x0000    ),
DEADTRANS(    0x0033    ,    0x0031    ,    0x2153    ,0x0000    ),
DEADTRANS(    0x006D    ,    0x0074    ,    0x2122    ,0x0000    ),
DEADTRANS(    0x004D    ,    0x0054    ,    0x2122    ,0x0000    ),
DEADTRANS(    0x004D    ,    0x0053    ,    0x2120    ,0x0000    ),
DEADTRANS(    0x0046    ,    0x00B0    ,    0x2109    ,0x0000    ),
DEADTRANS(    0x0043    ,    0x00B0    ,    0x2103    ,0x0000    ),
DEADTRANS(    0x002D    ,    0x0064    ,    0x20ab    ,0x0000    ),
DEADTRANS(    0x0057    ,    0x003D    ,    0x20a9    ,0x0000    ),
DEADTRANS(    0x003D    ,    0x0057    ,    0x20a9    ,0x0000    ),
DEADTRANS(    0x0073    ,    0x0052    ,    0x20a8    ,0x0000    ),
DEADTRANS(    0x0074    ,    0x0050    ,    0x20a7    ,0x0000    ),
DEADTRANS(    0x004E    ,    0x003D    ,    0x20a6    ,0x0000    ),
DEADTRANS(    0x003D    ,    0x004E    ,    0x20a6    ,0x0000    ),
DEADTRANS(    0x006D    ,    0x002F    ,    0x20a5    ,0x0000    ),
DEADTRANS(    0x002F    ,    0x006D    ,    0x20a5    ,0x0000    ),
DEADTRANS(    0x004C    ,    0x003D    ,    0x20a4    ,0x0000    ),
DEADTRANS(    0x003D    ,    0x004C    ,    0x20a4    ,0x0000    ),
DEADTRANS(    0x0072    ,    0x0046    ,    0x20a3    ,0x0000    ),
DEADTRANS(    0x0072    ,    0x0043    ,    0x20a2    ,0x0000    ),
DEADTRANS(    0x0043    ,    0x002F    ,    0x20a1    ,0x0000    ),
DEADTRANS(    0x002F    ,    0x0043    ,    0x20a1    ,0x0000    ),
DEADTRANS(    0x0045    ,    0x0043    ,    0x20a0    ,0x0000    ),
DEADTRANS(    0x0029    ,    0x0BC6    ,    0x208E    ,0x0000    ),
DEADTRANS(    0x0029    ,    0x005F    ,    0x208E    ,0x0000    ),
DEADTRANS(    0x0028    ,    0x0BC6    ,    0x208D    ,0x0000    ),
DEADTRANS(    0x0028    ,    0x005F    ,    0x208D    ,0x0000    ),
DEADTRANS(    L'='    ,    0x0BC6    ,    0x208C    ,0x0000    ),
DEADTRANS(    L'='    ,    0x005F    ,    0x208C    ,0x0000    ),
DEADTRANS(    0x003D    ,    0x0BC6    ,    0x208C    ,0x0000    ),
DEADTRANS(    0x003D    ,    0x005F    ,    0x208C    ,0x0000    ),
DEADTRANS(    L'-'    ,    0x0BC6    ,    0x208B    ,0x0000    ),
DEADTRANS(    L'-'    ,    0x005F    ,    0x208B    ,0x0000    ),
DEADTRANS(    0x002D    ,    0x0BC6    ,    0x208B    ,0x0000    ),
DEADTRANS(    0x002D    ,    0x005F    ,    0x208B    ,0x0000    ),
DEADTRANS(    L'+'    ,    0x0BC6    ,    0x208A    ,0x0000    ),
DEADTRANS(    L'+'    ,    0x005F    ,    0x208A    ,0x0000    ),
DEADTRANS(    0x002B    ,    0x0BC6    ,    0x208A    ,0x0000    ),
DEADTRANS(    0x002B    ,    0x005F    ,    0x208A    ,0x0000    ),
DEADTRANS(    0x0039    ,    0x0BC6    ,    0x2089    ,0x0000    ),
DEADTRANS(    0x0039    ,    0x005F    ,    0x2089    ,0x0000    ),
DEADTRANS(    0x0038    ,    0x0BC6    ,    0x2088    ,0x0000    ),
DEADTRANS(    0x0038    ,    0x005F    ,    0x2088    ,0x0000    ),
DEADTRANS(    0x0037    ,    0x0BC6    ,    0x2087    ,0x0000    ),
DEADTRANS(    0x0037    ,    0x005F    ,    0x2087    ,0x0000    ),
DEADTRANS(    0x0036    ,    0x0BC6    ,    0x2086    ,0x0000    ),
DEADTRANS(    0x0036    ,    0x005F    ,    0x2086    ,0x0000    ),
DEADTRANS(    0x0035    ,    0x0BC6    ,    0x2085    ,0x0000    ),
DEADTRANS(    0x0035    ,    0x005F    ,    0x2085    ,0x0000    ),
DEADTRANS(    0x0034    ,    0x0BC6    ,    0x2084    ,0x0000    ),
DEADTRANS(    0x0034    ,    0x005F    ,    0x2084    ,0x0000    ),
DEADTRANS(    0x0033    ,    0x0BC6    ,    0x2083    ,0x0000    ),
DEADTRANS(    0x0033    ,    0x005F    ,    0x2083    ,0x0000    ),
DEADTRANS(    0x0032    ,    0x0BC6    ,    0x2082    ,0x0000    ),
DEADTRANS(    0x0032    ,    0x005F    ,    0x2082    ,0x0000    ),
DEADTRANS(    0x0031    ,    0x0BC6    ,    0x2081    ,0x0000    ),
DEADTRANS(    0x0031    ,    0x005F    ,    0x2081    ,0x0000    ),
DEADTRANS(    0x0030    ,    0x0BC6    ,    0x2080    ,0x0000    ),
DEADTRANS(    0x0030    ,    0x005F    ,    0x2080    ,0x0000    ),
DEADTRANS(    0x0029    ,    0x005E    ,    0x207E    ,0x0000    ),
DEADTRANS(    0x0028    ,    0x005E    ,    0x207D    ,0x0000    ),
DEADTRANS(    L'='    ,    0x005E    ,    0x207C    ,0x0000    ),
DEADTRANS(    0x003D    ,    0x005E    ,    0x207C    ,0x0000    ),
DEADTRANS(    L'-'    ,    0x005E    ,    0x207B    ,0x0000    ),
DEADTRANS(    0x002D    ,    0x005E    ,    0x207B    ,0x0000    ),
DEADTRANS(    L'+'    ,    0x005E    ,    0x207A    ,0x0000    ),
DEADTRANS(    0x002B    ,    0x005E    ,    0x207A    ,0x0000    ),
DEADTRANS(    0x0039    ,    0x005E    ,    0x2079    ,0x0000    ),
DEADTRANS(    0x0038    ,    0x005E    ,    0x2078    ,0x0000    ),
DEADTRANS(    0x0037    ,    0x005E    ,    0x2077    ,0x0000    ),
DEADTRANS(    0x0036    ,    0x005E    ,    0x2076    ,0x0000    ),
DEADTRANS(    0x0035    ,    0x005E    ,    0x2075    ,0x0000    ),
DEADTRANS(    0x0034    ,    0x005E    ,    0x2074    ,0x0000    ),
DEADTRANS(    0x0030    ,    0x005E    ,    0x2070    ,0x0000    ),
DEADTRANS(    0x003F    ,    0x0021    ,    0x2049    ,0x0000    ),
DEADTRANS(    0x0021    ,    0x003F    ,    0x2048    ,0x0000    ),
DEADTRANS(    0x003F    ,    0x0032    ,    0x2047    ,0x0000    ),
DEADTRANS(    0x0032    ,    0x003F    ,    0x2047    ,0x0000    ),
DEADTRANS(    0x0032    ,    0x0021    ,    0x203C    ,0x0000    ),
DEADTRANS(    0x0021    ,    0x0032    ,    0x203C    ,0x0000    ),
DEADTRANS(    0x003E    ,    0x002E    ,    0x203a    ,0x0000    ),
DEADTRANS(    0x003C    ,    0x002E    ,    0x2039    ,0x0000    ),
DEADTRANS(    0x0022    ,    0x0077    ,    0x2033    ,0x0000    ),
DEADTRANS(    0x0027    ,    0x0077    ,    0x2032    ,0x0000    ),
DEADTRANS(    0x006F    ,    0x0025    ,    0x2030    ,0x0000    ),
DEADTRANS(    0x002C    ,    0x0022    ,    0x201e    ,0x0000    ),
DEADTRANS(    0x0022    ,    0x002C    ,    0x201e    ,0x0000    ),
DEADTRANS(    0x003E    ,    0x0022    ,    0x201d    ,0x0000    ),
DEADTRANS(    0x0022    ,    0x003E    ,    0x201d    ,0x0000    ),
DEADTRANS(    0x003C    ,    0x0022    ,    0x201c    ,0x0000    ),
DEADTRANS(    0x0022    ,    0x003C    ,    0x201c    ,0x0000    ),
DEADTRANS(    0x002C    ,    0x0027    ,    0x201a    ,0x0000    ),
DEADTRANS(    0x0027    ,    0x002C    ,    0x201a    ,0x0000    ),
DEADTRANS(    0x003E    ,    0x0027    ,    0x2019    ,0x0000    ),
DEADTRANS(    0x0027    ,    0x003E    ,    0x2019    ,0x0000    ),
DEADTRANS(    0x003C    ,    0x0027    ,    0x2018    ,0x0000    ),
DEADTRANS(    0x0027    ,    0x003C    ,    0x2018    ,0x0000    ),
DEADTRANS(    0x002E    ,    0x0020    ,    0x2008    ,0x0000    ),
DEADTRANS(    0x07D9    ,    0x07E9    ,    0x1FFC    ,0x0000    ),
DEADTRANS(    0x07D9    ,    0x0060    ,    0x1FFA    ,0x0000    ),
DEADTRANS(    0x07CF    ,    0x0060    ,    0x1FF8    ,0x0000    ),
DEADTRANS(    0x07F9    ,    0x007E    ,    0x1FF6    ,0x0000    ),
DEADTRANS(    0x07BB    ,    0x07E9    ,    0x1FF4    ,0x0000    ),
DEADTRANS(    0x07F9    ,    0x07E9    ,    0x1FF3    ,0x0000    ),
DEADTRANS(    0x1EF2    ,    0x00A8    ,    0x1FED    ,0x0000    ),
DEADTRANS(    0x0060    ,    0x00A8    ,    0x1FED    ,0x0000    ),
DEADTRANS(    0x07D1    ,    0x0028    ,    0x1FEC    ,0x0000    ),
DEADTRANS(    0x07D5    ,    0x0060    ,    0x1FEA    ,0x0000    ),
DEADTRANS(    0x07D5    ,    0x00AF    ,    0x1FE9    ,0x0000    ),
DEADTRANS(    0x07D5    ,    0x005F    ,    0x1FE9    ,0x0000    ),
DEADTRANS(    0x07D5    ,    0x0062    ,    0x1FE8    ,0x0000    ),
DEADTRANS(    0x07D5    ,    0x0055    ,    0x1FE8    ,0x0000    ),
DEADTRANS(    0x07B9    ,    0x007E    ,    0x1FE7    ,0x0000    ),
DEADTRANS(    0x07F5    ,    0x007E    ,    0x1FE6    ,0x0000    ),
DEADTRANS(    0x07F1    ,    0x0028    ,    0x1FE5    ,0x0000    ),
DEADTRANS(    0x07F1    ,    0x0029    ,    0x1FE4    ,0x0000    ),
DEADTRANS(    0x07B9    ,    0x0060    ,    0x1FE2    ,0x0000    ),
DEADTRANS(    0x07F5    ,    0x00AF    ,    0x1FE1    ,0x0000    ),
DEADTRANS(    0x07F5    ,    0x005F    ,    0x1FE1    ,0x0000    ),
DEADTRANS(    0x07F5    ,    0x0062    ,    0x1FE0    ,0x0000    ),
DEADTRANS(    0x07F5    ,    0x0055    ,    0x1FE0    ,0x0000    ),
DEADTRANS(    0x07C9    ,    0x0060    ,    0x1FDA    ,0x0000    ),
DEADTRANS(    0x07C9    ,    0x00AF    ,    0x1FD9    ,0x0000    ),
DEADTRANS(    0x07C9    ,    0x005F    ,    0x1FD9    ,0x0000    ),
DEADTRANS(    0x07C9    ,    0x0062    ,    0x1FD8    ,0x0000    ),
DEADTRANS(    0x07C9    ,    0x0055    ,    0x1FD8    ,0x0000    ),
DEADTRANS(    0x07B5    ,    0x007E    ,    0x1FD7    ,0x0000    ),
DEADTRANS(    0x07E9    ,    0x007E    ,    0x1FD6    ,0x0000    ),
DEADTRANS(    0x07B5    ,    0x0060    ,    0x1FD2    ,0x0000    ),
DEADTRANS(    0x07E9    ,    0x00AF    ,    0x1FD1    ,0x0000    ),
DEADTRANS(    0x07E9    ,    0x005F    ,    0x1FD1    ,0x0000    ),
DEADTRANS(    0x07E9    ,    0x0062    ,    0x1FD0    ,0x0000    ),
DEADTRANS(    0x07E9    ,    0x0055    ,    0x1FD0    ,0x0000    ),
DEADTRANS(    0x07C7    ,    0x07E9    ,    0x1FCC    ,0x0000    ),
DEADTRANS(    0x07C7    ,    0x0060    ,    0x1FCA    ,0x0000    ),
DEADTRANS(    0x07C5    ,    0x0060    ,    0x1FC8    ,0x0000    ),
DEADTRANS(    0x07E7    ,    0x007E    ,    0x1FC6    ,0x0000    ),
DEADTRANS(    0x07B3    ,    0x07E9    ,    0x1FC4    ,0x0000    ),
DEADTRANS(    0x07E7    ,    0x07E9    ,    0x1FC3    ,0x0000    ),
DEADTRANS(    0x007E    ,    0x00A8    ,    0x1FC1    ,0x0000    ),
DEADTRANS(    0x07C1    ,    0x07E9    ,    0x1FBC    ,0x0000    ),
DEADTRANS(    0x07C1    ,    0x0060    ,    0x1FBA    ,0x0000    ),
DEADTRANS(    0x07C1    ,    0x00AF    ,    0x1FB9    ,0x0000    ),
DEADTRANS(    0x07C1    ,    0x005F    ,    0x1FB9    ,0x0000    ),
DEADTRANS(    0x07C1    ,    0x0062    ,    0x1FB8    ,0x0000    ),
DEADTRANS(    0x07C1    ,    0x0055    ,    0x1FB8    ,0x0000    ),
DEADTRANS(    0x07E1    ,    0x007E    ,    0x1FB6    ,0x0000    ),
DEADTRANS(    0x07B1    ,    0x07E9    ,    0x1FB4    ,0x0000    ),
DEADTRANS(    0x07E1    ,    0x07E9    ,    0x1FB3    ,0x0000    ),
DEADTRANS(    0x07E1    ,    0x00AF    ,    0x1FB1    ,0x0000    ),
DEADTRANS(    0x07E1    ,    0x005F    ,    0x1FB1    ,0x0000    ),
DEADTRANS(    0x07E1    ,    0x0062    ,    0x1FB0    ,0x0000    ),
DEADTRANS(    0x07E1    ,    0x0055    ,    0x1FB0    ,0x0000    ),
DEADTRANS(    0x07F9    ,    0x0060    ,    0x1F7C    ,0x0000    ),
DEADTRANS(    0x07F5    ,    0x0060    ,    0x1F7A    ,0x0000    ),
DEADTRANS(    0x07EF    ,    0x0060    ,    0x1F78    ,0x0000    ),
DEADTRANS(    0x07E9    ,    0x0060    ,    0x1F76    ,0x0000    ),
DEADTRANS(    0x07E7    ,    0x0060    ,    0x1F74    ,0x0000    ),
DEADTRANS(    0x07E5    ,    0x0060    ,    0x1F72    ,0x0000    ),
DEADTRANS(    0x07E1    ,    0x0060    ,    0x1F70    ,0x0000    ),
DEADTRANS(    0x07D9    ,    0x0028    ,    0x1F69    ,0x0000    ),
DEADTRANS(    0x07D9    ,    0x0029    ,    0x1F68    ,0x0000    ),
DEADTRANS(    0x07F9    ,    0x0028    ,    0x1F61    ,0x0000    ),
DEADTRANS(    0x07F9    ,    0x0029    ,    0x1F60    ,0x0000    ),
DEADTRANS(    0x07D5    ,    0x0028    ,    0x1F59    ,0x0000    ),
DEADTRANS(    0x07F5    ,    0x0028    ,    0x1F51    ,0x0000    ),
DEADTRANS(    0x07F5    ,    0x0029    ,    0x1F50    ,0x0000    ),
DEADTRANS(    0x07CF    ,    0x0028    ,    0x1F49    ,0x0000    ),
DEADTRANS(    0x07CF    ,    0x0029    ,    0x1F48    ,0x0000    ),
DEADTRANS(    0x07EF    ,    0x0028    ,    0x1F41    ,0x0000    ),
DEADTRANS(    0x07EF    ,    0x0029    ,    0x1F40    ,0x0000    ),
DEADTRANS(    0x07C9    ,    0x0028    ,    0x1F39    ,0x0000    ),
DEADTRANS(    0x07C9    ,    0x0029    ,    0x1F38    ,0x0000    ),
DEADTRANS(    0x07E9    ,    0x0028    ,    0x1F31    ,0x0000    ),
DEADTRANS(    0x07E9    ,    0x0029    ,    0x1F30    ,0x0000    ),
DEADTRANS(    0x07C7    ,    0x0028    ,    0x1F29    ,0x0000    ),
DEADTRANS(    0x07C7    ,    0x0029    ,    0x1F28    ,0x0000    ),
DEADTRANS(    0x07E7    ,    0x0028    ,    0x1F21    ,0x0000    ),
DEADTRANS(    0x07E7    ,    0x0029    ,    0x1F20    ,0x0000    ),
DEADTRANS(    0x07C5    ,    0x0028    ,    0x1F19    ,0x0000    ),
DEADTRANS(    0x07C5    ,    0x0029    ,    0x1F18    ,0x0000    ),
DEADTRANS(    0x07E5    ,    0x0028    ,    0x1F11    ,0x0000    ),
DEADTRANS(    0x07E5    ,    0x0029    ,    0x1F10    ,0x0000    ),
DEADTRANS(    0x07C1    ,    0x0028    ,    0x1F09    ,0x0000    ),
DEADTRANS(    0x07C1    ,    0x0029    ,    0x1F08    ,0x0000    ),
DEADTRANS(    0x07E1    ,    0x0028    ,    0x1F01    ,0x0000    ),
DEADTRANS(    0x07E1    ,    0x0029    ,    0x1F00    ,0x0000    ),
DEADTRANS(    0x0079    ,    0x007E    ,    0x1EF9    ,0x0000    ),
DEADTRANS(    0x0059    ,    0x007E    ,    0x1EF8    ,0x0000    ),
DEADTRANS(    0x0079    ,    0x003F    ,    0x1EF7    ,0x0000    ),
DEADTRANS(    0x0059    ,    0x003F    ,    0x1EF6    ,0x0000    ),
DEADTRANS(    0x0079    ,    0x0021    ,    0x1EF5    ,0x0000    ),
DEADTRANS(    0x0059    ,    0x0021    ,    0x1EF4    ,0x0000    ),
DEADTRANS(    0x0079    ,    0x0060    ,    0x1EF3    ,0x0000    ),
DEADTRANS(    0x0059    ,    0x0060    ,    0x1EF2    ,0x0000    ),
DEADTRANS(    0x1EFD    ,    0x0021    ,    0x1EF1    ,0x0000    ),
DEADTRANS(    0x1EFC    ,    0x0021    ,    0x1EF0    ,0x0000    ),
DEADTRANS(    0x1EFD    ,    0x007E    ,    0x1EEF    ,0x0000    ),
DEADTRANS(    0x1EFC    ,    0x007E    ,    0x1EEE    ,0x0000    ),
DEADTRANS(    0x1EFD    ,    0x003F    ,    0x1EED    ,0x0000    ),
DEADTRANS(    0x1EFC    ,    0x003F    ,    0x1EEC    ,0x0000    ),
DEADTRANS(    0x1EFD    ,    0x0060    ,    0x1EEB    ,0x0000    ),
DEADTRANS(    0x1EFC    ,    0x0060    ,    0x1EEA    ,0x0000    ),
DEADTRANS(    0x1EFD    ,    0x00B4    ,    0x1EE9    ,0x0000    ),
DEADTRANS(    0x1EFD    ,    0x0027    ,    0x1EE9    ,0x0000    ),
DEADTRANS(    0x1EFC    ,    0x00B4    ,    0x1EE8    ,0x0000    ),
DEADTRANS(    0x1EFC    ,    0x0027    ,    0x1EE8    ,0x0000    ),
DEADTRANS(    0x0075    ,    0x003F    ,    0x1EE7    ,0x0000    ),
DEADTRANS(    0x0055    ,    0x003F    ,    0x1EE6    ,0x0000    ),
DEADTRANS(    0x0075    ,    0x0021    ,    0x1EE5    ,0x0000    ),
DEADTRANS(    0x0055    ,    0x0021    ,    0x1EE4    ,0x0000    ),
DEADTRANS(    0x1EFB    ,    0x0021    ,    0x1EE3    ,0x0000    ),
DEADTRANS(    0x1EFA    ,    0x0021    ,    0x1EE2    ,0x0000    ),
DEADTRANS(    0x1EFB    ,    0x007E    ,    0x1EE1    ,0x0000    ),
DEADTRANS(    0x1EFA    ,    0x007E    ,    0x1EE0    ,0x0000    ),
DEADTRANS(    0x1EFB    ,    0x003F    ,    0x1EDF    ,0x0000    ),
DEADTRANS(    0x1EFA    ,    0x003F    ,    0x1EDE    ,0x0000    ),
DEADTRANS(    0x1EFB    ,    0x0060    ,    0x1EDD    ,0x0000    ),
DEADTRANS(    0x1EFA    ,    0x0060    ,    0x1EDC    ,0x0000    ),
DEADTRANS(    0x1EFB    ,    0x00B4    ,    0x1EDB    ,0x0000    ),
DEADTRANS(    0x1EFB    ,    0x0027    ,    0x1EDB    ,0x0000    ),
DEADTRANS(    0x1EFA    ,    0x00B4    ,    0x1EDA    ,0x0000    ),
DEADTRANS(    0x1EFA    ,    0x0027    ,    0x1EDA    ,0x0000    ),
DEADTRANS(    0x00F4    ,    0x007E    ,    0x1ED7    ,0x0000    ),
DEADTRANS(    0x00D4    ,    0x007E    ,    0x1ED6    ,0x0000    ),
DEADTRANS(    0x00F4    ,    0x003F    ,    0x1ED5    ,0x0000    ),
DEADTRANS(    0x00D4    ,    0x003F    ,    0x1ED4    ,0x0000    ),
DEADTRANS(    0x00F4    ,    0x0060    ,    0x1ED3    ,0x0000    ),
DEADTRANS(    0x00D4    ,    0x0060    ,    0x1ED2    ,0x0000    ),
DEADTRANS(    0x00F4    ,    0x00B4    ,    0x1ED1    ,0x0000    ),
DEADTRANS(    0x00F4    ,    0x0027    ,    0x1ED1    ,0x0000    ),
DEADTRANS(    0x00D4    ,    0x00B4    ,    0x1ED0    ,0x0000    ),
DEADTRANS(    0x00D4    ,    0x0027    ,    0x1ED0    ,0x0000    ),
DEADTRANS(    0x006F    ,    0x003F    ,    0x1ECF    ,0x0000    ),
DEADTRANS(    0x004F    ,    0x003F    ,    0x1ECE    ,0x0000    ),
DEADTRANS(    0x006F    ,    0x0021    ,    0x1ECD    ,0x0000    ),
DEADTRANS(    0x004F    ,    0x0021    ,    0x1ECC    ,0x0000    ),
DEADTRANS(    0x0069    ,    0x0021    ,    0x1ECB    ,0x0000    ),
DEADTRANS(    0x0049    ,    0x0021    ,    0x1ECA    ,0x0000    ),
DEADTRANS(    0x0069    ,    0x003F    ,    0x1EC9    ,0x0000    ),
DEADTRANS(    0x0049    ,    0x003F    ,    0x1EC8    ,0x0000    ),
DEADTRANS(    0x00EA    ,    0x007E    ,    0x1EC5    ,0x0000    ),
DEADTRANS(    0x00CA    ,    0x007E    ,    0x1EC4    ,0x0000    ),
DEADTRANS(    0x00EA    ,    0x003F    ,    0x1EC3    ,0x0000    ),
DEADTRANS(    0x00CA    ,    0x003F    ,    0x1EC2    ,0x0000    ),
DEADTRANS(    0x00EA    ,    0x0060    ,    0x1EC1    ,0x0000    ),
DEADTRANS(    0x00CA    ,    0x0060    ,    0x1EC0    ,0x0000    ),
DEADTRANS(    0x00EA    ,    0x00B4    ,    0x1EBF    ,0x0000    ),
DEADTRANS(    0x00EA    ,    0x0027    ,    0x1EBF    ,0x0000    ),
DEADTRANS(    0x00CA    ,    0x00B4    ,    0x1EBE    ,0x0000    ),
DEADTRANS(    0x00CA    ,    0x0027    ,    0x1EBE    ,0x0000    ),
DEADTRANS(    0x0065    ,    0x007E    ,    0x1EBD    ,0x0000    ),
DEADTRANS(    0x0045    ,    0x007E    ,    0x1EBC    ,0x0000    ),
DEADTRANS(    0x0065    ,    0x003F    ,    0x1EBB    ,0x0000    ),
DEADTRANS(    0x0045    ,    0x003F    ,    0x1EBA    ,0x0000    ),
DEADTRANS(    0x0065    ,    0x0021    ,    0x1EB9    ,0x0000    ),
DEADTRANS(    0x0045    ,    0x0021    ,    0x1EB8    ,0x0000    ),
DEADTRANS(    0x01E3    ,    0x007E    ,    0x1EB5    ,0x0000    ),
DEADTRANS(    0x01C3    ,    0x007E    ,    0x1EB4    ,0x0000    ),
DEADTRANS(    0x01E3    ,    0x003F    ,    0x1EB3    ,0x0000    ),
DEADTRANS(    0x01C3    ,    0x003F    ,    0x1EB2    ,0x0000    ),
DEADTRANS(    0x01E3    ,    0x0060    ,    0x1EB1    ,0x0000    ),
DEADTRANS(    0x01C3    ,    0x0060    ,    0x1EB0    ,0x0000    ),
DEADTRANS(    0x01E3    ,    0x00B4    ,    0x1EAF    ,0x0000    ),
DEADTRANS(    0x01E3    ,    0x0027    ,    0x1EAF    ,0x0000    ),
DEADTRANS(    0x01C3    ,    0x00B4    ,    0x1EAE    ,0x0000    ),
DEADTRANS(    0x01C3    ,    0x0027    ,    0x1EAE    ,0x0000    ),
DEADTRANS(    0x00E2    ,    0x007E    ,    0x1EAB    ,0x0000    ),
DEADTRANS(    0x00C2    ,    0x007E    ,    0x1EAA    ,0x0000    ),
DEADTRANS(    0x00E2    ,    0x003F    ,    0x1EA9    ,0x0000    ),
DEADTRANS(    0x00C2    ,    0x003F    ,    0x1EA8    ,0x0000    ),
DEADTRANS(    0x00E2    ,    0x0060    ,    0x1EA7    ,0x0000    ),
DEADTRANS(    0x00C2    ,    0x0060    ,    0x1EA6    ,0x0000    ),
DEADTRANS(    0x00E2    ,    0x00B4    ,    0x1EA5    ,0x0000    ),
DEADTRANS(    0x00E2    ,    0x0027    ,    0x1EA5    ,0x0000    ),
DEADTRANS(    0x00C2    ,    0x00B4    ,    0x1EA4    ,0x0000    ),
DEADTRANS(    0x00C2    ,    0x0027    ,    0x1EA4    ,0x0000    ),
DEADTRANS(    0x0061    ,    0x003F    ,    0x1EA3    ,0x0000    ),
DEADTRANS(    0x0041    ,    0x003F    ,    0x1EA2    ,0x0000    ),
DEADTRANS(    0x0061    ,    0x0021    ,    0x1EA1    ,0x0000    ),
DEADTRANS(    0x0041    ,    0x0021    ,    0x1EA0    ,0x0000    ),
DEADTRANS(    0x0079    ,    0x006F    ,    0x1E99    ,0x0000    ),
DEADTRANS(    0x0077    ,    0x006F    ,    0x1E98    ,0x0000    ),
DEADTRANS(    0x0074    ,    0x0022    ,    0x1E97    ,0x0000    ),
DEADTRANS(    0x007A    ,    0x0021    ,    0x1E93    ,0x0000    ),
DEADTRANS(    0x005A    ,    0x0021    ,    0x1E92    ,0x0000    ),
DEADTRANS(    0x007A    ,    0x005E    ,    0x1E91    ,0x0000    ),
DEADTRANS(    0x005A    ,    0x005E    ,    0x1E90    ,0x0000    ),
DEADTRANS(    0x0079    ,    0x002E    ,    0x1E8F    ,0x0000    ),
DEADTRANS(    0x0059    ,    0x002E    ,    0x1E8E    ,0x0000    ),
DEADTRANS(    0x0078    ,    0x0022    ,    0x1E8D    ,0x0000    ),
DEADTRANS(    0x0058    ,    0x0022    ,    0x1E8C    ,0x0000    ),
DEADTRANS(    0x0078    ,    0x002E    ,    0x1E8B    ,0x0000    ),
DEADTRANS(    0x0058    ,    0x002E    ,    0x1E8A    ,0x0000    ),
DEADTRANS(    0x0077    ,    0x0021    ,    0x1E89    ,0x0000    ),
DEADTRANS(    0x0057    ,    0x0021    ,    0x1E88    ,0x0000    ),
DEADTRANS(    0x0077    ,    0x002E    ,    0x1E87    ,0x0000    ),
DEADTRANS(    0x0057    ,    0x002E    ,    0x1E86    ,0x0000    ),
DEADTRANS(    0x0077    ,    0x0022    ,    0x1E85    ,0x0000    ),
DEADTRANS(    0x0057    ,    0x0022    ,    0x1E84    ,0x0000    ),
DEADTRANS(    0x0077    ,    0x00B4    ,    0x1E83    ,0x0000    ),
DEADTRANS(    0x0077    ,    0x0027    ,    0x1E83    ,0x0000    ),
DEADTRANS(    0x0057    ,    0x00B4    ,    0x1E82    ,0x0000    ),
DEADTRANS(    0x0057    ,    0x0027    ,    0x1E82    ,0x0000    ),
DEADTRANS(    0x0077    ,    0x0060    ,    0x1E81    ,0x0000    ),
DEADTRANS(    0x0057    ,    0x0060    ,    0x1E80    ,0x0000    ),
DEADTRANS(    0x0076    ,    0x0021    ,    0x1E7F    ,0x0000    ),
DEADTRANS(    0x0056    ,    0x0021    ,    0x1E7E    ,0x0000    ),
DEADTRANS(    0x0076    ,    0x007E    ,    0x1E7D    ,0x0000    ),
DEADTRANS(    0x0056    ,    0x007E    ,    0x1E7C    ,0x0000    ),
DEADTRANS(    0x03FE    ,    0x0022    ,    0x1E7B    ,0x0000    ),
DEADTRANS(    0x03DE    ,    0x0022    ,    0x1E7A    ,0x0000    ),
DEADTRANS(    0x03FD    ,    0x00B4    ,    0x1E79    ,0x0000    ),
DEADTRANS(    0x03FD    ,    0x0027    ,    0x1E79    ,0x0000    ),
DEADTRANS(    0x03DD    ,    0x00B4    ,    0x1E78    ,0x0000    ),
DEADTRANS(    0x03DD    ,    0x0027    ,    0x1E78    ,0x0000    ),
DEADTRANS(    0x0074    ,    0x0021    ,    0x1E6D    ,0x0000    ),
DEADTRANS(    0x0054    ,    0x0021    ,    0x1E6C    ,0x0000    ),
DEADTRANS(    0x0074    ,    0x002E    ,    0x1E6B    ,0x0000    ),
DEADTRANS(    0x0054    ,    0x002E    ,    0x1E6A    ,0x0000    ),
DEADTRANS(    0x01B9    ,    0x002E    ,    0x1E67    ,0x0000    ),
DEADTRANS(    0x01A9    ,    0x002E    ,    0x1E66    ,0x0000    ),
DEADTRANS(    0x01B6    ,    0x002E    ,    0x1E65    ,0x0000    ),
DEADTRANS(    0x01A6    ,    0x002E    ,    0x1E64    ,0x0000    ),
DEADTRANS(    0x0073    ,    0x0021    ,    0x1E63    ,0x0000    ),
DEADTRANS(    0x0053    ,    0x0021    ,    0x1E62    ,0x0000    ),
DEADTRANS(    0x0073    ,    0x002E    ,    0x1E61    ,0x0000    ),
DEADTRANS(    0x0053    ,    0x002E    ,    0x1E60    ,0x0000    ),
DEADTRANS(    0x0072    ,    0x0021    ,    0x1E5B    ,0x0000    ),
DEADTRANS(    0x0052    ,    0x0021    ,    0x1E5A    ,0x0000    ),
DEADTRANS(    0x0072    ,    0x002E    ,    0x1E59    ,0x0000    ),
DEADTRANS(    0x0052    ,    0x002E    ,    0x1E58    ,0x0000    ),
DEADTRANS(    0x0070    ,    0x002E    ,    0x1E57    ,0x0000    ),
DEADTRANS(    0x0050    ,    0x002E    ,    0x1E56    ,0x0000    ),
DEADTRANS(    0x0070    ,    0x00B4    ,    0x1E55    ,0x0000    ),
DEADTRANS(    0x0070    ,    0x0027    ,    0x1E55    ,0x0000    ),
DEADTRANS(    0x0050    ,    0x00B4    ,    0x1E54    ,0x0000    ),
DEADTRANS(    0x0050    ,    0x0027    ,    0x1E54    ,0x0000    ),
DEADTRANS(    0x03F2    ,    0x00B4    ,    0x1E53    ,0x0000    ),
DEADTRANS(    0x03F2    ,    0x0027    ,    0x1E53    ,0x0000    ),
DEADTRANS(    0x03D2    ,    0x00B4    ,    0x1E52    ,0x0000    ),
DEADTRANS(    0x03D2    ,    0x0027    ,    0x1E52    ,0x0000    ),
DEADTRANS(    0x03F2    ,    0x0060    ,    0x1E51    ,0x0000    ),
DEADTRANS(    0x03D2    ,    0x0060    ,    0x1E50    ,0x0000    ),
DEADTRANS(    0x00F5    ,    0x0022    ,    0x1E4F    ,0x0000    ),
DEADTRANS(    0x00D5    ,    0x0022    ,    0x1E4E    ,0x0000    ),
DEADTRANS(    0x00F5    ,    0x00B4    ,    0x1E4D    ,0x0000    ),
DEADTRANS(    0x00F5    ,    0x0027    ,    0x1E4D    ,0x0000    ),
DEADTRANS(    0x00D5    ,    0x00B4    ,    0x1E4C    ,0x0000    ),
DEADTRANS(    0x00D5    ,    0x0027    ,    0x1E4C    ,0x0000    ),
DEADTRANS(    0x006E    ,    0x0021    ,    0x1E47    ,0x0000    ),
DEADTRANS(    0x004E    ,    0x0021    ,    0x1E46    ,0x0000    ),
DEADTRANS(    0x006E    ,    0x002E    ,    0x1E45    ,0x0000    ),
DEADTRANS(    0x004E    ,    0x002E    ,    0x1E44    ,0x0000    ),
DEADTRANS(    0x006D    ,    0x0021    ,    0x1E43    ,0x0000    ),
DEADTRANS(    0x004D    ,    0x0021    ,    0x1E42    ,0x0000    ),
DEADTRANS(    0x006D    ,    0x002E    ,    0x1E41    ,0x0000    ),
DEADTRANS(    0x004D    ,    0x002E    ,    0x1E40    ,0x0000    ),
DEADTRANS(    0x006D    ,    0x00B4    ,    0x1E3F    ,0x0000    ),
DEADTRANS(    0x006D    ,    0x0027    ,    0x1E3F    ,0x0000    ),
DEADTRANS(    0x004D    ,    0x00B4    ,    0x1E3E    ,0x0000    ),
DEADTRANS(    0x004D    ,    0x0027    ,    0x1E3E    ,0x0000    ),
DEADTRANS(    0x006C    ,    0x0021    ,    0x1E37    ,0x0000    ),
DEADTRANS(    0x004C    ,    0x0021    ,    0x1E36    ,0x0000    ),
DEADTRANS(    0x006B    ,    0x0021    ,    0x1E33    ,0x0000    ),
DEADTRANS(    0x004B    ,    0x0021    ,    0x1E32    ,0x0000    ),
DEADTRANS(    0x006B    ,    0x00B4    ,    0x1E31    ,0x0000    ),
DEADTRANS(    0x006B    ,    0x0027    ,    0x1E31    ,0x0000    ),
DEADTRANS(    0x004B    ,    0x00B4    ,    0x1E30    ,0x0000    ),
DEADTRANS(    0x004B    ,    0x0027    ,    0x1E30    ,0x0000    ),
DEADTRANS(    0x00EF    ,    0x00B4    ,    0x1E2F    ,0x0000    ),
DEADTRANS(    0x00EF    ,    0x0027    ,    0x1E2F    ,0x0000    ),
DEADTRANS(    0x00CF    ,    0x00B4    ,    0x1E2E    ,0x0000    ),
DEADTRANS(    0x00CF    ,    0x0027    ,    0x1E2E    ,0x0000    ),
DEADTRANS(    0x0068    ,    0x002C    ,    0x1E29    ,0x0000    ),
DEADTRANS(    0x0048    ,    0x002C    ,    0x1E28    ,0x0000    ),
DEADTRANS(    0x0068    ,    0x0022    ,    0x1E27    ,0x0000    ),
DEADTRANS(    0x0048    ,    0x0022    ,    0x1E26    ,0x0000    ),
DEADTRANS(    0x0068    ,    0x0021    ,    0x1E25    ,0x0000    ),
DEADTRANS(    0x0048    ,    0x0021    ,    0x1E24    ,0x0000    ),
DEADTRANS(    0x0068    ,    0x002E    ,    0x1E23    ,0x0000    ),
DEADTRANS(    0x0048    ,    0x002E    ,    0x1E22    ,0x0000    ),
DEADTRANS(    0x0067    ,    0x00AF    ,    0x1E21    ,0x0000    ),
DEADTRANS(    0x0067    ,    0x005F    ,    0x1E21    ,0x0000    ),
DEADTRANS(    0x0047    ,    0x00AF    ,    0x1E20    ,0x0000    ),
DEADTRANS(    0x0047    ,    0x005F    ,    0x1E20    ,0x0000    ),
DEADTRANS(    0x0066    ,    0x002E    ,    0x1E1F    ,0x0000    ),
DEADTRANS(    0x0046    ,    0x002E    ,    0x1E1E    ,0x0000    ),
DEADTRANS(    0x03BA    ,    0x00B4    ,    0x1E17    ,0x0000    ),
DEADTRANS(    0x03BA    ,    0x0027    ,    0x1E17    ,0x0000    ),
DEADTRANS(    0x03AA    ,    0x00B4    ,    0x1E16    ,0x0000    ),
DEADTRANS(    0x03AA    ,    0x0027    ,    0x1E16    ,0x0000    ),
DEADTRANS(    0x03BA    ,    0x0060    ,    0x1E15    ,0x0000    ),
DEADTRANS(    0x03AA    ,    0x0060    ,    0x1E14    ,0x0000    ),
DEADTRANS(    0x0064    ,    0x002C    ,    0x1E11    ,0x0000    ),
DEADTRANS(    0x0044    ,    0x002C    ,    0x1E10    ,0x0000    ),
DEADTRANS(    0x0064    ,    0x0021    ,    0x1E0D    ,0x0000    ),
DEADTRANS(    0x0044    ,    0x0021    ,    0x1E0C    ,0x0000    ),
DEADTRANS(    0x0064    ,    0x002E    ,    0x1E0B    ,0x0000    ),
DEADTRANS(    0x0044    ,    0x002E    ,    0x1E0A    ,0x0000    ),
DEADTRANS(    0x00E7    ,    0x00B4    ,    0x1E09    ,0x0000    ),
DEADTRANS(    0x00E7    ,    0x0027    ,    0x1E09    ,0x0000    ),
DEADTRANS(    0x00C7    ,    0x00B4    ,    0x1E08    ,0x0000    ),
DEADTRANS(    0x00C7    ,    0x0027    ,    0x1E08    ,0x0000    ),
DEADTRANS(    0x0062    ,    0x0021    ,    0x1E05    ,0x0000    ),
DEADTRANS(    0x0042    ,    0x0021    ,    0x1E04    ,0x0000    ),
DEADTRANS(    0x0062    ,    0x002E    ,    0x1E03    ,0x0000    ),
DEADTRANS(    0x0042    ,    0x002E    ,    0x1E02    ,0x0000    ),
DEADTRANS(    0x07E8    ,    0x005E    ,    0x1DBF    ,0x0000    ),
DEADTRANS(    0x07F7    ,    0x0BC6    ,    0x1D6A    ,0x0000    ),
DEADTRANS(    0x07F7    ,    0x005F    ,    0x1D6A    ,0x0000    ),
DEADTRANS(    0x07F6    ,    0x0BC6    ,    0x1D69    ,0x0000    ),
DEADTRANS(    0x07F6    ,    0x005F    ,    0x1D69    ,0x0000    ),
DEADTRANS(    0x07F1    ,    0x0BC6    ,    0x1D68    ,0x0000    ),
DEADTRANS(    0x07F1    ,    0x005F    ,    0x1D68    ,0x0000    ),
DEADTRANS(    0x07E3    ,    0x0BC6    ,    0x1D67    ,0x0000    ),
DEADTRANS(    0x07E3    ,    0x005F    ,    0x1D67    ,0x0000    ),
DEADTRANS(    0x07E2    ,    0x0BC6    ,    0x1D66    ,0x0000    ),
DEADTRANS(    0x07E2    ,    0x005F    ,    0x1D66    ,0x0000    ),
DEADTRANS(    0x07F7    ,    0x005E    ,    0x1D61    ,0x0000    ),
DEADTRANS(    0x07F6    ,    0x005E    ,    0x1D60    ,0x0000    ),
DEADTRANS(    0x07E4    ,    0x005E    ,    0x1D5F    ,0x0000    ),
DEADTRANS(    0x07E3    ,    0x005E    ,    0x1D5E    ,0x0000    ),
DEADTRANS(    0x07E2    ,    0x005E    ,    0x1D5D    ,0x0000    ),
DEADTRANS(    0x0039    ,    0x0061    ,    0x0669    ,0x0000    ),
DEADTRANS(    0x0038    ,    0x0061    ,    0x0668    ,0x0000    ),
DEADTRANS(    0x0037    ,    0x0061    ,    0x0667    ,0x0000    ),
DEADTRANS(    0x0036    ,    0x0061    ,    0x0666    ,0x0000    ),
DEADTRANS(    0x0035    ,    0x0061    ,    0x0665    ,0x0000    ),
DEADTRANS(    0x0034    ,    0x0061    ,    0x0664    ,0x0000    ),
DEADTRANS(    0x0033    ,    0x0061    ,    0x0663    ,0x0000    ),
DEADTRANS(    0x0032    ,    0x0061    ,    0x0662    ,0x0000    ),
DEADTRANS(    0x0031    ,    0x0061    ,    0x0661    ,0x0000    ),
DEADTRANS(    0x0030    ,    0x0061    ,    0x0660    ,0x0000    ),
DEADTRANS(    0x06D9    ,    0x0022    ,    0x04F9    ,0x0000    ),
DEADTRANS(    0x06F9    ,    0x0022    ,    0x04F8    ,0x0000    ),
DEADTRANS(    0x06DE    ,    0x0022    ,    0x04F5    ,0x0000    ),
DEADTRANS(    0x06FE    ,    0x0022    ,    0x04F4    ,0x0000    ),
DEADTRANS(    0x06D5    ,    0x003D    ,    0x04F3    ,0x0000    ),
DEADTRANS(    0x06F5    ,    0x003D    ,    0x04F2    ,0x0000    ),
DEADTRANS(    0x06D5    ,    0x0022    ,    0x04F1    ,0x0000    ),
DEADTRANS(    0x06F5    ,    0x0022    ,    0x04F0    ,0x0000    ),
DEADTRANS(    0x06D5    ,    0x00AF    ,    0x04EF    ,0x0000    ),
DEADTRANS(    0x06D5    ,    0x005F    ,    0x04EF    ,0x0000    ),
DEADTRANS(    0x06F5    ,    0x00AF    ,    0x04EE    ,0x0000    ),
DEADTRANS(    0x06F5    ,    0x005F    ,    0x04EE    ,0x0000    ),
DEADTRANS(    0x06DC    ,    0x0022    ,    0x04ED    ,0x0000    ),
DEADTRANS(    0x06FC    ,    0x0022    ,    0x04EC    ,0x0000    ),
DEADTRANS(    0x06CF    ,    0x0022    ,    0x04E7    ,0x0000    ),
DEADTRANS(    0x06EF    ,    0x0022    ,    0x04E6    ,0x0000    ),
DEADTRANS(    0x06C9    ,    0x0022    ,    0x04E5    ,0x0000    ),
DEADTRANS(    0x06E9    ,    0x0022    ,    0x04E4    ,0x0000    ),
DEADTRANS(    0x06C9    ,    0x00AF    ,    0x04E3    ,0x0000    ),
DEADTRANS(    0x06C9    ,    0x005F    ,    0x04E3    ,0x0000    ),
DEADTRANS(    0x06E9    ,    0x00AF    ,    0x04E2    ,0x0000    ),
DEADTRANS(    0x06E9    ,    0x005F    ,    0x04E2    ,0x0000    ),
DEADTRANS(    0x06DA    ,    0x0022    ,    0x04DF    ,0x0000    ),
DEADTRANS(    0x06FA    ,    0x0022    ,    0x04DE    ,0x0000    ),
DEADTRANS(    0x06D6    ,    0x0022    ,    0x04DD    ,0x0000    ),
DEADTRANS(    0x06F6    ,    0x0022    ,    0x04DC    ,0x0000    ),
DEADTRANS(    0x06C5    ,    0x0062    ,    0x04D7    ,0x0000    ),
DEADTRANS(    0x06C5    ,    0x0055    ,    0x04D7    ,0x0000    ),
DEADTRANS(    0x06E5    ,    0x0062    ,    0x04D6    ,0x0000    ),
DEADTRANS(    0x06E5    ,    0x0055    ,    0x04D6    ,0x0000    ),
DEADTRANS(    0x06C1    ,    0x0022    ,    0x04D3    ,0x0000    ),
DEADTRANS(    0x06E1    ,    0x0022    ,    0x04D2    ,0x0000    ),
DEADTRANS(    0x06C1    ,    0x0062    ,    0x04D1    ,0x0000    ),
DEADTRANS(    0x06C1    ,    0x0055    ,    0x04D1    ,0x0000    ),
DEADTRANS(    0x06E1    ,    0x0062    ,    0x04D0    ,0x0000    ),
DEADTRANS(    0x06E1    ,    0x0055    ,    0x04D0    ,0x0000    ),
DEADTRANS(    0x06D6    ,    0x0062    ,    0x04C2    ,0x0000    ),
DEADTRANS(    0x06D6    ,    0x0055    ,    0x04C2    ,0x0000    ),
DEADTRANS(    0x06F6    ,    0x0062    ,    0x04C1    ,0x0000    ),
DEADTRANS(    0x06F6    ,    0x0055    ,    0x04C1    ,0x0000    ),
DEADTRANS(    0x06CB    ,    L'/'    ,    0x049F    ,0x0000    ),
DEADTRANS(    0x06CB    ,    0x002F    ,    0x049F    ,0x0000    ),
DEADTRANS(    0x06EB    ,    L'/'    ,    0x049E    ,0x0000    ),
DEADTRANS(    0x06EB    ,    0x002F    ,    0x049E    ,0x0000    ),
DEADTRANS(    0x06C7    ,    L'/'    ,    0x0493    ,0x0000    ),
DEADTRANS(    0x06C7    ,    0x002F    ,    0x0493    ,0x0000    ),
DEADTRANS(    0x06E7    ,    L'/'    ,    0x0492    ,0x0000    ),
DEADTRANS(    0x06E7    ,    0x002F    ,    0x0492    ,0x0000    ),
DEADTRANS(    0x06D5    ,    0x0062    ,    0x045E    ,0x0000    ),
DEADTRANS(    0x06D5    ,    0x0055    ,    0x045E    ,0x0000    ),
DEADTRANS(    0x06C9    ,    0x0060    ,    0x045D    ,0x0000    ),
DEADTRANS(    0x06CB    ,    0x00B4    ,    0x045C    ,0x0000    ),
DEADTRANS(    0x06CB    ,    0x0027    ,    0x045C    ,0x0000    ),
DEADTRANS(    0x06A6    ,    0x0022    ,    0x0457    ,0x0000    ),
DEADTRANS(    0x06C7    ,    0x00B4    ,    0x0453    ,0x0000    ),
DEADTRANS(    0x06C7    ,    0x0027    ,    0x0453    ,0x0000    ),
DEADTRANS(    0x06C5    ,    0x0022    ,    0x0451    ,0x0000    ),
DEADTRANS(    0x06C5    ,    0x0060    ,    0x0450    ,0x0000    ),
DEADTRANS(    0x06C9    ,    0x0062    ,    0x0439    ,0x0000    ),
DEADTRANS(    0x06C9    ,    0x0055    ,    0x0439    ,0x0000    ),
DEADTRANS(    0x06E9    ,    0x0062    ,    0x0419    ,0x0000    ),
DEADTRANS(    0x06E9    ,    0x0055    ,    0x0419    ,0x0000    ),
DEADTRANS(    0x06F5    ,    0x0062    ,    0x040E    ,0x0000    ),
DEADTRANS(    0x06F5    ,    0x0055    ,    0x040E    ,0x0000    ),
DEADTRANS(    0x06E9    ,    0x0060    ,    0x040D    ,0x0000    ),
DEADTRANS(    0x06EB    ,    0x00B4    ,    0x040C    ,0x0000    ),
DEADTRANS(    0x06EB    ,    0x0027    ,    0x040C    ,0x0000    ),
DEADTRANS(    0x06B6    ,    0x0022    ,    0x0407    ,0x0000    ),
DEADTRANS(    0x06E7    ,    0x00B4    ,    0x0403    ,0x0000    ),
DEADTRANS(    0x06E7    ,    0x0027    ,    0x0403    ,0x0000    ),
DEADTRANS(    0x06E5    ,    0x0022    ,    0x0401    ,0x0000    ),
DEADTRANS(    0x06E5    ,    0x0060    ,    0x0400    ,0x0000    ),
DEADTRANS(    0x07F9    ,    0x00B4    ,    0x03CE    ,0x0000    ),
DEADTRANS(    0x07F9    ,    0x0027    ,    0x03CE    ,0x0000    ),
DEADTRANS(    0x07F5    ,    0x00B4    ,    0x03CD    ,0x0000    ),
DEADTRANS(    0x07F5    ,    0x0027    ,    0x03CD    ,0x0000    ),
DEADTRANS(    0x07EF    ,    0x00B4    ,    0x03CC    ,0x0000    ),
DEADTRANS(    0x07EF    ,    0x0027    ,    0x03CC    ,0x0000    ),
DEADTRANS(    0x07F5    ,    0x0022    ,    0x03CB    ,0x0000    ),
DEADTRANS(    0x07E9    ,    0x0022    ,    0x03CA    ,0x0000    ),
DEADTRANS(    0x07B9    ,    0x00B4    ,    0x03B0    ,0x0000    ),
DEADTRANS(    0x07B9    ,    0x0027    ,    0x03B0    ,0x0000    ),
DEADTRANS(    0x07E9    ,    0x00B4    ,    0x03AF    ,0x0000    ),
DEADTRANS(    0x07E9    ,    0x0027    ,    0x03AF    ,0x0000    ),
DEADTRANS(    0x07E7    ,    0x00B4    ,    0x03AE    ,0x0000    ),
DEADTRANS(    0x07E7    ,    0x0027    ,    0x03AE    ,0x0000    ),
DEADTRANS(    0x07E5    ,    0x00B4    ,    0x03AD    ,0x0000    ),
DEADTRANS(    0x07E5    ,    0x0027    ,    0x03AD    ,0x0000    ),
DEADTRANS(    0x07E1    ,    0x00B4    ,    0x03AC    ,0x0000    ),
DEADTRANS(    0x07E1    ,    0x0027    ,    0x03AC    ,0x0000    ),
DEADTRANS(    0x07D5    ,    0x0022    ,    0x03AB    ,0x0000    ),
DEADTRANS(    0x07C9    ,    0x0022    ,    0x03AA    ,0x0000    ),
DEADTRANS(    0x0058    ,    0x0047    ,    0x03A7    ,0x0000    ),
DEADTRANS(    0x0059    ,    0x0047    ,    0x03A5    ,0x0000    ),
DEADTRANS(    0x0054    ,    0x0047    ,    0x03A4    ,0x0000    ),
DEADTRANS(    0x0050    ,    0x0047    ,    0x03A1    ,0x0000    ),
DEADTRANS(    0x004F    ,    0x0047    ,    0x039F    ,0x0000    ),
DEADTRANS(    0x004E    ,    0x0047    ,    0x039D    ,0x0000    ),
DEADTRANS(    0x004D    ,    0x0047    ,    0x039C    ,0x0000    ),
DEADTRANS(    0x004B    ,    0x0047    ,    0x039A    ,0x0000    ),
DEADTRANS(    0x0049    ,    0x0047    ,    0x0399    ,0x0000    ),
DEADTRANS(    0x0048    ,    0x0047    ,    0x0397    ,0x0000    ),
DEADTRANS(    0x005A    ,    0x0047    ,    0x0396    ,0x0000    ),
DEADTRANS(    0x0045    ,    0x0047    ,    0x0395    ,0x0000    ),
DEADTRANS(    0x0042    ,    0x0047    ,    0x0392    ,0x0000    ),
DEADTRANS(    0x0041    ,    0x0047    ,    0x0391    ,0x0000    ),
DEADTRANS(    0x07B5    ,    0x00B4    ,    0x0390    ,0x0000    ),
DEADTRANS(    0x07B5    ,    0x0027    ,    0x0390    ,0x0000    ),
DEADTRANS(    0x07D9    ,    0x00B4    ,    0x038F    ,0x0000    ),
DEADTRANS(    0x07D9    ,    0x0027    ,    0x038F    ,0x0000    ),
DEADTRANS(    0x07D5    ,    0x00B4    ,    0x038E    ,0x0000    ),
DEADTRANS(    0x07D5    ,    0x0027    ,    0x038E    ,0x0000    ),
DEADTRANS(    0x07CF    ,    0x00B4    ,    0x038C    ,0x0000    ),
DEADTRANS(    0x07CF    ,    0x0027    ,    0x038C    ,0x0000    ),
DEADTRANS(    0x07C9    ,    0x00B4    ,    0x038A    ,0x0000    ),
DEADTRANS(    0x07C9    ,    0x0027    ,    0x038A    ,0x0000    ),
DEADTRANS(    0x07C7    ,    0x00B4    ,    0x0389    ,0x0000    ),
DEADTRANS(    0x07C7    ,    0x0027    ,    0x0389    ,0x0000    ),
DEADTRANS(    0x07C5    ,    0x00B4    ,    0x0388    ,0x0000    ),
DEADTRANS(    0x07C5    ,    0x0027    ,    0x0388    ,0x0000    ),
DEADTRANS(    0x07C1    ,    0x00B4    ,    0x0386    ,0x0000    ),
DEADTRANS(    0x07C1    ,    0x0027    ,    0x0386    ,0x0000    ),
DEADTRANS(    0x1EF3    ,    0x00A8    ,    0x0385    ,0x0000    ),
DEADTRANS(    0x00B4    ,    0x00A8    ,    0x0385    ,0x0000    ),
DEADTRANS(    0x0027    ,    0x00A8    ,    0x0385    ,0x0000    ),
DEADTRANS(    0x1EF3    ,    0x0022    ,    0x0344    ,0x0000    ),
DEADTRANS(    0x00B4    ,    0x0022    ,    0x0344    ,0x0000    ),
DEADTRANS(    0x0027    ,    0x0022    ,    0x0344    ,0x0000    ),
DEADTRANS(    0x0069    ,    L'/'    ,    0x0268    ,0x0000    ),
DEADTRANS(    0x0069    ,    0x002F    ,    0x0268    ,0x0000    ),
DEADTRANS(    0x0065    ,    0x0065    ,    0x0259    ,0x0000    ),
DEADTRANS(    0x0079    ,    0x00AF    ,    0x0233    ,0x0000    ),
DEADTRANS(    0x0079    ,    0x005F    ,    0x0233    ,0x0000    ),
DEADTRANS(    0x0059    ,    0x00AF    ,    0x0232    ,0x0000    ),
DEADTRANS(    0x0059    ,    0x005F    ,    0x0232    ,0x0000    ),
DEADTRANS(    0x006F    ,    0x002E    ,    0x022F    ,0x0000    ),
DEADTRANS(    0x004F    ,    0x002E    ,    0x022E    ,0x0000    ),
DEADTRANS(    0x00F5    ,    0x00AF    ,    0x022D    ,0x0000    ),
DEADTRANS(    0x00F5    ,    0x005F    ,    0x022D    ,0x0000    ),
DEADTRANS(    0x00D5    ,    0x00AF    ,    0x022C    ,0x0000    ),
DEADTRANS(    0x00D5    ,    0x005F    ,    0x022C    ,0x0000    ),
DEADTRANS(    0x00F6    ,    0x00AF    ,    0x022B    ,0x0000    ),
DEADTRANS(    0x00F6    ,    0x005F    ,    0x022B    ,0x0000    ),
DEADTRANS(    0x00D6    ,    0x00AF    ,    0x022A    ,0x0000    ),
DEADTRANS(    0x00D6    ,    0x005F    ,    0x022A    ,0x0000    ),
DEADTRANS(    0x0065    ,    0x002C    ,    0x0229    ,0x0000    ),
DEADTRANS(    0x0045    ,    0x002C    ,    0x0228    ,0x0000    ),
DEADTRANS(    0x0061    ,    0x002E    ,    0x0227    ,0x0000    ),
DEADTRANS(    0x0041    ,    0x002E    ,    0x0226    ,0x0000    ),
DEADTRANS(    0x0068    ,    0x0063    ,    0x021F    ,0x0000    ),
DEADTRANS(    0x0048    ,    0x0063    ,    0x021E    ,0x0000    ),
DEADTRANS(    0x00F8    ,    0x00B4    ,    0x01FF    ,0x0000    ),
DEADTRANS(    0x00F8    ,    0x0027    ,    0x01FF    ,0x0000    ),
DEADTRANS(    0x00D8    ,    0x00B4    ,    0x01FE    ,0x0000    ),
DEADTRANS(    0x00D8    ,    0x0027    ,    0x01FE    ,0x0000    ),
DEADTRANS(    0x00E6    ,    0x00B4    ,    0x01FD    ,0x0000    ),
DEADTRANS(    0x00E6    ,    0x0027    ,    0x01FD    ,0x0000    ),
DEADTRANS(    0x00C6    ,    0x00B4    ,    0x01FC    ,0x0000    ),
DEADTRANS(    0x00C6    ,    0x0027    ,    0x01FC    ,0x0000    ),
DEADTRANS(    0x00E5    ,    0x00B4    ,    0x01FB    ,0x0000    ),
DEADTRANS(    0x00E5    ,    0x0027    ,    0x01FB    ,0x0000    ),
DEADTRANS(    0x00C5    ,    0x00B4    ,    0x01FA    ,0x0000    ),
DEADTRANS(    0x00C5    ,    0x0027    ,    0x01FA    ,0x0000    ),
DEADTRANS(    0x006E    ,    0x0060    ,    0x01F9    ,0x0000    ),
DEADTRANS(    0x004E    ,    0x0060    ,    0x01F8    ,0x0000    ),
DEADTRANS(    0x0067    ,    0x00B4    ,    0x01F5    ,0x0000    ),
DEADTRANS(    0x0067    ,    0x0027    ,    0x01F5    ,0x0000    ),
DEADTRANS(    0x0047    ,    0x00B4    ,    0x01F4    ,0x0000    ),
DEADTRANS(    0x0047    ,    0x0027    ,    0x01F4    ,0x0000    ),
DEADTRANS(    0x006A    ,    0x0063    ,    0x01F0    ,0x0000    ),
DEADTRANS(    0x006F    ,    0x003B    ,    0x01EB    ,0x0000    ),
DEADTRANS(    0x004F    ,    0x003B    ,    0x01EA    ,0x0000    ),
DEADTRANS(    0x006B    ,    0x0063    ,    0x01E9    ,0x0000    ),
DEADTRANS(    0x004B    ,    0x0063    ,    0x01E8    ,0x0000    ),
DEADTRANS(    0x0067    ,    0x0063    ,    0x01E7    ,0x0000    ),
DEADTRANS(    0x0047    ,    0x0063    ,    0x01E6    ,0x0000    ),
DEADTRANS(    0x0067    ,    L'/'    ,    0x01E5    ,0x0000    ),
DEADTRANS(    0x0067    ,    0x002F    ,    0x01E5    ,0x0000    ),
DEADTRANS(    0x0047    ,    L'/'    ,    0x01E4    ,0x0000    ),
DEADTRANS(    0x0047    ,    0x002F    ,    0x01E4    ,0x0000    ),
DEADTRANS(    0x00E6    ,    0x00AF    ,    0x01E3    ,0x0000    ),
DEADTRANS(    0x00E6    ,    0x005F    ,    0x01E3    ,0x0000    ),
DEADTRANS(    0x00C6    ,    0x00AF    ,    0x01E2    ,0x0000    ),
DEADTRANS(    0x00C6    ,    0x005F    ,    0x01E2    ,0x0000    ),
DEADTRANS(    0x00E4    ,    0x00AF    ,    0x01DF    ,0x0000    ),
DEADTRANS(    0x00E4    ,    0x005F    ,    0x01DF    ,0x0000    ),
DEADTRANS(    0x00C4    ,    0x00AF    ,    0x01DE    ,0x0000    ),
DEADTRANS(    0x00C4    ,    0x005F    ,    0x01DE    ,0x0000    ),
DEADTRANS(    0x00FC    ,    0x0060    ,    0x01DC    ,0x0000    ),
DEADTRANS(    0x00FC    ,    0x0063    ,    0x01DA    ,0x0000    ),
DEADTRANS(    0x00FC    ,    0x00B4    ,    0x01D8    ,0x0000    ),
DEADTRANS(    0x00FC    ,    0x0027    ,    0x01D8    ,0x0000    ),
DEADTRANS(    0x00FC    ,    0x00AF    ,    0x01D6    ,0x0000    ),
DEADTRANS(    0x00FC    ,    0x005F    ,    0x01D6    ,0x0000    ),
DEADTRANS(    0x0075    ,    0x0063    ,    0x01D4    ,0x0000    ),
DEADTRANS(    0x0055    ,    0x0063    ,    0x01D3    ,0x0000    ),
DEADTRANS(    0x006F    ,    0x0063    ,    0x01D2    ,0x0000    ),
DEADTRANS(    0x004F    ,    0x0063    ,    0x01D1    ,0x0000    ),
DEADTRANS(    0x0069    ,    0x0063    ,    0x01D0    ,0x0000    ),
DEADTRANS(    0x0049    ,    0x0063    ,    0x01CF    ,0x0000    ),
DEADTRANS(    0x0061    ,    0x0063    ,    0x01CE    ,0x0000    ),
DEADTRANS(    0x0041    ,    0x0063    ,    0x01CD    ,0x0000    ),
DEADTRANS(    0x006A    ,    0x006E    ,    0x01CC    ,0x0000    ),
DEADTRANS(    0x006A    ,    0x004E    ,    0x01CB    ,0x0000    ),
DEADTRANS(    0x004A    ,    0x004E    ,    0x01CA    ,0x0000    ),
DEADTRANS(    0x006A    ,    0x006C    ,    0x01C9    ,0x0000    ),
DEADTRANS(    0x006A    ,    0x004C    ,    0x01C8    ,0x0000    ),
DEADTRANS(    0x004A    ,    0x004C    ,    0x01C7    ,0x0000    ),
DEADTRANS(    0x007A    ,    0x0064    ,    0x01C6    ,0x0000    ),
DEADTRANS(    0x007A    ,    0x0044    ,    0x01C5    ,0x0000    ),
DEADTRANS(    0x005A    ,    0x0044    ,    0x01C4    ,0x0000    ),
DEADTRANS(    0x007A    ,    L'/'    ,    0x01B6    ,0x0000    ),
DEADTRANS(    0x007A    ,    0x002F    ,    0x01B6    ,0x0000    ),
DEADTRANS(    0x005A    ,    L'/'    ,    0x01B5    ,0x0000    ),
DEADTRANS(    0x005A    ,    0x002F    ,    0x01B5    ,0x0000    ),
DEADTRANS(    0x0075    ,    0x002B    ,    0x01B0    ,0x0000    ),
DEADTRANS(    0x0055    ,    0x002B    ,    0x01AF    ,0x0000    ),
DEADTRANS(    0x006F    ,    0x002B    ,    0x01A1    ,0x0000    ),
DEADTRANS(    0x004F    ,    0x002B    ,    0x01A0    ,0x0000    ),
DEADTRANS(    0x0049    ,    L'/'    ,    0x0197    ,0x0000    ),
DEADTRANS(    0x0049    ,    0x002F    ,    0x0197    ,0x0000    ),
DEADTRANS(    0x0045    ,    0x0045    ,    0x018F    ,0x0000    ),
DEADTRANS(    0x0062    ,    L'/'    ,    0x0180    ,0x0000    ),
DEADTRANS(    0x0062    ,    0x002F    ,    0x0180    ,0x0000    ),
DEADTRANS(    0x0073    ,    0x0066    ,    0x017f    ,0x0000    ),
DEADTRANS(    0x0053    ,    0x0066    ,    0x017f    ,0x0000    ),
DEADTRANS(    0x007A    ,    0x0063    ,    0x017E    ,0x0000    ),
DEADTRANS(    0x005A    ,    0x0063    ,    0x017D    ,0x0000    ),
DEADTRANS(    0x007A    ,    0x002E    ,    0x017C    ,0x0000    ),
DEADTRANS(    0x005A    ,    0x002E    ,    0x017B    ,0x0000    ),
DEADTRANS(    0x007A    ,    0x00B4    ,    0x017A    ,0x0000    ),
DEADTRANS(    0x007A    ,    0x0027    ,    0x017A    ,0x0000    ),
DEADTRANS(    0x005A    ,    0x00B4    ,    0x0179    ,0x0000    ),
DEADTRANS(    0x005A    ,    0x0027    ,    0x0179    ,0x0000    ),
DEADTRANS(    0x0059    ,    0x0022    ,    0x0178    ,0x0000    ),
DEADTRANS(    0x0079    ,    0x005E    ,    0x0177    ,0x0000    ),
DEADTRANS(    0x0059    ,    0x005E    ,    0x0176    ,0x0000    ),
DEADTRANS(    0x0077    ,    0x005E    ,    0x0175    ,0x0000    ),
DEADTRANS(    0x0057    ,    0x005E    ,    0x0174    ,0x0000    ),
DEADTRANS(    0x0075    ,    0x003B    ,    0x0173    ,0x0000    ),
DEADTRANS(    0x0055    ,    0x003B    ,    0x0172    ,0x0000    ),
DEADTRANS(    0x0075    ,    0x003D    ,    0x0171    ,0x0000    ),
DEADTRANS(    0x0055    ,    0x003D    ,    0x0170    ,0x0000    ),
DEADTRANS(    0x0075    ,    0x006F    ,    0x016F    ,0x0000    ),
DEADTRANS(    0x0055    ,    0x006F    ,    0x016E    ,0x0000    ),
DEADTRANS(    0x0075    ,    0x0075    ,    0x016D    ,0x0000    ),
DEADTRANS(    0x0075    ,    0x0062    ,    0x016D    ,0x0000    ),
DEADTRANS(    0x0075    ,    0x0055    ,    0x016D    ,0x0000    ),
DEADTRANS(    0x0055    ,    0x0062    ,    0x016C    ,0x0000    ),
DEADTRANS(    0x0055    ,    0x0055    ,    0x016C    ,0x0000    ),
DEADTRANS(    0x0075    ,    0x00AF    ,    0x016B    ,0x0000    ),
DEADTRANS(    0x0075    ,    0x005F    ,    0x016B    ,0x0000    ),
DEADTRANS(    0x0055    ,    0x00AF    ,    0x016A    ,0x0000    ),
DEADTRANS(    0x0055    ,    0x005F    ,    0x016A    ,0x0000    ),
DEADTRANS(    0x0075    ,    0x007E    ,    0x0169    ,0x0000    ),
DEADTRANS(    0x0055    ,    0x007E    ,    0x0168    ,0x0000    ),
DEADTRANS(    0x0074    ,    L'/'    ,    0x0167    ,0x0000    ),
DEADTRANS(    0x0074    ,    0x002F    ,    0x0167    ,0x0000    ),
DEADTRANS(    0x0054    ,    L'/'    ,    0x0166    ,0x0000    ),
DEADTRANS(    0x0054    ,    0x002F    ,    0x0166    ,0x0000    ),
DEADTRANS(    0x0074    ,    0x0063    ,    0x0165    ,0x0000    ),
DEADTRANS(    0x0054    ,    0x0063    ,    0x0164    ,0x0000    ),
DEADTRANS(    0x0074    ,    0x002C    ,    0x0163    ,0x0000    ),
DEADTRANS(    0x0054    ,    0x002C    ,    0x0162    ,0x0000    ),
DEADTRANS(    0x0073    ,    0x0063    ,    0x0161    ,0x0000    ),
DEADTRANS(    0x0053    ,    0x0063    ,    0x0160    ,0x0000    ),
DEADTRANS(    0x0073    ,    0x002C    ,    0x015F    ,0x0000    ),
DEADTRANS(    0x0053    ,    0x002C    ,    0x015E    ,0x0000    ),
DEADTRANS(    0x0073    ,    0x005E    ,    0x015D    ,0x0000    ),
DEADTRANS(    0x0053    ,    0x005E    ,    0x015C    ,0x0000    ),
DEADTRANS(    0x0073    ,    0x00B4    ,    0x015B    ,0x0000    ),
DEADTRANS(    0x0073    ,    0x0027    ,    0x015B    ,0x0000    ),
DEADTRANS(    0x0053    ,    0x00B4    ,    0x015A    ,0x0000    ),
DEADTRANS(    0x0053    ,    0x0027    ,    0x015A    ,0x0000    ),
DEADTRANS(    0x0072    ,    0x0063    ,    0x0159    ,0x0000    ),
DEADTRANS(    0x0052    ,    0x0063    ,    0x0158    ,0x0000    ),
DEADTRANS(    0x0072    ,    0x002C    ,    0x0157    ,0x0000    ),
DEADTRANS(    0x0052    ,    0x002C    ,    0x0156    ,0x0000    ),
DEADTRANS(    0x0072    ,    0x00B4    ,    0x0155    ,0x0000    ),
DEADTRANS(    0x0072    ,    0x0027    ,    0x0155    ,0x0000    ),
DEADTRANS(    0x0052    ,    0x00B4    ,    0x0154    ,0x0000    ),
DEADTRANS(    0x0052    ,    0x0027    ,    0x0154    ,0x0000    ),
DEADTRANS(    0x006F    ,    0x003D    ,    0x0151    ,0x0000    ),
DEADTRANS(    0x004F    ,    0x003D    ,    0x0150    ,0x0000    ),
DEADTRANS(    0x006F    ,    0x0062    ,    0x014F    ,0x0000    ),
DEADTRANS(    0x006F    ,    0x0055    ,    0x014F    ,0x0000    ),
DEADTRANS(    0x004F    ,    0x0062    ,    0x014E    ,0x0000    ),
DEADTRANS(    0x004F    ,    0x0055    ,    0x014E    ,0x0000    ),
DEADTRANS(    0x006F    ,    0x00AF    ,    0x014D    ,0x0000    ),
DEADTRANS(    0x006F    ,    0x005F    ,    0x014D    ,0x0000    ),
DEADTRANS(    0x004F    ,    0x00AF    ,    0x014C    ,0x0000    ),
DEADTRANS(    0x004F    ,    0x005F    ,    0x014C    ,0x0000    ),
DEADTRANS(    0x0067    ,    0x006E    ,    0x014B    ,0x0000    ),
DEADTRANS(    0x0047    ,    0x004E    ,    0x014A    ,0x0000    ),
DEADTRANS(    0x006E    ,    0x0063    ,    0x0148    ,0x0000    ),
DEADTRANS(    0x004E    ,    0x0063    ,    0x0147    ,0x0000    ),
DEADTRANS(    0x006E    ,    0x002C    ,    0x0146    ,0x0000    ),
DEADTRANS(    0x004E    ,    0x002C    ,    0x0145    ,0x0000    ),
DEADTRANS(    0x006E    ,    0x00B4    ,    0x0144    ,0x0000    ),
DEADTRANS(    0x006E    ,    0x0027    ,    0x0144    ,0x0000    ),
DEADTRANS(    0x004E    ,    0x00B4    ,    0x0143    ,0x0000    ),
DEADTRANS(    0x004E    ,    0x0027    ,    0x0143    ,0x0000    ),
DEADTRANS(    0x006C    ,    L'/'    ,    0x0142    ,0x0000    ),
DEADTRANS(    0x006C    ,    0x002F    ,    0x0142    ,0x0000    ),
DEADTRANS(    0x004C    ,    L'/'    ,    0x0141    ,0x0000    ),
DEADTRANS(    0x004C    ,    0x002F    ,    0x0141    ,0x0000    ),
DEADTRANS(    0x006C    ,    0x0063    ,    0x013E    ,0x0000    ),
DEADTRANS(    0x004C    ,    0x0063    ,    0x013D    ,0x0000    ),
DEADTRANS(    0x006C    ,    0x002C    ,    0x013C    ,0x0000    ),
DEADTRANS(    0x004C    ,    0x002C    ,    0x013B    ,0x0000    ),
DEADTRANS(    0x006C    ,    0x00B4    ,    0x013A    ,0x0000    ),
DEADTRANS(    0x006C    ,    0x0027    ,    0x013A    ,0x0000    ),
DEADTRANS(    0x004C    ,    0x00B4    ,    0x0139    ,0x0000    ),
DEADTRANS(    0x004C    ,    0x0027    ,    0x0139    ,0x0000    ),
DEADTRANS(    0x006B    ,    0x006B    ,    0x0138    ,0x0000    ),
DEADTRANS(    0x006B    ,    0x002C    ,    0x0137    ,0x0000    ),
DEADTRANS(    0x004B    ,    0x002C    ,    0x0136    ,0x0000    ),
DEADTRANS(    0x006A    ,    0x005E    ,    0x0135    ,0x0000    ),
DEADTRANS(    0x004A    ,    0x005E    ,    0x0134    ,0x0000    ),
DEADTRANS(    0x006A    ,    0x0069    ,    0x0133    ,0x0000    ),
DEADTRANS(    0x004A    ,    0x0049    ,    0x0133    ,0x0000    ),
DEADTRANS(    0x002E    ,    0x0069    ,    0x0131    ,0x0000    ),
DEADTRANS(    0x0049    ,    0x002E    ,    0x0130    ,0x0000    ),
DEADTRANS(    0x0069    ,    0x003B    ,    0x012F    ,0x0000    ),
DEADTRANS(    0x0049    ,    0x003B    ,    0x012E    ,0x0000    ),
DEADTRANS(    0x0069    ,    0x0062    ,    0x012D    ,0x0000    ),
DEADTRANS(    0x0069    ,    0x0055    ,    0x012D    ,0x0000    ),
DEADTRANS(    0x0049    ,    0x0062    ,    0x012C    ,0x0000    ),
DEADTRANS(    0x0049    ,    0x0055    ,    0x012C    ,0x0000    ),
DEADTRANS(    0x0069    ,    0x00AF    ,    0x012B    ,0x0000    ),
DEADTRANS(    0x0069    ,    0x005F    ,    0x012B    ,0x0000    ),
DEADTRANS(    0x0049    ,    0x00AF    ,    0x012A    ,0x0000    ),
DEADTRANS(    0x0049    ,    0x005F    ,    0x012A    ,0x0000    ),
DEADTRANS(    0x0069    ,    0x007E    ,    0x0129    ,0x0000    ),
DEADTRANS(    0x0049    ,    0x007E    ,    0x0128    ,0x0000    ),
DEADTRANS(    0x0068    ,    L'/'    ,    0x0127    ,0x0000    ),
DEADTRANS(    0x0068    ,    0x002F    ,    0x0127    ,0x0000    ),
DEADTRANS(    0x0068    ,    0x002D    ,    0x0127    ,0x0000    ),
DEADTRANS(    0x0048    ,    L'/'    ,    0x0126    ,0x0000    ),
DEADTRANS(    0x0048    ,    0x002F    ,    0x0126    ,0x0000    ),
DEADTRANS(    0x0048    ,    0x002D    ,    0x0126    ,0x0000    ),
DEADTRANS(    0x0068    ,    0x005E    ,    0x0125    ,0x0000    ),
DEADTRANS(    0x0048    ,    0x005E    ,    0x0124    ,0x0000    ),
DEADTRANS(    0x0067    ,    0x002C    ,    0x0123    ,0x0000    ),
DEADTRANS(    0x0047    ,    0x002C    ,    0x0122    ,0x0000    ),
DEADTRANS(    0x0067    ,    0x002E    ,    0x0121    ,0x0000    ),
DEADTRANS(    0x0047    ,    0x002E    ,    0x0120    ,0x0000    ),
DEADTRANS(    0x0067    ,    0x0062    ,    0x011F    ,0x0000    ),
DEADTRANS(    0x0067    ,    0x0055    ,    0x011F    ,0x0000    ),
DEADTRANS(    0x0047    ,    0x0062    ,    0x011E    ,0x0000    ),
DEADTRANS(    0x0047    ,    0x0055    ,    0x011E    ,0x0000    ),
DEADTRANS(    0x0067    ,    0x005E    ,    0x011D    ,0x0000    ),
DEADTRANS(    0x0047    ,    0x005E    ,    0x011C    ,0x0000    ),
DEADTRANS(    0x0065    ,    0x0063    ,    0x011B    ,0x0000    ),
DEADTRANS(    0x0045    ,    0x0063    ,    0x011A    ,0x0000    ),
DEADTRANS(    0x0065    ,    0x003B    ,    0x0119    ,0x0000    ),
DEADTRANS(    0x0045    ,    0x003B    ,    0x0118    ,0x0000    ),
DEADTRANS(    0x0065    ,    0x002E    ,    0x0117    ,0x0000    ),
DEADTRANS(    0x0045    ,    0x002E    ,    0x0116    ,0x0000    ),
DEADTRANS(    0x0065    ,    0x0062    ,    0x0115    ,0x0000    ),
DEADTRANS(    0x0065    ,    0x0055    ,    0x0115    ,0x0000    ),
DEADTRANS(    0x0045    ,    0x0062    ,    0x0114    ,0x0000    ),
DEADTRANS(    0x0045    ,    0x0055    ,    0x0114    ,0x0000    ),
DEADTRANS(    0x0065    ,    0x00AF    ,    0x0113    ,0x0000    ),
DEADTRANS(    0x0065    ,    0x005F    ,    0x0113    ,0x0000    ),
DEADTRANS(    0x0045    ,    0x00AF    ,    0x0112    ,0x0000    ),
DEADTRANS(    0x0045    ,    0x005F    ,    0x0112    ,0x0000    ),
DEADTRANS(    0x0064    ,    L'/'    ,    0x0111    ,0x0000    ),
DEADTRANS(    0x0064    ,    0x002F    ,    0x0111    ,0x0000    ),
DEADTRANS(    0x0044    ,    L'/'    ,    0x0110    ,0x0000    ),
DEADTRANS(    0x0044    ,    0x002F    ,    0x0110    ,0x0000    ),
DEADTRANS(    0x0064    ,    0x0063    ,    0x010F    ,0x0000    ),
DEADTRANS(    0x0044    ,    0x0063    ,    0x010E    ,0x0000    ),
DEADTRANS(    0x0063    ,    0x0063    ,    0x010D    ,0x0000    ),
DEADTRANS(    0x0043    ,    0x0063    ,    0x010C    ,0x0000    ),
DEADTRANS(    0x0063    ,    0x002E    ,    0x010B    ,0x0000    ),
DEADTRANS(    0x0043    ,    0x002E    ,    0x010A    ,0x0000    ),
DEADTRANS(    0x0063    ,    0x005E    ,    0x0109    ,0x0000    ),
DEADTRANS(    0x0043    ,    0x005E    ,    0x0108    ,0x0000    ),
DEADTRANS(    0x0063    ,    0x00B4    ,    0x0107    ,0x0000    ),
DEADTRANS(    0x0063    ,    0x0027    ,    0x0107    ,0x0000    ),
DEADTRANS(    0x0043    ,    0x00B4    ,    0x0106    ,0x0000    ),
DEADTRANS(    0x0043    ,    0x0027    ,    0x0106    ,0x0000    ),
DEADTRANS(    0x0061    ,    0x003B    ,    0x0105    ,0x0000    ),
DEADTRANS(    0x0041    ,    0x003B    ,    0x0104    ,0x0000    ),
DEADTRANS(    0x0061    ,    0x0062    ,    0x0103    ,0x0000    ),
DEADTRANS(    0x0061    ,    0x0055    ,    0x0103    ,0x0000    ),
DEADTRANS(    0x0041    ,    0x0062    ,    0x0102    ,0x0000    ),
DEADTRANS(    0x0041    ,    0x0055    ,    0x0102    ,0x0000    ),
DEADTRANS(    0x0061    ,    0x00AF    ,    0x0101    ,0x0000    ),
DEADTRANS(    0x0061    ,    0x005F    ,    0x0101    ,0x0000    ),
DEADTRANS(    0x0041    ,    0x00AF    ,    0x0100    ,0x0000    ),
DEADTRANS(    0x0041    ,    0x005F    ,    0x0100    ,0x0000    ),
DEADTRANS(    0x0079    ,    0x0022    ,    0x00FF    ,0x0000    ),
DEADTRANS(    0x0068    ,    0x0074    ,    0x00FE    ,0x0000    ),
DEADTRANS(    0x0079    ,    0x00B4    ,    0x00FD    ,0x0000    ),
DEADTRANS(    0x0079    ,    0x0027    ,    0x00FD    ,0x0000    ),
DEADTRANS(    0x0075    ,    0x0022    ,    0x00FC    ,0x0000    ),
DEADTRANS(    0x0075    ,    0x005E    ,    0x00FB    ,0x0000    ),
DEADTRANS(    0x0075    ,    0x00B4    ,    0x00FA    ,0x0000    ),
DEADTRANS(    0x0075    ,    0x0027    ,    0x00FA    ,0x0000    ),
DEADTRANS(    0x0075    ,    0x0060    ,    0x00F9    ,0x0000    ),
DEADTRANS(    0x006F    ,    L'/'    ,    0x00F8    ,0x0000    ),
DEADTRANS(    0x006F    ,    0x002F    ,    0x00F8    ,0x0000    ),
DEADTRANS(    0x003A    ,    0x002D    ,    0x00F7    ,0x0000    ),
DEADTRANS(    0x002D    ,    0x003A    ,    0x00F7    ,0x0000    ),
DEADTRANS(    0x006F    ,    0x0022    ,    0x00F6    ,0x0000    ),
DEADTRANS(    0x006F    ,    0x007E    ,    0x00F5    ,0x0000    ),
DEADTRANS(    0x006F    ,    0x005E    ,    0x00F4    ,0x0000    ),
DEADTRANS(    0x006F    ,    0x00B4    ,    0x00F3    ,0x0000    ),
DEADTRANS(    0x006F    ,    0x0027    ,    0x00F3    ,0x0000    ),
DEADTRANS(    0x006F    ,    0x0060    ,    0x00F2    ,0x0000    ),
DEADTRANS(    0x006E    ,    0x007E    ,    0x00F1    ,0x0000    ),
DEADTRANS(    0x0068    ,    0x0064    ,    0x00F0    ,0x0000    ),
DEADTRANS(    0x0069    ,    0x0022    ,    0x00EF    ,0x0000    ),
DEADTRANS(    0x0069    ,    0x005E    ,    0x00EE    ,0x0000    ),
DEADTRANS(    0x0069    ,    0x00B4    ,    0x00ED    ,0x0000    ),
DEADTRANS(    0x0069    ,    0x0027    ,    0x00ED    ,0x0000    ),
DEADTRANS(    0x0069    ,    0x0060    ,    0x00EC    ,0x0000    ),
DEADTRANS(    0x0065    ,    0x0022    ,    0x00EB    ,0x0000    ),
DEADTRANS(    0x0065    ,    0x005E    ,    0x00EA    ,0x0000    ),
DEADTRANS(    0x0065    ,    0x00B4    ,    0x00E9    ,0x0000    ),
DEADTRANS(    0x0065    ,    0x0027    ,    0x00E9    ,0x0000    ),
DEADTRANS(    0x0065    ,    0x0060    ,    0x00E8    ,0x0000    ),
DEADTRANS(    0x0063    ,    0x002C    ,    0x00E7    ,0x0000    ),
DEADTRANS(    0x0065    ,    0x0061    ,    0x00e6    ,0x0000    ),
DEADTRANS(    0x0061    ,    0x006F    ,    0x00E5    ,0x0000    ),
DEADTRANS(    0x0061    ,    0x0022    ,    0x00E4    ,0x0000    ),
DEADTRANS(    0x0061    ,    0x007E    ,    0x00E3    ,0x0000    ),
DEADTRANS(    0x0061    ,    0x005E    ,    0x00E2    ,0x0000    ),
DEADTRANS(    0x0061    ,    0x00B4    ,    0x00E1    ,0x0000    ),
DEADTRANS(    0x0061    ,    0x0027    ,    0x00E1    ,0x0000    ),
DEADTRANS(    0x0061    ,    0x0060    ,    0x00E0    ,0x0000    ),
DEADTRANS(    0x0048    ,    0x0054    ,    0x00DE    ,0x0000    ),
DEADTRANS(    0x0059    ,    0x00B4    ,    0x00DD    ,0x0000    ),
DEADTRANS(    0x0059    ,    0x0027    ,    0x00DD    ,0x0000    ),
DEADTRANS(    0x0055    ,    0x0022    ,    0x00DC    ,0x0000    ),
DEADTRANS(    0x0055    ,    0x005E    ,    0x00DB    ,0x0000    ),
DEADTRANS(    0x0055    ,    0x00B4    ,    0x00DA    ,0x0000    ),
DEADTRANS(    0x0055    ,    0x0027    ,    0x00DA    ,0x0000    ),
DEADTRANS(    0x0055    ,    0x0060    ,    0x00D9    ,0x0000    ),
DEADTRANS(    0x004F    ,    L'/'    ,    0x00D8    ,0x0000    ),
DEADTRANS(    0x004F    ,    0x002F    ,    0x00D8    ,0x0000    ),
DEADTRANS(    0x0078    ,    0x0078    ,    0x00D7    ,0x0000    ),
DEADTRANS(    0x004F    ,    0x0022    ,    0x00D6    ,0x0000    ),
DEADTRANS(    0x004F    ,    0x007E    ,    0x00D5    ,0x0000    ),
DEADTRANS(    0x004F    ,    0x005E    ,    0x00D4    ,0x0000    ),
DEADTRANS(    0x004F    ,    0x00B4    ,    0x00D3    ,0x0000    ),
DEADTRANS(    0x004F    ,    0x0027    ,    0x00D3    ,0x0000    ),
DEADTRANS(    0x004F    ,    0x0060    ,    0x00D2    ,0x0000    ),
DEADTRANS(    0x004E    ,    0x007E    ,    0x00D1    ,0x0000    ),
DEADTRANS(    0x0048    ,    0x0044    ,    0x00D0    ,0x0000    ),
DEADTRANS(    0x0049    ,    0x0022    ,    0x00CF    ,0x0000    ),
DEADTRANS(    0x0049    ,    0x005E    ,    0x00CE    ,0x0000    ),
DEADTRANS(    0x0049    ,    0x00B4    ,    0x00CD    ,0x0000    ),
DEADTRANS(    0x0049    ,    0x0027    ,    0x00CD    ,0x0000    ),
DEADTRANS(    0x0049    ,    0x0060    ,    0x00CC    ,0x0000    ),
DEADTRANS(    0x0045    ,    0x0022    ,    0x00CB    ,0x0000    ),
DEADTRANS(    0x0045    ,    0x005E    ,    0x00CA    ,0x0000    ),
DEADTRANS(    0x0045    ,    0x00B4    ,    0x00C9    ,0x0000    ),
DEADTRANS(    0x0045    ,    0x0027    ,    0x00C9    ,0x0000    ),
DEADTRANS(    0x0045    ,    0x0060    ,    0x00C8    ,0x0000    ),
DEADTRANS(    0x0043    ,    0x002C    ,    0x00C7    ,0x0000    ),
DEADTRANS(    0x0045    ,    0x0041    ,    0x00c6    ,0x0000    ),
DEADTRANS(    0x0041    ,    0x006F    ,    0x00C5    ,0x0000    ),
DEADTRANS(    0x0041    ,    0x0022    ,    0x00C4    ,0x0000    ),
DEADTRANS(    0x0041    ,    0x007E    ,    0x00C3    ,0x0000    ),
DEADTRANS(    0x0041    ,    0x005E    ,    0x00C2    ,0x0000    ),
DEADTRANS(    0x0041    ,    0x00B4    ,    0x00C1    ,0x0000    ),
DEADTRANS(    0x0041    ,    0x0027    ,    0x00C1    ,0x0000    ),
DEADTRANS(    0x0041    ,    0x0060    ,    0x00C0    ,0x0000    ),
DEADTRANS(    0x0034    ,    0x0033    ,    0x00BE    ,0x0000    ),
DEADTRANS(    0x0032    ,    0x0031    ,    0x00BD    ,0x0000    ),
DEADTRANS(    0x0034    ,    0x0031    ,    0x00BC    ,0x0000    ),
DEADTRANS(    0x0031    ,    0x005E    ,    0x00B9    ,0x0000    ),
DEADTRANS(    0x002E    ,    0x002E    ,    0x00B7    ,0x0000    ),
DEADTRANS(    0x0075    ,    0x006D    ,    0x00B5    ,0x0000    ),
DEADTRANS(    0x0033    ,    0x005E    ,    0x00B3    ,0x0000    ),
DEADTRANS(    0x0032    ,    0x005E    ,    0x00B2    ,0x0000    ),
DEADTRANS(    0x00B0    ,    0x0077    ,    0x00B0    ,0x0000    ),
DEADTRANS(    0x002D    ,    0x002C    ,    0x00AC    ,0x0000    ),
DEADTRANS(    0x002C    ,    0x002D    ,    0x00AC    ,0x0000    ),
DEADTRANS(    0x004C    ,    0x002D    ,    0x00a3    ,0x0000    ),
DEADTRANS(    0x002D    ,    0x004C    ,    0x00a3    ,0x0000    ),
DEADTRANS(    0x007C    ,    0x0063    ,    0x00A2    ,0x0000    ),
DEADTRANS(    0x0063    ,    0x007C    ,    0x00A2    ,0x0000    ),
DEADTRANS(    0x0063    ,    0x002F    ,    0x00A2    ,0x0000    ),
DEADTRANS(    0x002F    ,    0x0063    ,    0x00A2    ,0x0000    ),
DEADTRANS(    0x0063    ,    0x003D    ,    0x20AC    ,0x0000    ),
DEADTRANS(    0x0045    ,    0x003D    ,    0x20AC    ,0x0000    ),
DEADTRANS(    0x0043    ,    0x003D    ,    0x20AC    ,0x0000    ),
DEADTRANS(    0x003D    ,    0x0063    ,    0x20AC    ,0x0000    ),
DEADTRANS(    0x003D    ,    0x0045    ,    0x20AC    ,0x0000    ),
DEADTRANS(    0x003D    ,    0x0043    ,    0x20AC    ,0x0000    ),
DEADTRANS(    0x0065    ,    0x006F    ,    0x13BD    ,0x0000    ),
DEADTRANS(    0x0045    ,    0x004F    ,    0x13BC    ,0x0000    ),
DEADTRANS(    0x006D    ,    0x0074    ,    0x0AC9    ,0x0000    ),
DEADTRANS(    0x0064    ,    0x002D    ,    0x01F0    ,0x0000    ),
DEADTRANS(    0x0044    ,    0x002D    ,    0x01D0    ,0x0000    ),
DEADTRANS(    0x0073    ,    0x0073    ,    0x00DF    ,0x0000    ),
DEADTRANS(    0x003F    ,    0x003F    ,    0x00BF    ,0x0000    ),
DEADTRANS(    0x003E    ,    0x003E    ,    0x00BB    ,0x0000    ),
DEADTRANS(    0x002C    ,    0x0020    ,    0x00B8    ,0x0000    ),
DEADTRANS(    0x0020    ,    0x002C    ,    0x00B8    ,0x0000    ),
DEADTRANS(    0x0050    ,    0x0050    ,    0x00B6    ,0x0000    ),
DEADTRANS(    0x0021    ,    0x0070    ,    0x00B6    ,0x0000    ),
DEADTRANS(    0x0021    ,    0x0050    ,    0x00B6    ,0x0000    ),
DEADTRANS(    0x002D    ,    0x002B    ,    0x00B1    ,0x0000    ),
DEADTRANS(    0x006F    ,    0x006F    ,    0x00B0    ,0x0000    ),
DEADTRANS(    0x0072    ,    0x006F    ,    0x00AE    ,0x0000    ),
DEADTRANS(    0x0072    ,    0x004F    ,    0x00AE    ,0x0000    ),
DEADTRANS(    0x0052    ,    0x006F    ,    0x00AE    ,0x0000    ),
DEADTRANS(    0x0052    ,    0x004F    ,    0x00AE    ,0x0000    ),
DEADTRANS(    0x003C    ,    0x003C    ,    0x00AB    ,0x0000    ),
DEADTRANS(    0x0063    ,    0x006F    ,    0x00A9    ,0x0000    ),
DEADTRANS(    0x0063    ,    0x004F    ,    0x00A9    ,0x0000    ),
DEADTRANS(    0x0043    ,    0x006F    ,    0x00A9    ,0x0000    ),
DEADTRANS(    0x0043    ,    0x004F    ,    0x00A9    ,0x0000    ),
DEADTRANS(    0x0073    ,    0x006F    ,    0x00A7    ,0x0000    ),
DEADTRANS(    0x006F    ,    0x0073    ,    0x00A7    ,0x0000    ),
DEADTRANS(    0x005E    ,    0x0021    ,    0x00A6    ,0x0000    ),
DEADTRANS(    0x0059    ,    0x003D    ,    0x00A5    ,0x0000    ),
DEADTRANS(    0x003D    ,    0x0059    ,    0x00A5    ,0x0000    ),
DEADTRANS(    0x0078    ,    0x006F    ,    0x00A4    ,0x0000    ),
DEADTRANS(    0x006F    ,    0x0078    ,    0x00A4    ,0x0000    ),
DEADTRANS(    0x0021    ,    0x0021    ,    0x00A1    ,0x0000    ),
DEADTRANS(    0x0020    ,    0x0020    ,    0x00A0    ,0x0000    ),
DEADTRANS(    0x007E    ,    0x0020    ,    0x007E    ,0x0000    ),
DEADTRANS(    0x002D    ,    0x0020    ,    0x007E    ,0x0000    ),
DEADTRANS(    0x0020    ,    0x007E    ,    0x007E    ,0x0000    ),
DEADTRANS(    0x0020    ,    0x002D    ,    0x007E    ,0x0000    ),
DEADTRANS(    0x002D    ,    0x0029    ,    0x007D    ,0x0000    ),
DEADTRANS(    0x0029    ,    0x002D    ,    0x007D    ,0x0000    ),
DEADTRANS(    0x0076    ,    0x006C    ,    0x007C    ,0x0000    ),
DEADTRANS(    0x006C    ,    0x0076    ,    0x007C    ,0x0000    ),
DEADTRANS(    0x005E    ,    0x002F    ,    0x007C    ,0x0000    ),
DEADTRANS(    0x0056    ,    0x004C    ,    0x007C    ,0x0000    ),
DEADTRANS(    0x004C    ,    0x0056    ,    0x007C    ,0x0000    ),
DEADTRANS(    0x002F    ,    0x005E    ,    0x007C    ,0x0000    ),
DEADTRANS(    0x002D    ,    0x0028    ,    0x007B    ,0x0000    ),
DEADTRANS(    0x0028    ,    0x002D    ,    0x007B    ,0x0000    ),
DEADTRANS(    0x0060    ,    0x0020    ,    0x0060    ,0x0000    ),
DEADTRANS(    0x0020    ,    0x0060    ,    0x0060    ,0x0000    ),
DEADTRANS(    0x005E    ,    0x0020    ,    0x005E    ,0x0000    ),
DEADTRANS(    0x003E    ,    0x0020    ,    0x005E    ,0x0000    ),
DEADTRANS(    0x0020    ,    0x005E    ,    0x005E    ,0x0000    ),
DEADTRANS(    0x0020    ,    0x003E    ,    0x005E    ,0x0000    ),
DEADTRANS(    0x0029    ,    0x0029    ,    0x005D    ,0x0000    ),
DEADTRANS(    0x003C    ,    0x002F    ,    0x005C    ,0x0000    ),
DEADTRANS(    0x002F    ,    0x003C    ,    0x005C    ,0x0000    ),
DEADTRANS(    0x002F    ,    0x002F    ,    0x005C    ,0x0000    ),
DEADTRANS(    0x0028    ,    0x0028    ,    0x005B    ,0x0000    ),
DEADTRANS(    0x0054    ,    0x0041    ,    0x0040    ,0x0000    ),
DEADTRANS(    0x0027    ,    0x0020    ,    0x0027    ,0x0000    ),
DEADTRANS(    0x0020    ,    0x0027    ,    0x0027    ,0x0000    ),
DEADTRANS(    0x002B    ,    0x002B    ,    0x0023    ,0x0000    ),
DEADTRANS(    0x06FC    ,    0x00B4    ,    0    ,0x0000    ),
DEADTRANS(    0x06FC    ,    0x0060    ,    0    ,0x0000    ),
DEADTRANS(    0x06FC    ,    0x005E    ,    0    ,0x0000    ),
DEADTRANS(    0x06FC    ,    0x0027    ,    0    ,0x0000    ),
DEADTRANS(    0x06F5    ,    0x00B4    ,    0    ,0x0000    ),
DEADTRANS(    0x06F5    ,    0x0060    ,    0    ,0x0000    ),
DEADTRANS(    0x06F5    ,    0x005E    ,    0    ,0x0000    ),
DEADTRANS(    0x06F5    ,    0x0027    ,    0    ,0x0000    ),
DEADTRANS(    0x06EF    ,    0x00B4    ,    0    ,0x0000    ),
DEADTRANS(    0x06EF    ,    0x0060    ,    0    ,0x0000    ),
DEADTRANS(    0x06EF    ,    0x005E    ,    0    ,0x0000    ),
DEADTRANS(    0x06EF    ,    0x0027    ,    0    ,0x0000    ),
DEADTRANS(    0x06E9    ,    0x00B4    ,    0    ,0x0000    ),
DEADTRANS(    0x06E9    ,    0x0060    ,    0    ,0x0000    ),
DEADTRANS(    0x06E9    ,    0x005E    ,    0    ,0x0000    ),
DEADTRANS(    0x06E9    ,    0x0027    ,    0    ,0x0000    ),
DEADTRANS(    0x06E1    ,    0x00B4    ,    0    ,0x0000    ),
DEADTRANS(    0x06E1    ,    0x0060    ,    0    ,0x0000    ),
DEADTRANS(    0x06E1    ,    0x005E    ,    0    ,0x0000    ),
DEADTRANS(    0x06E1    ,    0x0027    ,    0    ,0x0000    ),
DEADTRANS(    0x06DC    ,    0x00B4    ,    0    ,0x0000    ),
DEADTRANS(    0x06DC    ,    0x0060    ,    0    ,0x0000    ),
DEADTRANS(    0x06DC    ,    0x005E    ,    0    ,0x0000    ),
DEADTRANS(    0x06DC    ,    0x0027    ,    0    ,0x0000    ),
DEADTRANS(    0x06D5    ,    0x00B4    ,    0    ,0x0000    ),
DEADTRANS(    0x06D5    ,    0x0060    ,    0    ,0x0000    ),
DEADTRANS(    0x06D5    ,    0x005E    ,    0    ,0x0000    ),
DEADTRANS(    0x06D5    ,    0x0027    ,    0    ,0x0000    ),
DEADTRANS(    0x06CF    ,    0x00B4    ,    0    ,0x0000    ),
DEADTRANS(    0x06CF    ,    0x0060    ,    0    ,0x0000    ),
DEADTRANS(    0x06CF    ,    0x005E    ,    0    ,0x0000    ),
DEADTRANS(    0x06CF    ,    0x0027    ,    0    ,0x0000    ),
DEADTRANS(    0x06C9    ,    0x00B4    ,    0    ,0x0000    ),
DEADTRANS(    0x06C9    ,    0x0060    ,    0    ,0x0000    ),
DEADTRANS(    0x06C9    ,    0x005E    ,    0    ,0x0000    ),
DEADTRANS(    0x06C9    ,    0x0027    ,    0    ,0x0000    ),
DEADTRANS(    0x06C1    ,    0x00B4    ,    0    ,0x0000    ),
DEADTRANS(    0x06C1    ,    0x0060    ,    0    ,0x0000    ),
DEADTRANS(    0x06C1    ,    0x005E    ,    0    ,0x0000    ),
DEADTRANS(    0x06C1    ,    0x0027    ,    0    ,0x0000    ),






    0, 0
};


static ALLOC_SECTION_LDATA KBDTABLES KbdTables = {
/*
* Modifier keys
*/
    &CharModifiers,

/*
* Characters tables
*/
    aVkToWcharTable,

/*
* Diacritics
*/
    aDeadKey,

/*
* Names of Keys
*/
    aKeyNames,
    aKeyNamesExt,
    aKeyNamesDead,

/*
* Scan codes to Virtual Keys
*/
    ausVK,
    sizeof(ausVK) / sizeof(ausVK[0]),
    aE0VscToVk,
    aE1VscToVk,

/*
* Locale-specific special processing
* KLLF_ALTGR damit AltGr = Strg+Alt 
*/
    MAKELONG(KLLF_ALTGR, KBD_VERSION),

/*
* Ligatures
*/
    0,
    0,
    NULL
};

PKBDTABLES KbdLayerDescriptor(VOID)
{
    return &KbdTables;
}