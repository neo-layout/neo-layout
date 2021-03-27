#!/usr/bin/env python
import more_itertools as mit
from jinja2 import Template
import os
import sys

import replacements

if len(sys.argv) == 1:
    print('Usage: ./<this script> variantname [numpad]')
    exit(1)

layout = sys.argv[1]
templatename = "base.svg.template"
numpad = True if len(sys.argv) == 3 and sys.argv[2] == "numpad" else False
swap_m3r_ä = True if layout == "de vou" else False

os.system("setxkbmap de " + layout + " -print | xkbcomp -xkb - /tmp/keymaptmp 2>/dev/null")
# TODO: actually write/generate a proper parser for xkbmaps
os.system(r'''sed -n '/xkb_symbols/,/xkb_geometry/p' /tmp/keymaptmp | tail -n +2 | grep -e 'key' -e symbols -e '}' | sed 's/symbols\[Group1]=//' | paste -sd "" - | sed 's/\;/&\n/g' | grep -v 'modifier_map' | sed -r 's/\s//g' | sed -r 's/key<(.*)>\{\[/\1=/g' | sed -r 's/\]?,?\}\;//' | grep -v '^$' > /tmp/keymap''')


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

with open('/tmp/keymap', 'r') as file:
  data = file.readlines()

  # read the keymap into a dict
  keymap = {x.split('=')[0]: x.split('=')[1].strip('\n').split(',') for x in data}
  # some keys arent layered, hence the list is too short. pad them with the first entry.
  keymap = {a: list(mit.padded(b, b[0], 9)) for a,b in keymap.items()}
  # replace keynames with the symbol they produce
  keymap = {a: list(map(replacements.f, b)) for a,b in keymap.items()}

  for layer in range(0,7): # 7 because the last layer is empty
      # create a dict with the replacements from repalcements.py
      layerdict = {a: b[layer] for a,b in keymap.items()}
      # color modifiers accordingly
      for x in modifiers[layer]:
          layerdict[x] = " pressed"
      layerdict["numpad"] = numpad
      layerdict["swap_m3r_ä"] = swap_m3r_ä
      versionstring = "-numpad" if numpad else "-tkl"
      out = open(layout + "-Ebene-" + layernames[layer] + versionstring + ".svg", "w")
      with open(templatename) as templatefile:
          template = Template(templatefile.read())
      out.write(template.render(layerdict))
      out.close()
