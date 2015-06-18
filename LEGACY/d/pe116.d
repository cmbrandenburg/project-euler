// vim: set noet ts=2 sw=2:
//
// Red, green or blue tiles

import std.stdio;

// m: length of colored block(s)
// n: total number of tiles to fill
long numWays(int m, int n) {
	long recur(int m, int n) {
		static long[][int] pastResults;
		// base cases:
		if (n < m)
			return 1;
		// memoize:
		if (m in pastResults && pastResults[m].length > n)
			return pastResults[m][n];
		// recur:
		long result = recur(m, n-1) + recur(m, n-m);
		if (!(m in pastResults))
			pastResults[m] = null;
		while (pastResults[m].length < n)
			pastResults[m] ~= 0;
		pastResults[m] ~= result;
	//writeln("  ", m, ", ", n, ": ", result);
		return result;
	}
	long result = recur(m, n) - 1;
	//writeln(m, ", ", n, ": ", result);
	return result;
}

unittest {
	assert(numWays(2, 5) == 7);
	assert(numWays(3, 5) == 3);
	assert(numWays(4, 5) == 2);
}

void main() {
	writeln(numWays(2, 50) + numWays(3, 50) + numWays(4, 50));
}

