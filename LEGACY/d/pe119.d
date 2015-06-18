// vim: set noet ts=2 sw=2:
//
// Digit power sum

import std.stdio;
import digit;

void main() {
	immutable size_t base = 10;
	immutable size_t L = 30;
	long maxSum;
	long n = 2;
	long[] seq;

	// calculate maximum sum-of-digits:
	long powBase = base;
	while (powBase < long.max / 10)
		powBase *= base;
	maxSum = long.max / powBase + sumDigits(powBase - 1);
	//writeln(long.max, ", ", maxSum);

	// populate array with L elements:
	while (n <= maxSum) {
		long prod = n, prev;
		while (prod > prev) {
			if (prod >= base && sumDigits(prod) == n) {
				//writeln(n, ": ", prod);
				seq ~= prod;
			}
			prev = prod;
			prod *= n;
		}
		n++;
	}

	seq.sort;
	assert(seq.length >= L);
	writeln(seq[L-1]);
}

