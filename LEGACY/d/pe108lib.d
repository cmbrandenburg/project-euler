// vim: set noet ts=2 sw=2:

// The number of unique solutions for n is equal to the number of divisors of
// n^2, divided by 2 and rounded up. E.g., n == 6 -> n^2 == 36 has 9 divisors
// {1, 2, 3, 4, 6, 9, 12, 18, 36} -> n has (9+1) / 2 == 5 solutions.
//
// How many divisors does a square number have? There's a fast way to calculate
// this. If n^2 is the square then n = a^A * b^B * c^C * ..., where a, b, c,
// etc. are all the prime numbers and A, B, C, etc. are each >= 0. The number of
// divisors of n^2 is (1 + 2A) * (1 + 2B) * (1 + 2C) * ...
//
// Thus, the trick to solving problem #108 is finding small, very composite
// numbers. Because the number of unique solutions for n is based solely on how
// many prime factors n has and how many times each prime factor is repeated,
// the smallest n with at least K solutions will use the smallest possible prime
// factors. So we don't have to do any actual factorization.

import std.range;
import exponent;
import factor;
import prime;

// Returns smallest n with more than K solutions.
ulong smallestN(const uint K) {

	assert(K >= 1);

	// Find the smallest N with more than K solutions such that N is divisible by
	// each prime number no more than once--e.g., 2 * 3 * 5 * 7 is OK but not 2^2
	// * 3 * 5 * 7.

	ulong sols = 1;
	ulong n = 1;
	uint pIndex = 0;
	uint[] pCounts;
	while (sols <= K) {
		sols += ipow!ulong(3, pIndex);
		n *= nthPrime(pIndex);
		pCounts ~= 1;
		pIndex++;
	}

	// Here's a function for determining how many unique solutions are in a given
	// n, where n is given by the pCounts array.
	uint howManyUniq() {
		uint t = 1;
		foreach (c; pCounts) {
			t *= 1 + 2 * c;
		}
		return (t + 1) / 2;
	}

	// This is a good guess, but there may be a smaller n. Continue stripping the
	// biggest prime and try all combinations of repeated primes so long as (1) n
	// is smaller than our best guess and (2) the number of unique solutions
	// remains greater than K. If stripping a prime doesn't result in a better
	// guess, or if we're out of primes, then we're done.

	ulong bestN = n;
	bool better = true;
	while (better && pCounts.length >= 2) {
		better = false; // must find a better n this iteration or we're done
		pCounts = pCounts[0 .. $-1];
		n /= nthPrime(pCounts.length);
		void recur(const uint pIndex, const uint limit) {
			uint i = 1;
			ulong fact = 1;
			while (limit == 0 || i < limit) {
				const p = nthPrime(pIndex);
				pCounts[pIndex]++;
				n *= p;
				fact *= p;
				i++;
				if (n >= bestN) {
					n /= fact;
					pCounts[pIndex] = 1;
					return;
				}
				sols = howManyUniq();		
				if (sols > K) {
					bestN = n;
					better = true;
					n /= fact;
					pCounts[pIndex] = 1;
					return;
				}
				if (pIndex + 1 < pCounts.length) {
					recur(pIndex + 1, i);
				}
			}
			n /= fact;
			pCounts[pIndex] = 1;
		}
		recur(0, 0);
	}
	return bestN;
}

unittest {
	assert(2 == smallestN(1));
	assert(4 == smallestN(2));
	assert(6 == smallestN(4));
	assert(180180 == smallestN(1000));
}

