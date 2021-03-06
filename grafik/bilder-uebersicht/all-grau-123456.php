#!/usr/bin/env php
<?php
/* Dieser Textabschnitt befand sich vorher (etwa bei Commit 705fac448a0d0562e4e1bc16bf0b6cadbe235771)
in einer separaten Datei "neo_basierend_auf_wikipedias_KB_Germany.txt".
Ich denke, er bezieht sich auf das Template, das hier weiter unten geinlint ist
und habe ihn mal in diese Datei eingefügt, damit er nicht verloren geht.
  -- hrnz

== Quelle ==
Die Datei  wurde vom Wikipedia-Bild „KB_Germany.svg“ mit Inkscape angepasst.
Quelle: http://upload.wikimedia.org/wikipedia/commons/3/36/KB_Germany.svg
Stand: Januar 2007
Angepasst von Erik Streb (mail at erikstreb dot de)

== Dokumenteneinstellungen  ==
=== Einrasten ===
- Umrandungsboxen am Gitter einrasten
- Einrastempfindlichkeit ca. 10

=== Gitter/Führungslinien ===
Die Tasten sind auf einem Raster von 60 mal 60 Pixeln erstellt. Daher Abstand
X und Abstand Y = 60.

Die Startpositionen des Rasters (Ursprung X und Ursprung Y) für die Beschriftung der
einzelnen Tasten sind unten angegeben als Ux und Uy.

Immer (außer bei Ausnahmen) muss die Beschriftung von oben rechts aus
angepasst werden.

== Schrift ==
Was		Schrift			Größe		Fett
Buchstaben	DejaVu LGC Sans		22		Ja
Modifikatoren	DejaVu LGC Sans		14		Ja

== Gitterursprung ==
=== Für die einzelnen Reihen und Ebenen ===
Tastatur Position	Ebene	Zeichen		Ux	Uy	Ax	Ay
0. Reihe		1.	X		9	7	60	60
1. Reihe		1.	X		39	7	60	60
3. Reihe		1.	X		24	7	60	60

0. Reihe		2.	X		9	37	60	60
1. Reihe		2.	X		39	37	60	60
2. Reihe		2.	X		54	37	60	60
3. Reihe		2.	X		24	37	60	60

0. Reihe		3.	X		37	7	60	60
1. Reihe		3.	X		7	7	60	60
2. Reihe		3.	X		22	7	60	60
3. Reihe		3.	X		52	7	60	60

0. Reihe		4.	X		37	37	60	60
1. Reihe		4.	X		7	37	60	60
2. Reihe		4.	X		22	37	60	60
3. Reihe		4.	X		52	37	60	60

=== Für die Modifier ===
Bei Strg für Positionierung das „g“ wegnehmen und links ausrichten.

Modifier ganz links und auch rechtes Mod3:
Ux 9
Uy 25 oder 40 (linkes Shift)

Alt, rechte Strg und Menü:
Ux 39
Uy 25

Alt Option:
Ux 35
Uy 15

Enter (rechts ausrichten, von oben links anpassen):
Ux 51
Uy 40

Backspace (von unten rechts anpassen):
Ux 9
Uy 25
*/

    if ($argc == 1) {
        echo("Usage: ./neo_svg.php [neo20|bone|neoqwertz]\n");
        exit(1);
    }

	# Referenz laden
    $layout = $argv[1];
    $reference = file_get_contents('http://neo-layout.org/git/A-REFERENZ-A/' . $layout . ".txt");

    # Haupttastatur finden
    preg_match('/┌─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────┬─────────┐\n(.*)\n└──────┴──────┴──────┴──────────────────────────────────────┴──────┴──────┴──────┴──────┘/s', $reference, $found);
    # Tastaturreihen aufspalten
    $rows = preg_split('/\n├.*\n/', $found[1]);

    $n = 1;
    # Für jede Reihe:
    foreach ($rows as $row) {
        $sub_rows = preg_split('/\n/', $row);

        # Finde Zeichen in beiden Zeilen.
        # U030F ist ein combining-character und tritt zusammen mit einem Leerzeichen auf, damit es angezeigt wird
        preg_match_all('/│(.) (\x{030F} |.) (.)(?=│)/u', $sub_rows[0], $r1);
        preg_match_all('/│(.) (.) (.)(?=│)/u', $sub_rows[1], $r2);

        # Für jede Taste:
        for ($i = 0; $i < count($r1[0]); $i++) {
            # Überspringe Enter-Taste, die nicht dazugehört
            if ($r1[2][$i] == "⏎" && $i == 11) {
                $n--;
                continue;
            }
            # Lade die Zeichen der beiden Zeilen in das Array, geordnet nach ihrer Ebene
            $key[$n+$i.'_1'] = $r2[1][$i];
            $key[$n+$i.'_2'] = $r1[1][$i];
            $key[$n+$i.'_3'] = $r2[2][$i];
            $key[$n+$i.'_4'] = $r1[2][$i];
            $key[$n+$i.'_5'] = $r2[3][$i];
            $key[$n+$i.'_6'] = $r1[3][$i];
        }
        $n += $i;
    }

    # Lade das "rohe" SVG
    $svg = <<<EOF
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!-- Created with Inkscape (http://www.inkscape.org/) -->
<svg
   xmlns:dc="http://purl.org/dc/elements/1.1/"
   xmlns:cc="http://creativecommons.org/ns#"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg="http://www.w3.org/2000/svg"
   xmlns="http://www.w3.org/2000/svg"
   xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
   xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
   width="1081.1526"
   height="361.19427"
   id="svg2"
   sodipodi:version="0.32"
   inkscape:version="0.46"
   version="1.0"
   sodipodi:docbase="/home/sdb/keyb"
   sodipodi:docname="neo_default.svg"
   inkscape:output_extension="org.inkscape.output.svg.inkscape">
  <defs
     id="defs4">
    <inkscape:perspective
       sodipodi:type="inkscape:persp3d"
       inkscape:vp_x="0 : 150 : 1"
       inkscape:vp_y="0 : 1000 : 0"
       inkscape:vp_z="900 : 150 : 1"
       inkscape:persp3d-origin="450 : 100 : 1"
       id="perspective2833" />
    <marker
       inkscape:stockid="Arrow1Lend"
       orient="auto"
       refY="0"
       refX="0"
       id="Arrow1Lend"
       style="overflow:visible">
      <path
         id="path5387"
         d="M 0,0 L 5,-5 L -12.5,0 L 5,5 L 0,0 z"
         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
         transform="scale(-0.8,-0.8)" />
    </marker>
    <marker
       inkscape:stockid="Arrow1Lstart"
       orient="auto"
       refY="0"
       refX="0"
       id="Arrow1Lstart"
       style="overflow:visible">
      <path
         id="path5390"
         d="M 0,0 L 5,-5 L -12.5,0 L 5,5 L 0,0 z"
         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
         transform="scale(0.8,0.8)" />
    </marker>
    <marker
       inkscape:stockid="Tail"
       orient="auto"
       refY="0"
       refX="0"
       id="Tail"
       style="overflow:visible">
      <g
         id="g5342"
         transform="scale(-1.2,-1.2)">
        <path
           id="path5344"
           d="M -3.8048674,-3.9585227 L 0.54352094,-0.00068114835"
           style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:0.80000001;stroke-linecap:round;marker-start:none;marker-end:none" />
        <path
           id="path5346"
           d="M -1.2866832,-3.9585227 L 3.0617053,-0.00068114835"
           style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:0.80000001;stroke-linecap:round;marker-start:none;marker-end:none" />
        <path
           id="path5348"
           d="M 1.3053582,-3.9585227 L 5.6537466,-0.00068114835"
           style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:0.80000001;stroke-linecap:round;marker-start:none;marker-end:none" />
        <path
           id="path5350"
           d="M -3.8048674,4.1775838 L 0.54352094,0.21974226"
           style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:0.80000001;stroke-linecap:round;marker-start:none;marker-end:none" />
        <path
           id="path5352"
           d="M -1.2866832,4.1775838 L 3.0617053,0.21974226"
           style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:0.80000001;stroke-linecap:round;marker-start:none;marker-end:none" />
        <path
           id="path5354"
           d="M 1.3053582,4.1775838 L 5.6537466,0.21974226"
           style="fill:none;fill-rule:evenodd;stroke:#000000;stroke-width:0.80000001;stroke-linecap:round;marker-start:none;marker-end:none" />
      </g>
    </marker>
    <marker
       inkscape:stockid="Arrow2Mend"
       orient="auto"
       refY="0"
       refX="0"
       id="Arrow2Mend"
       style="overflow:visible">
      <path
         id="path5363"
         style="fill-rule:evenodd;stroke-width:0.625;stroke-linejoin:round"
         d="M 8.7185878,4.0337352 L -2.2072895,0.016013256 L 8.7185884,-4.0017078 C 6.97309,-1.6296469 6.9831476,1.6157441 8.7185878,4.0337352 z"
         transform="matrix(-0.6,0,0,-0.6,3,0)" />
    </marker>
    <marker
       inkscape:stockid="Arrow2Lend"
       orient="auto"
       refY="0"
       refX="0"
       id="Arrow2Lend"
       style="overflow:visible">
      <path
         id="path5369"
         style="fill-rule:evenodd;stroke-width:0.625;stroke-linejoin:round"
         d="M 8.7185878,4.0337352 L -2.2072895,0.016013256 L 8.7185884,-4.0017078 C 6.97309,-1.6296469 6.9831476,1.6157441 8.7185878,4.0337352 z"
         transform="matrix(-1.1,0,0,-1.1,5.5,0)" />
    </marker>
    <marker
       inkscape:stockid="Arrow1Send"
       orient="auto"
       refY="0"
       refX="0"
       id="Arrow1Send"
       style="overflow:visible">
      <path
         id="path5375"
         d="M 0,0 L 5,-5 L -12.5,0 L 5,5 L 0,0 z"
         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
         transform="scale(-0.2,-0.2)" />
    </marker>
    <marker
       inkscape:stockid="Arrow2Send"
       orient="auto"
       refY="0"
       refX="0"
       id="Arrow2Send"
       style="overflow:visible">
      <path
         id="path5357"
         style="fill-rule:evenodd;stroke-width:0.625;stroke-linejoin:round"
         d="M 8.7185878,4.0337352 L -2.2072895,0.016013256 L 8.7185884,-4.0017078 C 6.97309,-1.6296469 6.9831476,1.6157441 8.7185878,4.0337352 z"
         transform="matrix(-0.3,0,0,-0.3,1.5,0)" />
    </marker>
    <marker
       inkscape:stockid="Arrow1Mend"
       orient="auto"
       refY="0"
       refX="0"
       id="Arrow1Mend"
       style="overflow:visible">
      <path
         id="path5381"
         d="M 0,0 L 5,-5 L -12.5,0 L 5,5 L 0,0 z"
         style="fill-rule:evenodd;stroke:#000000;stroke-width:1pt;marker-start:none"
         transform="scale(-0.4,-0.4)" />
    </marker>
    <marker
       inkscape:stockid="Arrow2Lstart"
       orient="auto"
       refY="0"
       refX="0"
       id="Arrow2Lstart"
       style="overflow:visible">
      <path
         id="path5372"
         style="fill-rule:evenodd;stroke-width:0.625;stroke-linejoin:round"
         d="M 8.7185878,4.0337352 L -2.2072895,0.016013256 L 8.7185884,-4.0017078 C 6.97309,-1.6296469 6.9831476,1.6157441 8.7185878,4.0337352 z"
         transform="matrix(1.1,0,0,1.1,-5.5,0)" />
    </marker>
  </defs>
  <sodipodi:namedview
     id="base"
     pagecolor="#ffffff"
     bordercolor="#666666"
     borderopacity="1.0"
     inkscape:pageopacity="0.0"
     inkscape:pageshadow="2"
     inkscape:zoom="0.70710678"
     inkscape:cx="640.4962"
     inkscape:cy="91.757971"
     inkscape:document-units="px"
     inkscape:current-layer="layer1"
     inkscape:grid-points="true"
     showgrid="true"
     gridtolerance="15px"
     showborder="false"
     inkscape:window-width="1280"
     inkscape:window-height="949"
     inkscape:window-x="0"
     inkscape:window-y="25"
     showguides="true"
     inkscape:guide-bbox="true"
     inkscape:grid-bbox="true">
    <inkscape:grid
       id="GridFromPre046Settings"
       type="xygrid"
       originx="0px"
       originy="0px"
       spacingx="7.5px"
       spacingy="7.5px"
       color="#0000ff"
       empcolor="#0000ff"
       opacity="0.12156863"
       empopacity="0.25098039"
       empspacing="4"
       visible="true"
       enabled="true" />
  </sodipodi:namedview>
  <metadata
     id="metadata7">
    <rdf:RDF>
      <cc:Work
         rdf:about="">
        <dc:format>image/svg+xml</dc:format>
        <dc:type
           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />
      </cc:Work>
    </rdf:RDF>
  </metadata>
  <g
     inkscape:label="Layer 1"
     inkscape:groupmode="layer"
     id="layer1"
     transform="translate(0.5007389,0.5)">
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 0.10012093,0.099973201 L 72.096905,0.099973201 L 72.096905,72.096757 L 0.10012093,72.096757 L 0.10012093,0.099973201 z"
       id="rect2186" />
    <path
       style="fill:#000000;fill-opacity:0.2;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 936.05831,0.099973201 L 1080.0519,0.099973201 L 1080.0519,72.096757 L 936.05831,72.096757 L 936.05831,0.099973201 z"
       id="rect2248" />
    <path
       style="fill:#000000;fill-opacity:0.2;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 0.10012093,72.096757 L 108.0953,72.096757 L 108.0953,144.09354 L 0.10012093,144.09354 L 0.10012093,72.096757 z"
       id="rect2250" />
    <path
       style="fill:#000000;fill-opacity:0.2;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 0.10012093,144.09354 L 126.09449,144.09354 L 126.09449,216.09033 L 0.10012093,216.09033 L 0.10012093,144.09354 z"
       id="rect2286" />
    <path
       style="fill:#000000;fill-opacity:0.2;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 990.0559,144.09354 L 972.05671,144.09354 L 972.05671,72.096757 L 1080.0519,72.096757 L 1080.0519,216.09033 L 990.0559,216.09033 L 990.0559,144.09354 z"
       id="rect2320" />
    <path
       style="fill:#000000;fill-opacity:0.2;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 0.10012093,216.09033 L 90.097914,216.09033 L 90.097914,288.08711 L 0.10012093,288.08711 L 0.10012093,216.09033 z"
       id="rect2322" />
    <path
       style="fill:#000000;fill-opacity:0.2;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 882.06073,216.09033 L 1080.0519,216.09033 L 1080.0519,288.08711 L 882.06073,288.08711 L 882.06073,216.09033 z"
       id="rect2348" />
    <path
       style="fill:#000000;fill-opacity:0.2;fill-rule:evenodd;stroke:#000000;stroke-width:1.19996119;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 0.099241741,288.08801 L 108.0944,288.08801 L 108.0944,360.08657 L 0.099241741,360.08657 L 0.099241741,288.08801 z"
       id="rect2350" />
    <path
       style="fill:#000000;fill-opacity:0.2;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 972.05671,288.08711 L 1080.0519,288.08711 L 1080.0519,360.08389 L 972.05671,360.08389 L 972.05671,288.08711 z"
       id="rect2352" />
    <path
       style="fill:#000000;fill-opacity:0.2;fill-rule:evenodd;stroke:#000000;stroke-width:1.21494985;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 198.28842,288.08808 L 288.08629,288.08808 L 288.08629,360.0868 L 198.28842,360.0868 L 198.28842,288.08808 z"
       id="rect2354" />
    <path
       style="fill:#000000;fill-opacity:0.2;fill-rule:evenodd;stroke:#000000;stroke-width:1.09551895;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 702.06881,288.08716 L 792.0649,288.08716 L 792.0649,360.09997 L 702.06881,360.09997 L 702.06881,288.08716 z"
       id="rect2360" />
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.17465985;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 288.08809,288.08794 L 702.04489,288.08794 L 702.04489,360.08635 L 288.08809,360.08635 L 288.08809,288.08794 z"
       id="rect2362" />
    <path
       style="fill:#000000;fill-opacity:0.2;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 918.05912,144.09354 L 990.0559,144.09354 L 990.0559,216.09033 L 918.05912,216.09033 L 918.05912,144.09354 z"
       id="rect10188" />
    <path
       style="fill:#000000;fill-opacity:0.2;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 90.096101,216.09033 L 162.09289,216.09033 L 162.09289,288.08711 L 90.096101,288.08711 L 90.096101,216.09033 z"
       id="rect10196" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans;-inkscape-font-specification:DejaVu Sans"
       x="31.898701"
       y="332.14764"
       id="text3701"><tspan
         sodipodi:role="line"
         id="tspan3703"
         x="31.898701"
         y="332.14764">Strg</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans;-inkscape-font-specification:DejaVu Sans"
       x="7.9747691"
       y="260.56332"
       id="text3705"><tspan
         sodipodi:role="line"
         id="tspan3707"
         x="7.9747691"
         y="260.56332">Umsch</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans;-inkscape-font-specification:DejaVu Sans"
       x="29.986286"
       y="188.15407"
       id="text3709"><tspan
         sodipodi:role="line"
         id="tspan3711"
         x="29.986286"
         y="188.15407">Mod 3</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans;-inkscape-font-specification:DejaVu Sans"
       x="92.401077"
       y="260.29089"
       id="text3717"><tspan
         sodipodi:role="line"
         id="tspan3719"
         x="92.401077"
         y="260.29089">Mod 4</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans;-inkscape-font-specification:DejaVu Sans"
       x="228.2413"
       y="332.42719"
       id="text3721"><tspan
         sodipodi:role="line"
         id="tspan3723"
         x="228.2413"
         y="332.42719">Alt</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans;-inkscape-font-specification:DejaVu Sans"
       x="36.098515"
       y="116.49477"
       id="text3471"><tspan
         sodipodi:role="line"
         id="tspan3473"
         x="36.098515"
         y="116.49477">Tab</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans;-inkscape-font-specification:DejaVu Sans"
       x="712.92395"
       y="332.1377"
       id="text3475"><tspan
         sodipodi:role="line"
         id="tspan3477"
         x="712.92395"
         y="332.1377">Mod 4</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans;-inkscape-font-specification:DejaVu Sans"
       x="1004.1125"
       y="332.25427"
       id="text3479"><tspan
         sodipodi:role="line"
         id="tspan3481"
         x="1004.1125"
         y="332.25427">Strg</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans;-inkscape-font-specification:DejaVu Sans"
       x="924.3764"
       y="260.1409"
       id="text3483"><tspan
         sodipodi:role="line"
         id="tspan3485"
         x="924.3764"
         y="260.1409">Umschalt</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans;-inkscape-font-specification:DejaVu Sans"
       x="921.31622"
       y="188.26071"
       id="text3487"><tspan
         sodipodi:role="line"
         id="tspan3489"
         x="921.31622"
         y="188.26071">Mod 3</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans;-inkscape-font-specification:DejaVu Sans"
       x="949.57178"
       y="44.150539"
       id="text3491"><tspan
         sodipodi:role="line"
         id="tspan3493"
         x="949.57178"
         y="44.150539">Backspace</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans;-inkscape-font-specification:DejaVu Sans"
       x="990.36993"
       y="129.34674"
       id="text3495"><tspan
         sodipodi:role="line"
         id="tspan3497"
         x="990.36993"
         y="129.34674">Return</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="11.19365"
       y="60.409214"
       id="text3499"><tspan
         sodipodi:role="line"
         id="tspan3501"
         x="11.19365"
         y="60.409214">{1_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="16.424999"
       y="23.675066"
       id="text3503"><tspan
         sodipodi:role="line"
         id="tspan3505"
         x="16.424999"
         y="23.675066">{1_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="34.334991"
       y="52.460888"
       id="text3507"><tspan
         sodipodi:role="line"
         x="34.334991"
         y="52.460888"
         id="tspan3511">{1_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="34.288067"
       y="23.623892"
       id="text3515"><tspan
         sodipodi:role="line"
         id="tspan3517"
         x="34.288067"
         y="23.623892">{1_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="52.318493"
       y="52.514126"
       id="text3519"><tspan
         sodipodi:role="line"
         id="tspan3521"
         x="52.318493"
         y="52.514126">{1_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="52.464069"
       y="23.636379"
       id="text3523"><tspan
         sodipodi:role="line"
         id="tspan3525"
         x="52.464069"
         y="23.636379">{1_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 72.096903,0.099973201 L 144.09369,0.099973201 L 144.09369,72.096757 L 72.096903,72.096757 L 72.096903,0.099973201 z"
       id="path3656" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="83.19043"
       y="60.409214"
       id="text3658"><tspan
         sodipodi:role="line"
         id="tspan3660"
         x="83.19043"
         y="60.409214">{2_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="88.421776"
       y="23.675066"
       id="text3662"><tspan
         sodipodi:role="line"
         id="tspan3664"
         x="88.421776"
         y="23.675066">{2_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="106.33177"
       y="52.460888"
       id="text3666"><tspan
         sodipodi:role="line"
         x="106.33177"
         y="52.460888"
         id="tspan3668">{2_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="106.28484"
       y="23.623892"
       id="text3670"><tspan
         sodipodi:role="line"
         id="tspan3672"
         x="106.28484"
         y="23.623892">{2_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="124.3153"
       y="52.514126"
       id="text3674"><tspan
         sodipodi:role="line"
         id="tspan3676"
         x="124.3153"
         y="52.514126">{2_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="124.46085"
       y="23.636379"
       id="text3678"><tspan
         sodipodi:role="line"
         id="tspan3680"
         x="124.46085"
         y="23.636379">{2_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 144.09369,0.099973201 L 216.09047,0.099973201 L 216.09047,72.096757 L 144.09369,72.096757 L 144.09369,0.099973201 z"
       id="path3682" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="155.18723"
       y="60.409214"
       id="text3684"><tspan
         sodipodi:role="line"
         id="tspan3686"
         x="155.18723"
         y="60.409214">{3_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="160.41856"
       y="23.675068"
       id="text3688"><tspan
         sodipodi:role="line"
         id="tspan3690"
         x="160.41856"
         y="23.675068">{3_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="178.32857"
       y="52.460888"
       id="text3692"><tspan
         sodipodi:role="line"
         x="178.32857"
         y="52.460888"
         id="tspan3694">{3_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="178.28163"
       y="23.623894"
       id="text3696"><tspan
         sodipodi:role="line"
         id="tspan3698"
         x="178.28163"
         y="23.623894">{3_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="196.31209"
       y="52.514126"
       id="text3700"><tspan
         sodipodi:role="line"
         id="tspan3702"
         x="196.31209"
         y="52.514126">{3_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="196.45764"
       y="23.636381"
       id="text3704"><tspan
         sodipodi:role="line"
         id="tspan3706"
         x="196.45764"
         y="23.636381">{3_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 216.09047,0.099973201 L 288.08726,0.099973201 L 288.08726,72.096757 L 216.09047,72.096757 L 216.09047,0.099973201 z"
       id="path3065" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="227.18399"
       y="60.409218"
       id="text3067"><tspan
         sodipodi:role="line"
         id="tspan3069"
         x="227.18399"
         y="60.409218">{4_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="232.41536"
       y="23.675068"
       id="text3071"><tspan
         sodipodi:role="line"
         id="tspan3073"
         x="232.41536"
         y="23.675068">{4_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="250.32535"
       y="52.460892"
       id="text3075"><tspan
         sodipodi:role="line"
         x="250.32535"
         y="52.460892"
         id="tspan3077">{4_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="250.27841"
       y="23.623892"
       id="text3079"><tspan
         sodipodi:role="line"
         id="tspan3081"
         x="250.27841"
         y="23.623892">{4_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="268.30887"
       y="52.514137"
       id="text3083"><tspan
         sodipodi:role="line"
         id="tspan3085"
         x="268.30887"
         y="52.514137">{4_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="268.45444"
       y="23.636379"
       id="text3087"><tspan
         sodipodi:role="line"
         id="tspan3089"
         x="268.45444"
         y="23.636379">{4_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 288.08726,0.099973201 L 360.08404,0.099973201 L 360.08404,72.096757 L 288.08726,72.096757 L 288.08726,0.099973201 z"
       id="path3091" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="299.18079"
       y="60.409218"
       id="text3093"><tspan
         sodipodi:role="line"
         id="tspan3095"
         x="299.18079"
         y="60.409218">{5_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="304.41214"
       y="23.675068"
       id="text3097"><tspan
         sodipodi:role="line"
         id="tspan3099"
         x="304.41214"
         y="23.675068">{5_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="322.32214"
       y="52.460892"
       id="text3101"><tspan
         sodipodi:role="line"
         x="322.32214"
         y="52.460892"
         id="tspan3103">{5_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="322.27518"
       y="23.623892"
       id="text3105"><tspan
         sodipodi:role="line"
         id="tspan3107"
         x="322.27518"
         y="23.623892">{5_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="340.30566"
       y="52.514137"
       id="text3109"><tspan
         sodipodi:role="line"
         id="tspan3111"
         x="340.30566"
         y="52.514137">{5_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="340.45117"
       y="23.636379"
       id="text3113"><tspan
         sodipodi:role="line"
         id="tspan3115"
         x="340.45117"
         y="23.636379">{5_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 360.08404,0.099973201 L 432.08083,0.099973201 L 432.08083,72.096757 L 360.08404,72.096757 L 360.08404,0.099973201 z"
       id="path3117" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="371.17755"
       y="60.409218"
       id="text3119"><tspan
         sodipodi:role="line"
         id="tspan3121"
         x="371.17755"
         y="60.409218">{6_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="376.40894"
       y="23.675068"
       id="text3123"><tspan
         sodipodi:role="line"
         id="tspan3125"
         x="376.40894"
         y="23.675068">{6_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="394.31891"
       y="52.460892"
       id="text3127"><tspan
         sodipodi:role="line"
         x="394.31891"
         y="52.460892"
         id="tspan3129">{6_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="394.27197"
       y="23.623892"
       id="text3131"><tspan
         sodipodi:role="line"
         id="tspan3133"
         x="394.27197"
         y="23.623892">{6_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="412.30243"
       y="52.514137"
       id="text3135"><tspan
         sodipodi:role="line"
         id="tspan3137"
         x="412.30243"
         y="52.514137">{6_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="412.44797"
       y="23.636379"
       id="text3139"><tspan
         sodipodi:role="line"
         id="tspan3141"
         x="412.44797"
         y="23.636379">{6_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 432.08083,0.099973201 L 504.07761,0.099973201 L 504.07761,72.096757 L 432.08083,72.096757 L 432.08083,0.099973201 z"
       id="path3143" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="443.17432"
       y="60.409218"
       id="text3145"><tspan
         sodipodi:role="line"
         id="tspan3147"
         x="443.17432"
         y="60.409218">{7_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="448.4057"
       y="23.675068"
       id="text3149"><tspan
         sodipodi:role="line"
         id="tspan3151"
         x="448.4057"
         y="23.675068">{7_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="466.3157"
       y="52.460892"
       id="text3153"><tspan
         sodipodi:role="line"
         x="466.3157"
         y="52.460892"
         id="tspan3155">{7_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="466.26874"
       y="23.623892"
       id="text3157"><tspan
         sodipodi:role="line"
         id="tspan3159"
         x="466.26874"
         y="23.623892">{7_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="484.29922"
       y="52.514137"
       id="text3161"><tspan
         sodipodi:role="line"
         id="tspan3163"
         x="484.29922"
         y="52.514137">{7_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="484.44473"
       y="23.636379"
       id="text3165"><tspan
         sodipodi:role="line"
         id="tspan3167"
         x="484.44473"
         y="23.636379">{7_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 504.07761,0.099973201 L 576.07439,0.099973201 L 576.07439,72.096757 L 504.07761,72.096757 L 504.07761,0.099973201 z"
       id="path3169" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="515.17108"
       y="60.409218"
       id="text3171"><tspan
         sodipodi:role="line"
         id="tspan3173"
         x="515.17108"
         y="60.409218">{8_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="520.40247"
       y="23.675068"
       id="text3175"><tspan
         sodipodi:role="line"
         id="tspan3177"
         x="520.40247"
         y="23.675068">{8_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="538.3125"
       y="52.460892"
       id="text3179"><tspan
         sodipodi:role="line"
         x="538.3125"
         y="52.460892"
         id="tspan3181">{8_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="538.26556"
       y="23.623892"
       id="text3183"><tspan
         sodipodi:role="line"
         id="tspan3185"
         x="538.26556"
         y="23.623892">{8_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="556.29602"
       y="52.514126"
       id="text3187"><tspan
         sodipodi:role="line"
         id="tspan3189"
         x="556.29602"
         y="52.514126">{8_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="556.44153"
       y="23.636379"
       id="text3191"><tspan
         sodipodi:role="line"
         id="tspan3193"
         x="556.44153"
         y="23.636379">{8_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 576.07439,0.099973201 L 648.07118,0.099973201 L 648.07118,72.096757 L 576.07439,72.096757 L 576.07439,0.099973201 z"
       id="path3195" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="587.16791"
       y="60.409218"
       id="text3197"><tspan
         sodipodi:role="line"
         id="tspan3199"
         x="587.16791"
         y="60.409218">{9_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="592.39929"
       y="23.675068"
       id="text3201"><tspan
         sodipodi:role="line"
         id="tspan3203"
         x="592.39929"
         y="23.675068">{9_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="610.30927"
       y="52.460892"
       id="text3205"><tspan
         sodipodi:role="line"
         x="610.30927"
         y="52.460892"
         id="tspan3207">{9_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="610.26233"
       y="23.623892"
       id="text3209"><tspan
         sodipodi:role="line"
         id="tspan3211"
         x="610.26233"
         y="23.623892">{9_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="628.29279"
       y="52.514137"
       id="text3213"><tspan
         sodipodi:role="line"
         id="tspan3215"
         x="628.29279"
         y="52.514137">{9_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="628.43829"
       y="23.636379"
       id="text3217"><tspan
         sodipodi:role="line"
         id="tspan3219"
         x="628.43829"
         y="23.636379">{9_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 648.07118,0.099973201 L 720.06796,0.099973201 L 720.06796,72.096757 L 648.07118,72.096757 L 648.07118,0.099973201 z"
       id="path3221" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="659.16467"
       y="60.409218"
       id="text3223"><tspan
         sodipodi:role="line"
         id="tspan3225"
         x="659.16467"
         y="60.409218">{10_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="664.39606"
       y="23.675068"
       id="text3227"><tspan
         sodipodi:role="line"
         id="tspan3229"
         x="664.39606"
         y="23.675068">{10_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="682.30603"
       y="52.460892"
       id="text3231"><tspan
         sodipodi:role="line"
         x="682.30603"
         y="52.460892"
         id="tspan3233">{10_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="682.25909"
       y="23.623892"
       id="text3235"><tspan
         sodipodi:role="line"
         id="tspan3237"
         x="682.25909"
         y="23.623892">{10_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="700.28955"
       y="52.514137"
       id="text3239"><tspan
         sodipodi:role="line"
         id="tspan3241"
         x="700.28955"
         y="52.514137">{10_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="700.43512"
       y="23.636379"
       id="text3243"><tspan
         sodipodi:role="line"
         id="tspan3245"
         x="700.43512"
         y="23.636379">{10_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 720.06796,0.099973201 L 792.06475,0.099973201 L 792.06475,72.096757 L 720.06796,72.096757 L 720.06796,0.099973201 z"
       id="path3247" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="731.16144"
       y="60.409218"
       id="text3249"><tspan
         sodipodi:role="line"
         id="tspan3251"
         x="731.16144"
         y="60.409218">{11_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="736.39282"
       y="23.675068"
       id="text3253"><tspan
         sodipodi:role="line"
         id="tspan3255"
         x="736.39282"
         y="23.675068">{11_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="754.30286"
       y="52.460892"
       id="text3257"><tspan
         sodipodi:role="line"
         x="754.30286"
         y="52.460892"
         id="tspan3259">{11_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="754.25586"
       y="23.623892"
       id="text3261"><tspan
         sodipodi:role="line"
         id="tspan3263"
         x="754.25586"
         y="23.623892">{11_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="772.28638"
       y="52.514137"
       id="text3265"><tspan
         sodipodi:role="line"
         id="tspan3267"
         x="772.28638"
         y="52.514137">{11_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="772.43188"
       y="23.636379"
       id="text3269"><tspan
         sodipodi:role="line"
         id="tspan3271"
         x="772.43188"
         y="23.636379">{11_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 792.06475,0.099973201 L 864.06153,0.099973201 L 864.06153,72.096757 L 792.06475,72.096757 L 792.06475,0.099973201 z"
       id="path3273" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="803.15826"
       y="60.409218"
       id="text3275"><tspan
         sodipodi:role="line"
         id="tspan3277"
         x="803.15826"
         y="60.409218">{12_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="808.38965"
       y="23.675068"
       id="text3279"><tspan
         sodipodi:role="line"
         id="tspan3281"
         x="808.38965"
         y="23.675068">{12_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="826.29962"
       y="52.460892"
       id="text3283"><tspan
         sodipodi:role="line"
         x="826.29962"
         y="52.460892"
         id="tspan3285">{12_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="826.25269"
       y="23.623892"
       id="text3287"><tspan
         sodipodi:role="line"
         id="tspan3289"
         x="826.25269"
         y="23.623892">{12_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="844.28314"
       y="52.514137"
       id="text3291"><tspan
         sodipodi:role="line"
         id="tspan3293"
         x="844.28314"
         y="52.514137">{12_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="844.42865"
       y="23.636379"
       id="text3295"><tspan
         sodipodi:role="line"
         id="tspan3297"
         x="844.42865"
         y="23.636379">{12_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 864.06153,0.099973201 L 936.05831,0.099973201 L 936.05831,72.096757 L 864.06153,72.096757 L 864.06153,0.099973201 z"
       id="path3299" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="875.15503"
       y="60.409218"
       id="text3301"><tspan
         sodipodi:role="line"
         id="tspan3303"
         x="875.15503"
         y="60.409218">{13_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="880.38641"
       y="23.675068"
       id="text3305"><tspan
         sodipodi:role="line"
         id="tspan3307"
         x="880.38641"
         y="23.675068">{13_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="898.29639"
       y="52.460892"
       id="text3309"><tspan
         sodipodi:role="line"
         x="898.29639"
         y="52.460892"
         id="tspan3311">{13_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="898.24945"
       y="23.623892"
       id="text3313"><tspan
         sodipodi:role="line"
         id="tspan3315"
         x="898.24945"
         y="23.623892">{13_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="916.27991"
       y="52.514137"
       id="text3317"><tspan
         sodipodi:role="line"
         id="tspan3319"
         x="916.27991"
         y="52.514137">{13_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="916.42548"
       y="23.636379"
       id="text3321"><tspan
         sodipodi:role="line"
         id="tspan3323"
         x="916.42548"
         y="23.636379">{13_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 108.0953,72.096757 L 180.09208,72.096757 L 180.09208,144.09354 L 108.0953,144.09354 L 108.0953,72.096757 z"
       id="path3819" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="119.1888"
       y="132.40601"
       id="text3821"><tspan
         sodipodi:role="line"
         id="tspan3823"
         x="119.1888"
         y="132.40601">{14_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="124.42019"
       y="95.671852"
       id="text3825"><tspan
         sodipodi:role="line"
         id="tspan3827"
         x="124.42019"
         y="95.671852">{14_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="142.33015"
       y="124.45767"
       id="text3829"><tspan
         sodipodi:role="line"
         x="142.33015"
         y="124.45767"
         id="tspan3831">{14_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="142.28322"
       y="95.620674"
       id="text3833"><tspan
         sodipodi:role="line"
         id="tspan3835"
         x="142.28322"
         y="95.620674">{14_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="160.31369"
       y="124.51092"
       id="text3837"><tspan
         sodipodi:role="line"
         id="tspan3839"
         x="160.31369"
         y="124.51092">{14_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="160.45921"
       y="95.633163"
       id="text3841"><tspan
         sodipodi:role="line"
         id="tspan3843"
         x="160.45921"
         y="95.633163">{14_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 180.09208,72.096757 L 252.08887,72.096757 L 252.08887,144.09354 L 180.09208,144.09354 L 180.09208,72.096757 z"
       id="path3845" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="191.18558"
       y="132.40601"
       id="text3847"><tspan
         sodipodi:role="line"
         id="tspan3849"
         x="191.18558"
         y="132.40601">{15_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="196.41696"
       y="95.671852"
       id="text3851"><tspan
         sodipodi:role="line"
         id="tspan3853"
         x="196.41696"
         y="95.671852">{15_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="214.32695"
       y="124.45767"
       id="text3855"><tspan
         sodipodi:role="line"
         x="214.32695"
         y="124.45767"
         id="tspan3857">{15_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="214.28001"
       y="95.620674"
       id="text3859"><tspan
         sodipodi:role="line"
         id="tspan3861"
         x="214.28001"
         y="95.620674">{15_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="232.31047"
       y="124.51092"
       id="text3863"><tspan
         sodipodi:role="line"
         id="tspan3865"
         x="232.31047"
         y="124.51092">{15_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="232.45601"
       y="95.633163"
       id="text3867"><tspan
         sodipodi:role="line"
         id="tspan3869"
         x="232.45601"
         y="95.633163">{15_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 252.08887,72.096757 L 324.08565,72.096757 L 324.08565,144.09354 L 252.08887,144.09354 L 252.08887,72.096757 z"
       id="path3871" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="263.18237"
       y="132.40601"
       id="text3873"><tspan
         sodipodi:role="line"
         id="tspan3875"
         x="263.18237"
         y="132.40601">{16_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="268.41376"
       y="95.671852"
       id="text3877"><tspan
         sodipodi:role="line"
         id="tspan3879"
         x="268.41376"
         y="95.671852">{16_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="286.32373"
       y="124.45767"
       id="text3881"><tspan
         sodipodi:role="line"
         x="286.32373"
         y="124.45767"
         id="tspan3883">{16_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="286.27679"
       y="95.620674"
       id="text3885"><tspan
         sodipodi:role="line"
         id="tspan3887"
         x="286.27679"
         y="95.620674">{16_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="304.30725"
       y="124.51092"
       id="text3889"><tspan
         sodipodi:role="line"
         id="tspan3891"
         x="304.30725"
         y="124.51092">{16_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="304.45279"
       y="95.633163"
       id="text3893"><tspan
         sodipodi:role="line"
         id="tspan3895"
         x="304.45279"
         y="95.633163">{16_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 324.08565,72.096757 L 396.08243,72.096757 L 396.08243,144.09354 L 324.08565,144.09354 L 324.08565,72.096757 z"
       id="path3897" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="335.17914"
       y="132.40601"
       id="text3899"><tspan
         sodipodi:role="line"
         id="tspan3901"
         x="335.17914"
         y="132.40601">{17_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="340.41052"
       y="95.671852"
       id="text3903"><tspan
         sodipodi:role="line"
         id="tspan3905"
         x="340.41052"
         y="95.671852">{17_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="358.32053"
       y="124.45767"
       id="text3907"><tspan
         sodipodi:role="line"
         x="358.32053"
         y="124.45767"
         id="tspan3909">{17_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="358.27359"
       y="95.620674"
       id="text3911"><tspan
         sodipodi:role="line"
         id="tspan3913"
         x="358.27359"
         y="95.620674">{17_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="376.30405"
       y="124.51092"
       id="text3915"><tspan
         sodipodi:role="line"
         id="tspan3917"
         x="376.30405"
         y="124.51092">{17_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="376.44958"
       y="95.633163"
       id="text3919"><tspan
         sodipodi:role="line"
         id="tspan3921"
         x="376.44958"
         y="95.633163">{17_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 396.08243,72.096757 L 468.07922,72.096757 L 468.07922,144.09354 L 396.08243,144.09354 L 396.08243,72.096757 z"
       id="path3923" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="407.17593"
       y="132.40601"
       id="text3925"><tspan
         sodipodi:role="line"
         id="tspan3927"
         x="407.17593"
         y="132.40601">{18_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="412.40732"
       y="95.671852"
       id="text3929"><tspan
         sodipodi:role="line"
         id="tspan3931"
         x="412.40732"
         y="95.671852">{18_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="430.31729"
       y="124.45767"
       id="text3933"><tspan
         sodipodi:role="line"
         x="430.31729"
         y="124.45767"
         id="tspan3935">{18_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="430.27036"
       y="95.620674"
       id="text3937"><tspan
         sodipodi:role="line"
         id="tspan3939"
         x="430.27036"
         y="95.620674">{18_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="448.30084"
       y="124.51092"
       id="text3941"><tspan
         sodipodi:role="line"
         id="tspan3943"
         x="448.30084"
         y="124.51092">{18_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="448.44635"
       y="95.633163"
       id="text3945"><tspan
         sodipodi:role="line"
         id="tspan3947"
         x="448.44635"
         y="95.633163">{18_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 468.07922,72.096757 L 540.076,72.096757 L 540.076,144.09354 L 468.07922,144.09354 L 468.07922,72.096757 z"
       id="path4791" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="479.17273"
       y="132.40601"
       id="text4793"><tspan
         sodipodi:role="line"
         id="tspan4795"
         x="479.17273"
         y="132.40601">{19_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="484.40411"
       y="95.671852"
       id="text4797"><tspan
         sodipodi:role="line"
         id="tspan4799"
         x="484.40411"
         y="95.671852">{19_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="502.31409"
       y="124.45767"
       id="text4801"><tspan
         sodipodi:role="line"
         x="502.31409"
         y="124.45767"
         id="tspan4803">{19_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="502.26715"
       y="95.620674"
       id="text4805"><tspan
         sodipodi:role="line"
         id="tspan4807"
         x="502.26715"
         y="95.620674">{19_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="520.29761"
       y="124.51092"
       id="text4809"><tspan
         sodipodi:role="line"
         id="tspan4811"
         x="520.29761"
         y="124.51092">{19_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="520.44312"
       y="95.633163"
       id="text4813"><tspan
         sodipodi:role="line"
         id="tspan4815"
         x="520.44312"
         y="95.633163">{19_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 540.076,72.096757 L 612.07279,72.096757 L 612.07279,144.09354 L 540.076,144.09354 L 540.076,72.096757 z"
       id="path4817" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="551.16949"
       y="132.40601"
       id="text4819"><tspan
         sodipodi:role="line"
         id="tspan4821"
         x="551.16949"
         y="132.40601">{20_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="556.40088"
       y="95.671852"
       id="text4823"><tspan
         sodipodi:role="line"
         id="tspan4825"
         x="556.40088"
         y="95.671852">{20_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="574.31085"
       y="124.45767"
       id="text4827"><tspan
         sodipodi:role="line"
         x="574.31085"
         y="124.45767"
         id="tspan4829">{20_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="574.26392"
       y="95.620674"
       id="text4831"><tspan
         sodipodi:role="line"
         id="tspan4833"
         x="574.26392"
         y="95.620674">{20_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="592.29437"
       y="124.51092"
       id="text4835"><tspan
         sodipodi:role="line"
         id="tspan4837"
         x="592.29437"
         y="124.51092">{20_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="592.43994"
       y="95.633163"
       id="text4839"><tspan
         sodipodi:role="line"
         id="tspan4841"
         x="592.43994"
         y="95.633163">{20_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 612.07279,72.096757 L 684.06957,72.096757 L 684.06957,144.09354 L 612.07279,144.09354 L 612.07279,72.096757 z"
       id="path4843" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="623.16626"
       y="132.40601"
       id="text4845"><tspan
         sodipodi:role="line"
         id="tspan4847"
         x="623.16626"
         y="132.40601">{21_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="628.39764"
       y="95.671852"
       id="text4849"><tspan
         sodipodi:role="line"
         id="tspan4851"
         x="628.39764"
         y="95.671852">{21_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="646.30768"
       y="124.45767"
       id="text4853"><tspan
         sodipodi:role="line"
         x="646.30768"
         y="124.45767"
         id="tspan4855">{21_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="646.26074"
       y="95.620674"
       id="text4857"><tspan
         sodipodi:role="line"
         id="tspan4859"
         x="646.26074"
         y="95.620674">{21_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="664.2912"
       y="124.51092"
       id="text4861"><tspan
         sodipodi:role="line"
         id="tspan4863"
         x="664.2912"
         y="124.51092">{21_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="664.43671"
       y="95.633163"
       id="text4865"><tspan
         sodipodi:role="line"
         id="tspan4867"
         x="664.43671"
         y="95.633163">{21_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 684.06957,72.096757 L 756.06635,72.096757 L 756.06635,144.09354 L 684.06957,144.09354 L 684.06957,72.096757 z"
       id="path4869" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="695.16309"
       y="132.40601"
       id="text4871"><tspan
         sodipodi:role="line"
         id="tspan4873"
         x="695.16309"
         y="132.40601">{22_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="700.39447"
       y="95.671852"
       id="text4875"><tspan
         sodipodi:role="line"
         id="tspan4877"
         x="700.39447"
         y="95.671852">{22_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="718.30444"
       y="124.45767"
       id="text4879"><tspan
         sodipodi:role="line"
         x="718.30444"
         y="124.45767"
         id="tspan4881">{22_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="718.25751"
       y="95.620674"
       id="text4883"><tspan
         sodipodi:role="line"
         id="tspan4885"
         x="718.25751"
         y="95.620674">{22_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="736.28796"
       y="124.51092"
       id="text4887"><tspan
         sodipodi:role="line"
         id="tspan4889"
         x="736.28796"
         y="124.51092">{22_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="736.43347"
       y="95.633163"
       id="text4891"><tspan
         sodipodi:role="line"
         id="tspan4893"
         x="736.43347"
         y="95.633163">{22_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 756.06635,72.096757 L 828.06314,72.096757 L 828.06314,144.09354 L 756.06635,144.09354 L 756.06635,72.096757 z"
       id="path4895" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="767.15985"
       y="132.40601"
       id="text4897"><tspan
         sodipodi:role="line"
         id="tspan4899"
         x="767.15985"
         y="132.40601">{23_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="772.39124"
       y="95.671852"
       id="text4901"><tspan
         sodipodi:role="line"
         id="tspan4903"
         x="772.39124"
         y="95.671852">{23_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="790.30121"
       y="124.45767"
       id="text4905"><tspan
         sodipodi:role="line"
         x="790.30121"
         y="124.45767"
         id="tspan4907">{23_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="790.25427"
       y="95.620674"
       id="text4909"><tspan
         sodipodi:role="line"
         id="tspan4911"
         x="790.25427"
         y="95.620674">{23_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="808.28473"
       y="124.51092"
       id="text4913"><tspan
         sodipodi:role="line"
         id="tspan4915"
         x="808.28473"
         y="124.51092">{23_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="808.4303"
       y="95.633163"
       id="text4917"><tspan
         sodipodi:role="line"
         id="tspan4919"
         x="808.4303"
         y="95.633163">{23_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 828.06314,72.096757 L 900.05992,72.096757 L 900.05992,144.09354 L 828.06314,144.09354 L 828.06314,72.096757 z"
       id="path4921" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="839.15662"
       y="132.40601"
       id="text4923"><tspan
         sodipodi:role="line"
         id="tspan4925"
         x="839.15662"
         y="132.40601">{24_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="844.388"
       y="95.671852"
       id="text4927"><tspan
         sodipodi:role="line"
         id="tspan4929"
         x="844.388"
         y="95.671852">{24_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="862.29803"
       y="124.45767"
       id="text4931"><tspan
         sodipodi:role="line"
         x="862.29803"
         y="124.45767"
         id="tspan4933">{24_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="862.25104"
       y="95.620674"
       id="text4935"><tspan
         sodipodi:role="line"
         id="tspan4937"
         x="862.25104"
         y="95.620674">{24_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="880.28156"
       y="124.51092"
       id="text4939"><tspan
         sodipodi:role="line"
         id="tspan4941"
         x="880.28156"
         y="124.51092">{24_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="880.42706"
       y="95.633163"
       id="text4943"><tspan
         sodipodi:role="line"
         id="tspan4945"
         x="880.42706"
         y="95.633163">{24_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 900.05992,72.096757 L 972.05671,72.096757 L 972.05671,144.09354 L 900.05992,144.09354 L 900.05992,72.096757 z"
       id="path4947" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="911.15344"
       y="132.40601"
       id="text4949"><tspan
         sodipodi:role="line"
         id="tspan4951"
         x="911.15344"
         y="132.40601">{25_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="916.38483"
       y="95.671852"
       id="text4953"><tspan
         sodipodi:role="line"
         id="tspan4955"
         x="916.38483"
         y="95.671852">{25_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="934.2948"
       y="124.45767"
       id="text4957"><tspan
         sodipodi:role="line"
         x="934.2948"
         y="124.45767"
         id="tspan4959">{25_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="934.24786"
       y="95.620674"
       id="text4961"><tspan
         sodipodi:role="line"
         id="tspan4963"
         x="934.24786"
         y="95.620674">{25_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="952.27832"
       y="124.51092"
       id="text4965"><tspan
         sodipodi:role="line"
         id="tspan4967"
         x="952.27832"
         y="124.51092">{25_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#ff0000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="952.42383"
       y="95.633163"
       id="text4969"><tspan
         sodipodi:role="line"
         id="tspan4971"
         x="952.42383"
         y="95.633163">{25_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 126.09449,144.09354 L 198.09128,144.09354 L 198.09128,216.09033 L 126.09449,216.09033 L 126.09449,144.09354 z"
       id="path4973" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="137.188"
       y="204.40279"
       id="text4975"><tspan
         sodipodi:role="line"
         id="tspan4977"
         x="137.188"
         y="204.40279">{26_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="142.41939"
       y="167.66864"
       id="text4979"><tspan
         sodipodi:role="line"
         id="tspan4981"
         x="142.41939"
         y="167.66864">{26_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="160.32936"
       y="196.45445"
       id="text4983"><tspan
         sodipodi:role="line"
         x="160.32936"
         y="196.45445"
         id="tspan4985">{26_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="160.28242"
       y="167.61746"
       id="text4987"><tspan
         sodipodi:role="line"
         id="tspan4989"
         x="160.28242"
         y="167.61746">{26_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="178.31288"
       y="196.50771"
       id="text4991"><tspan
         sodipodi:role="line"
         id="tspan4993"
         x="178.31288"
         y="196.50771">{26_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="178.45842"
       y="167.62994"
       id="text4995"><tspan
         sodipodi:role="line"
         id="tspan4997"
         x="178.45842"
         y="167.62994">{26_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 198.09128,144.09354 L 270.08806,144.09354 L 270.08806,216.09033 L 198.09128,216.09033 L 198.09128,144.09354 z"
       id="path4999" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="209.18477"
       y="204.40279"
       id="text5001"><tspan
         sodipodi:role="line"
         id="tspan5003"
         x="209.18477"
         y="204.40279">{27_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="214.41615"
       y="167.66864"
       id="text5005"><tspan
         sodipodi:role="line"
         id="tspan5007"
         x="214.41615"
         y="167.66864">{27_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="232.32616"
       y="196.45445"
       id="text5009"><tspan
         sodipodi:role="line"
         x="232.32616"
         y="196.45445"
         id="tspan5011">{27_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="232.27921"
       y="167.61746"
       id="text5013"><tspan
         sodipodi:role="line"
         id="tspan5015"
         x="232.27921"
         y="167.61746">{27_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="250.30968"
       y="196.50771"
       id="text5017"><tspan
         sodipodi:role="line"
         id="tspan5019"
         x="250.30968"
         y="196.50771">{27_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="250.4552"
       y="167.62994"
       id="text5021"><tspan
         sodipodi:role="line"
         id="tspan5023"
         x="250.4552"
         y="167.62994">{27_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 270.08806,144.09354 L 342.08485,144.09354 L 342.08485,216.09033 L 270.08806,216.09033 L 270.08806,144.09354 z"
       id="path5025" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="281.18155"
       y="204.40279"
       id="text5027"><tspan
         sodipodi:role="line"
         id="tspan5029"
         x="281.18155"
         y="204.40279">{28_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="286.41293"
       y="167.66864"
       id="text5031"><tspan
         sodipodi:role="line"
         id="tspan5033"
         x="286.41293"
         y="167.66864">{28_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="304.32294"
       y="196.45445"
       id="text5035"><tspan
         sodipodi:role="line"
         x="304.32294"
         y="196.45445"
         id="tspan5037">{28_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="304.276"
       y="167.61746"
       id="text5039"><tspan
         sodipodi:role="line"
         id="tspan5041"
         x="304.276"
         y="167.61746">{28_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="322.30646"
       y="196.50771"
       id="text5043"><tspan
         sodipodi:role="line"
         id="tspan5045"
         x="322.30646"
         y="196.50771">{28_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="322.452"
       y="167.62994"
       id="text5047"><tspan
         sodipodi:role="line"
         id="tspan5049"
         x="322.452"
         y="167.62994">{28_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 342.08485,144.09354 L 414.08163,144.09354 L 414.08163,216.09033 L 342.08485,216.09033 L 342.08485,144.09354 z"
       id="path5051" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="353.17834"
       y="204.40279"
       id="text5053"><tspan
         sodipodi:role="line"
         id="tspan5055"
         x="353.17834"
         y="204.40279">{29_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="358.40973"
       y="167.66864"
       id="text5057"><tspan
         sodipodi:role="line"
         id="tspan5059"
         x="358.40973"
         y="167.66864">{29_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="376.31973"
       y="196.45445"
       id="text5061"><tspan
         sodipodi:role="line"
         x="376.31973"
         y="196.45445"
         id="tspan5063">{29_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="376.27277"
       y="167.61746"
       id="text5065"><tspan
         sodipodi:role="line"
         id="tspan5067"
         x="376.27277"
         y="167.61746">{29_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="394.30325"
       y="196.50771"
       id="text5069"><tspan
         sodipodi:role="line"
         id="tspan5071"
         x="394.30325"
         y="196.50771">{29_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="394.44876"
       y="167.62994"
       id="text5073"><tspan
         sodipodi:role="line"
         id="tspan5075"
         x="394.44876"
         y="167.62994">{29_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 414.08163,144.09354 L 486.07841,144.09354 L 486.07841,216.09033 L 414.08163,216.09033 L 414.08163,144.09354 z"
       id="path5077" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="425.17514"
       y="204.40279"
       id="text5079"><tspan
         sodipodi:role="line"
         id="tspan5081"
         x="425.17514"
         y="204.40279">{30_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="430.40652"
       y="167.66864"
       id="text5083"><tspan
         sodipodi:role="line"
         id="tspan5085"
         x="430.40652"
         y="167.66864">{30_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="448.3165"
       y="196.45445"
       id="text5087"><tspan
         sodipodi:role="line"
         x="448.3165"
         y="196.45445"
         id="tspan5089">{30_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="448.26956"
       y="167.61746"
       id="text5091"><tspan
         sodipodi:role="line"
         id="tspan5093"
         x="448.26956"
         y="167.61746">{30_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="466.30002"
       y="196.50771"
       id="text5095"><tspan
         sodipodi:role="line"
         id="tspan5097"
         x="466.30002"
         y="196.50771">{30_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="466.44556"
       y="167.62994"
       id="text5099"><tspan
         sodipodi:role="line"
         id="tspan5101"
         x="466.44556"
         y="167.62994">{30_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 486.07841,144.09354 L 558.0752,144.09354 L 558.0752,216.09033 L 486.07841,216.09033 L 486.07841,144.09354 z"
       id="path5103" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="497.17191"
       y="204.40279"
       id="text5105"><tspan
         sodipodi:role="line"
         id="tspan5107"
         x="497.17191"
         y="204.40279">{31_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="502.40329"
       y="167.66864"
       id="text5109"><tspan
         sodipodi:role="line"
         id="tspan5111"
         x="502.40329"
         y="167.66864">{31_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="520.31329"
       y="196.45445"
       id="text5113"><tspan
         sodipodi:role="line"
         x="520.31329"
         y="196.45445"
         id="tspan5115">{31_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="520.26636"
       y="167.61746"
       id="text5117"><tspan
         sodipodi:role="line"
         id="tspan5119"
         x="520.26636"
         y="167.61746">{31_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="538.29681"
       y="196.50771"
       id="text5121"><tspan
         sodipodi:role="line"
         id="tspan5123"
         x="538.29681"
         y="196.50771">{31_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="538.44232"
       y="167.62994"
       id="text5125"><tspan
         sodipodi:role="line"
         id="tspan5127"
         x="538.44232"
         y="167.62994">{31_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 558.0752,144.09354 L 630.07198,144.09354 L 630.07198,216.09033 L 558.0752,216.09033 L 558.0752,144.09354 z"
       id="path5129" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="569.1687"
       y="204.40279"
       id="text5131"><tspan
         sodipodi:role="line"
         id="tspan5133"
         x="569.1687"
         y="204.40279">{32_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="574.40009"
       y="167.66864"
       id="text5135"><tspan
         sodipodi:role="line"
         id="tspan5137"
         x="574.40009"
         y="167.66864">{32_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="592.31006"
       y="196.45445"
       id="text5139"><tspan
         sodipodi:role="line"
         x="592.31006"
         y="196.45445"
         id="tspan5141">{32_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="592.26312"
       y="167.61746"
       id="text5143"><tspan
         sodipodi:role="line"
         id="tspan5145"
         x="592.26312"
         y="167.61746">{32_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="610.29358"
       y="196.50771"
       id="text5147"><tspan
         sodipodi:role="line"
         id="tspan5149"
         x="610.29358"
         y="196.50771">{32_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="610.43915"
       y="167.62994"
       id="text5151"><tspan
         sodipodi:role="line"
         id="tspan5153"
         x="610.43915"
         y="167.62994">{32_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 630.07198,144.09354 L 702.06877,144.09354 L 702.06877,216.09033 L 630.07198,216.09033 L 630.07198,144.09354 z"
       id="path5155" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="641.16547"
       y="204.40279"
       id="text5157"><tspan
         sodipodi:role="line"
         id="tspan5159"
         x="641.16547"
         y="204.40279">{33_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="646.39685"
       y="167.66864"
       id="text5161"><tspan
         sodipodi:role="line"
         id="tspan5163"
         x="646.39685"
         y="167.66864">{33_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="664.30688"
       y="196.45445"
       id="text5165"><tspan
         sodipodi:role="line"
         x="664.30688"
         y="196.45445"
         id="tspan5167">{33_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="664.25989"
       y="167.61746"
       id="text5169"><tspan
         sodipodi:role="line"
         id="tspan5171"
         x="664.25989"
         y="167.61746">{33_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="682.29041"
       y="196.50771"
       id="text5173"><tspan
         sodipodi:role="line"
         id="tspan5175"
         x="682.29041"
         y="196.50771">{33_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="682.43591"
       y="167.62994"
       id="text5177"><tspan
         sodipodi:role="line"
         id="tspan5179"
         x="682.43591"
         y="167.62994">{33_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 702.06877,144.09354 L 774.06555,144.09354 L 774.06555,216.09033 L 702.06877,216.09033 L 702.06877,144.09354 z"
       id="path5181" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="713.16229"
       y="204.40279"
       id="text5183"><tspan
         sodipodi:role="line"
         id="tspan5185"
         x="713.16229"
         y="204.40279">{34_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="718.39368"
       y="167.66864"
       id="text5187"><tspan
         sodipodi:role="line"
         id="tspan5189"
         x="718.39368"
         y="167.66864">{34_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="736.30365"
       y="196.45445"
       id="text5191"><tspan
         sodipodi:role="line"
         x="736.30365"
         y="196.45445"
         id="tspan5193">{34_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="736.25671"
       y="167.61746"
       id="text5195"><tspan
         sodipodi:role="line"
         id="tspan5197"
         x="736.25671"
         y="167.61746">{34_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="754.28717"
       y="196.50771"
       id="text5199"><tspan
         sodipodi:role="line"
         id="tspan5201"
         x="754.28717"
         y="196.50771">{34_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="754.43268"
       y="167.62994"
       id="text5203"><tspan
         sodipodi:role="line"
         id="tspan5205"
         x="754.43268"
         y="167.62994">{34_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 774.06555,144.09354 L 846.06233,144.09354 L 846.06233,216.09033 L 774.06555,216.09033 L 774.06555,144.09354 z"
       id="path5207" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="785.15906"
       y="204.40279"
       id="text5209"><tspan
         sodipodi:role="line"
         id="tspan5211"
         x="785.15906"
         y="204.40279">{35_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="790.39044"
       y="167.66864"
       id="text5213"><tspan
         sodipodi:role="line"
         id="tspan5215"
         x="790.39044"
         y="167.66864">{35_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="808.30042"
       y="196.45445"
       id="text5217"><tspan
         sodipodi:role="line"
         x="808.30042"
         y="196.45445"
         id="tspan5219">{35_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="808.25348"
       y="167.61746"
       id="text5221"><tspan
         sodipodi:role="line"
         id="tspan5223"
         x="808.25348"
         y="167.61746">{35_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="826.28394"
       y="196.50771"
       id="text5225"><tspan
         sodipodi:role="line"
         id="tspan5227"
         x="826.28394"
         y="196.50771">{35_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="826.42944"
       y="167.62994"
       id="text5229"><tspan
         sodipodi:role="line"
         id="tspan5231"
         x="826.42944"
         y="167.62994">{35_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 846.06233,144.09354 L 918.05912,144.09354 L 918.05912,216.09033 L 846.06233,216.09033 L 846.06233,144.09354 z"
       id="path5233" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="857.15582"
       y="204.40279"
       id="text5235"><tspan
         sodipodi:role="line"
         id="tspan5237"
         x="857.15582"
         y="204.40279">{36_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="862.38721"
       y="167.66864"
       id="text5239"><tspan
         sodipodi:role="line"
         id="tspan5241"
         x="862.38721"
         y="167.66864">{36_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="880.29718"
       y="196.45445"
       id="text5243"><tspan
         sodipodi:role="line"
         x="880.29718"
         y="196.45445"
         id="tspan5245">{36_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="880.25024"
       y="167.61746"
       id="text5247"><tspan
         sodipodi:role="line"
         id="tspan5249"
         x="880.25024"
         y="167.61746">{36_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="898.2807"
       y="196.50771"
       id="text5251"><tspan
         sodipodi:role="line"
         id="tspan5253"
         x="898.2807"
         y="196.50771">{36_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="898.42627"
       y="167.62994"
       id="text5255"><tspan
         sodipodi:role="line"
         id="tspan5257"
         x="898.42627"
         y="167.62994">{36_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 162.09289,216.09033 L 234.08967,216.09033 L 234.08967,288.08711 L 162.09289,288.08711 L 162.09289,216.09033 z"
       id="path5259" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="173.18639"
       y="276.39957"
       id="text5261"><tspan
         sodipodi:role="line"
         id="tspan5263"
         x="173.18639"
         y="276.39957">{37_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="178.41777"
       y="239.66542"
       id="text5265"><tspan
         sodipodi:role="line"
         id="tspan5267"
         x="178.41777"
         y="239.66542">{37_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="196.32776"
       y="268.45123"
       id="text5269"><tspan
         sodipodi:role="line"
         x="196.32776"
         y="268.45123"
         id="tspan5271">{37_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="196.28081"
       y="239.61424"
       id="text5273"><tspan
         sodipodi:role="line"
         id="tspan5275"
         x="196.28081"
         y="239.61424">{37_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="214.31128"
       y="268.50449"
       id="text5277"><tspan
         sodipodi:role="line"
         id="tspan5279"
         x="214.31128"
         y="268.50449">{37_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="214.4568"
       y="239.62672"
       id="text5281"><tspan
         sodipodi:role="line"
         id="tspan5283"
         x="214.4568"
         y="239.62672">{37_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 234.08967,216.09033 L 306.08645,216.09033 L 306.08645,288.08711 L 234.08967,288.08711 L 234.08967,216.09033 z"
       id="path5285" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="245.18317"
       y="276.39957"
       id="text5287"><tspan
         sodipodi:role="line"
         id="tspan5289"
         x="245.18317"
         y="276.39957">{38_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="250.41455"
       y="239.66542"
       id="text5291"><tspan
         sodipodi:role="line"
         id="tspan5293"
         x="250.41455"
         y="239.66542">{38_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="268.32455"
       y="268.45123"
       id="text5295"><tspan
         sodipodi:role="line"
         x="268.32455"
         y="268.45123"
         id="tspan5297">{38_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="268.27759"
       y="239.61424"
       id="text5299"><tspan
         sodipodi:role="line"
         id="tspan5301"
         x="268.27759"
         y="239.61424">{38_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="286.30807"
       y="268.50449"
       id="text5303"><tspan
         sodipodi:role="line"
         id="tspan5305"
         x="286.30807"
         y="268.50449">{38_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="286.45358"
       y="239.62672"
       id="text5307"><tspan
         sodipodi:role="line"
         id="tspan5309"
         x="286.45358"
         y="239.62672">{38_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 306.08645,216.09033 L 378.08324,216.09033 L 378.08324,288.08711 L 306.08645,288.08711 L 306.08645,216.09033 z"
       id="path5311" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="317.17996"
       y="276.39957"
       id="text5313"><tspan
         sodipodi:role="line"
         id="tspan5315"
         x="317.17996"
         y="276.39957">{39_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="322.41135"
       y="239.66542"
       id="text5317"><tspan
         sodipodi:role="line"
         id="tspan5319"
         x="322.41135"
         y="239.66542">{39_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="340.32132"
       y="268.45123"
       id="text5321"><tspan
         sodipodi:role="line"
         x="340.32132"
         y="268.45123"
         id="tspan5323">{39_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="340.27438"
       y="239.61424"
       id="text5325"><tspan
         sodipodi:role="line"
         id="tspan5327"
         x="340.27438"
         y="239.61424">{39_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="358.30484"
       y="268.50449"
       id="text5329"><tspan
         sodipodi:role="line"
         id="tspan5331"
         x="358.30484"
         y="268.50449">{39_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="358.45038"
       y="239.62672"
       id="text5333"><tspan
         sodipodi:role="line"
         id="tspan5335"
         x="358.45038"
         y="239.62672">{39_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 378.08324,216.09033 L 450.08002,216.09033 L 450.08002,288.08711 L 378.08324,288.08711 L 378.08324,216.09033 z"
       id="path5364" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="389.17673"
       y="276.39957"
       id="text5366"><tspan
         sodipodi:role="line"
         id="tspan5368"
         x="389.17673"
         y="276.39957">{40_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="394.40811"
       y="239.66542"
       id="text5370"><tspan
         sodipodi:role="line"
         id="tspan5372"
         x="394.40811"
         y="239.66542">{40_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="412.31812"
       y="268.45123"
       id="text5374"><tspan
         sodipodi:role="line"
         x="412.31812"
         y="268.45123"
         id="tspan5376">{40_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="412.27115"
       y="239.61424"
       id="text5378"><tspan
         sodipodi:role="line"
         id="tspan5380"
         x="412.27115"
         y="239.61424">{40_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="430.30164"
       y="268.50449"
       id="text5382"><tspan
         sodipodi:role="line"
         id="tspan5384"
         x="430.30164"
         y="268.50449">{40_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="430.44714"
       y="239.62672"
       id="text5386"><tspan
         sodipodi:role="line"
         id="tspan5388"
         x="430.44714"
         y="239.62672">{40_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 450.08002,216.09033 L 522.07681,216.09033 L 522.07681,288.08711 L 450.08002,288.08711 L 450.08002,216.09033 z"
       id="path5417" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="461.17352"
       y="276.39957"
       id="text5419"><tspan
         sodipodi:role="line"
         id="tspan5421"
         x="461.17352"
         y="276.39957">{41_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="466.40491"
       y="239.66542"
       id="text5423"><tspan
         sodipodi:role="line"
         id="tspan5425"
         x="466.40491"
         y="239.66542">{41_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="484.31488"
       y="268.45123"
       id="text5427"><tspan
         sodipodi:role="line"
         x="484.31488"
         y="268.45123"
         id="tspan5429">{41_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="484.26794"
       y="239.61424"
       id="text5431"><tspan
         sodipodi:role="line"
         id="tspan5433"
         x="484.26794"
         y="239.61424">{41_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="502.29843"
       y="268.50449"
       id="text5435"><tspan
         sodipodi:role="line"
         id="tspan5437"
         x="502.29843"
         y="268.50449">{41_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="502.44394"
       y="239.62672"
       id="text5439"><tspan
         sodipodi:role="line"
         id="tspan5441"
         x="502.44394"
         y="239.62672">{41_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 522.07681,216.09033 L 594.07359,216.09033 L 594.07359,288.08711 L 522.07681,288.08711 L 522.07681,216.09033 z"
       id="path5443" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="533.17029"
       y="276.39957"
       id="text5445"><tspan
         sodipodi:role="line"
         id="tspan5447"
         x="533.17029"
         y="276.39957">{42_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="538.40167"
       y="239.66542"
       id="text5449"><tspan
         sodipodi:role="line"
         id="tspan5451"
         x="538.40167"
         y="239.66542">{42_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="556.31171"
       y="268.45123"
       id="text5453"><tspan
         sodipodi:role="line"
         x="556.31171"
         y="268.45123"
         id="tspan5455">{42_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="556.26471"
       y="239.61424"
       id="text5457"><tspan
         sodipodi:role="line"
         id="tspan5459"
         x="556.26471"
         y="239.61424">{42_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="574.29523"
       y="268.50449"
       id="text5461"><tspan
         sodipodi:role="line"
         id="tspan5463"
         x="574.29523"
         y="268.50449">{42_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="574.44073"
       y="239.62672"
       id="text5465"><tspan
         sodipodi:role="line"
         id="tspan5467"
         x="574.44073"
         y="239.62672">{42_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 594.07359,216.09033 L 666.07037,216.09033 L 666.07037,288.08711 L 594.07359,288.08711 L 594.07359,216.09033 z"
       id="path5469" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="605.16711"
       y="276.39957"
       id="text5471"><tspan
         sodipodi:role="line"
         id="tspan5473"
         x="605.16711"
         y="276.39957">{43_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="610.3985"
       y="239.66542"
       id="text5475"><tspan
         sodipodi:role="line"
         id="tspan5477"
         x="610.3985"
         y="239.66542">{43_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="628.30847"
       y="268.45123"
       id="text5479"><tspan
         sodipodi:role="line"
         x="628.30847"
         y="268.45123"
         id="tspan5481">{43_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="628.26154"
       y="239.61424"
       id="text5483"><tspan
         sodipodi:role="line"
         id="tspan5485"
         x="628.26154"
         y="239.61424">{43_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="646.29199"
       y="268.50449"
       id="text5487"><tspan
         sodipodi:role="line"
         id="tspan5489"
         x="646.29199"
         y="268.50449">{43_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="646.4375"
       y="239.62672"
       id="text5491"><tspan
         sodipodi:role="line"
         id="tspan5493"
         x="646.4375"
         y="239.62672">{43_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 666.07037,216.09033 L 738.06716,216.09033 L 738.06716,288.08711 L 666.07037,288.08711 L 666.07037,216.09033 z"
       id="path5495" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="677.16388"
       y="276.39957"
       id="text5497"><tspan
         sodipodi:role="line"
         id="tspan5499"
         x="677.16388"
         y="276.39957">{44_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="682.39526"
       y="239.66542"
       id="text5501"><tspan
         sodipodi:role="line"
         id="tspan5503"
         x="682.39526"
         y="239.66542">{44_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="700.30524"
       y="268.45123"
       id="text5505"><tspan
         sodipodi:role="line"
         x="700.30524"
         y="268.45123"
         id="tspan5507">{44_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="700.2583"
       y="239.61424"
       id="text5509"><tspan
         sodipodi:role="line"
         id="tspan5511"
         x="700.2583"
         y="239.61424">{44_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="718.28876"
       y="268.50449"
       id="text5513"><tspan
         sodipodi:role="line"
         id="tspan5515"
         x="718.28876"
         y="268.50449">{44_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="718.43427"
       y="239.62672"
       id="text5517"><tspan
         sodipodi:role="line"
         id="tspan5519"
         x="718.43427"
         y="239.62672">{44_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 738.06716,216.09033 L 810.06394,216.09033 L 810.06394,288.08711 L 738.06716,288.08711 L 738.06716,216.09033 z"
       id="path5521" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="749.16064"
       y="276.39957"
       id="text5523"><tspan
         sodipodi:role="line"
         id="tspan5525"
         x="749.16064"
         y="276.39957">{45_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="754.39203"
       y="239.66542"
       id="text5527"><tspan
         sodipodi:role="line"
         id="tspan5529"
         x="754.39203"
         y="239.66542">{45_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="772.302"
       y="268.45123"
       id="text5531"><tspan
         sodipodi:role="line"
         x="772.302"
         y="268.45123"
         id="tspan5533">{45_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="772.25507"
       y="239.61424"
       id="text5535"><tspan
         sodipodi:role="line"
         id="tspan5537"
         x="772.25507"
         y="239.61424">{45_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="790.28558"
       y="268.50449"
       id="text5539"><tspan
         sodipodi:role="line"
         id="tspan5541"
         x="790.28558"
         y="268.50449">{45_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="790.43109"
       y="239.62672"
       id="text5543"><tspan
         sodipodi:role="line"
         id="tspan5545"
         x="790.43109"
         y="239.62672">{45_6}</tspan></text>
    <path
       style="fill:#000000;fill-opacity:0;fill-rule:evenodd;stroke:#000000;stroke-width:1.1999464;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dashoffset:0;stroke-opacity:1"
       d="M 810.06394,216.09033 L 882.06073,216.09033 L 882.06073,288.08711 L 810.06394,288.08711 L 810.06394,216.09033 z"
       id="path5547" />
    <text
       xml:space="preserve"
       style="font-size:21.59903526px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="821.15747"
       y="276.39957"
       id="text5549"><tspan
         sodipodi:role="line"
         id="tspan5551"
         x="821.15747"
         y="276.39957">{46_1}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="826.38879"
       y="239.66542"
       id="text5553"><tspan
         sodipodi:role="line"
         id="tspan5555"
         x="826.38879"
         y="239.66542">{46_2}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="844.29883"
       y="268.45123"
       id="text5557"><tspan
         sodipodi:role="line"
         x="844.29883"
         y="268.45123"
         id="tspan5559">{46_3}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="844.25189"
       y="239.61423"
       id="text5561"><tspan
         sodipodi:role="line"
         id="tspan5563"
         x="844.25189"
         y="239.61423">{46_4}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="862.28235"
       y="268.50449"
       id="text5565"><tspan
         sodipodi:role="line"
         id="tspan5567"
         x="862.28235"
         y="268.50449">{46_5}</tspan></text>
    <text
       xml:space="preserve"
       style="font-size:14.39935684px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;fill:#000000;fill-opacity:1;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1;font-family:DejaVu Sans Mono;-inkscape-font-specification:DejaVu Sans Mono"
       x="862.42786"
       y="239.62675"
       id="text5569"><tspan
         sodipodi:role="line"
         id="tspan5571"
         x="862.42786"
         y="239.62675">{46_6}</tspan></text>
  </g>
</svg>
EOF;

    # Ersetze die Platzhalter mit den Zeichen aus dem Array
    foreach ($key as $search => $replace) {
        # Die Zeichen werden in HTML-NCRs (numeric character references) umgewandelt, damit sie nicht falsch interpretiert werden.
        $svg = preg_replace('/{'.preg_quote($search).'}/', mb_encode_numericentity ($replace, array (0x0, 0xffff, 0, 0xffff), 'UTF-8'), $svg);
    }

    # Speichern und Fertig
    file_put_contents($layout . '-grau-123456.svg', $svg);
?>
