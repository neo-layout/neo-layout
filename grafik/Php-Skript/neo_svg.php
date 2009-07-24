<?php
	# Referenz laden
	$reference = file_get_contents('http://neo-layout.org/svn/A-REFERENZ-A/neo20.txt');

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
			if ($r1[2][$i] == "\xE2\x86\xB2" && $i == 11) {
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
	$svg = file_get_contents('neo_raw.svg');

	# Ersetze die Platzhalter mit den Zeichen aus dem Array
	foreach ($key as $search => $replace) {
		# Die Zeichen werden in HTML-NCRs (numeric character references) umgewandelt, damit sie nicht falsch interpretiert werden.
		$svg = preg_replace('/{'.preg_quote($search).'}/', mb_encode_numericentity ($replace, array (0x0, 0xffff, 0, 0xffff), 'UTF-8'), $svg);
	}

	# Speichern und Fertig
	file_put_contents('neo.svg', $svg);
?>