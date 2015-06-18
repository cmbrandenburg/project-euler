// vim: set noet ts=2 sw=2:
//
// Special subset sums: testing

import std.algorithm;
import std.array;
import std.range;
import std.stdio;
import set;

uint[][] loadSets() {
	uint[][] sets;
	foreach (l; File("data/sets.txt").byLine()) {
		sets ~= array(map!"to!uint(a)"(splitter(l, ',')));
		sets[$-1].sort;
	}
	return sets;
}

bool testSet(uint[] s) {
	static uint[][][][ulong] disjointPairs;
	if (!(s.length in disjointPairs))
		disjointPairs[s.length] = enumNonemptyDisjointPairs(cast(uint)(s.length));

	// N is the number of smallest values to check against the biggest N-1 values.
	const N = (s.length + 1) / 2;

	// test condition 1:
	foreach (dp; disjointPairs[s.length]) {
		auto B = indexed(s, dp[0]);
		ulong sumB = reduce!"a + b"(B);
		auto C = indexed(s, dp[1]);
		ulong sumC = reduce!"a + b"(C); // sum(C)
		if (sumB == sumC) {
			return false;
		}
	}

	// test condition 2:
	uint smallSum = reduce!"a + b"(s[0..N]);
	uint bigSum = reduce!"a + b"(0, s[(s.length / 2 + 1)..$]);
	return smallSum > bigSum;
}

void main() {
	uint sum;
	foreach (s; loadSets) {
		if (testSet(s))
			sum += reduce!"a + b"(s);
	}
	writeln(sum);
}

