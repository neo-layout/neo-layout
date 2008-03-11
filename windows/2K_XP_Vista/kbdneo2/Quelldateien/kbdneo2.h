/****************************** Module Header ******************************\
* Module Name: KBDNEO2.H
*
* keyboard layout header for NEO German
*
* Various defines for use by keyboard input code.
*
* History: Ver 0.1
*
\***************************************************************************/

/*
 * kbd type should be controlled by cl command-line argument
 */
#define KBD_TYPE 4

/*
* Include the basis of all keyboard table values
*/
#include "kbd.h"
#include <dontuse.h>
/***************************************************************************\
* The table below defines the virtual keys for various keyboard types where
* the keyboard differ from the US keyboard.
*
* _EQ() : all keyboard types have the same virtual key for this scancode
* _NE() : different virtual keys for this scancode, depending on kbd type
*
*     +------+ +----------+----------+----------+----------+----------+----------+
*     | Scan | |    kbd   |    kbd   |    kbd   |    kbd   |    kbd   |    kbd   |
*     | code | |   type 1 |   type 2 |   type 3 |   type 4 |   type 5 |   type 6 |
\****+-------+_+----------+----------+----------+----------+----------+----------+*/

#undef  T0D
#define T0D _EQ(                           OEM_2                     )
#undef  T10
#define T10 _EQ(                           'X'                       )
#undef  T11
#define T11 _EQ(                           'V'                       )
#undef  T12
#define T12 _EQ(                           'L'                       )
#undef  T13
#define T13 _EQ(                           'C'                       )
#undef  T14
#define T14 _EQ(                           'W'                       )
#undef  T15
#define T15 _EQ(                           'K'                       )
#undef  T16
#define T16 _EQ(                           'H'                       )
#undef  T17
#define T17 _EQ(                           'G'                       )
#undef  T18
#define T18 _EQ(                           'F'                       )
#undef  T19
#define T19 _EQ(                           'Q'                       )
#undef  T1A
#define T1A _EQ(                           OEM_3                     )
#undef  T1B
#define T1B _EQ(                           OEM_4                     )
#undef  T1E
#define T1E _EQ(                           'U'                       )
#undef  T1F
#define T1F _EQ(                           'I'                       )
#undef  T20
#define T20 _EQ(                           'A'                       )
#undef  T21
#define T21 _EQ(                           'E'                       )
#undef  T22
#define T22 _EQ(                           'O'                       )
#undef  T23
#define T23 _EQ(                           'S'                       )
#undef  T24
#define T24 _EQ(                           'N'                       )
#undef  T25
#define T25 _EQ(                           'R'                       )
#undef  T26
#define T26 _EQ(                           'T'                       )
#undef  T27
#define T27 _EQ(                           'D'                       )
#undef  T28
#define T28 _EQ(                           'Y'                       )
#undef  T29
#define T29 _EQ(                           OEM_1                     )
#undef  T2B
#define T2B _EQ(                           KANA                      ) // Mod 3
// #define T2B _EQ(                           OEM_ROYA                  )
#undef  T2C
#define T2C _EQ(                           OEM_5                     )
#undef  T2D
#define T2D _EQ(                           OEM_6                     )
#undef  T2E
#define T2E _EQ(                           OEM_7                     )
#undef  T2F
#define T2F _EQ(                           'P'                       )
#undef  T30
#define T30 _EQ(                           'Z'                       )
#undef  T31
#define T31 _EQ(                           'B'                       )
#undef  T35
#define T35 _EQ(                           'J'                       )
#undef  T3A
#define T3A _EQ(                           KANA                      )// Mod 3
// #define T3A _EQ(                           OEM_ROYA                  )
#undef  X38
#define X38 _EQ(                           RMENU                     )// Mod 5
// #define X38 _EQ(                           OEM_102                     )
#undef  T56
#define T56 _EQ(                           RMENU                     )// Mod 5
// #define T56 _EQ(                           OEM_102                     )