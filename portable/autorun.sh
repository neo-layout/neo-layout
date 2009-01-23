#!/bin/sh
# CapsLock sollte aus sein
xmodmap -e "clear Lock" 

numlockx off
# schalte autorepeat für modifier und deadkeys aus
for key in 51 94 21 35 49; do
	xset -r $key
done
setxkbmap lv
xmodmap neo/neo_de.xmodmap || setxkbmap de

