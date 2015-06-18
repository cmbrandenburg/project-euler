// vim: set noet ts=2 sw=2:

import std.math;
import std.range;

static alias long PInt;
static PrimeGen!PInt pg;

static this() {
	pg = new PrimeGen!PInt;
}

/** Returns the nth prime number, where 2 is the 0th prime, 3 is the 1st prime,
 * etc. */
PInt nthPrime(size_t n) {
	return pg[n];
}

unittest {
	assert(2 == nthPrime(0));
	assert(3 == nthPrime(1));
	assert(5 == nthPrime(2));
	assert(7 == nthPrime(3));
}

/** Returns the 0-based index of P, where P is the smallest prime >= n. */
size_t primeIndex(PInt n) {
	// Use binary search to find the prime.
	pg.popThrough(n + 1);
	auto all = assumeSorted!("a <= b")(pg.primes);
	auto upper = all.upperBound(n);
	return pg.primes.length - upper.length;
}

unittest {
	assert(primeIndex(1) == 0);
	assert(primeIndex(2) == 0);
	assert(primeIndex(3) == 1);
	assert(primeIndex(4) == 2);
	assert(primeIndex(5) == 2);
	assert(primeIndex(6) == 3);
	assert(primeIndex(7) == 3);
	assert(primeIndex(8) == 4);
}

/** Returns whether a given integer is prime. */
bool isPrime(PInt n) {
	if (0 < pg.length && n <= pg.primes[$-1]) {
		// If n has already been found (or skipped over) then use the existing prime
		// searcher to find the prime.
		size_t pos = primeIndex(n);
		return pg.primes[pos] == n;
	}

	if (n < 2) {
		return false;
	}

	// Otherwise, n is possibly very big. Test divisibility against all primes <=
	// sqrt(n).
	long rt = cast(long)(sqrt(cast(real)(n)));
	pg.popThrough(rt);
	long prime;
	for (size_t i; (prime = nthPrime(i)) <= rt; i++) {
		if (n % prime == 0)
			return false;
	}
	return true;
}

unittest {
	assert(!isPrime(1));
	assert(isPrime(2));
	assert(isPrime(3));
	assert(!isPrime(4));
	assert(isPrime(5));
	assert(isPrime(1979));
	assert(!isPrime(4));
	assert(isPrime(5));

	pg.clear();
	assert(!isPrime(1));
}

/** Returns all primes less than n. */
PInt[] enumPrimes(PInt n) {
	size_t i = primeIndex(n);
	return pg.primes[0 .. i];
}

unittest {
	assert([] == enumPrimes(1));
	assert([] == enumPrimes(2));
	assert([2] == enumPrimes(3));
	assert([2, 3] == enumPrimes(4));
	assert([2, 3] == enumPrimes(5));
	assert([2, 3, 5] == enumPrimes(6));
}

class PrimeGen(Int) {

	this() {
		max = 2;
	}

	@property size_t length() const {
		return primes.length;
	}

	unittest {
		auto pg = new PrimeGen!long;
		assert(0 == pg.length);
	}

	Int opIndex(size_t i) {
		while (i >= primes.length) {
			popPrimes(2 * max);
		}
		return primes[i];
	}

	unittest {
		auto pg = new PrimeGen!long;
		assert(0 == pg.length);
		assert(2 == pg[0]);
		assert(2 == pg.length);
		assert(3 == pg[1]);
		assert(2 == pg.length);
		assert(5 == pg[2]);
		assert(7 == pg[3]);
		assert(4 == pg.length);
		assert([2, 3, 5, 7] == pg.primes);
	}

	void popThrough(Int n) {
		while (0 == primes.length || primes[$-1] < n) {
			popPrimes(2 * max);
		}
	}

	unittest {
		auto pg = new PrimeGen!long;
		pg.popThrough(10);
		assert(4 <= pg.length);
		assert([2, 3, 5, 7] == pg.primes[0..4]);
		pg.popThrough(12);
		assert([2, 3, 5, 7, 11] == pg.primes[0..5]);
		pg.popThrough(30);
		assert([2, 3, 5, 7, 11, 13, 17, 19, 23, 29] == pg.primes[0..10]);
	}

	// Populates the array of primes with all primes less than or equal to n.
	// TODO: Try improving performance by implementing this using concurrency.
	private void popPrimes(Int n) {

		// This implements the Sieve of Eratosthenes.

		// trivial case: upper bound has already been reached
		if (n <= max) {
			return;
		}

		// First, take all primes already found and mark masks array such that
		// masks[i] is true if and only if (i-max) is not a prime.

		bool[] masks;
		masks.length = n - max;
		foreach (_, p; primes) {
			for (Int i = ((max - 1) / p + 1) * p; i < n; i += p) {
				masks[i - max] = true;
			}
		}

		// For each mask marked false, add its corresponding prime to the primes
		// array and mark any multiples of the prime in the masks array.

		foreach (size_t i, isPrime; masks) {
			if (!masks[i]) {
				Int p = i + max;
				primes ~= p;
				for (size_t j = i + p; j < n - max; j += p) {
					masks[j] = true;
				}
			}
		}

		max = n;
	}

	private void clear() {
		max = 2;
		primes.length = 0;
	}

	unittest {
		auto pg = new PrimeGen!long;
		pg.popThrough(10);
		pg.clear();
		assert(pg.primes.length == 0);
		assert(pg.max == 2);
	}

	private Int[] primes;
	private Int max;
}

