my $total = 0;
for "input.txt".IO.lines {
	m/^(\d+)'-'(\d+)','(\d+)'-'(\d+)$/;
	$total++ if so ($0..$1) (&) ($2..$3)
}
say $total