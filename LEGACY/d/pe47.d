// vim: set noet ts=2 sw=2:
//
// Distinct primes factors

import std.stdio;
import prime;

static immutable seqLen = 4;

// E.g., 20 -> [*4*, 5]
static long[] enumPrimeBasedFactors(Int)(Int n) {
	long[] primes;
	while (n > 1) {
		long prime = n;
		if (!isPrime(n)) {
			for (size_t i; n % (prime = nthPrime(i)) != 0; i++) {
			}
		}
		n /= prime;
		primes ~= prime;
	}
	long[long] primeCnts;
	foreach (_, prime; primes) {
		primeCnts[prime]++;
	}
	long[] facts;
	foreach (prime, cnt; primeCnts) {
		long fact = 1;
		for (int i = 0; i < cnt; i++) {
			fact *= prime;
		}
		facts ~= fact; 
	}
	return facts;
}

void main() {
	long i = 1;
	long[][] facts;
	for (int j = 0; j < seqLen; j++) {
		facts ~= enumPrimeBasedFactors(i + j);
	}
	while (true) {
		bool[long] map;
		for (int j = 0; j < seqLen; j++) {
			foreach (_, theseFacts; facts) {
				if (theseFacts.length != seqLen) {
					goto next;
				}
			}
			foreach (_, fact; facts[j]) {
				if ((fact in map) != null) {
					goto next;
				}
				map[fact] = true;
			}
		}
		break;
next:
		for (int j = 0; j < seqLen - 1; j++) {
			facts[j] = facts[j + 1];
		}
		facts[seqLen - 1] = enumPrimeBasedFactors(i + seqLen);
		i++;
	}
	writeln(i);
}

