echo download the latest images for the screen keyboard
for /L %%e in (1,1,6) do make-wget.exe -q -O ebene%%e.png http://neo-layout.org/grafik/tastatur3d/haupt_ziffern_feld/tastatur_neo_Ebene%%e.png