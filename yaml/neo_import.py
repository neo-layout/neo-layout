#===============================================================================
# Imports:
#===============================================================================
#===============================================================================
# define box drawings:
# index bits: (0) left (1) down (2) right (3) up
#===============================================================================

box_drawings = None, None, None, '\u2510', \
                 None, '\u2500', '\u250C', '\u252C', \
                 None, '\u2518', '\u2502', '\u2524', \
                 '\u2514', '\u2534', '\u251C', '\u253C'

#===============================================================================
# Defaults:
#===============================================================================

reference_directory = '../A-REFERENZ-A/'
file_name_append_start = 'neo20-'
file_name_append_end = '.txt'
file_name_standard_extension = file_name_append_end

# synchronize with program!
file_extensions_mapping = {('model_file', 'm'):('.model','model'),
                           ('hex_model_file', 'x'):('.hex', 'hex_model'),
                           ('index_sorted_file', 'i'):('.index', 'index'),
                           ('view_file', 'v'):('.view', 'view')}
