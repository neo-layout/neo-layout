#!/bin/sh
#
# xkb2svg.sh 
# author: lucky [at] zankt [dot] net
# license: GPL

OUTPUT=$1.svg
echo '<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg xmlns:svg="http://www.w3.org/2000/svg" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.0"
     width="210mm" height="297mm" >

<g id="taste">
 <rect width="120" height="150" x="0" y="0" style="stroke:black;fill:white"/>
 <rect width="54" height="44" x="03" y="03"  style="fill:black;stroke:black" />
 <rect width="54" height="44" x="63" y="03"  style="fill:none;stroke:black" />
 <rect width="54" height="44" x="03" y="53"  style="fill:none;stroke:black" />
 <rect width="54" height="44" x="63" y="53"  style="fill:none;stroke:black" />
 <rect width="54" height="44" x="03" y="103" style="fill:none;stroke:black" />
 <rect width="54" height="44" x="63" y="103" style="fill:none;stroke:black" />
</g>

' > $OUTPUT
x=150; y=0
cat $1 | sed '/.*key <\|xkb_symbols/!d;/\/\//d;' | while read line
do 
    if [[ "$line" =~ 'xkb_symbols(.*)' ]];then
        echo "$line" | sed 's/^[^"]*"//;s/".*//'
    else
        echo -e '<use xlink:href="#taste" transform="translate('$x','$y')" x="0"  y="0" />'"\n"'<g transform="translate('$x','$y')" >' >> $OUTPUT
        k=3;j=3;l="white"
        for i in $(echo $line | sed 's/^[^\[]*\[[[:space:]]*//;s/\].*//;s/\,[[:space:]]*/\t/g')
        do
            uni=$(cat ./keysymdef.h | sed "/^#define XK_$i /!d;s/^#define XK_$i[[:space:]]*0\|[[:space:]]*\/\*.*//g")
            if [ ${#uni} -eq 5 ];then
                echo -e '<text x="'"$j"'0" y="'"$k"'5"  style="font-size:30;text-align:center;text-anchor:middle;fill:'"$l"';font-weight:bold" xml:space="preserve">&#'"$uni"';</text>' >> $OUTPUT
            else
                echo "$i is not in keysymdef.h"
            fi             
            l="black"
            if [ $j -eq 9 ];then
                k=$(($k+5))
                j=3;
            else
                j=9
            fi
        done
        echo '</g>' >> $OUTPUT
    fi
    if [ $x -gt 1800 ]; then
        y=$(($y+200))
        x=0
    else
        x=$(($x+150))
    fi    
done
echo '</svg>' >> $OUTPUT
exit 0
