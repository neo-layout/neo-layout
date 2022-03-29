/****************************************************************************\
* Module Name: KBD_MOD.H
* Änderungen an der KBD.H für Neo 2.0 oder darauf basierende Layouts
\****************************************************************************/

#undef DEADTRANS
#define DEADTRANS(accent, ch, comp, flags) { MAKELONG(ch, accent), comp, flags}