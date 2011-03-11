/****************************************************************************\
* Module Name: KBD_MOD.H
* Änderungen an der KBD.H für das deutsches ergonomische Layout Neo 2.0
\****************************************************************************/

#undef DEADTRANS(ch, accent, comp, flags)
#define DEADTRANS(accent, ch, comp, flags) { MAKELONG(ch, accent), comp, flags}