#YAML Parser for the Neo reference
#Copyright 2009 Martin Roppelt (m.p.roppelt ἢτ web in Germany)
#
#This file is part of German NEO-Layout Version 2.
#German Neo Layout Version 2 is free software: you can redistribute it and/or 
#modify it under the terms of the GNU General Public License as published by the 
#Free Software Foundation, either version 3 of the License, or (at your option) 
#any later version. You should have received a copy of the GNU General Public 
#License along with German NEO-Layout Version 2. If not, see 
#<http://www.gnu.org/licenses/>.
'''
Converts the reference into both human and machine readable and editable files 
for automated creating of keyboard drivers, pictures and references.
'''
#Needs at least Phyton 3.0 and PyYAML 3.08 (pyyaml.org) to run.
#
#Call with -h|--help to print command line options.
#
#Variables:
#b: box drawing characters as tuple, 
#index bits: (0) left (1) down (2) right (3) up
##c: control file #for reference
#f: file iterator
#i: index-sorted file
#m: model file
#min: miniatures
#n: name/number iterator
#o: command line options:
#o.a: auto-completion of file names as boolean
#o.d: destination file name
#o.i: index-sorted file name
#o.m: model file name
#o.r: paths relative to ./ otherwise to ../A-REFERENZ-A/ as boolean
#o.s: source file name
#o.t: destination file types (i/m/p/v)
#o.v: view file name
#p: pattern file
#pm: pre-model
#r: compiled regular expression
#s: source file as string
#v: view file, contains:
#pv: pre-view
#   string literals
#   replacement commands
#   patterns

from neo20_global import b
from optparse import OptionParser, make_option
from sys import stdout
from unicodedata import category
import os
import re
import yaml

def parse(s, w = 5):
    '''
    Returns a representation of a key field s with the standard with w.
    '''
    #Variables:
    #i: line iterator
    #j: level iterator
    #l: key line iterator
    #y: key level list
    #m: model
    #k: key iterator
    #s: key field as string
    #w: standard key with
    #v: view
    #q: key iterator
    m = []; v = []; y = []; i = 0
    for l in [l[:s.index(b[3])] for l in s.splitlines()[1:]]:
        if l[0] in (b[12], b[14]):
            m.append([]); v.append([])
            for j, l in enumerate(y[::-1]):
                q = 0
                for k in l[1:].split(b[10]):
                    if j == 0:
                        m[i].append([]); v[i].append([])
                    if len(k) == w:
                        if w == 7:
                            m[i][q].extend([k[0], k[2:5], k[6:7]])
                        elif w == 5:
                            m[i][q].extend(list(k[0:5:2]))
                        elif w == 1:
                            m[i][q] = k
                    else:
                        v[i][q] = k
                    q += 1
            i += 1; y = []
        else:
            y.append(l)
    return m, v

def compare(m, min):
    '''
    Compares the overall and miniature key field and returns their completed 
    views.
    '''
    v = [m[1] for m in m]
    return v

#command line options:
o = OptionParser(usage = 'example: %prog -ti -astest',
                 description = 'YAML Parser for the Neo reference', 
                 option_list = [
make_option('-a', action = 'store_true', default = False, help = 'source file \
name is inserted into ‘neo20-’ and ‘.txt’'),
make_option('-r', action = 'store_false', default = True, help = 'source and \
destination files are not relative to ../A-REFERENZ-A/'),
make_option('-t', metavar = 'mxiv', default = 'm', help = 'destination file \
types (default = %default)'),
make_option('-s', metavar = 'source file', default = 'neo20.txt', 
            help = 'default = %default'),
make_option('-d', metavar = 'destination file name', help = 'default = *.*'),
make_option('-m', metavar = 'model file', help = 'default = *.model'),
make_option('-x', metavar = 'hex model file', help = 'default = *.x'),
make_option('-i', metavar = 'index-sorted file', help = 'default = *.index'),
make_option('-v', metavar = 'view file', help = 'default = *.view')]
).parse_args()[0]

#evaluate options:
o.t = o.t.lower()
if o.d == None:
    o.d = o.s.rsplit('.txt')[0]
if o.a:
    o.s, o.d = 'neo20-' + o.s + '.txt', 'neo20-' + o.d
if o.r:
    o.s, o.d = '../A-REFERENZ-A/' + o.s, '../A-REFERENZ-A/' + o.d
for f in '.model', '.x', '.index', '.view':
    if f[1] in o.t.lower() and eval('o.' + f[1]) == None:
        exec('o.' + f[1] + ' = o.d + f')

#input:
s = open(o.s, encoding = 'utf8').read()

#processing:
r = re.compile(b[6] + '.*?' + b[9] + '.*?\n(?=\n)', re.DOTALL | re.MULTILINE)
p, pm = r.split(s), r.findall(s) #Split into key fields and the rest
for n in (0, 16):
    p.insert(n, p.pop(n) + pm.pop(n) + p.pop(n)) #Put the legends back into the 
    #pattern list

#parse key fields
m = [parse(pm[9]), parse(pm[20], 7)]
min = []
for n in range(6):
    min.append([parse(pm[10 + n], 1), parse(pm[21+ n], 7)])
v = compare(m, min); m = [m[0] for m in m]

#complete view ##
v = [[v], []]

v.append(p)

#create hex model
if 'x' in o.t.lower():
    x = []
    for f, n in enumerate(m):
        x.append(); ##
        
#create index
if 'i' in o.t.lower():
    i = []
    for n in m:
        for n in n: 
            i.extend(n)
#output:
for f in 'mxiv':
    if not stdout.isatty():
        file = stdout
    else:
        file = open(eval('o.' + f), 'w', encoding = 'utf8')
    if f in o.t:
        if f == 'v':
            yaml.dump_all(v[0:-1], file, allow_unicode = True, 
                      explicit_start = True,
                      explicit_end = True)
            yaml.dump(v.pop(), file, allow_unicode = True, 
                      explicit_start = True,
                      explicit_end = True, 
                      default_style = '|')
        else:
               yaml.dump(eval(f), file, allow_unicode = True, 
                      explicit_start = True,
                      explicit_end = True)
