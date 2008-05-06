/***************************************************************************\
* Module Name: KBDNEO2.C
*
* keyboard layout for German
*
* Copyright (c) 1985-2000, Microsoft Corporation
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
*
* German Keyboard has only three shifter keys:
*     SHIFT (L & R) affects alphabnumeric keys,
*     CTRL  (L & R) is used to generate control characters
*     ALT   (L & R) used for generating characters by number with numpad
\***************************************************************************/
static ALLOC_SECTION_LDATA VK_TO_BIT aVkToBits[] = {
    { VK_SHIFT    ,   KBDSHIFT     },
    { VK_CONTROL  ,   KBDCTRL      },	
	{ VK_MENU     ,   KBDALT       },
	{ VK_KANA     ,   KBDKANA	   },
	{ 0           ,   0            }
};

/***************************************************************************\
* aModification[]  - map character modifier bits to modification number
*
* See kbd.h for a full description.
*
\***************************************************************************/
static ALLOC_SECTION_LDATA MODIFIERS CharModifiers = {
    &aVkToBits[0],
    14,
    {
	//  Modifier NEO 
	//  Ebene 1 - nix
	//  Ebene 2 - Shift
	//  Ebene 3 - Kana
	//  Ebene 4 - AltGr
	//  Ebene 5 - Kana+Shift
	//  Ebene 6 - AltGr+Kana
	//  
	//  Modification# //  Keys Pressed
    //  ============= // =============
        0,            	// 0000 
        1,            	// 0001	Shift
        6,            	// 0010	Strg
        7,            	// 0011	Shift + Strg
        SHFT_INVALID, 	// 0100	Menu
        SHFT_INVALID,	// 0101	Shift + Menu 
        3,				// 0110	Strg + Menu 
		SHFT_INVALID,	// 0111	Shift + Strg + Menu
		2,			  	// 1000	Kana
		4,             	// 1001	Shift + Kana
		SHFT_INVALID,	// 1010	Strg + Kana
		SHFT_INVALID,	// 1011	Shift + Strg + Kana
		SHFT_INVALID,	// 1100	Menu + Kana
		SHFT_INVALID,	// 1101	Shift + Menu + Kana
		5				// 1110	Menu + Strg + Kana
		
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

static ALLOC_SECTION_LDATA VK_TO_WCHARS2 aVkToWch2[] = {
//				|		 |    Shift      |
//				|===========|=========|
{VK_DECIMAL		,0      ,','      ,','      },
{0            	,0      ,0        ,0        }
};

static ALLOC_SECTION_LDATA VK_TO_WCHARS4 aVkToWch4[] = {
//							|			|   SHIFT	        |   KANA                   |  ALT+CTL	          |
//							|			|===============|================|===============|
{VK_ADD			,0			,'+'		,'+'		,0x00b1		,0x2213		},
{VK_DIVIDE		,0			,'/'		,'/'		,0x00f7		,0x2215		},
{VK_MULTIPLY	,0			,'*'		,'*'		,0x00d7		,0x22c5		},
{VK_SUBTRACT	,0			,'-'		,'-'		,WCH_NONE	,0x2052		},
{0				,0			,0			,0			,0			,0			}
};                                                                

static ALLOC_SECTION_LDATA VK_TO_WCHARS6 aVkToWch6[] = {
//							|			|   SHIFT	          |   KANA                  |  ALT+CTL	          |  KANA+Shift      |   ALT+CTL+Kana	 | 
//							|			|===============|================|===============|===============|================|
{VK_OEM_1		,0			,WCH_DEAD	,WCH_DEAD	,WCH_DEAD	,WCH_DEAD	,WCH_DEAD	,WCH_DEAD	},
{0xff			,0			,'^'		,0x030c		,0x0306		,0x00b7		,0x0335		,0x0323		},
{'1'			,CAPLOK		,'1'		,0x00b0		,0x00B9		,0x2022		,0x2640		,0x00ac		},
{'3'			,CAPLOK		,'3'		,0x00a7		,0x00b3		,WCH_NONE	,0x2640		,0x2227		},
{'4'			,CAPLOK		,'4'		,0x00bb		,0x203A		,WCH_NONE	,0x2113		,0x02d4		},
{'5'			,CAPLOK		,'5'		,0x00ab		,0x2039		,WCH_NONE	,0x2020		,0x2221		},
{'7'			,CAPLOK		,'7'		,0x0024		,0x00a5		,0x00a4		,0x03f0		,0x2209		},
{'8'			,CAPLOK		,'8'		,0x201E		,0x201A		,0x002F		,WCH_NONE	,0x2204		},
{'9'			,CAPLOK		,'9'		,0x201C		,0x2018		,0x002A		,WCH_NONE	,0x2226		},
{'0'			,CAPLOK		,'0'		,0x201D		,0x2019		,0x002D		,WCH_NONE	,0x2205		},
{VK_OEM_MINUS	,0			,'-'		,0x2013		,0x2014		,0X2011		,0x00AD		,0x2227		},
{VK_OEM_2		,0			,WCH_DEAD	,WCH_DEAD	,WCH_DEAD	,WCH_DEAD	,WCH_DEAD	,WCH_DEAD	},
{0xff			,0			,0x0301		,0x0300		,0x0327		,0x0307		,0x0328		,0x030a		},
{VK_TAB			,0			,'\t'		,'\t'		,'\t'		,'\t'		,'\t'		,'\t'		},
{'X'			,CAPLOK		,'x'		,'X'		,WCH_NONE	,WCH_NONE	,0x03BE		,0x039E		},
{'V'			,CAPLOK		,'v'		,'V'		,'_'		,'\b'		,WCH_NONE	,0x2259		},
{'L'			,CAPLOK		,'l'		,'L'		,'['		,WCH_NONE	,0x03BB		,0x039b		},
{'C'			,CAPLOK		,'c'		,'C'		,']'		,0x007f		,0x03C7		,0x2102		}, 
{'W'			,CAPLOK		,'w'		,'W'		,0x005E		,WCH_NONE	,0x1f7c		,0x03a9		},
{'K'			,CAPLOK		,'k'		,'K'		,'!'		,0x00A1		,0x03BA		,0x221a		},
{'H'			,CAPLOK		,'h'		,'H'		,'<'		,'7'		,0x03C8		,0x03A8		},
{'G'			,CAPLOK		,'g'		,'G'		,'>'		,'8'		,0x03B3		,0x0393		},
{'F'			,CAPLOK		,'f'		,'F'		,'='		,'9'		,0x03C6		,0x03A6		},
{'Q'			,CAPLOK		,'q'		,'Q'		,'&'		,'+'		,0x0278		,0x211a		},
{'U'			,CAPLOK		,'u'		,'U'		,'\\'		,WCH_NONE	,WCH_NONE	,0x222e		},
{'I'			,CAPLOK		,'i'		,'I'		,'/'		,WCH_NONE	,0x03B9		,0x222b		},
{'A'			,CAPLOK		,'a'		,'A'		,'{'		,WCH_NONE	,0x03B1		,0x2200		},
{'E'			,CAPLOK		,'e'		,'E'		,'}'		,WCH_NONE	,0x03B5		,0x2203		},
{'O'			,CAPLOK		,'o'		,'O'		,'*'		,WCH_NONE	,0x03bf		,0x2208		},
{'S'			,CAPLOK		,'s'		,'S'		,'?'		,0x00BF		,0x03C3		,0x03A3		},
{'N'			,CAPLOK		,'n'		,'N'		,'('		,'4'		,0x03BD		,0x2115		},
{'R'			,CAPLOK		,'r'		,'R'		,')'		,'5'		,0x03C1		,0x211d		},
{'T'			,CAPLOK		,'t'		,'T'		,'-'		,'6'		,0x03C4		,0x2202		},
{'D'			,CAPLOK		,'d'		,'D'		,':'		,','		,0x03B4		,0x0394		},
{VK_OEM_5		,CAPLOK		,0x00FC		,0x00DC		,'#'		,0x001b		,WCH_NONE	,0x221d		},
{VK_OEM_6		,CAPLOK		,0x00F6		,0x00D6		,'$'		,'\t'		,WCH_NONE	,0x2111		},
{VK_OEM_7		,CAPLOK		,0x00E4		,0x00C4		,'|'		,WCH_NONE	,0x03B7		,0x211c		},
{'P'			,CAPLOK		,'p'		,'P'		,'~'		,'\r'		,0x03C0		,0x03A0		},
{'Z'			,CAPLOK		,'z'		,'Z'		,'`'		,WCH_NONE	,0x03B6		,0x2124		},
{'B'			,CAPLOK		,'b'		,'B'		,'+'		,WCH_NONE	,0x03B2		,0x212d		},
{'M'			,CAPLOK		,'m'		,'M'		,'%'		,'1'		,0x00b5		,0x21d4		},
{VK_OEM_COMMA	,0			,','		,0x22ee		,'\''		,'2'		,0x03F1		,0x21d0		},
{VK_OEM_PERIOD	,0			,'.'		,0x2026		,'\"'		,'3'		,0x03B8		,0x0398		},
{0				,0			,0			,0			,0			,0			,0			,0			}
};                                                                  

static ALLOC_SECTION_LDATA VK_TO_WCHARS7 aVkToWch7[] = {
//							|			|   SHIFT	          |   KANA                  |  ALT+CTL	          |  KANA+Shift       |   ALT+CTL+Kana	 |  Control		| 
//							|			|===============|================|===============|===============|================|===============|
{VK_OEM_3		,CAPLOK		,0x00df		,0x1E9E 	,0x017F		,WCH_NONE	,0x03C2		,0x018F		,0x2218		},
{VK_OEM_4		,0			,WCH_DEAD	,WCH_DEAD	,WCH_DEAD	,WCH_DEAD	,WCH_DEAD	,WCH_DEAD	,0x001d		},
{0xff			,0			,0x0303		,0x0304		,0x0308		,0x0337		,0x030b		,0x0326		,WCH_NONE	},
{'Y'			,CAPLOK		,'y'		,'Y'		,'@'		,WCH_NONE	,0x03C5		,0x2207		,0x001c		},
{VK_SPACE		,0      	,' '		,' '		,0x00A0		,'0'		,' '		,0x2009		,' '		},
{VK_BACK		,0			,'\b'		,'\b'		,WCH_NONE	,WCH_NONE	,WCH_NONE	,WCH_NONE	,0x007f		},
{VK_ESCAPE		,0			,0x001b		,0x001b		,WCH_NONE	,WCH_NONE	,WCH_NONE	,WCH_NONE	,0x001b		},
{VK_RETURN		,0			,'\r'		,'\r'		,WCH_NONE	,WCH_NONE	,WCH_NONE	,WCH_NONE	,'\n'		},
{VK_CANCEL		,0			,0x0003		,0x0003		,WCH_NONE	,WCH_NONE	,WCH_NONE	,WCH_NONE	,0x0003		},
{0				,0			,0			,0			,0			,0			,0			,0			,0			}
};                                                                  

static ALLOC_SECTION_LDATA VK_TO_WCHARS8 aVkToWch8[] = {
//							|			|   SHIFT	          |   KANA                  |  ALT+CTL	          |  KANA+Shift       |   ALT+CTL+Kana	 |  Control		|  Control+Shift	|
//							|			|===============|================|===============|===============|================|===============|===============|
{'2'			,CAPLOK		,'2'		,0x2116		,0x00b2		,0x2023		,0x26A5		,0x2228		,WCH_NONE	,0x0000		},
{'6'			,CAPLOK		,'6'		,0x20ac		,0x00Ac		,0x00a3		,WCH_NONE	,0x2225		,WCH_NONE	,0x001e		},
{'J'			,CAPLOK		,'j'		,'J'		,';'		,'.'		,0x03D1		,0x2261		,WCH_NONE	,0x001f		},
{0				,0			,0			,0			,0			,0			,0			,0			,0			,0			}
};                                                                  

// Put this last so that VkKeyScan interprets number characters
// as coming from the main section of the kbd (aVkToWch2 and
// aVkToWch5) before considering the numpad (aVkToWch1).

static ALLOC_SECTION_LDATA VK_TO_WCHARS1 aVkToWch1[] = {
    { VK_NUMPAD0   , 0      ,  '0'   },
    { VK_NUMPAD1   , 0      ,  '1'   },
    { VK_NUMPAD2   , 0      ,  '2'   },
    { VK_NUMPAD3   , 0      ,  '3'   },
    { VK_NUMPAD4   , 0      ,  '4'   },
    { VK_NUMPAD5   , 0      ,  '5'   },
    { VK_NUMPAD6   , 0      ,  '6'   },
    { VK_NUMPAD7   , 0      ,  '7'   },
    { VK_NUMPAD8   , 0      ,  '8'   },
    { VK_NUMPAD9   , 0      ,  '9'   },
    { 0            , 0      ,  '\0'  }
};

static ALLOC_SECTION_LDATA VK_TO_WCHAR_TABLE aVkToWcharTable[] = {
    {  (PVK_TO_WCHARS1)aVkToWch4, 4, sizeof(aVkToWch4[0]) },
    {  (PVK_TO_WCHARS1)aVkToWch6, 6, sizeof(aVkToWch6[0]) },
    {  (PVK_TO_WCHARS1)aVkToWch7, 7, sizeof(aVkToWch7[0]) },
	{  (PVK_TO_WCHARS1)aVkToWch8, 8, sizeof(aVkToWch8[0]) },
    {  (PVK_TO_WCHARS1)aVkToWch2, 2, sizeof(aVkToWch2[0]) },
    {  (PVK_TO_WCHARS1)aVkToWch1, 1, sizeof(aVkToWch1[0]) },
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
    0x0e,    L"R\x00DC" L"CK",
    0x0f,    L"TABULATOR",
    0x1c,    L"EINGABE",
    0x1d,    L"STRG",
    0x2a,    L"UMSCHALT",
    0x36,    L"UMSCHALT RECHTS",
    0x37,    L" (ZEHNERTASTATUR)",
    0x38,    L"ALT",
    0x39,    L"LEER",
    0x3a,    L"FESTSTELL",
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
    0x57,    L"F11",
    0x58,    L"F12",
    0   ,    NULL
};

static ALLOC_SECTION_LDATA VSC_LPWSTR aKeyNamesExt[] = {
    0x1c,    L"EINGABE (ZEHNERTASTATUR)",
    0x1d,    L"STRG-RECHTS",
    0x35,    L" (ZEHNERTASTATUR)",
    0x37,    L"DRUCK",
    0x38,    L"ALT GR",
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
    L"^"		L"ZIRKUMFLEX",
    L"\x030c"	L"CARON",
	L"\x0306"	L"BREVIS",
	L"\x0335"	L"QUERSTRICH",
	L"\x00b7"	L"DOT_MID",
	L"\x0323"	L"DOT_BELOW",
	
	L"\x0301"	L"AKUT",
    L"\x0300"	L"GRAVIS",
	L"\x0327"	L"CEDILLA",
	L"\x0328"	L"OGONEK",
	L"\x0307"	L"DOT_ABOVE",
	L"\x030a"	L"RING",
	
	L"\x0303"	L"TILDE",
	L"\x0304"	L"MAKRON",
	L"\x0308"	L"DIAERASE",
	L"\x030b"	L"DOPPEL_AKUT",
	L"\x0337"	L"SCHRAEGSTRICH",
	L"\x0326"	L"KOMMA_BELOW",


    NULL
};

static ALLOC_SECTION_LDATA DEADKEY aDeadKey[] = {

// Anfang der Taste links neben der 1
	DEADTRANS( L'1'   , L'^'   , 0x00b9 , 0x0000), //ZIRKUMFLEX
	DEADTRANS( L'2'   , L'^'   , 0x00b2 , 0x0000),
	DEADTRANS( L'3'   , L'^'   , 0x00b3 , 0x0000),
    DEADTRANS( L'A'   , L'^'   , 0x00c2 , 0x0000),	
    DEADTRANS( L'E'   , L'^'   , 0x00ca , 0x0000),
    DEADTRANS( L'I'   , L'^'   , 0x00ce , 0x0000),
    DEADTRANS( L'O'   , L'^'   , 0x00d4 , 0x0000),
    DEADTRANS( L'U'   , L'^'   , 0x00db , 0x0000),	
	DEADTRANS( L'a'   , L'^'   , 0x00e2 , 0x0000),
    DEADTRANS( L'e'   , L'^'   , 0x00ea , 0x0000),
    DEADTRANS( L'i'   , L'^'   , 0x00ee , 0x0000),
    DEADTRANS( L'o'   , L'^'   , 0x00f4 , 0x0000),
    DEADTRANS( L'u'   , L'^'   , 0x00fb , 0x0000),	
	DEADTRANS( L'C'   , L'^'   , 0x0108 , 0x0000),
	DEADTRANS( L'c'   , L'^'   , 0x0109 , 0x0000),
	DEADTRANS( L'G'   , L'^'   , 0x011c , 0x0000),
	DEADTRANS( L'g'   , L'^'   , 0x011d , 0x0000),
	DEADTRANS( L'H'   , L'^'   , 0x0124 , 0x0000),
	DEADTRANS( L'h'   , L'^'   , 0x0125 , 0x0000),
	DEADTRANS( L'J'   , L'^'   , 0x0134 , 0x0000),
	DEADTRANS( L'j'   , L'^'   , 0x0135 , 0x0000),
	DEADTRANS( L'S'   , L'^'   , 0x015c , 0x0000),
	DEADTRANS( L's'   , L'^'   , 0x015d , 0x0000),
	DEADTRANS( L'W'   , L'^'   , 0x0174 , 0x0000),
	DEADTRANS( L'w'   , L'^'   , 0x0175 , 0x0000),
	DEADTRANS( L'Y'   , L'^'   , 0x0176 , 0x0000),
	DEADTRANS( L'y'   , L'^'   , 0x0177 , 0x0000),
	DEADTRANS( L'Z'   , L'^'   , 0x1e90 , 0x0000),
	DEADTRANS( L'z'   , L'^'   , 0x1e91 , 0x0000),
	DEADTRANS( L'1'   , L'^'   , 0x00b9 , 0x0000),
	DEADTRANS( L'2'   , L'^'   , 0x00b2 , 0x0000),
	DEADTRANS( L'3'   , L'^'   , 0x00b3 , 0x0000),
	DEADTRANS( L'4'   , L'^'   , 0x2074 , 0x0000),
	DEADTRANS( L'5'   , L'^'   , 0x2075	, 0x0000),
	DEADTRANS( L'6'   , L'^'   , 0x2076	, 0x0000),
	DEADTRANS( L'7'   , L'^'   , 0x2077	, 0x0000),
	DEADTRANS( L'8'   , L'^'   , 0x2078	, 0x0000),
	DEADTRANS( L'9'   , L'^'   , 0x2079	, 0x0000),
	DEADTRANS( L'0'   , L'^'   , 0x2070 , 0x0000),
	DEADTRANS( L'+'   , L'^'   , 0x207a , 0x0000),
	DEADTRANS( L'-'   , L'^'   , 0x207b , 0x0000),
	DEADTRANS( L'='   , L'^'   , 0x207c , 0x0000),
	DEADTRANS( L'('   , L'^'   , 0x207d , 0x0000),
	DEADTRANS( L')'   , L'^'   , 0x207e , 0x0000),
	DEADTRANS( L'n'   , L'^'   , 0x207f , 0x0000),
    DEADTRANS( L' '   , L'^'   , L'^'   , 0x0000),
	
	DEADTRANS( L'C'   , 0x030c , 0x010c   , 0x0000), //CARON
	DEADTRANS( L'c'   , 0x030c , 0x010d   , 0x0000), 
	DEADTRANS( L'D'   , 0x030c , 0x010e   , 0x0000), 
	DEADTRANS( L'd'   , 0x030c , 0x010f   , 0x0000),
	DEADTRANS( L'E'   , 0x030c , 0x011a   , 0x0000),
	DEADTRANS( L'e'   , 0x030c , 0x011b   , 0x0000),
	DEADTRANS( L'L'   , 0x030c , 0x013d   , 0x0000),
	DEADTRANS( L'l'   , 0x030c , 0x013e   , 0x0000),
	DEADTRANS( L'N'   , 0x030c , 0x0147   , 0x0000),
	DEADTRANS( L'n'   , 0x030c , 0x0148   , 0x0000),
	DEADTRANS( L'R'   , 0x030c , 0x0158   , 0x0000),
	DEADTRANS( L'r'   , 0x030c , 0x0159   , 0x0000),
	DEADTRANS( L'S'   , 0x030c , 0x0160   , 0x0000),
	DEADTRANS( L's'   , 0x030c , 0x0161   , 0x0000),
	DEADTRANS( L'T'   , 0x030c , 0x0164   , 0x0000),
	DEADTRANS( L't'   , 0x030c , 0x0165   , 0x0000),
	DEADTRANS( L'Z'   , 0x030c , 0x017d   , 0x0000),
	DEADTRANS( L'z'   , 0x030c , 0x017e   , 0x0000),
	DEADTRANS( L'A'   , 0x030c , 0x01cd   , 0x0000),
	DEADTRANS( L'a'   , 0x030c , 0x01ce   , 0x0000),
	DEADTRANS( L'I'   , 0x030c , 0x01cf   , 0x0000),
	DEADTRANS( L'i'   , 0x030c , 0x01d0   , 0x0000),
	DEADTRANS( L'O'   , 0x030c , 0x01d1   , 0x0000),
	DEADTRANS( L'o'   , 0x030c , 0x01d2   , 0x0000),
	DEADTRANS( L'U'   , 0x030c , 0x01d3   , 0x0000),
	DEADTRANS( L'u'   , 0x030c , 0x01d4   , 0x0000),
	DEADTRANS( L'G'   , 0x030c , 0x01e6   , 0x0000),
	DEADTRANS( L'g'   , 0x030c , 0x01e7   , 0x0000),
	DEADTRANS( L'K'   , 0x030c , 0x01e8   , 0x0000),
	DEADTRANS( L'k'   , 0x030c , 0x01e9   , 0x0000),
	DEADTRANS( L'j'   , 0x030c , 0x01f0   , 0x0000),
	DEADTRANS( L'H'   , 0x030c , 0x021e   , 0x0000),
	DEADTRANS( L'h'   , 0x030c , 0x021f   , 0x0000),
	DEADTRANS( 0x00fc , 0x030c , 0x01da   , 0x0000),
	DEADTRANS( 0x00dc , 0x030c , 0x01d9   , 0x0000),
	DEADTRANS( L' '   , 0x030c , 0x030c   , 0x0000), 
	
	DEADTRANS( L'A'   , 0x0306 , 0x0102   , 0x0000),	//BREVIS
	DEADTRANS( L'a'   , 0x0306 , 0x0103   , 0x0000),
	DEADTRANS( L'E'   , 0x0306 , 0x0114   , 0x0000),
	DEADTRANS( L'e'   , 0x0306 , 0x0115   , 0x0000),
	DEADTRANS( L'G'   , 0x0306 , 0x011e   , 0x0000),
	DEADTRANS( L'g'   , 0x0306 , 0x011f   , 0x0000),
	DEADTRANS( L'I'   , 0x0306 , 0x012c   , 0x0000),
	DEADTRANS( L'i'   , 0x0306 , 0x012d   , 0x0000),
	DEADTRANS( L'O'   , 0x0306 , 0x014e   , 0x0000),
	DEADTRANS( L'o'   , 0x0306 , 0x014f   , 0x0000),
	DEADTRANS( L'U'   , 0x0306 , 0x016c   , 0x0000),
	DEADTRANS( L'u'   , 0x0306 , 0x016d   , 0x0000),
	DEADTRANS( L' '   , 0x0306 , 0x0306   , 0x0000),
	
	DEADTRANS( L'1'   , 0x0335 , 0x2081   , 0x0000),	//QUERSTRICH
	DEADTRANS( L'2'   , 0x0335 , 0x2082   , 0x0000),
	DEADTRANS( L'3'   , 0x0335 , 0x2083   , 0x0000),
	DEADTRANS( L'4'   , 0x0335 , 0x2084   , 0x0000),
	DEADTRANS( L'5'   , 0x0335 , 0x2085   , 0x0000),
	DEADTRANS( L'6'   , 0x0335 , 0x2086   , 0x0000),
	DEADTRANS( L'7'   , 0x0335 , 0x2087   , 0x0000),
	DEADTRANS( L'8'   , 0x0335 , 0x2088   , 0x0000),
	DEADTRANS( L'9'   , 0x0335 , 0x2089   , 0x0000),
	DEADTRANS( L'0'   , 0x0335 , 0x2080   , 0x0000),
	DEADTRANS( L'+'   , 0x0335 , 0x208a   , 0x0000),
	DEADTRANS( L'-'   , 0x0335 , 0x208b   , 0x0000),
	DEADTRANS( L'='   , 0x0335 , 0x208c   , 0x0000),
	DEADTRANS( L'('   , 0x0335 , 0x208d   , 0x0000),
	DEADTRANS( L')'   , 0x0335 , 0x208e   , 0x0000),
	DEADTRANS( L'x'   , 0x0335 , 0x2093   , 0x0000),
	DEADTRANS( L' '   , 0x0335 , 0x0335   , 0x0000),
	
	DEADTRANS( L' '   , 0x00b7 , 0x00b7   , 0x0000),	//DOT_MID
	
	DEADTRANS( L'B'   , 0x0323 , 0x1e04   , 0x0000),	//DOT_BELOW
	DEADTRANS( L'b'   , 0x0323 , 0x1e05   , 0x0000),
	DEADTRANS( L'D'   , 0x0323 , 0x1e0c   , 0x0000),
	DEADTRANS( L'd'   , 0x0323 , 0x1e0d   , 0x0000),
	DEADTRANS( L'H'   , 0x0323 , 0x1e24   , 0x0000),
	DEADTRANS( L'h'   , 0x0323 , 0x1e25   , 0x0000),
	DEADTRANS( L'K'   , 0x0323 , 0x1e32   , 0x0000),
	DEADTRANS( L'k'   , 0x0323 , 0x1e33   , 0x0000),
	DEADTRANS( L'L'   , 0x0323 , 0x1e36   , 0x0000),
	DEADTRANS( L'l'   , 0x0323 , 0x1e37   , 0x0000),
	DEADTRANS( L'M'   , 0x0323 , 0x1e42   , 0x0000),
	DEADTRANS( L'm'   , 0x0323 , 0x1e43   , 0x0000),
	DEADTRANS( L'N'   , 0x0323 , 0x1e46   , 0x0000),
	DEADTRANS( L'n'   , 0x0323 , 0x1e47   , 0x0000),
	DEADTRANS( L'R'   , 0x0323 , 0x1e5a   , 0x0000),
	DEADTRANS( L'r'   , 0x0323 , 0x1e5b   , 0x0000),
	DEADTRANS( L'S'   , 0x0323 , 0x1e62   , 0x0000),
	DEADTRANS( L's'   , 0x0323 , 0x1e63   , 0x0000),
	DEADTRANS( L'T'   , 0x0323 , 0x1e6c   , 0x0000),
	DEADTRANS( L't'   , 0x0323 , 0x1e6d   , 0x0000),
	DEADTRANS( L'V'   , 0x0323 , 0x1e7e   , 0x0000),
	DEADTRANS( L'v'   , 0x0323 , 0x1e7f   , 0x0000),
	DEADTRANS( L'W'   , 0x0323 , 0x1e88   , 0x0000),
	DEADTRANS( L'w'   , 0x0323 , 0x1e89   , 0x0000),
	DEADTRANS( L'Z'   , 0x0323 , 0x1e92   , 0x0000),
	DEADTRANS( L'z'   , 0x0323 , 0x1e93   , 0x0000),
	DEADTRANS( L'A'   , 0x0323 , 0x1ea0   , 0x0000),
	DEADTRANS( L'a'   , 0x0323 , 0x1ea1   , 0x0000),
	DEADTRANS( L'E'   , 0x0323 , 0x1eb8   , 0x0000),
	DEADTRANS( L'e'   , 0x0323 , 0x1eb9   , 0x0000),
	DEADTRANS( L'I'   , 0x0323 , 0x1eca   , 0x0000),
	DEADTRANS( L'i'   , 0x0323 , 0x1ecb   , 0x0000),
	DEADTRANS( L'O'   , 0x0323 , 0x1ecc   , 0x0000),
	DEADTRANS( L'o'   , 0x0323 , 0x1ecd   , 0x0000),
	DEADTRANS( L'Y'   , 0x0323 , 0x1ef4   , 0x0000),
	DEADTRANS( L'y'   , 0x0323 , 0x1ef5   , 0x0000),
	DEADTRANS( L' '   , 0x0323 , 0x0323   , 0x0000),
// Ende der Taste links neben der 1
// Anfang der Tasten zwei rechts neben der 0
    DEADTRANS( L'a'   , 0x0301 , 0x00e1 , 0x0000),	//AKUT
    DEADTRANS( L'e'   , 0x0301 , 0x00e9 , 0x0000),
    DEADTRANS( L'i'   , 0x0301 , 0x00ed , 0x0000),
    DEADTRANS( L'o'   , 0x0301 , 0x00f3 , 0x0000),
    DEADTRANS( L'u'   , 0x0301 , 0x00fa , 0x0000),
    DEADTRANS( L'y'   , 0x0301 , 0x00fd , 0x0000),
    DEADTRANS( L'A'   , 0x0301 , 0x00c1 , 0x0000),
    DEADTRANS( L'E'   , 0x0301 , 0x00c9 , 0x0000),
    DEADTRANS( L'I'   , 0x0301 , 0x00cd , 0x0000),
    DEADTRANS( L'O'   , 0x0301 , 0x00d3 , 0x0000),
    DEADTRANS( L'U'   , 0x0301 , 0x00da , 0x0000),
    DEADTRANS( L'Y'   , 0x0301 , 0x00dd , 0x0000),
	DEADTRANS( L'C'   , 0x0301 , 0x0106 , 0x0000),
    DEADTRANS( L'c'   , 0x0301 , 0x0106 , 0x0000),
	DEADTRANS( L'L'   , 0x0301 , 0x0139 , 0x0000),
    DEADTRANS( L'l'   , 0x0301 , 0x013a , 0x0000),
	DEADTRANS( L'N'   , 0x0301 , 0x0143 , 0x0000),
    DEADTRANS( L'n'   , 0x0301 , 0x0144 , 0x0000),
	DEADTRANS( L'R'   , 0x0301 , 0x0154 , 0x0000),
    DEADTRANS( L'r'   , 0x0301 , 0x0155 , 0x0000),
	DEADTRANS( L'S'   , 0x0301 , 0x015a , 0x0000),
    DEADTRANS( L's'   , 0x0301 , 0x015b , 0x0000),
	DEADTRANS( L'Z'   , 0x0301 , 0x0179 , 0x0000),
    DEADTRANS( L'z'   , 0x0301 , 0x017a , 0x0000),
	DEADTRANS( 0x00fc , 0x0301 , 0x01d8 , 0x0000),
	DEADTRANS( 0x00dc , 0x0301 , 0x01d7 , 0x0000),
	DEADTRANS( L'G'   , 0x0301 , 0x01f4 , 0x0000),
    DEADTRANS( L'g'   , 0x0301 , 0x01f5 , 0x0000),
	DEADTRANS( L'K'   , 0x0301 , 0x1e30 , 0x0000),
    DEADTRANS( L'k'   , 0x0301 , 0x1e31 , 0x0000),
	DEADTRANS( L'M'   , 0x0301 , 0x1e3e , 0x0000),
    DEADTRANS( L'm'   , 0x0301 , 0x1e3f , 0x0000),
	DEADTRANS( L'P'   , 0x0301 , 0x1e54 , 0x0000),
    DEADTRANS( L'p'   , 0x0301 , 0x1e55 , 0x0000),
	DEADTRANS( L'W'   , 0x0301 , 0x1e82 , 0x0000),
    DEADTRANS( L'w'   , 0x0301 , 0x1e83 , 0x0000),
	DEADTRANS( L' '   , 0x0301 , 0x0301 , 0x0000),

    DEADTRANS( L'a'   , 0x0300 , 0x00e0 , 0x0000),	//GRAVIS
    DEADTRANS( L'e'   , 0x0300 , 0x00e8 , 0x0000),
    DEADTRANS( L'i'   , 0x0300 , 0x00ec , 0x0000),
    DEADTRANS( L'o'   , 0x0300 , 0x00f2 , 0x0000),
    DEADTRANS( L'u'   , 0x0300 , 0x00f9 , 0x0000),
    DEADTRANS( L'A'   , 0x0300 , 0x00c0 , 0x0000),
    DEADTRANS( L'E'   , 0x0300 , 0x00c8 , 0x0000),
    DEADTRANS( L'I'   , 0x0300 , 0x00cc , 0x0000),
    DEADTRANS( L'O'   , 0x0300 , 0x00d2 , 0x0000),
    DEADTRANS( L'U'   , 0x0300 , 0x00d9 , 0x0000),
    DEADTRANS( 0x00dc , 0x0300 , 0x01db , 0x0000),
	DEADTRANS( 0x00fc , 0x0300 , 0x01dc , 0x0000),
	DEADTRANS( L'N'   , 0x0300 , 0x01f8 , 0x0000),
	DEADTRANS( L'n'   , 0x0300 , 0x01f9 , 0x0000),
	DEADTRANS( L'W'   , 0x0300 , 0x1e80 , 0x0000),
	DEADTRANS( L'w'   , 0x0300 , 0x1e81 , 0x0000),
	DEADTRANS( L'Y'   , 0x0300 , 0x1ef2 , 0x0000),
	DEADTRANS( L'y'   , 0x0300 , 0x1ef3 , 0x0000),
	DEADTRANS( L' '   , 0x0300 , 0x0300 , 0x0000),
	
	DEADTRANS( L'C'   , 0x0327 , 0x00c7 , 0x0000),	//CEDILLA
	DEADTRANS( L'c'   , 0x0327 , 0x00e7 , 0x0000),
	DEADTRANS( L'G'   , 0x0327 , 0x0122 , 0x0000),
	DEADTRANS( L'g'   , 0x0327 , 0x0123 , 0x0000),
	DEADTRANS( L'K'   , 0x0327 , 0x0136 , 0x0000),
	DEADTRANS( L'k'   , 0x0327 , 0x0137 , 0x0000),
	DEADTRANS( L'L'   , 0x0327 , 0x013b , 0x0000),
	DEADTRANS( L'l'   , 0x0327 , 0x013c , 0x0000),
	DEADTRANS( L'N'   , 0x0327 , 0x0145 , 0x0000),
	DEADTRANS( L'n'   , 0x0327 , 0x0146 , 0x0000),
	DEADTRANS( L'R'   , 0x0327 , 0x0156 , 0x0000),
	DEADTRANS( L'r'   , 0x0327 , 0x0157 , 0x0000),
	DEADTRANS( L'S'   , 0x0327 , 0x015e , 0x0000),
	DEADTRANS( L's'   , 0x0327 , 0x015f , 0x0000),
	DEADTRANS( L'T'   , 0x0327 , 0x0162 , 0x0000),
	DEADTRANS( L't'   , 0x0327 , 0x0163 , 0x0000),
	DEADTRANS( L'E'   , 0x0327 , 0x0228 , 0x0000),
	DEADTRANS( L'e'   , 0x0327 , 0x0229 , 0x0000),
	DEADTRANS( L'D'   , 0x0327 , 0x1e10 , 0x0000),
	DEADTRANS( L'd'   , 0x0327 , 0x1e11 , 0x0000),
	DEADTRANS( L'H'   , 0x0327 , 0x1e28 , 0x0000),
	DEADTRANS( L'h'   , 0x0327 , 0x1e29 , 0x0000),
	DEADTRANS( L' '   , 0x0327 , 0x0327 , 0x0000),
		
	DEADTRANS( L'A'   , 0x0328 , 0x0104 , 0x0000),	//OGONEK
	DEADTRANS( L'a'   , 0x0328 , 0x0105 , 0x0000),
	DEADTRANS( L'E'   , 0x0328 , 0x0118 , 0x0000),
	DEADTRANS( L'e'   , 0x0328 , 0x0119 , 0x0000),
	DEADTRANS( L'I'   , 0x0328 , 0x012e , 0x0000),
	DEADTRANS( L'i'   , 0x0328 , 0x012f , 0x0000),
	DEADTRANS( L'U'   , 0x0328 , 0x0172 , 0x0000),
	DEADTRANS( L'u'   , 0x0328 , 0x0173 , 0x0000),
	DEADTRANS( L'O'   , 0x0328 , 0x01ea , 0x0000),
	DEADTRANS( L'o'   , 0x0328 , 0x01eb , 0x0000),
	DEADTRANS( L' '   , 0x0328 , 0x0328 , 0x0000),
	
	DEADTRANS( L'C'   , 0x0307 , 0x010a , 0x0000),	//DOT_ABOVE
	DEADTRANS( L'c'   , 0x0307 , 0x010b , 0x0000),
	DEADTRANS( L'E'   , 0x0307 , 0x0116 , 0x0000),
	DEADTRANS( L'e'   , 0x0307 , 0x0117 , 0x0000),
	DEADTRANS( L'G'   , 0x0307 , 0x0120 , 0x0000),
	DEADTRANS( L'g'   , 0x0307 , 0x0121 , 0x0000),
	DEADTRANS( L'I'   , 0x0307 , 0x0130 , 0x0000),
	DEADTRANS( L'i'   , 0x0307 , 0x0131 , 0x0000),
	DEADTRANS( L'Z'   , 0x0307 , 0x017b , 0x0000),
	DEADTRANS( L'z'   , 0x0307 , 0x017c , 0x0000),
	DEADTRANS( L'A'   , 0x0307 , 0x0226 , 0x0000),
	DEADTRANS( L'a'   , 0x0307 , 0x0227 , 0x0000),
	DEADTRANS( L'O'   , 0x0307 , 0x022e , 0x0000),
	DEADTRANS( L'o'   , 0x0307 , 0x022f , 0x0000),
	DEADTRANS( L'B'   , 0x0307 , 0x1e02 , 0x0000),
	DEADTRANS( L'b'   , 0x0307 , 0x1e03 , 0x0000),
	DEADTRANS( L'D'   , 0x0307 , 0x1e0a , 0x0000),
	DEADTRANS( L'd'   , 0x0307 , 0x1e0b , 0x0000),
	DEADTRANS( L'F'   , 0x0307 , 0x1e1e , 0x0000),
	DEADTRANS( L'f'   , 0x0307 , 0x1e1f , 0x0000),
	DEADTRANS( L'H'   , 0x0307 , 0x1e22 , 0x0000),
	DEADTRANS( L'h'   , 0x0307 , 0x1e23 , 0x0000),
	DEADTRANS( L'M'   , 0x0307 , 0x1e40 , 0x0000),
	DEADTRANS( L'm'   , 0x0307 , 0x1e41 , 0x0000),
	DEADTRANS( L'N'   , 0x0307 , 0x1e44 , 0x0000),
	DEADTRANS( L'n'   , 0x0307 , 0x1e45 , 0x0000),
	DEADTRANS( L'P'   , 0x0307 , 0x1e56 , 0x0000),
	DEADTRANS( L'p'   , 0x0307 , 0x1e57 , 0x0000),
	DEADTRANS( L'R'   , 0x0307 , 0x1e58 , 0x0000),
	DEADTRANS( L'r'   , 0x0307 , 0x1e59 , 0x0000),
	DEADTRANS( L'S'   , 0x0307 , 0x1e60 , 0x0000),
	DEADTRANS( L's'   , 0x0307 , 0x1e61 , 0x0000),
	DEADTRANS( L'T'   , 0x0307 , 0x1e6a , 0x0000),
	DEADTRANS( L't'   , 0x0307 , 0x1e6b , 0x0000),
	DEADTRANS( L'W'   , 0x0307 , 0x1e86 , 0x0000),
	DEADTRANS( L'w'   , 0x0307 , 0x1e87 , 0x0000),
	DEADTRANS( L'X'   , 0x0307 , 0x1e8a , 0x0000),
	DEADTRANS( L'x'   , 0x0307 , 0x1e8b , 0x0000),
	DEADTRANS( L'Y'   , 0x0307 , 0x1e8e , 0x0000),
	DEADTRANS( L'y'   , 0x0307 , 0x1e8f , 0x0000),
	DEADTRANS( L' '   , 0x0307 , 0x0307 , 0x0000),
	
	DEADTRANS( L'E'   , 0x030a , 0x0116 , 0x0000),	//RING
	DEADTRANS( L'e'   , 0x030a , 0x030a , 0x0000),
	DEADTRANS( L'e'   , 0x030a , 0x030a , 0x0000),
	
	
	DEADTRANS( L'e'   , 0x030a , 0x030a , 0x0000),
	
	
	
	
	
	
	
	
	
	
// Ende der Tasten zwei rechts neben der 0
//Fehlt noch viel :(	
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
