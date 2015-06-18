// vim: set noet ts=2 sw=2:
//
// Largest prime factor

import std.algorithm;
import std.stdio;
import factor;

void main() {
	long num = 600851475143;
	long biggestFactor;
	while (num > 1) {
		long prime = smallestFactor(num);
		biggestFactor = max(biggestFactor, prime);
		num /= prime;
	}
	writeln(biggestFactor);
}

