#!/usr/bin/env perl6

use experimental :pack;

sub MAIN(Str $data-file, Str $out-file = 'out.data') {
	my $fh = $data-file.IO.open(:bin); LEAVE { $fh.close; }
	my $version = $fh.read(4).decode("utf8");
	my $offset  = $fh.read(4).unpack("L");
	my $record  = $fh.read($offset - 8);
	my @record;

	say "VERSION: {$version}, OFFSET: {$offset}";

	loop (my ($l, $r) = (0, 0); $l < $offset - 8 ;$l = $r) {
		while $record[$r++] != 0 { }
		my $info = $record.subbuf($l, $r - $l - 1).decode("utf8");
		@record.push([ $l, $info.substr($info.rindex('|') + 1)]);
	}

	my $out = $out-file.IO.open(:w); LEAVE { $out.close; }

	$fh.Supply(:size<9>).tap: -> $index {
		my ($phone, $offset, $type) = $index.unpack("LLC");

		for @record -> $record {
			if $record.[0] == $offset - 8 {
				my $line = "{$phone}0000\t{$phone}9999\t{$record.[1]}";
				say $line if $*ENV<DEBUG>;
				$out.say: $line;
			}
		}
	};
}
