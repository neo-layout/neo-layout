#!/usr/bin/perl -wT

use strict;
use warnings;

use XML::Writer;

use open ':encoding(utf8)';
use utf8;

sub start_svg;
sub end_svg;
sub create_defs;
sub create_key;
sub parse_ref;
sub in2px;
sub css_builder;
sub create_keys;
sub round;

my $dpi = 90;
# a4 paper
my $height = in2px(8.268);
my $width = in2px(11.69);

my $keywidth = in2px(0.75);
my $keyheight = in2px(0.75);
my $labelwidth = in2px(0.5);
my $labelheight = in2px(0.55);

my $posx = 0;
my $posy = 0;

my $row = 0;
my %kp_mapping = ( # mapping for keypad, level 4
	'Hom' => '⇱',
	'KP↑' => '⇡',
	'PgU' => '⇞',
	'KP←' => '⇠',
	'Beg' => '•',
	'KP→' => '⇢',
	'End' => '⇲',
	'KP↓' => '⇣',
	'PgD' => '⇟',
	'Ins' => '⎀',
	'Del' => '⌦',
	'Ent' => '↲',
	'vec' => ' ⃗'
);

my $writer = new XML::Writer(ENCODING => 'utf-8',
	DATA_MODE => 1,
	DATA_INDENT => 2);

start_svg;
create_defs;

create_keys(parse_ref);

end_svg;

exit;

# parse reference and return multi-array
sub parse_ref {
	my @letters;
	open REF, "../../A-REFERENZ-A/neo20.txt"
		or die 'Error opening reference: '.$!;
	while (<REF>) {
		my @layer;
		last if /^== Zeichenerläuterungen/;

		# layout blocks
		if(/Miniatur ===$/) {
			while(<REF>) {
				last if(/^$/); # empty line => end of current block
				next if($_ !~ /^│/); # skip horizontal dividers

				push @layer, split /│/;
			}
			push @letters, [ @layer ]; # push ref
		}
	}
	close REF;

	return @letters;
}

sub create_keys {
	my @letters = @_;

	#for (0..$#{$letters[0]}) { # letters
	for (0..$#{$letters[0]}) { # letters
		create_key
			$letters[0][$_],
			$letters[0][$_],
			$letters[1][$_],
			$letters[2][$_],
			$letters[3][$_];
	}
	for (0..$#{$letters[7]}) { # numbers
		create_key
			$letters[7][$_],
			$letters[7][$_],
			$letters[8][$_],
			$letters[9][$_],
			$letters[10][$_];
	}
}

sub css_builder {
	my %props = @_;
	my $css = '';

	foreach (keys %props) {
		$css .= "$_:${props{$_}};";
	}
	return $css;
}

sub in2px {
	return ($_[0]||0) * $dpi;
}

sub start_svg {
	$writer->xmlDecl('UTF-8');
	$writer->doctype('svg', '-//W3C//DTD SVG 20001102//EN',
		'http://www.w3.org/TR/2000/CR-SVG-20001102/DTD/svg-20001102.dtd');

	$writer->startTag('svg', height => $height, width => $width,
		'xmlns' => 'http://www.w3.org/2000/svg',
		'xmlns:xlink' => 'http://www.w3.org/1999/xlink');
}
sub end_svg {
	$writer->endTag('svg');
	$writer->end();
}

# create the key template
sub create_defs {
	$writer->startTag('defs');

		# style information
		$writer->dataElement('style', '
			text.common {
				font-family:Linux Biolinum O, Linux Biolinum;
				font-style:normal;
				font-variant:normal;
				font-stretch:normal;
				text-align:center;
				text-anchor:middle;
				stroke:none;
			}
			text.main {
				/*font-weight:bold;*/
				font-size:19px;
				fill:#eeeeee;
				stroke-width:4;
			}
			text.special {
				font-size:16px;
				stroke-width:3;
			}
			text.outline {
				stroke:#111111;
				stroke-linejoin:round;
			}', type => 'text/css');

		# boundary of keys
		$writer->emptyTag('rect',
			id => 'boundary',
			width => $keywidth, height => $keyheight,
			rx => 5,
			style => css_builder(
				fill => 'none',
				stroke => '#eeeeee',
				'stroke-width' => in2px(0.005)
			));
		# border for keys, actual key stickers
		$writer->emptyTag('rect',
			id => 'border',
			width => $labelwidth, height => $labelheight,
			rx => 10,
			style => css_builder(
				fill => '#333333',
				stroke => '#eeeeee',
				'stroke-width' => in2px(0.025)
			));

	$writer->endTag('defs');
} 

# create a specific key (cloned from template)
# first parameter (0) is first level, and is only used for line breaks in the graphic
# param 1..4 are actual layers
sub create_key {
	my @keys  = @_;

	$keys[0] = '' unless defined($keys[0]);
	$keys[1] = '' unless defined($keys[1]);
	s/\s//g for @keys; # remove any space

	# map words to symbols for numblock
	foreach (keys %kp_mapping) {
		$keys[3] =~ s/\Q$_/\Q$kp_mapping{$_}/;
		$keys[4] =~ s/\Q$_/\Q$kp_mapping{$_}/;
	}

	return if length($keys[0]) != 1;

	$writer->startTag('g',
		transform => "translate($posx,$posy)",
		id => 'key_'.(join '', @keys));
		$writer->emptyTag('use', 'xlink:href' => '#boundary');
		$writer->startTag('g',
			transform => 'translate('.(($keywidth-$labelwidth)/2.5).', 2)');
			$writer->emptyTag('use', 'xlink:href' => '#border');

			# add text+outlines to sticker
			for(' outline', '') {
				$writer->dataElement('text', $keys[1],
					transform => 'translate(15,41)',
					class => "common main$_")
				       	# do not show e1, if it's the same letter as e2
					# only use for latin letters
					unless(#$keys[1] =~ /[a-züöäß]/ &&
						$keys[1] =~ /\Q$keys[2]/i);
				$writer->dataElement('text', $keys[2]||'',
					transform => 'translate(15,19)',
					class => "common main$_");
				$writer->dataElement('text', $keys[3]||'',
					transform => 'translate(32,18)',
					class => "common special$_",
					style => css_builder(fill => '#99dd66'));
				$writer->dataElement('text', $keys[4]||'',
					transform => 'translate(32,42)',
					class => "common special$_",
					style => css_builder(fill => '#6699dd',
						'font-size' => '13px'));
				       	# do not show e4 on keypad
					#unless($row > 4 && $keys[0] =~ /\d/i);
			}
		$writer->endTag('g');
	$writer->endTag('g');

	$posx += $keywidth;
	if($row < 3) {
		if($keys[0] =~ /[`´y]/) { # split keyboard rows, dirty way
			$posx = ++$row*$keywidth/2; # not really accurate, but works
			$posy += $keyheight;
		}
	} elsif($keys[0] =~ /[-93+j]/) { # keypad
		$posx = ++$row*0;
		$posy += $keyheight;
	}
}

sub round {
	return int($_[0]+.5*($_[0]<=>0));
}
