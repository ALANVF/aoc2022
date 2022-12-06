enum RPS <R P S>;

my %rpc = (
	A => RPS::R,
	B => RPS::P,
	C => RPS::S,
	X => RPS::R,
	Y => RPS::P,
	Z => RPS::S
);

my %score := :{
	RPS::R => 1,
	RPS::P => 2,
	RPS::S => 3
};

my @matches = "input.txt".IO.lines;

my $score = 0;
for @matches {
	my ($a, $b) = .split(" ").map({%rpc{$_}});
	$score += %score{$b};
	given ($a, $b) {
		when .[0] === .[1] {
			$score += 3
		}
		when (
			(RPS::R, RPS::P) |
			(RPS::P, RPS::S) |
			(RPS::S, RPS::R)
		) {
			$score += 6
		}
	}
}

say $score