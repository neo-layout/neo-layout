#!/usr/bin/env python
# -*- coding: utf-8 -*-

"""OSD Neo2
   ========
   On screen display for learning the keyboard layout Neo2

   Copyright (c) 2009 Martin Zuther (http://www.mzuther.de/)

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

import pygtk
pygtk.require('2.0')
import gtk
import gobject

import gettext
import locale
import os
import time

import SimpleXkbWrapper
from optparse import OptionParser
from Settings import *

# set standard localisation for application
locale.setlocale(locale.LC_ALL, '')

# initialise localisation settings
module_path = os.path.dirname(os.path.realpath(__file__))
gettext.bindtextdomain('OSDneo2', os.path.join(module_path, 'po/'))
gettext.textdomain('OSDneo2')
_ = gettext.lgettext

# specifies distance between main keyboard and numeric keyboard (in pixels)
DISTANCE_LAYOUT_BLOCKS = 10

class OSDneo2:
    # layer matrix for "xkbdmap" with disabled Locks (plain)
    #
    # |-----------+----------+---------|
    # | Shift off | Mod4 off | Mod4 on |
    # |-----------+----------+---------|
    # | Mod3 off  |        1 |       4 |
    # | Mod3 on   |        3 |       6 |
    # |-----------+----------+---------|
    # | Shift on  | Mod4 off | Mod4 on |
    # |-----------+----------+---------|
    # | Mod3 off  |        2 |       0 |
    # | Mod3 on   |        5 |       0 |
    # |-----------+----------+---------|
    xkbdmap_layers_plain = {'   ': 1, \
                            ' 3 ': 3, \
                            '  4': 4, \
                            ' 34': 6, \
                            'S  ': 2, \
                            'S3 ': 5, \
                            'S 4': 0, \
                            'S34': 0}

    # layer matrix for "xkbdmap" with enabled Caps Lock
    #
    # |-----------+----------+---------|
    # | Shift off | Mod4 off | Mod4 on |
    # |-----------+----------+---------|
    # | Mod3 off  |        7 |       4 |
    # | Mod3 on   |        3 |       6 |
    # |-----------+----------+---------|
    # | Shift on  | Mod4 off | Mod4 on |
    # |-----------+----------+---------|
    # | Mod3 off  |        8 |       0 |
    # | Mod3 on   |        5 |       0 |
    # |-----------+----------+---------|
    xkbdmap_layers_caps_lock = {'   ': 7, \
                                ' 3 ': 3, \
                                '  4': 4, \
                                ' 34': 6, \
                                'S  ': 8, \
                                'S3 ': 5, \
                                'S 4': 0, \
                                'S34': 0}

    # layer matrix for "xkbdmap" with enabled Mod4 Lock
    #
    # |-----------+----------+---------|
    # | Shift off | Mod4 off | Mod4 on |
    # |-----------+----------+---------|
    # | Mod3 off  |        4 |       1 |
    # | Mod3 on   |        6 |       3 |
    # |-----------+----------+---------|
    # | Shift on  | Mod4 off | Mod4 on |
    # |-----------+----------+---------|
    # | Mod3 off  |        0 |       2 |
    # | Mod3 on   |        0 |       5 |
    # |-----------+----------+---------|
    xkbdmap_layers_mod4_lock = {'   ': 4, \
                                ' 3 ': 6, \
                                '  4': 1, \
                                ' 34': 3, \
                                'S  ': 0, \
                                'S3 ': 0, \
                                'S 4': 2, \
                                'S34': 5}

    # layer matrix for "xkbdmap" with enabled Caps+Mod4 Lock
    #
    # |-----------+----------+---------|
    # | Shift off | Mod4 off | Mod4 on |
    # |-----------+----------+---------|
    # | Mod3 off  |        4 |       7 |
    # | Mod3 on   |        6 |       3 |
    # |-----------+----------+---------|
    # | Shift on  | Mod4 off | Mod4 on |
    # |-----------+----------+---------|
    # | Mod3 off  |        0 |       8 |
    # | Mod3 on   |        0 |       5 |
    # |-----------+----------+---------|
    xkbdmap_layers_caps_mod4_lock = {'   ': 4, \
                                     ' 3 ': 6, \
                                     '  4': 7, \
                                     ' 34': 3, \
                                     'S  ': 0, \
                                     'S3 ': 0, \
                                     'S 4': 8, \
                                     'S34': 5}

    # layer matrix for "xmodmap" with disabled Locks (plain)
    #
    # |-----------+----------+---------|
    # | Shift off | Mod4 off | Mod4 on |
    # |-----------+----------+---------|
    # | Mod3 off  |        1 |       4 |
    # | Mod3 on   |        3 |       6 |
    # |-----------+----------+---------|
    # | Shift on  | Mod4 off | Mod4 on |
    # |-----------+----------+---------|
    # | Mod3 off  |        2 |       0 |
    # | Mod3 on   |        5 |       6 |
    # |-----------+----------+---------|
    xmodmap_layers_plain = {'   ': 1, \
                            ' 3 ': 3, \
                            '  4': 4, \
                            ' 34': 6, \
                            'S  ': 2, \
                            'S3 ': 5, \
                            'S 4': 0, \
                            'S34': 6}

    # layer matrix for "xmodmap" with enabled Caps Lock
    #
    # |-----------+----------+---------|
    # | Shift off | Mod4 off | Mod4 on |
    # |-----------+----------+---------|
    # | Mod3 off  |        2 |       0 |
    # | Mod3 on   |        5 |       6 |
    # |-----------+----------+---------|
    # | Shift on  | Mod4 off | Mod4 on |
    # |-----------+----------+---------|
    # | Mod3 off  |        2 |       0 |
    # | Mod3 on   |        5 |       6 |
    # |-----------+----------+---------|
    xmodmap_layers_caps_lock = {'   ': 2, \
                                ' 3 ': 5, \
                                '  4': 0, \
                                ' 34': 6, \
                                'S  ': 2, \
                                'S3 ': 5, \
                                'S 4': 0, \
                                'S34': 6}

    # layer matrix for "xmodmap" with enabled Mod4 Lock
    #
    # |-----------+----------+---------|
    # | Shift off | Mod4 off | Mod4 on |
    # |-----------+----------+---------|
    # | Mod3 off  |        4 |       4 |
    # | Mod3 on   |        3 |       6 |
    # |-----------+----------+---------|
    # | Shift on  | Mod4 off | Mod4 on |
    # |-----------+----------+---------|
    # | Mod3 off  |        0 |       0 |
    # | Mod3 on   |        5 |       6 |
    # |-----------+----------+---------|
    xmodmap_layers_mod4_lock = {'   ': 4, \
                                ' 3 ': 3, \
                                '  4': 4, \
                                ' 34': 6, \
                                'S  ': 0, \
                                'S3 ': 5, \
                                'S 4': 0, \
                                'S34': 6}

    # layer matrix for "xmodmap" with enabled Caps+Mod4 Lock
    #
    # |-----------+----------+---------|
    # | Shift off | Mod4 off | Mod4 on |
    # |-----------+----------+---------|
    # | Mod3 off  |        0 |       0 |
    # | Mod3 on   |        5 |       5 |
    # |-----------+----------+---------|
    # | Shift on  | Mod4 off | Mod4 on |
    # |-----------+----------+---------|
    # | Mod3 off  |        0 |       0 |
    # | Mod3 on   |        5 |       5 |
    # |-----------+----------+---------|
    xmodmap_layers_caps_mod4_lock = {'   ': 0, \
                                     ' 3 ': 5, \
                                     '  4': 0, \
                                     ' 34': 5, \
                                     'S  ': 0, \
                                     'S3 ': 5, \
                                     'S 4': 0, \
                                     'S34': 5}


    def __init__(self):
        # initialise version information, ...
        version_long = _('%(description)s\n%(copyrights)s\n\n%(license)s') % \
            {'description':settings.get_description(True), \
                 'copyrights':settings.get_copyrights(), \
                 'license':settings.get_license(True)}
        # ... ,usage information and...
        usage = 'Usage: %(cmd_line)s [options]' % \
            {'cmd_line':settings.get_variable('cmd_line')}
        # ... the command line parser itself
        parser = OptionParser(usage=usage, version=version_long)

        # parse command line
        (options, args) = parser.parse_args()

        # setting: display main keyboard (Boolean)
        self.display_main_keyboard = (settings.get( \
                'settings', 'display_main_keyboard', str(True)) == "True")

        # setting: display numeric keyboard (Boolean)
        self.display_numeric_keyboard = (settings.get( \
                'settings', 'display_numeric_keyboard', str(True)) == "True")

        # setting: magnification of keyboard (in percent)
        self.magnification = int(settings.get( \
                'settings', 'magnification_in_percent', str(100)))

        # setting: interval of update timer (in milliseconds)
        self.polling = int(settings.get( \
                'settings', 'polling_in_milliseconds', str(100)))

        # setting: selected driver ("xkbdmap" or "xmodmap")
        self.keyboard_driver = settings.get( \
            'settings', 'selected_keyboard_driver', 'xkbdmap')

        # initialise core keyboard
        self.initialise_keyboard()

        # set currently selected keyboard layer to defaults (for your
        # information, "leer" is German for "empty")
        self.current_modifier = 'leer'
        self.mod_states = None

        # create main window and set its title
        self.window = gtk.Window(gtk.WINDOW_TOPLEVEL)
        self.window.set_title(settings.get_description(False))

        # allow window to get killed and keep it on top
        self.window.connect('delete-event', self.on_delete_event)
        self.window.set_keep_above(True)

        # restore old window position
        x = int(settings.get('settings', 'window_position_x', str(0)))
        y = int(settings.get('settings', 'window_position_y', str(0)))
        if (x > 0) and (y > 0):
            self.window.move(x, y)

        # create an HBox, ...
        self.hbox = gtk.HBox(False, DISTANCE_LAYOUT_BLOCKS)
        self.window.add(self.hbox)

        # ..., attach image for main keyboard (if requested) ...
        if self.display_main_keyboard:
            self.image_main = gtk.Image()
            self.hbox.pack_start(self.image_main)

        # ... and attach image for numeric keyboard (if requested)
        if self.display_numeric_keyboard:
            self.image_numeric = gtk.Image()
            self.hbox.pack_start(self.image_numeric)

        # the window size depends on the loaded images and
        # "self.magnification", so we'll set it later
        self.window_width = -1
        self.window_height = -1

        # later on, the keyboard layout will only be drawn when the
        # selected keyboard layer changes, so we'll force the initial
        # drawing
        self.update_display()

        # show everything in window
        self.window.show_all()

        # update status of modifier leys once ...
        self.update_status()

        # ... before starting the timer for polling modifier keys
        gobject.timeout_add(self.polling, self.update_status)


    def main(self):
        # main event loop
        gtk.main()


    def on_delete_event(self, widget, event, data=None):
        # store current window position, ...
        (x,y) = self.window.get_position()
        settings.set('settings', 'window_position_x', str(x))
        settings.set('settings', 'window_position_y', str(y))

        # ... and quit the application
        gtk.main_quit()
        return False


    def initialise_keyboard(self):
        # initialise wrapper for the X Keyboard Extension (v1.0) and
        # open connection to X display
        self.xkb = SimpleXkbWrapper.SimpleXkbWrapper()

        # we'll use the default X display
        display_name = None

        # we need version 1.0 of the X Keyboard Extension
        major_in_out = 1
        minor_in_out = 0

        # open X display and check for compatible X Keyboard Extension
        try:
            ret = self.xkb.XkbOpenDisplay(display_name, major_in_out, \
                                              minor_in_out)
        except OSError, error:
            self.error_dialog(_('Error'), error)

        # store handle to X display for later use
        self.display_handle = ret['display_handle']


    def update_status(self):
        """
        This function is called by the timer in order to check the
        status of modifier keys.
        """

        # we only have to update the main window if the modifier
        # states have changed, so store the current modifier states
        old_mod_states = self.mod_states

        # select the core keyboard ...
        device_spec = self.xkb.XkbUseCoreKbd

        # ... and poll modifier state
        xkbstaterec = self.xkb.XkbGetState(self.display_handle, device_spec)
        self.mod_states = self.xkb.ExtractLocks(xkbstaterec)

        # as promised above, we'll only update the main window if the
        # modifier states have changed
        if self.mod_states != old_mod_states:
            self.set_current_modifier()

        # keep the timer running
        return True


    def set_current_modifier(self):
        # we'll keep CPU usage low by updating the main window only
        # when the selected keyboard layer has changed, so let's store
        # the currently selected keyboard layer
        old_modifier = self.current_modifier

        # please don't confuse the modifiers defined by Neo2 ("MOD3"
        # in the following section) with modifiers defined by X11
        # ("mod3") -- let's set the modifiers for accessing the layer
        # matrices

        # user selected Neo2 keyboard driver "xkbdmap"
        if self.keyboard_driver == 'xkbdmap':
            if self.mod_states['shift']:
                SHIFT = 'S'
            else:
                SHIFT = ' '

            if self.mod_states['mod5']:
                MOD3 = '3'
            else:
                MOD3 = ' '

            if self.mod_states['mod3']:
                MOD4 = '4'
            else:
                MOD4 = ' '

            # get status of locks
            CAPS_LOCK = self.mod_states['lock_lock']
            MOD4_LOCK = self.mod_states['mod2_lock']
        # user selected Neo2 keyboard driver "xmodmap"
        elif self.keyboard_driver == 'xmodmap':
            if self.mod_states['shift']:
                SHIFT = 'S'
            else:
                SHIFT = ' '

            if self.mod_states['mod3']:
                MOD4 = '4'
            else:
                MOD4 = ' '

            if self.mod_states['group'] == 0:
                MOD3 = ' '
            elif self.mod_states['group'] == 1:
                MOD3 = '3'
            elif self.mod_states['group'] == 2:
                MOD3 = '3'
                MOD4 = '4'

            # get status of locks
            CAPS_LOCK = self.mod_states['shift_lock']
            MOD4_LOCK = self.mod_states['mod3_lock']
        # user selected invalid Neo2 keyboard driver
        else:
            error = _('Invalid keyboard driver "%s" selected.') % \
                self.keyboard_driver
            self.error_dialog(_('Error'), error)

        # assemble matrix key
        MODIFIERS = '%s%s%s' % (SHIFT, MOD3, MOD4)

        # select correct matrix and get current layer for Neo2
        # keyboard driver "xkbdmap" ...
        if self.keyboard_driver == 'xkbdmap':
            if CAPS_LOCK:
                if MOD4_LOCK:
                    current_modifier_temp = \
                        self.xkbdmap_layers_caps_mod4_lock[MODIFIERS]
                else:
                    current_modifier_temp = \
                        self.xkbdmap_layers_caps_lock[MODIFIERS]
            elif MOD4_LOCK:
                current_modifier_temp = \
                    self.xkbdmap_layers_mod4_lock[MODIFIERS]
            else:
                current_modifier_temp = \
                    self.xkbdmap_layers_plain[MODIFIERS]
        # ... or keyboard driver "xmodmap"
        elif self.keyboard_driver == 'xmodmap':
            if CAPS_LOCK:
                if MOD4_LOCK:
                    current_modifier_temp = \
                        self.xmodmap_layers_caps_mod4_lock[MODIFIERS]
                else:
                    current_modifier_temp = \
                        self.xmodmap_layers_caps_lock[MODIFIERS]
            elif MOD4_LOCK:
                current_modifier_temp = \
                    self.xmodmap_layers_mod4_lock[MODIFIERS]
            else:
                current_modifier_temp = \
                    self.xmodmap_layers_plain[MODIFIERS]
        else:
            error = _('Invalid keyboard driver "%s" selected.') % \
                self.keyboard_driver
            self.error_dialog(_('Error'), error)

        # for your information, "Ebene" is German for "layer", while
        # "leer" is German for "empty"
        if current_modifier_temp < 1:
            self.current_modifier = 'leer'
        # add Caps Lock to layers 1 and 2
        elif current_modifier_temp > 6:
            self.current_modifier = 'ebene%d-caps' % \
                (current_modifier_temp - 6)
        # plain (i.e. no locks)
        else:
            self.current_modifier = 'ebene%d' % current_modifier_temp

        # as promised above, we'll only update the main window if the
        # selected keyboard layer has changed
        if self.current_modifier != old_modifier:
            self.update_display()


    def update_display(self):
        if self.display_main_keyboard:
            # check whether image for main keyboard exists
            path_main = os.path.join(module_path, 'images', \
                                         'neo2-hauptfeld_' + \
                                         self.current_modifier + '.png')
            if not os.path.exists(path_main):
                error = _('The following image file was not found:\n"%s"') % \
                    path_main
                self.error_dialog(_('Error'), error)

            # load image for main keyboard in PixBuf, ...
            pixbuf_main = gtk.gdk.pixbuf_new_from_file(path_main)

            # ... re-size it according to "self.magnification" ...
            if self.magnification != 100:
                pixbuf_main = pixbuf_main.scale_simple( \
                    int(pixbuf_main.get_width() * \
                            self.magnification / 100), \
                        int(pixbuf_main.get_height() * \
                                self.magnification / 100), \
                    gtk.gdk.INTERP_BILINEAR)
            # ... and copy it to the main window
            self.image_main.set_from_pixbuf(pixbuf_main)

        if self.display_numeric_keyboard:
            # check whether image for numeric keyboard exists
            path_numeric = os.path.join(module_path, 'images', \
                                            'neo2-ziffernfeld_' + \
                                            self.current_modifier + '.png')
            if not os.path.exists(path_numeric):
                error = _('The following image file was not found:\n"%s"') % \
                    path_numeric
                self.error_dialog(_('Error'), error)

            # load image for numeric keyboard in PixBuf, ...
            pixbuf_numeric = gtk.gdk.pixbuf_new_from_file(path_numeric)
            # ... re-size it according to "self.magnification" ...
            if self.magnification != 100:
                pixbuf_numeric = pixbuf_numeric.scale_simple( \
                    int(pixbuf_numeric.get_width() * \
                            self.magnification / 100), \
                        int(pixbuf_numeric.get_height() * \
                                self.magnification / 100), \
                    gtk.gdk.INTERP_BILINEAR)
            # ... and copy it to the main window
            self.image_numeric.set_from_pixbuf(pixbuf_numeric)

        # the window size depends on the loaded images and
        # "self.magnification", so we'll set it here if not yet done
        if (self.window_width == -1) or (self.window_height == -1):
            # only main keyboard has been requested
            if self.display_main_keyboard and not self.display_numeric_keyboard:
                self.window_width = pixbuf_main.get_width()
                self.window_height = pixbuf_main.get_height()
            # only numeric keyboard has been requested
            elif self.display_numeric_keyboard and not \
                    self.display_main_keyboard:
                self.window_width = pixbuf_numeric.get_width()
                self.window_height = pixbuf_numeric.get_height()
            # only main and numeric keyboard have been requested
            else:
                self.window_width = pixbuf_main.get_width() + \
                    DISTANCE_LAYOUT_BLOCKS + pixbuf_numeric.get_width()
                # set window height to highest image (in case they differ)
                if pixbuf_main.get_height() >= pixbuf_numeric.get_height():
                    self.window_height = pixbuf_main.get_height()
                else:
                    self.window_height = pixbuf_numeric.get_height()

            # re-size main window accordingly
            self.window.resize(self.window_width, self.window_height)


    def error_dialog(self, title, error):
        # display a dialog with the given error ...
        dialog = gtk.Dialog(title, None, gtk.DIALOG_NO_SEPARATOR, \
                                (gtk.STOCK_OK, gtk.RESPONSE_ACCEPT))
        dialog.vbox.pack_start(gtk.Label(str(error)))
        dialog.show_all()
        dialog.run()
        # ... and exit after user has pressed "Ok"
        exit(1)


if __name__ == '__main__':
    # check whether the script runs with superuser rights
    if (os.getuid() == 0) or (os.getgid() == 0):
        print _('For security reasons you may not run this application with superuser rights.')

    base = OSDneo2()
    base.main()
