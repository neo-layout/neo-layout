#===============================================================================
# YAML Parser for the Neo reference
# Copyright 2009 Martin Roppelt (m.p.roppelt ἢτ web in Germany)
# 
# This file is part of German NEO-Layout Version 2.
# German Neo Layout Version 2 is free software: you can redistribute it and/or 
# modify it under the terms of the GNU General Public License as published by 
# the Free Software Foundation, either version 3 of the License, or (at your 
# option) any later version. You should have received a copy of the GNU General 
# Public License along with German NEO-Layout Version 2. If not, see 
# <http://www.gnu.org/licenses/>.
#===============================================================================
'''
Converts the reference into both human and machine readable and editable files 
for automated creating of keyboard drivers, pictures and references.
'''
#===============================================================================
# Needs at least Phyton 3.0 and PyYAML 3.08 (pyyaml.org) to run.
# 
# Call with -h|--help to print command line options.
#===============================================================================

#===============================================================================
# To Do:
#===============================================================================

from neo_import import * #neo shared, settings and function module
from optparse import make_option, OptionParser #command line analyzing module
import re #regular expression processing module: compile
import sys #system module: stdout
import yaml #YAML processing module: dump

#===============================================================================
# analyze command line options:
#===============================================================================
options = OptionParser(usage = 'example: %prog -ti -astest', description = 'YAML Parser for the Neo reference',
    option_list = [
    make_option('-a', '--append', '--neo20-txt', action = 'store_true', default = False, help = 'source file name is inserted into ‘' + file_name_append_start + '’ and ‘' + file_name_append_end + '’'),
    make_option('-r', '--path-not-relative', dest = 'path_relative', action = 'store_false', default = True, help = 'source and destination files are not relative to ' + reference_directory),
    make_option('-t', '--types', metavar = 'mxiv', default = 'm', help = 'destination file types (default = %default)'),
    make_option('-s', '--source-file', metavar = 'source file', default = 'neo20.txt', help = 'default = %default'),
    make_option('-d', '--destination-file', metavar = 'destination file', help = 'default = *.*'),
    make_option('-m', '--model-file', metavar = 'model file', help = 'default = *.model'),
    make_option('-x', '--hex-model-file', metavar = 'hex model file', help = 'default = *.x'),
    make_option('-i', '--index-sorted-file', metavar = 'index-sorted file', help = 'default = *.index'),
    make_option('-v', '--view-file', metavar = 'view file', help = 'default = *.view'),
    make_option('-p', '--plain-panel', '--without-legend', dest = 'without_legend', action = 'store_true', default = False, help = 'plain panel reference (without legends)'),
    make_option('-w', '--key-level-width', type = 'int', metavar = 'int', default = 1, help = 'default = %default'),
    make_option('-W', '--key-level-delimiter-width', type = 'int', metavar = 'int', default = 1, help = 'default = %default'),
    make_option('-f', '--key-level-delimiter-filler', metavar = 'char',default = " ", help = 'default = %default'),
    make_option('-D', '--key-level-delimiter', metavar = 'char'),
    make_option('-l', '--key-levels-per-line', type = 'int', metavar = 'int', default = 3, help = 'default = %default')
    ]).parse_args()[0]
if options.destination_file == None:
    options.destination_file = options.source_file.rsplit(file_name_standard_extension)[0]
if options.append:
    options.source_file = file_name_append_start + options.source_file + file_name_append_end
    options.destination_file = file_name_append_start + options.destination_file
if options.path_relative:
    options.source_file = reference_directory + options.source_file
    options.destination_file = reference_directory + options.destination_file
for option, type in file_extensions_mapping:
    if type in options.types and eval('options.' + option) == None:
        exec('options.' + option + '=\'' + options.destination_file + file_extensions_mapping[option, type][0] + '\'')
if options.key_level_delimiter == None:
    options.key_level_delimiter = "".ljust(options.key_level_delimiter_width, options.key_level_delimiter_filler)

#===============================================================================
# functions:
#===============================================================================

