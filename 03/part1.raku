my %prio;

for flat("a".."z", "A".."Z").kv -> $i, $l {
	%prio{$l} = $i + 1
}

my @rucksacks = "input.txt".IO.lines.map: {
	my $l = .chars / 2;
	m/^(\w**{$l}) (\w**{$l})$/;
	~$0, ~$1
};

my $sum = 0;
for @rucksacks -> [$a, $b] {
	$sum += %prio{($a.comb (&) $b.comb).first.key}
}
say $sum