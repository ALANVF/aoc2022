my $input = slurp "input.txt";

for ^$input.chars -> $i {
	if $input.substr($i, 14).ords.unique.elems == 14 {
		say $i + 14;
		last
	}
}