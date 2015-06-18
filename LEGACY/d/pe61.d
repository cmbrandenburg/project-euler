// vim: set noet ts=2 sw=2:
//
// Cyclical figurate numbers

import std.stdio;

static int[] generateSet(
		int figure, // 3: triangle, 4: square, ...
		int min,
		int max
		) {

	int f(int n) {
		return ((figure - 2) * n * n - (figure - 4) * n) / 2;
	}

	int[] set;
	int i;
	int val;
	while ((val = f(i)) < max) {
		if (val >= min)
			set ~= val;
		i++;
	}
	return set;
}

static int findCycle(int[] cycle, int[][] availSets) {
	if (cycle.length == 6) {
		if ((cycle[5] % 100) == (cycle[0] / 100)) {
			//writeln(cycle);
			int sum;
			foreach (_, val; cycle) {
				sum += val;
			}
			return sum;
		}
	}
	foreach (i, set; availSets) {
		foreach (_, val; set) {

			if (cycle.length == 0 ||
			    (cycle[$-1] % 100) == (val / 100)) {
				cycle ~= val;
				int sum = findCycle(cycle, availSets[0..i] ~ availSets[i+1 .. $]);
				if (sum != 0)
					return sum;
				cycle = cycle[0 .. $-1];
			}
		}
	}
	return 0;
}

void main() {

	// Generate figurate sets.
	int[][] sets;
	for (int i = 3; i <= 8; i++) {
		sets ~= generateSet(i, 1000, 10000);
	}

	int[] cycle;
	writeln(findCycle(cycle, sets));
}

