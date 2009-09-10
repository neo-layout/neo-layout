#include <stdio.h>
#include <X11/XKBlib.h>

int main(int argc, char *argv[])
{
  int event_rtrn = 0;
  int error_rtrn = 0;
  int major_in_out = 1;
  int minor_in_out = 0;
  int reason_rtrn = 0;

  Display * display = NULL;
  display = XkbOpenDisplay(NULL, &event_rtrn, &error_rtrn, &major_in_out,
					  &minor_in_out, &reason_rtrn);

  printf("\n  Display handle:  %#010x\n", (unsigned int) display);

  XkbStateRec state;
  XkbGetState(display, XkbUseCoreKbd, &state);

  printf("\n  mods:          %x", state.mods);
  printf("\n  base_mods:     %x", state.base_mods);
  printf("\n  latched_mods:  %x", state.latched_mods);
  printf("\n  locked_mods:   %x", state.locked_mods);
  printf("\n  compat_state:  %x", state.compat_state);

  printf("\n\n");
  return 0;
}
