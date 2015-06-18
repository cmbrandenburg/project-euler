// vim: set noet ts=2 sw=2:
//
// Prime summations

import std.algorithm;
import std.stdio;
import prime;

void main() {

	long sum(long n, long max) {
		if (n == 0)
			return 1;
		long prime;
		long cnt;
		for (size_t i = 0; (prime = nthPrime(i)) <= max; i++) {
			cnt += sum(n - prime, min(prime, n - prime));
		}
		return cnt;
	}

	long cnt;
	long i;
	for (i = 1; (cnt = sum(i, i - 1)) <= 5000; i++) {
		//writeln(i, "\t", cnt);
	}
	//writeln(i, "\t", cnt);

	writeln(i);
}

