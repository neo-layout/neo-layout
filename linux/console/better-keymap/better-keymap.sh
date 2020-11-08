INFILE=../bone_in.map ;
OUTFILE=../bone_output.map ;
cat head.map > $OUTFILE ;
cat $INFILE | sed -n -e 's/KP_1/one /g' -e 's/KP_2/two /g' -e 's/KP_3 /three/g' -e 's/KP_4/four/g' -e 's/KP_5/five/g' -e 's/KP_6/six /g' -e 's/KP_7 /seven/g' -e 's/KP_8 /eight/g' -e 's/KP_9/nine/g' -e 's/KP_0/zero/g' -e 's/KP_Multiply/asterisk   /g' -e 's/KP_Divide/slash     /g' -e 's/KP_Substract/minus       /g' -e 's/KP_Addition/plus       /g' -e 's/KP_Comma/comma   /g' | racket -t better-keymap.rkt -- >> $OUTFILE ;
cat tail.map >> $OUTFILE ;
