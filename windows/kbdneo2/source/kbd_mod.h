/****************************************************************************\
* Module Name: KBD_MOD.H
* �nderungen an der KBD.H f�r Neo 2.0 oder darauf basierende Layouts
\****************************************************************************/

#undef DEADTRANS
#define DEADTRANS(accent, ch, comp, flags) { MAKELONG(ch, accent), comp, flags}