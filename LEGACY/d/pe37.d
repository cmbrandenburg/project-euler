// vim: set noet ts=2 sw=2:
//
// Truncatable primes

import std.stdio;
import prime;
import exponent;

void main() {

	bool isTruncatablePrime(long n) {

		// Work from right.
		long nCp = n / 10;
		while (nCp > 0) {
			if (!isPrime(nCp))
				return false;
			nCp /= 10;
		}

		// Work from left.
		long mostSig = ipow(10, ilog(n));
		nCp = n;
		nCp -= (nCp / mostSig) * mostSig;
		while (nCp > 0) {
			if (!isPrime(nCp))
				return false;
			mostSig /= 10;
			nCp -= (nCp / mostSig) * mostSig;
		}
		return true;
	}

	long iPrime, prime;
	while ((prime = nthPrime(iPrime)) < 10) {
		iPrime++;
	}

	int cnt;
	long sum;
	while (cnt < 11) {
		import std.stdio;
		if (isTruncatablePrime(prime)) {
			sum += prime;
			cnt++;
		}
		prime = nthPrime(++iPrime);
	}
	writeln(sum);
}

