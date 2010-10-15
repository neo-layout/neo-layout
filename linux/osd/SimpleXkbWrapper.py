#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""OSD Neo2
   ========
   On screen display for learning the keyboard layout Neo2

   Copyright (c) 2009-2010 Martin Zuther (http://www.mzuther.de/)

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.

   Thank you for using free software!

"""

# Here follows a plea in German to keep the comments in English so
# that you may understand them, dear visitor ...
#
# Meine Kommentare in den Quellcodes sind absichtlich auf Englisch
# gehalten, damit Leute, die im Internet nach Lösungen suchen, den
# Code nachvollziehen können.  Daher bitte ich darum, zusätzliche
# Kommentare ebenfalls auf Englisch zu schreiben.  Vielen Dank!

import ctypes
import ctypes.util
import gettext
import os
import types

# initialise localisation settings
module_path = os.path.dirname(os.path.realpath(__file__))
gettext.bindtextdomain('OSDneo2', os.path.join(module_path, 'po/'))
gettext.textdomain('OSDneo2')
_ = gettext.lgettext

class SimpleXkbWrapper:
    """
    Far from complete wrapper for the "X Keyboard Extension" (well, to
    be honest, it just wraps what I need using Python's "ctypes"
    library <g>).
    """

    # set this to true to get lots of debugging information (and
    # considerably slow things down)
    DEBUG_XKB = False

    # "C defines" from file /usr/include/X11/extensions/XKB.h (Ubuntu 9.04):
    # $XFree86: xc/include/extensions/XKB.h,v 1.5tsi Exp $
    #
    # XkbUseCoreKbd is used to specify the core keyboard without having to
    # look up its X input extension identifier.

    XkbUseCoreKbd            = 0x0100



    # "C defines" from file /usr/include/X11/XKBlib.h (Ubuntu 9.04):
    # $XFree86: xc/lib/X11/XKBlib.h,v 3.5 2003/04/17 02:06:31 dawes Exp $ #
    #
    # XkbOpenDisplay error codes

    XkbOD_Success            = 0
    XkbOD_BadLibraryVersion  = 1
    XkbOD_ConnectionRefused  = 2
    XkbOD_NonXkbServer       = 3
    XkbOD_BadServerVersion   = 4



    # "C typedef" from file /usr/include/X11/extensions/XKBstr.h (Ubuntu 9.04):
    # $Xorg: XKBstr.h,v 1.3 2000/08/18 04:05:45 coskrey Exp $
    #
    # Common data structures and access macros
    #
    # typedef struct _XkbStateRec {
    #         unsigned char   group;
    #         unsigned char   locked_group;
    #         unsigned short  base_group;
    #         unsigned short  latched_group;
    #         unsigned char   mods;
    #         unsigned char   base_mods;
    #         unsigned char   latched_mods;
    #         unsigned char   locked_mods;
    #         unsigned char   compat_state;
    #         unsigned char   grab_mods;
    #         unsigned char   compat_grab_mods;
    #         unsigned char   lookup_mods;
    #         unsigned char   compat_lookup_mods;
    #         unsigned short  ptr_buttons;
    # } XkbStateRec,*XkbStatePtr;

    class XkbStateRec(ctypes.Structure):
        _fields_ = [
                        ('group',              ctypes.c_ubyte), \
                        ('locked_group',       ctypes.c_ubyte), \
                        ('base_group',         ctypes.c_ushort), \
                        ('latched_group',      ctypes.c_ushort), \
                        ('mods',               ctypes.c_ubyte), \
                        ('base_mods',          ctypes.c_ubyte), \
                        ('latched_mods',       ctypes.c_ubyte), \
                        ('locked_mods',        ctypes.c_ubyte), \
                        ('compat_state',       ctypes.c_ubyte), \
                        ('grab_mods',          ctypes.c_ubyte), \
                        ('compat_grab_mods',   ctypes.c_ubyte), \
                        ('lookup_mods',        ctypes.c_ubyte), \
                        ('compat_lookup_mods', ctypes.c_ubyte), \
                        ('ptr_buttons',        ctypes.c_ushort) \
                   ]



    # "C defines" from file /usr/include/X11/X.h (Ubuntu 9.04):
    # $XFree86: xc/include/X.h,v 1.6 2003/07/09 15:27:28 tsi Exp $
    #
    # Key masks. Used as modifiers to GrabButton and GrabKey, results of
    # QueryPointer, state in various key-, mouse-, and button-related
    # events.

    ShiftMask                = 1
    LockMask                 = 2
    ControlMask              = 4
    Mod1Mask                 = 8
    Mod2Mask                 = 16
    Mod3Mask                 = 32
    Mod4Mask                 = 64
    Mod5Mask                 = 128



    def __init__(self):
        # dynamically link to "X Keyboard Extension" library while at
        # the same time checking which library to use
        xkbd_library_location = ctypes.util.find_library('Xxf86misc')
        if not xkbd_library_location:
            xkbd_library_location = ctypes.util.find_library('X11')

        xkbd_library = ctypes.CDLL(xkbd_library_location)

        # print debugging information if requested
        if self.DEBUG_XKB:
            print
            print '  %s' % xkbd_library



        # define "ctypes" prototype for the function
        #
        # Display *XkbOpenDisplay(display_name, event_rtrn, error_rtrn,
        #                             major_in_out, minor_in_out, reason_rtrn)
        #
        #    char * display_name;
        #    int * event_rtrn;
        #    int * error_rtrn;
        #    int * major_in_out;
        #    int * minor_in_out;
        #    int * reason_rtrn;

        paramflags_xkbopendisplay = \
            (1, 'display_name'), \
            (2, 'event_rtrn'), \
            (2, 'error_rtrn'), \
            (3, 'major_in_out'), \
            (3, 'minor_in_out'), \
            (2, 'reason_rtrn')

        prototype_xkbopendisplay = ctypes.CFUNCTYPE( \
            ctypes.c_uint, \
                ctypes.c_char_p, \
                ctypes.POINTER(ctypes.c_int), \
                ctypes.POINTER(ctypes.c_int), \
                ctypes.POINTER(ctypes.c_int), \
                ctypes.POINTER(ctypes.c_int), \
                ctypes.POINTER(ctypes.c_int) \
                )

        # set-up function (low-level)
        self.__XkbOpenDisplay__ = prototype_xkbopendisplay( \
            ('XkbOpenDisplay', xkbd_library), \
                paramflags_xkbopendisplay \
                )

        # define error handler
        def errcheck_xkbopendisplay(result, func, args):
            # print debugging information if requested
            if self.DEBUG_XKB:
                print
                print '  [XkbOpenDisplay]'
                print '  Display:       %#010x' % result
                print '  display_name:  %s' % args[0].value
                print '  event_rtrn:    %d' % args[1].value
                print '  error_rtrn:    %d' % args[2].value
                print '  major_in_out:  %d' % args[3].value
                print '  minor_in_out:  %d' % args[4].value
                print '  reason_rt:     %d' % args[5].value

            # function didn't return display handle, so let's see why
            # not
            if result == 0:
                # values were taken from file /usr/include/X11/XKBlib.h (Ubuntu 9.04):
                # $XFree86: xc/lib/X11/XKBlib.h,v 3.5 2003/04/17 02:06:31 dawes Exp $ #
                error_id = args[5].value
                if error_id == self.XkbOD_Success:
                    error_name = 'XkbOD_Success'
                elif error_id == self.XkbOD_BadLibraryVersion:
                    error_name = 'XkbOD_BadLibraryVersion'
                elif error_id == self.XkbOD_ConnectionRefused:
                    error_name = 'XkbOD_ConnectionRefused'
                elif error_id == self.XkbOD_NonXkbServer:
                    error_name = 'XkbOD_NonXkbServer'
                elif error_id == self.XkbOD_BadServerVersion:
                    error_name = 'XkbOD_BadServerVersion'
                else:
                    error_name = _('undefined')

                error_message = \
                    _('"XkbOpenDisplay" reported an error (%(error_name)s).') % \
                    {'error_name': error_name}
                raise OSError(error_message)

            # return display handle and all function arguments
            return (ctypes.c_uint(result), args)

        # connect error handler to function
        self.__XkbOpenDisplay__.errcheck = errcheck_xkbopendisplay



        # define "ctypes" prototype for the function
        #
        # Bool XkbGetState(display, device_spec, state_return)
        #
        #     Display *             display;
        #     unsigned int          device_spec;
        #     XkbStatePtr           state_return;

        paramflags_xkbgetstate = \
            (1, 'display'), \
            (1, 'device_spec'), \
            (3, 'state_return')

        prototype_xkbgetstate = ctypes.CFUNCTYPE( \
            ctypes.c_int, # Python 2.5 doesn't yet know c_bool \
                ctypes.c_uint, \
                ctypes.c_uint, \
                ctypes.POINTER(self.XkbStateRec) \
                )

        # set-up function (low-level)
        self.__XkbGetState__ = prototype_xkbgetstate( \
            ('XkbGetState', xkbd_library), \
                paramflags_xkbgetstate \
                )

        # define error handler
        def errcheck_xkbgetstate(result, func, args):
            # print debugging information if requested
            if self.DEBUG_XKB:
                print
                print '  [XkbGetState]'
                print '  Status:        %s' % result
                print '  display:       %#010x' % args[0].value
                print '  device_spec:   %d\n' % args[1].value

                print '  state_return.group:               %d' % \
                    args[2].group
                print '  state_return.locked_group:        %d' % \
                    args[2].locked_group
                print '  state_return.base_group:          %d' % \
                    args[2].base_group
                print '  state_return.latched_group:       %d' % \
                    args[2].latched_group
                print '  state_return.mods:                %d' % \
                    args[2].mods
                print '  state_return.base_mods:           %d' % \
                    args[2].base_mods
                print '  state_return.latched_mods:        %d' % \
                    args[2].latched_mods
                print '  state_return.locked_mods:         %d' % \
                    args[2].locked_mods
                print '  state_return.compat_state:        %d' % \
                    args[2].compat_state
                print '  state_return.grab_mods:           %d' % \
                    args[2].grab_mods
                print '  state_return.compat_grab_mods:    %d' % \
                    args[2].compat_grab_mods
                print '  state_return.lookup_mods:         %d' % \
                    args[2].lookup_mods
                print '  state_return.compat_lookup_mods:  %d' % \
                    args[2].compat_lookup_mods
                print '  state_return.ptr_buttons:         %d\n' % \
                    args[2].ptr_buttons

                print '  Mask          mods   base_mods   latched_mods   locked_mods   compat_state'
                print '  --------------------------------------------------------------------------'
                print '  ShiftMask     %-5s  %-5s       %-5s          %-5s         %-5s' % \
                    ((args[2].mods         & self.ShiftMask) != 0, \
                     (args[2].base_mods    & self.ShiftMask) != 0, \
                     (args[2].latched_mods & self.ShiftMask) != 0, \
                     (args[2].locked_mods  & self.ShiftMask) != 0, \
                     (args[2].compat_state & self.ShiftMask) != 0)

                print '  LockMask      %-5s  %-5s       %-5s          %-5s         %-5s' % \
                    ((args[2].mods         & self.LockMask) != 0, \
                     (args[2].base_mods    & self.LockMask) != 0, \
                     (args[2].latched_mods & self.LockMask) != 0, \
                     (args[2].locked_mods  & self.LockMask) != 0, \
                     (args[2].compat_state & self.LockMask) != 0)

                print '  ControlMask   %-5s  %-5s       %-5s          %-5s         %-5s' % \
                    ((args[2].mods         & self.ControlMask) != 0, \
                     (args[2].base_mods    & self.ControlMask) != 0, \
                     (args[2].latched_mods & self.ControlMask) != 0, \
                     (args[2].locked_mods  & self.ControlMask) != 0, \
                     (args[2].compat_state & self.ControlMask) != 0)

                print '  Mod1Mask      %-5s  %-5s       %-5s          %-5s         %-5s' % \
                    ((args[2].mods         & self.Mod1Mask) != 0, \
                     (args[2].base_mods    & self.Mod1Mask) != 0, \
                     (args[2].latched_mods & self.Mod1Mask) != 0, \
                     (args[2].locked_mods  & self.Mod1Mask) != 0, \
                     (args[2].compat_state & self.Mod1Mask) != 0)

                print '  Mod2Mask      %-5s  %-5s       %-5s          %-5s         %-5s' % \
                    ((args[2].mods         & self.Mod2Mask) != 0, \
                     (args[2].base_mods    & self.Mod2Mask) != 0, \
                     (args[2].latched_mods & self.Mod2Mask) != 0, \
                     (args[2].locked_mods  & self.Mod2Mask) != 0, \
                     (args[2].compat_state & self.Mod2Mask) != 0)

                print '  Mod3Mask      %-5s  %-5s       %-5s          %-5s         %-5s' % \
                    ((args[2].mods         & self.Mod3Mask) != 0, \
                     (args[2].base_mods    & self.Mod3Mask) != 0, \
                     (args[2].latched_mods & self.Mod3Mask) != 0, \
                     (args[2].locked_mods  & self.Mod3Mask) != 0, \
                     (args[2].compat_state & self.Mod3Mask) != 0)

                print '  Mod4Mask      %-5s  %-5s       %-5s          %-5s         %-5s' % \
                    ((args[2].mods         & self.Mod4Mask) != 0, \
                     (args[2].base_mods    & self.Mod4Mask) != 0, \
                     (args[2].latched_mods & self.Mod4Mask) != 0, \
                     (args[2].locked_mods  & self.Mod4Mask) != 0, \
                     (args[2].compat_state & self.Mod4Mask) != 0)

                print '  Mod5Mask      %-5s  %-5s       %-5s          %-5s         %-5s' % \
                    ((args[2].mods         & self.Mod5Mask) != 0, \
                     (args[2].base_mods    & self.Mod5Mask) != 0, \
                     (args[2].latched_mods & self.Mod5Mask) != 0, \
                     (args[2].locked_mods  & self.Mod5Mask) != 0, \
                     (args[2].compat_state & self.Mod5Mask) != 0)

            # return function return value and all function arguments
            return (result, args)

        # connect error handler to function
        self.__XkbGetState__.errcheck = errcheck_xkbgetstate


    # define high-level version of "XkbOpenDisplay"
    def XkbOpenDisplay(self, display_name, major_in_out, minor_in_out):
        # if we don't do type checking, nobody ever will
        assert (type(display_name) == types.NoneType) or \
            (type(display_name) == types.StringType)
        assert type(major_in_out) == types.IntType
        assert type(minor_in_out) == types.IntType

        # convert function arguments to "ctypes", ...
        __display_name__ = ctypes.c_char_p(display_name)
        __major_in_out__ = ctypes.c_int(major_in_out)
        __minor_in_out__ = ctypes.c_int(minor_in_out)

        # ... call low-level function ...
        ret = self.__XkbOpenDisplay__(__display_name__, __major_in_out__, \
                                         __minor_in_out__)

        # ... and return converted return value and function arguments
        return {'display_handle': ret[0].value, \
                    'server_major_version': ret[1][3].value, \
                    'server_minor_version': ret[1][4].value}


    # define high-level version of "XkbGetState"
    def XkbGetState(self, display_handle, device_spec):
        # if we don't do type checking, nobody ever will
        assert type(display_handle) == types.LongType
        assert type(device_spec) == types.IntType

        # convert function arguments to "ctypes", ...
        __display_handle__ = ctypes.c_uint(display_handle)
        __device_spec__ = ctypes.c_uint(device_spec)
        __xkbstaterec__ = self.XkbStateRec()

        # ... call low-level function ...
        ret = self.__XkbGetState__(__display_handle__, __device_spec__, \
                                  __xkbstaterec__)

        # ... and return converted function argument
        xkbstaterec = ret[1][2]
        return xkbstaterec


    # extract modifier status using bitmasks
    def ExtractLocks(self, xkbstaterec):
        return {'group': xkbstaterec.group, \
                'shift': \
                    (xkbstaterec.base_mods & self.ShiftMask) != 0, \
                'shift_lock': \
                    (xkbstaterec.locked_mods & self.ShiftMask) != 0, \
                'lock': \
                    (xkbstaterec.base_mods & self.LockMask) != 0, \
                'lock_lock': \
                    (xkbstaterec.locked_mods & self.LockMask) != 0, \
                'control': \
                    (xkbstaterec.base_mods & self.ControlMask) != 0, \
                'control_lock': \
                    (xkbstaterec.locked_mods & self.ControlMask) != 0, \
                'mod1': \
                    (xkbstaterec.base_mods & self.Mod1Mask) != 0, \
                'mod1_lock': \
                    (xkbstaterec.locked_mods & self.Mod1Mask) != 0, \
                'mod2': \
                    (xkbstaterec.base_mods & self.Mod2Mask) != 0, \
                'mod2_lock': \
                    (xkbstaterec.locked_mods & self.Mod2Mask) != 0, \
                'mod3': \
                    (xkbstaterec.base_mods & self.Mod3Mask) != 0, \
                'mod3_lock': \
                    (xkbstaterec.locked_mods & self.Mod3Mask) != 0, \
                'mod4': \
                    (xkbstaterec.base_mods & self.Mod4Mask) != 0, \
                'mod4_lock': \
                    (xkbstaterec.locked_mods & self.Mod4Mask) != 0, \
                'mod5': \
                    (xkbstaterec.base_mods & self.Mod5Mask) != 0, \
                'mod5_lock': \
                    (xkbstaterec.locked_mods & self.Mod5Mask) != 0}


if __name__ == '__main__':
    # simple demonstration of this wrapper
    xkb = SimpleXkbWrapper()

    # initialise wrapper for the X Keyboard Extension (v1.0) and
    # open connection to default X display
    display_name = None
    major_in_out = 1
    minor_in_out = 0

    try:
        ret = xkb.XkbOpenDisplay(display_name, major_in_out, minor_in_out)
    except OSError, error:
        print
        print '  Error: %s' % error
        print
        exit(1)

    # ... get modifier state of core keyboard ...
    display_handle = ret['display_handle']
    device_spec = xkb.XkbUseCoreKbd
    xkbstaterec = xkb.XkbGetState(display_handle, device_spec)

    # ... and extract and the information we need
    mod_states = xkb.ExtractLocks(xkbstaterec)
    print
    for mod in mod_states:
        print '  %-13s  %s' % (mod + ':', mod_states[mod])
    print
