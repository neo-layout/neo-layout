#!/usr/bin/env python

import os
from lxml import etree as ET

REFERENZ_DIR = '../../A-REFERENZ-A/'

KEYWIDTH = KEYHEIGHT = 72
LABELWIDTH = KEYWIDTH
LABELHEIGHT = KEYWIDTH

KP_MAPPING = {  # mapping for keypad, level 4
   'Hom': '⇱',
   'KP↑': '⇡',
   'PgU': '⇞',
   'KP←': '⇠',
   'Beg': '•',
   'KP→': '⇢',
   'End': '⇲',
   'KP↓': '⇣',
   'PgD': '⇟',
   'Ins': '⎀',
   'Del': '⌦',
   'Ent': '⏎',
   'vec': ' ⃗'
}

STYLESHEET = '''
rect.grey { fill:#cccccc !important }
rect.key { fill:white; stroke:black; stroke-width: 1 }

text {
    /* font-family:Linux Biolinum O, Linux Biolinum;*/
    font-family:normal;
    font-style:normal;
    font-variant:normal;
    font-stretch:normal;
    stroke:none;
    text-align:center;
    text-anchor:middle;
    dominant-baseline: middle;
    fill: black;
}
text.main { font-weight:bold }
text.special { }
text.level1 { font-size:22px }
text.level2 { font-size:22px }
text.level3 { font-size:14px }
text.level4 { font-size:14px }
text.level5 { font-size:14px }
text.level6 { font-size:14px }
text.deadkey { fill: red }
text.modifier { font-size:20px }
'''

NSMAP = {None: 'http://www.w3.org/2000/svg',
         'xlink': 'http://www.w3.org/1999/xlink'}
XLINK = '{%s}' % NSMAP['xlink']
DOCTYPE = ('<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 20001102//EN" '
           '"http://www.w3.org/TR/2000/CR-SVG-20001102/DTD/svg-20001102.dtd">')


LAYOUT = (
    [1] * 13 + [2.0],
    [1.5] + [1] * 12 + [0],
    [1.75] + [1] * 11 + [1.0, 0],
    [1.25, 1.0] + [1] * 10 + [2.75, 0],
    )

SPECIAL_KEYS = (
    (0, 13, 2.0, "Backspace"),
    (1, 0, 1.5, "Tab"),
    (2, 0, 1.75, "Mod 3"),
    (2, 12.75, 1, "Mod 3"),
    (3, 0, 1.25, "Umsch"),
    (3, 1.25, 1, "Mod 4"),
    (3, 12.25, 2.75, "Umschalt"),
    (4, 0, 1.5, "Strg"),
    (4, 2.5, 1.5, "Alt"),
    (4, 9.5, 1.5, "Mod4"),
    (4, 13.5, 1.5, "Strg"),
    )


def parse_ref(layout):
    '''parse reference and return multi-array'''
    filename = os.path.join(REFERENZ_DIR, f'{layout}.txt')
    with open(filename) as fh:
        lines = fh.read().splitlines()
    keymap = []
    state = 0
    for line in lines:
        line = line.strip()
        if state == 0:
            if line.endswith("Miniatur ==="):
                state = 1
                layer = []
                keymap.append(layer)
            continue
        elif not line:  # empty line: end of current block/layer
            state = 0
            layer = None
            continue
        elif not line.startswith("│"):  # skip horizontal dividers
            continue
        else:
            line = [k.strip() for k in line.split("│")]
            layer.append(line[1:-1])
    return keymap


def create_defs(parent):
    '''create the key template'''
    node = ET.SubElement(parent, 'defs')
    # style sheet
    ET.SubElement(node, 'style', type='text/css').text = STYLESHEET
    # boundary of keys
    # ET.SubElement(node, 'rect', id='boundary',
    #               width=str(KEYWIDTH), height=str(KEYHEIGHT), rx="0")
    # # border for keys, actual key stickers
    # ET.SubElement(node, 'rect', id='border',
    #               width=str(LABELWIDTH), height=str(LABELHEIGHT), rx="0")


