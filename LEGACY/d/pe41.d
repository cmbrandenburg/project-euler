// vim: set noet ts=2 sw=2:
//
// Pandigital prime

import std.stdio;
import digit;
import prime;

void main() {

	// No 8- or 9-digit prime pandigital numbers exists because all 8- and 9-digit
	// pandigital numbers' digits sum to either 36 or 45 (1 + 2 + 3 + ... + 8 [+
	// 9]), and any number whose digits sum to N, where N is evenly divisible by
	// 3, is also divisible by 3.

	long biggest;
	long prime;
	for (size_t i; (prime = nthPrime(i)) <= 7_654_321; i++) {
		if (isPartialPandigital(prime))
			biggest = prime;
	}

	writeln(biggest);
}

