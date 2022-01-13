#!/usr/bin/env python

import sys
import re
import subprocess

from jinja2 import Template

import replacements

TEMPLATENAME = "base.svg.template"

# modifiers for layers in order as in keymap
MODIFIERS = [
        [],
        ["SHIFT"],
        ["MOD3"],
        ["MOD3", "SHIFT"],
        ["MOD4"],
        ["MOD4", "SHIFT"],
        ["MOD3", "MOD4"],
        []
        ]

LAYERNAMES = ["1", "2", "3", "5", "4", "Pseudoebene", "6", ""]

# 1E9E = Latin Capital Letter Sharp S
upper_chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZÄÖÜ\u1e9e'
lower_chars = 'abcdefghijklmnopqrstuvwxyzäöüß'
CAPS_MAP = str.maketrans(dict(zip(upper_chars + lower_chars,
                                  lower_chars + upper_chars)))
assert len(lower_chars) == len(upper_chars) == 30
assert len(CAPS_MAP) == len(lower_chars) + len(upper_chars)


def keymap_to_keys(text):
    # simple and dump parser for xkb keymap files
    #
    # It simply searches all "key { … };" parts and splits them.
    # A more advanced version would parts "xkb_symbols { … }" first
    # and only search in this part.

    assert text.startswith("xkb_keymap")

    KEY_PATTERN = r'\s key \s .+? \s { [^}]+? };'
    SYMBOLS_PATTERN = r'\[ (.+?) \]'

    text = text.split('xkb_symbols', 1)[1]
    # FIXME: assumes the next section (if there is one) is
    # xkb_geometry
    text = text.split('xkb_geometry', 1)[0]

    for k in re.findall(KEY_PATTERN, text, re.M+re.X):
        _, name, text = k.split(None, 2)
        name = name.strip('<').rstrip('>')
        text = text.replace('symbols[Group1]', '')
        symbols = re.findall(SYMBOLS_PATTERN, text, re.M+re.X)
        if not symbols:
            raise SystemExit(f"{name} did not match: {text!r}")
        if len(symbols) != 1:
            print("currious key:", name, symbols)

        symbols = [s.strip() for s in symbols[0].split(',')]
        # replace keynames with the symbol they produce
        symbols = [replacements.f(s) for s in symbols]
        # Some keys aren't layered, hence the list is too short.
        # pad them with the first entry.
        symbols = (symbols + symbols[:1]*9)[:9]
        yield name, symbols


# --- argument handling ---

if len(sys.argv) not in (2, 3):
    raise SystemExit('Usage: ./<this script> variantname [numpad]')

layout = sys.argv[1]
numpad = (len(sys.argv) == 3 and sys.argv[2] == "numpad")

swap_m3r_ä = (layout == "vou" or layout == "mine")
vou = (layout == "vou")
mine = (layout == "mine")
version = "numpad" if numpad else "tkl"

# - read data and template

keymap = subprocess.check_output(
    ["xkbcli", "compile-keymap", "--layout", "de", "--variant", layout],
    text=True)
keymap = dict(keymap_to_keys(keymap))

with open(TEMPLATENAME) as templatefile:
    template = Template(templatefile.read())


# --- generate files ---

def write_image(layername, layerdict):
    layerdict["numpad"] = numpad
    layerdict["swap_m3r_ä"] = swap_m3r_ä
    layerdict["vou"] = vou
    layerdict["mine"] = mine

    with open(f'{layout}-{layername}-{version}.svg', 'w') as out:
        out.write(template.render(layerdict))


def make_caps_lock(text):
    if len(text) == 1:
        return text.translate(CAPS_MAP)
    else:
        return text


# - main layers

for layer in range(7):  # 7 because the last layer is empty
    # create a dict with the replacements from replacements.py
    layerdict = {a: b[layer] for a, b in keymap.items()}
    # color modifiers accordingly
    for x in MODIFIERS[layer]:
        layerdict[x] = " pressed"
    write_image(LAYERNAMES[layer], layerdict)

    filename = f'{layout}-{LAYERNAMES[layer]}-{version}.svg'
    with open(filename, 'w') as out:
        out.write(template.render(layerdict))

# - caps-lock images

for layer in 0, 1:
    # create a dict with the replacements from replacements.py
    layerdict = {a: make_caps_lock(b[layer]) for a, b in keymap.items()}
    # color modifiers accordingly
    for x in MODIFIERS[layer]:
        layerdict[x] = " pressed"
    write_image(LAYERNAMES[layer] + 'caps', layerdict)


# - "leer" image

write_image('leer', {})