# assumption: no delimiters around key level block
def parse_key_panel(key_panel, key_width = 5):
    '''
    returns the model and view representing key_panel,
    which contain lists for each key row,
    which contain lists for each key in the key row,
    which are lists for the key level strings.
    
    '''
    return_model = []; return_view = []; key_row = []; key_row_index = 0 # initialization
    for row in [row[:key_panel.index(box_drawings[3])] for row in key_panel.splitlines()[1:]]: # omit beginning and ending box drawings
        if row[0] in (box_drawings[12], box_drawings[14]): # if row begins with ├ or │,
            return_model.append([]); return_view.append([]) # create key row list
            key_lines = []
            for key_line_index, key_line in enumerate(key_row[:: - 1]): # reverse lines
                for key_index, key in enumerate(key_line[1:].split(box_drawings[10])): # split key line into keys
                    if key_line_index == 0: # if bottom line,
                        return_model[key_row_index].append([]); key_lines.append([]); return_view[key_row_index].append([]) # create key list
                    if len(key) == key_width: # if default key, parse line levels:
                        if options.key_level_width == 1 and key_width == 7: # if Neo 2 keypad key:
                            if key[1] == key[5] == options.key_level_delimiter:
                                key_lines[key_index].extend([key[0], key[2:5], key[6]])
                            elif key[::2] == options.key_level_delimiter * 4:
                                key_lines[key_index].extend(key[1::2])
                            else:
                                return_view[key_row_index][key_index].append(key)
                        elif key_width == options.key_level_width * options.key_levels_per_line + (options.key_levels_per_line - 1) * options.key_level_delimiter_width:
                            key_lines[key_index].extend([key[:options.key_level_width] for key in key[:key_width:options.key_level_width + options.key_level_delimiter_width]])
                        elif key_width == options.key_level_width:
                            key_lines[key_index].append(key)
                    else:
                        if options.key_level_width == 1 and key_width == 7 and len(key) == 15: # if Neo 2 keypad key:
                            key_lines[key_index].extend([key[2], key[6:9], key[12]])
                        else:
                            return_view[key_row_index][key_index].append(key)
                    if key_lines != []:
                        for key_level_index, level in enumerate(key_lines[0]):
                            for key_line_index, line_index in enumerate(key_lines):
                                return_model[key_row_index][key_index].append(key_lines[key_line_index][key_level_index])
            key_row_index += 1; key_row = []
        else:
            key_row.append(row)
    return return_model, return_view

def compare_model(model, miniature_model):
    '''
    Compares the overall and miniature key field and returns their completed 
    views.
    '''
    return [model[1] for model in model]
    
#===============================================================================
# read in reference:
#===============================================================================
source = open(options.source_file, encoding = 'utf8').read()

#===============================================================================
# split reference into lists of key panels and illustrative text patterns
#===============================================================================
# searches for ┌…┘ and the following line:
regex = re.compile(box_drawings[6] + '.*?' + box_drawings[9] + '.*?\n(?=\n)', re.DOTALL | re.MULTILINE)

legends, key_panels = regex.split(source), regex.findall(source) # split into lists of key panels and illustrative texts
if options.without_legend == False:
    for legend_index in (0, 16):
        legends.insert(legend_index, legends.pop(legend_index)+ key_panels.pop(legend_index) + legends.pop(legend_index)) # put the legends back into the pattern list

#parse key fields
model = [parse_key_panel(key_panels[9]), parse_key_panel(key_panels[20], 7)]
miniature_models = []
for miniature_models_index in range(6):
    miniature_models.append([parse_key_panel(key_panels[10 + miniature_models_index], 1), parse_key_panel(key_panels[21 + miniature_models_index], 7)])
view = compare_model(model, miniature_models) # complete views via comparing key widths
model = [model[0] for model in model] # strip views

# complete view ##
view = [[view], [], legends]


# create hex model
if 'x' in options.types:
    hex_model = []
    for row_index, row in enumerate(model):
        hex_model.append([])
        for key_index, key in enumerate(row):
            hex_model[row_index].append([])
            for level in key:
                if len(level) == 1:
                    hex_index[row_index][key_index].append(hex(ord(level))[2:].rjust(4,' '))
        
# create index
if 'i' in options.types:
    index = []
    for n in model:
        for n in n: 
            i.extend(n)

# output:
for option, type in file_extensions_mapping:
    if type in options.types:
        if not sys.stdout.isatty():
            file = sys.stdout
        else:
            file = open(eval('options.' + option), 'w', encoding = 'utf8')
        if type == 'v':
            yaml.dump_all(view[0: - 1], file, allow_unicode = True)
            yaml.dump(view.pop(), file, explicit_start = True, allow_unicode = True, default_style = '|')
        else:
            yaml.dump(eval(file_extensions_mapping[option, type][1]), file, allow_unicode = True)
