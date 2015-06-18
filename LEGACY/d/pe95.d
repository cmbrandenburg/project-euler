// vim: set noet ts=2 sw=2:
//
// Amicable chains

import std.algorithm;
import std.stdio;
import factor;

void main() {

	immutable maxN = 1_000_000;

	// Find all sums-of-divisors in [1, N].
	int[maxN + 1] divSums;
	for (int i = 1; i <= maxN; i++) {
		divSums[i] = amicable(i);
	}

	// Find longest amicable chain.
	int longestChainLen;
	int longestChainI;
	for (int i = 1; i <= maxN; i++) {
		//int[] path;
		bool[int] reached;
		int chainLen = 1;
		int smallestNInChain = i;
		reached[i] = true;
		//path ~= i;
		int next = divSums[i];
		//path ~= next;
		while (next != 1 && next < maxN && !(next in reached)) {
			chainLen++;
			reached[next] = true;
			next = divSums[next];
			//path ~= next;
		}
		if (next == i && chainLen > longestChainLen) {
			//writeln(i, "\t", path);
			longestChainLen = chainLen;
			longestChainI = i;
		}
	}

	writeln(longestChainI);
}

static Int amicable(Int)(Int n) {
	auto divs = enumDivisors(n);
	Int sum;
	foreach (_, div; divs[0 .. $-1]) {
		sum += div;
	}
	return sum;
}

