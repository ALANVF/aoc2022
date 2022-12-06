my @elves = "input.txt".IO.split("\n\n");

say @elves.map(*.lines.sum).max