def draw_keys(parent):
    # draw return key first to be overdrawn by others
    w = sum(LAYOUT[0]) * KEYWIDTH
    posx = sum(LAYOUT[1]) * KEYWIDTH
    ET.SubElement(parent, 'rect', {'class': 'key grey'},
                  x=str(posx), y=str(KEYHEIGHT + 1),
                  width=str(w - posx), height=str(2 * KEYHEIGHT))

    def rect(x, y, kwidth, classes):
        kwidth *= KEYWIDTH
        ET.SubElement(parent, 'rect', {'class': classes},
                      x=str(x), y=str(y),
                      width=str(kwidth), height=str(KEYHEIGHT))
        return kwidth

    # other keys
    posy = 1
    for row in LAYOUT:
        posx = 0
        for key in row:
            if not key:
                continue
            elif isinstance(key, float):
                kwidth = key * KEYWIDTH
            else:
                kwidth = rect(posx, posy, key, 'key')
            posx += kwidth
        posy += KEYHEIGHT
    drawing_width = posx + 1

    # special keys
    for row, col_offset, kwidth, label in SPECIAL_KEYS:
        rect(col_offset * KEYWIDTH, row * KEYHEIGHT + 1, kwidth, 'key grey')
    rect(4 * KEYWIDTH, posy, 5.5, 'key')  # Leertaste

    posy += KEYHEIGHT
    return drawing_width, posy


def create_labels(parent, keymap):
    posy = 1
    # main keyboard
    for row in range(len(keymap[0])-1):
        posx = 0
        for key in range(len(keymap[0][row])):
            create_label(parent, posx, posy,
                         keymap[0][row][key],
                         keymap[1][row][key],
                         keymap[2][row][key],
                         keymap[3][row][key],
                         keymap[4][row][key],
                         keymap[5][row][key])
            posx += LAYOUT[row][key] * KEYWIDTH
        posy += KEYHEIGHT

    def text(x, y, kwidth, label):
        x = x * KEYWIDTH + kwidth * KEYWIDTH / 2 + 1
        y = y * KEYHEIGHT + KEYHEIGHT / 2 + 1
        ET.SubElement(
            parent, 'text',
            {'x': str(x), 'y': str(y),
             'class': 'modifier'}
             ).text = label

    # special keys
    for row, col_offset, kwidth, label in SPECIAL_KEYS:
        text(col_offset, row, kwidth, label)
    text(13.5, 1.25, 1.75, "Return")


def create_label(parent, posx, posy, *labels):
    '''create a specific key (cloned from template)'''

    def text(level, trans, type):
        ET.SubElement(
            g, 'text',
            {'transform': f'translate({trans})',
             'class': f"level{level} {type} {deadkey}"}
             ).text = labels[level-1]

    labels = list(labels)
    if len(labels[0]) > 1:
        # special keys are labels special above
        return

    # map words to symbols for numblock
    labels[2] = KP_MAPPING.get(labels[2], labels[2])
    labels[3] = KP_MAPPING.get(labels[3], labels[3])

    g = ET.SubElement(parent, 'g',
                      transform=f"translate({posx},{posy})",
                      id='key_' + ''.join(labels))
    upper_eq_lower = (labels[1].lower() == labels[0])
    deadkey = 'deadkey' if labels[0] in "ˆ`´" else 'live'

    if upper_eq_lower:
        # do not show e1, if it's the same letter as e2
        text(2, '15,35', 'main')
    else:
        text(1, '15,55', 'main')
        text(2, '15,20', '')
    text(3, '42,50', 'special')
    text(4, '42,20', 'special')
    text(5, '59,50', 'special')
    text(6, '59,20', 'special')


def main():
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('layout')
    args = parser.parse_args()

    keymap = parse_ref(args.layout)

    root = ET.Element('svg',
                      nsmap=NSMAP)
    create_defs(root)
    width, height = draw_keys(root)
    create_labels(root, keymap)

    root.set('width', str(width))
    root.set('height', str(height))

    doc = ET.tostring(root, encoding="utf-8", xml_declaration=True,
                      doctype=DOCTYPE, pretty_print=True)
    with open(f'{args.layout}-grau-123456.svg', 'wb') as fh:
        fh.write(doc)


main()
