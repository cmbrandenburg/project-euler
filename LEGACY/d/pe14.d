// vim: set noet ts=2 sw=2:
//
// Longest Collatz sequence

import std.stdio;

void main() {

	long len(long x) {
		long cnt = 1;
		while (x != 1) {
			if (x % 2 == 0) {
				x /= 2;
			} else {
				x = 3 * x + 1;
			}
			cnt++;
		}
		return cnt;
	}

	long longestBase;
	long longestChain;
	for (long i = 1; i < 1000000; i++) {
		long chainLen = len(i);
		if (chainLen > longestChain) {
			longestChain = chainLen;
			longestBase = i;
		}
	}
	writeln(longestBase);
}

