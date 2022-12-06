my $total = 0;
for "input.txt".IO.lines {
	m/^(\d+)'-'(\d+)','(\d+)'-'(\d+)$/;
	my $a = $0..$1;
	my $b = $2..$3;
	$total++ if $a ~~ $b || $b ~~ $a
}
say $total