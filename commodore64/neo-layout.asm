;NEO-Layout für C64
;(C) 2005 Hanno Behrens (pebbles@schattenlauf.de)
;unter GPL
;Alpha-Release 0.1

	!to "neo-layout.prg"

	!source <C64/BASIC2.a>

	*=$0801

dest	=$c000

ptr1	=$f7
ptr2	=$f9
		
zp_pkeydec	=$028f
zp_keymap	=$f5
k_keydec	=$eb48
k_keytablen	=$41
k_keytab1	=$eb81
k_keytab2	=$ebc2
k_keytab3	=$ec03
k_keytab4	=$ec78

k_decode	=$eae0
	
;Header generieren
	!word endline		;Zeiger auf nächste Zeile
	!word 2005		;Zeilennummer
	+b_SYS
	!tx "2061",0
endline	!word 0
;Ende Header

setup:	
	ldy #0			;kopiere neo nach dest
set1:	lda neoentry,y
	sta dest,y
	lda neoentry+$100,y
	sta dest+$100,y
	iny
	bne set1

	sei			;setze keydecoder
	lda #<dest
	sta zp_pkeydec
	lda #>dest
	sta zp_pkeydec+1
	cli
	rts	

neoentry:
	lda $028d		;Flag Shift CTRL Commodore
	cmp #$03
	bne l1			;Zeiger auf Dekodiertabellen berechnen
	cmp $028e
	beq abfrage_default	
	lda $0291		;Shift-Commodore erlaubt?
	bmi fertig		;nein, zurück zur Dekodierung
	lda $d018		;Shift/Commodore
	eor #$02		;Umschaltung Klein/Großschreibung
	sta $d018
	jmp fertig
	
l1	asl
	cmp #$08
	bcc l2
	lda #$06
l2	tax
	lda tableptr-neoentry+dest,x
	sta zp_keymap		;Zeiger auf Tastatur-Dekodiertabellen lesen
	lda tableptr-neoentry+dest+1,x
	sta zp_keymap+1

fertig:	jmp k_decode		;zurück zur Dekodierung

abfrage_default:
	lda #$7f
	sta $dc00
	rts

tableptr:	
	!word table1-neoentry+dest, table2-neoentry+dest
	!word table3-neoentry+dest, table4-neoentry+dest

	!ct pet
table1	;Tastatur-Dekodierung, ungeshiftet
	!by $14, $0d, $1d, $88, $85, $86, $87, $11
;	!by "3", "w", "a", "4", "z", "s", "e", $01
	!by "3", "v", "u", "4", "k", "i", "l", $01
;	!by "5", "r", "d", "6", "c", "f", "t", "x"
	!by "5", "c", "a", "6", "@", "e", "w", ">"
;	!by "7", "y", "g", "8", "b", "h", "u", "v"
	!by "7", "<", "o", "8", "z", "s", "h", "p"
;	!by "9", "i", "j", "0", "m", "k", "o", "n"
	!by "9", "g", "n", "0", "m", "r", "f", "b"
;	!by "+", "p", "l", "-", ".", ":", "@", ","
	!by "+", "j", "t", "-", ".", "d", "/", ","
;	!by $5c, "*", ";", $13, $01, "=", $5e, "/"
	!by $5c, "*", "y", $13, $01, "=", $5e, "x"
	!by "1", $5f, $04, "2", " ", $02, "q", $03
	!by $ff 
table2	;Tastatur-Dekodierung geshifted
	!by $94, $8d, $9d, $8c, $89, $8a, $8b, $91
;	!by "#", "W", "A", "$", "Z", "S", "E", $01
	!by "#", "V", "U", "$", "K", "I", "L", $01
;	!by "%", "R", "D", "&", "C", "F", "T", "X"
	!by "%", "C", "A", "&", $ba, "E", "W", "]"
;	!by "'", "Y", "G", "(", "B", "H", "U", "V"
	!by "'", "[", "O", "(", "Z", "S", "H", "P"
;	!by ")", "I", "J", "0", "M", "K", "O", "N"
	!by ")", "G", "N", "0", "M", "R", "F", "B"
;	!by $db, $d0, $cc, $dd, ">", "[", $ba, "<"
	!by $db, $d0, $cc, $dd, ":", "D", "?", ";"
;	!by $a9, $c0, "]", $93, $01, "=", $de, "?"
	!by $a9, $c0, "Y", $93, $01, $3d, $de, "X"
	!by $21, $5f, $04, $22, $a0, $02, "Q", $83
	!by $ff
	
table3	;Tastatur-Dekodierung mit C=-Taste
	!by $94, $8d, $9d, $8c, $89, $8a, $8b, $91
	!by $96, $b3, $b0, $97, $ad, $ae, $b1, $01
	!by $98, $b2, $ac, $99, $bc, $bb, $a3, $bd
	!by $9a, $b7, $a5, $9b, $bf, $b4, $b8, $be
	!by $29, $a2, $b5, $30, $a7, $a1, $b9, $aa
	!by $a6, $af, $b6, $dc, $3e, $5b, $a4, $3c
	!by $a8, $df, $5d, $93, $01, $3d, $de, $3f
	!by $81, $5f, $04, $95, $a0, $02, $ab, $83
	!by $ff

table4	;Tastatur-Dekodierung mit CTRL-Taste
	!by $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	!by $1c, $17, $01, $9f, $1a, $13, $05, $ff
	!by $9c, $12, $04, $1e, $03, $06, $14, $18
	!by $1f, $19, $07, $9e, $02, $08, $15, $16
	!by $12, $09, $0a, $92, $0d, $0b, $0f, $0e
	!by $ff, $10, $0c, $ff, $ff, $1b, $00, $ff
	!by $1c, $ff, $1d, $ff, $ff, $1f, $1e, $ff
	!by $90, $06, $ff, $05, $ff, $ff, $11, $ff
	!by $ff
