#!/usr/bin/perl -w

# Dieses Skript prüft übergebene Compose-Dateien auf Präfix-Eigenschaft
# Beispiel-Aufruf:
#
# ./check-compose.pl *.neo

use strict;

my %prefix;
my %code;

while (my $line = <>) {
    chomp $line;
    next unless ($line =~ /^([^#]+):/);

    my @codes = split (/\s+/, $1);

    for my $i (0..$#codes-1) {
	$prefix{"@codes[0..$i]"} = $line;

	if ($code{"@codes[0..$i]"}) {
	    print <<EOF;

* @codes[0..$i] Präfix bereits terminal verwendet
 $line
 $code{"@codes[0..$i]"}
EOF
	}
    }

    $code{"@codes"} = $line;
    if ($prefix{"@codes"}) {
	    print <<EOF;

* @codes Sequenz bereits als Präfix verwendet
 $line
 $prefix{"@codes"}
EOF
    } 
}
