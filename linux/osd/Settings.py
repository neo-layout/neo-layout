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

import ConfigParser
import gettext
import locale
import os
import types

# initialise localisation settings
module_path = os.path.dirname(os.path.realpath(__file__))
gettext.bindtextdomain('OSDneo2', os.path.join(module_path, 'po/'))
gettext.textdomain('OSDneo2')
_ = gettext.lgettext

class Settings:
    """Store user and application settings in one place and make them available.
    """
    def __init__(self):
        """Initialise user settings and application information.

        Keyword arguments:
        None

        Return value:
        None

        """
        # common application copyrights and information (only set here, private)
        self.__application__ = 'OSD Neo2'
        self.__cmd_line__ = 'OSDneo2'
        self.__version__ = '0.12'
        self.__years__ = '2009'
        self.__authors__ = 'Martin Zuther'
        self.__license_short__ = 'GPL version 3 (or later)'
        self.__license_long__ = """This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

Thank you for using free software!"""
        self.__description__ = _('On screen display for learning the keyboard layout Neo2')

        # set INI file path
        self.__config_file_path__ = os.path.expanduser('~/.OSDneo2')

        # if not found otherwise, INI file can be accessed
        self.__can_access_config_file__ = True

        # if INI file doesn't exist or cannot be read, ...
        if not os.access(self.__config_file_path__, os.F_OK | os.R_OK):
            print _('File "%s" not found.\nUsing default settings') % \
                self.__config_file_path__
            # ... try to create it
            try:
                configfile = open(self.__config_file_path__, 'w')
                configfile.close()
            # failed to create INI file
            except IOError, e:
                self.__can_access_config_file__ = False
                print _('No read access to file "%s".\nChanged settings cannot be stored.') % \
                    self.__config_file_path__

        # if INI file cannot be accessed, read or written to, ...
        if self.__can_access_config_file__  and not os.access( \
                self.__config_file_path__, os.F_OK | os.R_OK | os.W_OK):
            # ... then notify the user
            self.__can_access_config_file__ = False
            print _('No write access to file "%s".\nChanged settings cannot be stored.') % \
                self.__config_file_path__

        # read application settings from INI file
        self.__settings__ = ConfigParser.RawConfigParser()
        self.__settings__.read(self.__config_file_path__)


    def __repr__(self):
        """Return all the contents of the INI file as string.

        Keyword arguments:
        None

        Return value:
        Formatted string containing all settings from the INI file

        """
        output = ''
        # sort and output sections
        for section in self.sections():
            output += '\n[%s]\n' % section
            # sort and output settings
            for item in self.items(section):
                output += '%s: %s\n' % (item[0], item[1])
        # dump the whole thing
        return output.lstrip('\n')


    def get(self, section, setting, default):
        """Get an application setting.

        Keyword arguments:
        section -- string that specifies the section to be queried
        setting -- string that specifies the setting to be queried
        value -- string that specifies a default value

        Return value:
        String containing the specified application setting

        """
        # return default value if INI file can't be accessed
        if not self.__can_access_config_file__:
            return default

        try:
            value = self.__settings__.get(section, setting)
        except (ConfigParser.NoOptionError, ConfigParser.NoSectionError):
            value = default
            if type(default) != types.NoneType:
                self.set(section, setting, default)
        return value


    def set(self, section, setting, value):
        """Set an application setting.

        Keyword arguments:
        section -- string that specifies the section to be changed
        setting -- string that specifies the setting to be changed
        value -- string that specifies the new value

        Return value:
        None

        """
        # do nothing if INI file can't be accessed
        if not self.__can_access_config_file__:
            return

        assert (type(value) == types.StringType) or \
            (type(value) == types.UnicodeType)

        if section not in self.sections():
            self.__settings__.add_section(section)

        old_value = self.get(section, setting, None)

        if value != old_value:
            self.__settings__.set(section, setting, value)

            configfile = open(self.__config_file_path__, 'w')
            configfile.write(self.__repr__())
            configfile.close()


    def items(self, section):
        """Get all application setting names of a section

        Keyword arguments:
        section -- string that specifies the section to be queried

        Return value:
        List containing application setting names of the given section

        """
        items = self.__settings__.items(section)
        items.sort()
        return items


    def sections(self):
        """Get all sections.

        Keyword arguments:
        None

        Return value:
        List containing all section names

        """
        sections = self.__settings__.sections()
        sections.sort()
        return sections


    def get_variable(self, variable):
        """Return application describing variable as string.

        Keyword arguments:
        variable -- variable to query

        Return value:
        Formatted string containing variable's value (or None for
        invalid queries)

        """
        # list of variable names that may be queried (as a security measure)
        valid_variable_names = ('application', 'cmd_line', 'version', \
                                    'years', 'authors', 'license_short', \
                                    'license_long', 'description')

        if variable in valid_variable_names:
            return eval('self.__%s__' % variable)
        else:
            return None


    def get_description(self, long):
        """Return application description as string.

        Keyword arguments:
        long -- Boolean indication whether to output long version of description

        Return value:
        Formatted string containing application description

        """
        if long:
            description = '%(application)s v%(version)s' % \
                {'application':self.get_variable('application'), \
                     'version':self.get_variable('version')}
            description += '\n' + '=' * len(description) + '\n'
            description += '%(description)s' % \
                {'description':self.get_variable('description')}
        else:
            description = '%(application)s %(version)s' % \
                {'application':self.get_variable('application'), \
                     'version':self.get_variable('version')}

        return description


    def get_copyrights(self):
        """Return application copyrights as string.

        Keyword arguments:
        None

        Return value:
        Formatted string containing application copyrights

        """
        return '(c) %(years)s %(authors)s' % \
            {'years':self.get_variable('years'),\
                 'authors':self.get_variable('authors')}


    def get_license(self, long):
        """Return application license as string.

        Keyword arguments:
        long -- Boolean indication whether to output long version of description

        Return value:
        Formatted string containing application license

        """
        if long:
            return self.get_variable('license_long')
        else:
            return self.get_variable('license_short')


# make everything available ("from Settings import *")
settings = Settings()
