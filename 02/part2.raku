enum RPS <R P S>;

my %rpc = (
	A => RPS::R,
	B => RPS::P,
	C => RPS::S
);

my %score := :{
	RPS::R => 1,
	RPS::P => 2,
	RPS::S => 3
};

my %choose = (
	X => :{
		RPS::R => RPS::S,
		RPS::P => RPS::R,
		RPS::S => RPS::P
	},
	Z => :{
		RPS::R => RPS::P,
		RPS::P => RPS::S,
		RPS::S => RPS::R
	}
);

my @matches = "input.txt".IO.lines;

my $score = 0;
for @matches {
	my ($a, $b) = .split(" ");
	$a = %rpc{$a};
	
	given $b {
		when "X" {
			$b = %choose<X>{$a}
		}
		when "Y" {
			$b = $a;
			$score += 3
		}
		when "Z" {
			$b = %choose<Z>{$a};
			$score += 6
		}
	}
	
	$score += %score{$b}
}

say $score