// vim: set noet ts=2 sw=2:
//
// Counting block combinations I

import std.stdio;

long numWays(int n) {
	const int blockSize = 3;
	static long[] pastResults;
	// base cases:
	if (n < blockSize)
		return 1;
	// memoize:
	if (pastResults.length > n)
		return pastResults[n];
	// recur:
	long result = numWays(n-1);
	for (auto i = -1; i < n-blockSize; i++)
		result += numWays(i);
	while (pastResults.length < n)
		pastResults ~= 0;
	pastResults ~= result;
	//writeln(n, ", ", result);
	return result;
}

unittest {
	assert(numWays(0) == 1);
	assert(numWays(1) == 1);
	assert(numWays(2) == 1);
	assert(numWays(3) == 2);
	assert(numWays(4) == 4);
	assert(numWays(5) == 7);
	assert(numWays(6) == 11);
	assert(numWays(7) == 17);
}

void main() {
	writeln(numWays(50));
}

