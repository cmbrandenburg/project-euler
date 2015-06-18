// vim: set noet ts=2 sw=2:
//
// Quadratic primes

import std.stdio;
import prime;

void main() {

	long q(long a, long b, long n) {
		return n * n + a * n + b;
	}

	long bestA, bestB, bestN;
	for (long a = -999; a < 1000; a++) {
		for (long b = -999; b < 1000; b++) {
			bool ok = true;
			long n = 0;
			do {
				long val = q(a, b, n);
				if (!isPrime(val)) {
					ok = false;
				} else {
					n++;
				}
			} while (ok);
			if (n > bestN) {
				bestA = a;
				bestB = b;
				bestN = n;
			}
		}
	}

	writeln(bestA * bestB);
}

