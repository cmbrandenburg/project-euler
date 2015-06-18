// vim: set noet ts=2 sw=2:
//
// Consecutive prime sum

import std.stdio;
import prime;

void main() {

	immutable max = 1000000; 

	long longestLen;
	long longestSum;
	long iPrime;
	long[] sums;
	for (size_t i; (iPrime = nthPrime(i)) < 1_000_000; i++) {
		long sum = iPrime;
		sums ~= iPrime;
		long cnt = 1;
		long jPrime;
		for (size_t j = i + 1; sum + (jPrime = nthPrime(j)) < max; j++) {
			sum += jPrime;
			sums ~= jPrime;
			cnt++;
			if (cnt > longestLen && isPrime(sum)) {
				longestLen = cnt;
				longestSum = sum;
			}
		}
	}

	writeln(longestSum);
}

