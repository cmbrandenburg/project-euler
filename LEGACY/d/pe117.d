// vim: set noet ts=2 sw=2:
//
// Red, green and blue tiles

import std.stdio;

immutable int minLen = 2;
immutable int maxLen = 4;

long numWays(int n) {
	static long[int] pastResults;
	// base cases:
	if (n < minLen)
		return 1;
	// memoize
	if (n in pastResults)
		return pastResults[n];
	// recur:
	long result = numWays(n-1);
	for (int i = minLen; i <= n && i <= maxLen; i++)
		result += numWays(n-i);
	pastResults[n] = result;
	//writeln(n, ": ", result);
	return result;
}

unittest {
	assert(numWays(1) == 1);
	assert(numWays(2) == 2);
	assert(numWays(3) == 4);
	assert(numWays(4) == 8);
	assert(numWays(5) == 15);
}

void main() {
	writeln(numWays(50));
}

