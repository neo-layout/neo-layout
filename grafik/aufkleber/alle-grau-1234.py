#!/usr/bin/env python

import sys
from lxml import etree as ET


def in2px(inch):
    return round(inch * DPI, 2)


DPI = 90

# a4 paper
HEIGHT = in2px(8.268)
WIDTH = in2px(11.69)

KEYWIDTH = in2px(0.75)
KEYHEIGHT = in2px(0.75)
LABELWIDTH = in2px(0.5)
LABELHEIGHT = in2px(0.55)

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

strokewidth = in2px(0.005)
STYLESHEET = '''
text.common {
    font-family:Linux Biolinum O, Linux Biolinum;
    font-style:normal;
    font-variant:normal;
    font-stretch:normal;
    text-align:center;
    text-anchor:middle;
    stroke:none;
}
text.main {
    /*font-weight:bold;*/
    font-size:19px;
    fill:#eeeeee;
    stroke-width:4;
}
text.special {
    font-size:16px;
    stroke-width:3;
}
text.outline {
    stroke:#111111;
    stroke-linejoin:round;
}
rect#boundary {
    fill:none;
    stroke:#eeeeee;
    stroke-width:''' + str(in2px(0.005)) + '''px;
}
rect#border {
    fill:#333333;
    stroke:#eeeeee;
    stroke-width:''' + str(in2px(0.025)) + '''px;
}
text.level1 {
}
text.level2 {
}
text.level3 {
    fill:#99dd66;
}
text.level4 {
    fill:#6699dd;
    font-size:13px;
}'''

NSMAP = {None: 'http://www.w3.org/2000/svg',
         'xlink': 'http://www.w3.org/1999/xlink'}
XLINK = '{%s}' % NSMAP['xlink']
DOCTYPE = ('<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 20001102//EN" '
           '"http://www.w3.org/TR/2000/CR-SVG-20001102/DTD/svg-20001102.dtd">')


def parse_ref(filename):
    '''parse reference and return multi-array'''
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
    ET.SubElement(node, 'rect', id='boundary',
                  width=str(KEYWIDTH), height=str(KEYHEIGHT), rx="5")
    # border for keys, actual key stickers
    ET.SubElement(node, 'rect', id='border',
                  width=str(LABELWIDTH), height=str(LABELHEIGHT), rx="10")


def create_keys(parent, keymap):
    posy = 0

    # main keyboard
    # TODO remove leading blank key
    for row in range(len(keymap[0])):
        posx = row / 2 * KEYWIDTH  # not really accurate, but works
        for key in range(len(keymap[0][row])):
            key = create_key(parent, posx, posy,
                             keymap[0][row][key],
                             keymap[1][row][key],
                             keymap[2][row][key],
                             keymap[3][row][key])
            if key is not None:  # advance only if sticker was output
                posx += KEYWIDTH
        posy += KEYHEIGHT

    # numpad
    for row in range(len(keymap[7])):
        posx = 0
        for key in range(len(keymap[7][row])):
            key = create_key(parent, posx, posy,
                             keymap[7][row][key],
                             keymap[8][row][key],
                             keymap[9][row][key],
                             keymap[10][row][key])
            if key is not None:  # advance only if sticker was output
                posx += KEYWIDTH
        posy += KEYHEIGHT


def create_key(parent, posx, posy, *keys):
    '''create a specific key (cloned from template)'''

    if len(keys[0]) != 1:  # skip keys like Tab at the left side
        return

    def text(level, trans, type):
        ET.SubElement(
            g1, 'text',
            {'transform': f'translate({trans})',
             'class': f"level{level} common {type}{outline}"}
             ).text = keys[level-1]

    keys = list(keys)

    # map words to symbols for numblock
    keys[2] = KP_MAPPING.get(keys[2], keys[2])
    keys[3] = KP_MAPPING.get(keys[3], keys[3])

    g0 = ET.SubElement(parent, 'g',
                       transform=f"translate({posx},{posy})",
                       id='key_' + ''.join(keys))
    ET.SubElement(g0, 'use', {XLINK + 'href': '#boundary'})
    g1 = ET.SubElement(g0, 'g',
                       transform=f'translate({(KEYWIDTH-LABELWIDTH)/2.5}, 2)')
    ET.SubElement(g1, 'use', {XLINK + 'href': '#border'})

    # do not show e1, if it's the same letter as e2
    upper_eq_lower = (keys[1].lower() == keys[0])

    # add text+outlines to sticker
    for outline in (' outline', ''):
        if not upper_eq_lower:
            text(1, '15,41', 'main')
        text(2, '15,19', 'main')
        text(3, '32,18', 'special')
        text(4, '32,42', 'special')
    return g0


def main():
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('filename')
    args = parser.parse_args()

    keymap = parse_ref(args.filename)

    root = ET.Element('svg',
                      height=str(HEIGHT), width=str(WIDTH),
                      nsmap=NSMAP)
    create_defs(root)
    create_keys(root, keymap)

    doc = ET.tostring(root, encoding="UTF-8", xml_declaration=True,
                      doctype=DOCTYPE, pretty_print=True)
    sys.stdout.buffer.write(doc)


main()
