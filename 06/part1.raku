my $input = slurp "input.txt";

for ^$input.chars -> $i {
	if $input.substr($i, 4).ords.unique.elems == 4 {
		say $i + 4;
		last
	}
}