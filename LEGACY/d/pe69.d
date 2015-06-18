// vim: set noet ts=2 sw=2:
//
// Totient maximum

import std.stdio;
import prime;

void main() {

	immutable MAX = 1_000_000;

	// Analysis: totient(N) = N * ((p1 - 1) / p1) * ((p2 - 1) / p2) * ..., where
	// p1, p2, ... are the prime factors of N.
	//
	// The smallest totient(K * N) is when K = 1.
	//
	// Thus, we're looking for the smallest N = 2 * 3 * 5 * 7 * 11 * ... such that
	// N <= 1,000,000.

	long prime;
	long prod = 1;
	for (size_t primeIndex = 0;
			(prod * (prime = nthPrime(primeIndex))) <= MAX;
	    primeIndex++) {
		prod *= prime;
	}

	writeln(prod);
}

