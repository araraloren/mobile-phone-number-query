#!/usr/bin/env perl6

sub MAIN(Str $msi, Str $num) {
	my @db = &loadDB($msi);

	note now - INIT now;

	my @nums = $num.IO.open(nl-in => "\n").lines;
	
	note "load num ", +@nums, " ", now - INIT now;

	(@nums.race.map(-> $num {
		my $info = &binarySearch(@db, $num);
		say $num, " ", $info ~~ Str ?? $info !! $info.[0];
	#	my $percent = ($++ / +@nums) * 100;
	#	$*ERR.printf: "%d%%\r", $percent;
	}));

	note now - INIT now;
}

sub binarySearch(@data, $goal) {
	my ($beg, $end) = (0, +@data - 1);

	while ($end >= $beg) {
		my $mid = ($end + $beg) div 2;
		given $goal {
			when @data[$mid][0] <= * <= @data[$mid][1] {
				return @data[$mid];
			}
			when * > @data[$mid][1] {
				$beg = $mid + 1;
			}
			default {
				$end = $mid - 1;
			}
		}
	}

	return "unknow";
}

sub loadDB(Str $file) {
	my @db;
	note "load db config => $file";
	@db.push( .split("\t") ) for $file.IO.open(nl-in => "\n").lines;
	@db;
}
