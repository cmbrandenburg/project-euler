// vim: set noet ts=2 sw=2:
//
// Summation of primes

import std.stdio;
import prime;

void main() {
	long sum;
	long prime;
	for (size_t i = 0; (prime = nthPrime(i)) < 2000000; i++) {
		sum += prime;
	}
	writeln(sum);
}

