grammar G {
	token TOP {
		<boxes>+ %% \n
		' ' $<numbers> = (\d+ % '   ') ' ' \n \n
		<op>+ %% \n
	}
	
	token boxes {
		$<row> = (
		| '[' $<box> = (\w) ']'
		| '   '
		)+ % ' '
	}
	
	token op {
		'move '
		$<amount> = (\d+)
		' from '
		$<from> = \d
		' to '
		$<to> = \d
	}
}

class A {
	method TOP($/) {
		my $len = $<numbers>.list.elems;
		my @boxes = [[] xx $len];
		
		for $<boxes>.list.reverse -> (:$row) {
			for $row.list -> (:$box?) {
				state $i = 0;
				
				with $box {
					@boxes[$i].push: ~$box
				}
				
				$i++
			}
		}
		
		for $<op>.list -> (Int() :$amount, Int() :$from, Int() :$to) {
			@boxes[$to - 1].append: @boxes[$from - 1].splice(*-$amount)
		}
		
		make @boxes>>[*-1].join
	}
}

say G.parsefile("input.txt", :actions(A)).made