#!/usr/bin/env python
from jinja2 import Template
import os
import sys
import re
import subprocess

import replacements

if len(sys.argv) == 1:
    print('Usage: ./<this script> variantname [numpad]')
    exit(1)

layout = sys.argv[1]
templatename = "base.svg.template"
numpad = True if len(sys.argv) == 3 and sys.argv[2] == "numpad" else False
swap_m3r_ä = True if layout == "vou" or layout == "mine" else False
vou = True if layout == "vou" else False
mine = True if layout == "mine" else False



# modifiers for layers in order as in keymap
modifiers=[
        [],
        ["SHIFT"],
        ["MOD3"],
        ["MOD3","SHIFT"],
        ["MOD4"],
        ["MOD4","SHIFT"],
        ["MOD3","MOD4"],
        []
        ]

layernames = ["1","2","3","5","4","Pseudoebene","6",""]


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
        #print(name, symbols)
        # replace keynames with the symbol they produce
        symbols = [replacements.f(s) for s in symbols]
        # Some keys aren't layered, hence the list is too short.
        # pad them with the first entry.
        symbols = (symbols + symbols[:1]*9)[:9]
        yield name, symbols


text = subprocess.check_output(
    ["xkbcli", "compile-keymap", "--layout", "de", "--variant", layout],
    text=True)
keymap = dict(keymap_to_keys(text))


for layer in range(0,7): # 7 because the last layer is empty
      # create a dict with the replacements from repalcements.py
      layerdict = {a: b[layer] for a,b in keymap.items()}
      # color modifiers accordingly
      for x in modifiers[layer]:
          layerdict[x] = " pressed"
      layerdict["numpad"] = numpad
      layerdict["swap_m3r_ä"] = swap_m3r_ä
      layerdict["vou"] = vou
      layerdict["mine"] = mine
      versionstring = "-numpad" if numpad else "-tkl"
      out = open(layout + "-" + layernames[layer] + versionstring + ".svg", "w")
      with open(templatename) as templatefile:
          template = Template(templatefile.read())
      out.write(template.render(layerdict))
      out.close()
