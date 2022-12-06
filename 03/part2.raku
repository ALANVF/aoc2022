my %prio;

for flat("a".."z", "A".."Z").kv -> $i, $l {
	%prio{$l} = $i + 1
}

my @groups = "input.txt".IO.lines.rotor(3);

my $sum = 0;
for @groups -> @rucksacks {
	$sum += %prio{([(&)] @rucksacks>>.comb).first.key}
}
say $sum