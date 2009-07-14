#!/usr/bin/perl -w

# Dieses Skript prüft übergebene Compose-Dateien auf 
# Präfix-Eigenschaft und auf Code-Dopplungen
#
# Beispiel-Aufruf:
#
# ./check-compose.pl *.neo

use strict;
use Getopt::Std;
our ($opt_q);

getopts('q'); # almost quiet operation

my %prefix;
my %code;

while (my $line = <>) {
    chomp $line;
    next unless ($line =~ /^([^#]+):/);

    my @codes = split (/\s+/, $1);

    for my $i (0..$#codes-1) {
	$prefix{"@codes[0..$i]"} = $line;

	if ($code{"@codes[0..$i]"}) {
	    if ($opt_q) { exit 1; }
	    print <<EOF;

* @codes[0..$i] Präfix bereits terminal verwendet
 $line
 $code{"@codes[0..$i]"}
EOF
	}
    }

    if ($code{"@codes"}) {
	if ($opt_q) { exit 1; }
	print <<EOF;

* @codes Sequenz mehrfach verwendet
 $line
 $code{"@codes"}
EOF
    }

    $code{"@codes"} = $line;

    if ($prefix{"@codes"}) {
	if ($opt_q) { exit 1; }
	print <<EOF;

* @codes Sequenz bereits als Präfix verwendet
 $line
 $prefix{"@codes"}
EOF
    } 
}

