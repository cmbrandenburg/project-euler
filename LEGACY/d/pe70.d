// vim: set noet ts=2 sw=2:
//
// Totient permutation

import std.stdio;
import digit;
import prime;

void main() {

	immutable MAX = 10_000_000;

	// It turns out the smallest N will be the product of two primes. This I
	// didn't prove except for first assuming that and then verifying the answer
	// is correct.

	long iPrime;
	real smallestRatio = 0;
	long smallestN;
	for (size_t i = 0; (iPrime = nthPrime(i)) < MAX / 2; i++) {
		long jPrime;
		for (size_t j = i + 1; (jPrime = nthPrime(j)) * iPrime < MAX; j++) {
			long totient = (iPrime - 1) * (jPrime - 1);
			long n = iPrime * jPrime;
			if (enumDigitCounts(totient) == enumDigitCounts(n)) {
				real ratio = 1.0 * n / totient;
				if (smallestRatio == 0 || ratio < smallestRatio) {
					smallestRatio = ratio;
					smallestN = n;
					//writeln(iPrime * jPrime, "\t", totient);
				}
			}
		}
	}	

	writeln(smallestN);
}

