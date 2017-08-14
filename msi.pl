#!/usr/bin/perl
open(KK,"msi.unl");
while(<KK>){
        my @abc=split "\t",$_;
        push @kk,\@abc;
}
sub check {
	while ($min <= $max) {
		$mid =int(( $min + $max )/2);
		if ($kk[$mid][0] <= $num and $num <= $kk[$mid][1]) {
			return $kk[$mid][2];
		} elsif ( $num > $kk[$mid][1]){
			$min = $mid + 1;
		}else{
			$max = $mid - 1;
		}
	}
	return "unknow\n";
}
$count=@kk;
open(FF,"num.unl");
foreach $num (<FF>){
		chomp($num);
        $min=0;
        $max=$count - 1;
        print $num." ".&check();
}
