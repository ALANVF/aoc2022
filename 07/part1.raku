my @input = "input.txt".IO.lines;

my $tree = {};
my @stack = ($tree);
my $cur = @stack[*-1];

my $i = 1;
while $i < +@input {
	given @input[$i++] {
		when '$ ls' {
			while $i < +@input {
				given @input[$i] {
					when /^(\d+) \h (.+)$/ { $cur{~$1} = +$0 }
					when /^dir \h (.+)$/ { $cur{~$0} = {} }
					default { last }
				}
				
				$i++
			}
		}
		
		when '$ cd ..' {
			@stack.pop;
			$cur = @stack[*-1]
		}
		
		when /^'$ cd ' (.+)$/ {
			@stack.push: $cur{~$0};
			$cur = @stack[*-1]
		}
	}
}

my @sizes;

sub rec($dir) {
	my $size = 0;
	for $dir.kv -> $name, $value {
		if $value ~~ Int {
			$size += $value
		} else {
			my $s = rec $value;
			@sizes.push: $s;
			$size += $s
		}
	}
	return $size
}

rec $tree;

say @sizes.grep(* <= 100_000).sum