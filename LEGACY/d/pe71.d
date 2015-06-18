// vim: set noet ts=2 sw=2:
//
// Ordered fractions

import std.stdio;
import factor;

void main() {
	long biggestNum;
	long biggestDenom;
	for (long denom = 8; denom <= 1_000_000; denom++) {
		long num = 3 * denom / 7;
		if (gcd(num, denom) == 1) {
			if (biggestNum == 0 || num * biggestDenom > biggestNum * denom) {
				biggestNum = num;
				biggestDenom = denom;
				//writeln(num, " / ", denom);
			}
		}
	}
	writeln(biggestNum);
}
