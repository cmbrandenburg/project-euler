// vim: set noet ts=2 sw=2:
//
// Counting block combinations II

import std.stdio;

long numWays(int m, int n) {
	static long[][int] pastResults;
	// base cases:
	if (n < m)
		return 1;
	// memoize:
	if (m in pastResults && pastResults[m].length > n)
		return pastResults[m][n];
	// recur:
	long result = numWays(m, n-1);
	for (auto i = -1; i < n-m; i++)
		result += numWays(m, i);
	if (!(m in pastResults))
		pastResults[m] = null;
	while (pastResults[m].length < n)
		pastResults[m] ~= 0;
	pastResults[m] ~= result;
	//writeln(n, ", ", result);
	return result;
}

unittest {
	assert(numWays(3, 0) == 1);
	assert(numWays(3, 1) == 1);
	assert(numWays(3, 2) == 1);
	assert(numWays(3, 3) == 2);
	assert(numWays(3, 4) == 4);
	assert(numWays(3, 5) == 7);
	assert(numWays(3, 6) == 11);
	assert(numWays(3, 7) == 17);

	// examples from problem description:
	assert(numWays(3, 29) == 673135);
	assert(numWays(3, 30) == 1089155);
	assert(numWays(10, 56) == 880711);
	assert(numWays(10, 57) == 1148904);
}

void main() {
	int i;
	for (i = 50; numWays(50, i) <= 1_000_000; i++) {}
	writeln(i);
}

