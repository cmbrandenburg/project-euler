// vim: set noet ts=2 sw=2:

import std.algorithm;
import std.math;
import prime;

/// Returns the least common multiple of one or more positive numbers.
Int gcd(Int)(Int[] nums) {
	assert(nums.length >= 1);
	if (nums.length == 1) {
		return nums[0];
	}
	return gcd(nums[0], gcd(nums[1..$]));
}

unittest {
	assert(gcd([1, 1, 1]) == 1);
	assert(gcd([1, 2, 1]) == 1);
	assert(gcd([2, 2, 2]) == 2);
	assert(gcd([2, 2, 4]) == 2);
	assert(gcd([2, 4, 2]) == 2);
	assert(gcd([4, 2, 2]) == 2);
	assert(gcd([6, 36, 48]) == 6);
	assert(gcd([16, 36, 48]) == 4);
}

/// Returns the greatest common divisor of exactly two positive numbers.
Int gcd(Int)(Int x, Int y) {
	return x < y ? fastGcd(y, x) : fastGcd(x, y);
}

static Int fastGcd(Int)(Int max, Int min) {
	while (min > 1) {
		Int nextMin = max % min;
		max = min;
		min = nextMin;
	}
	return min == 0 ? max : cast(Int)(1);
}

unittest {
	assert(gcd(1, 1) == 1);
	assert(gcd(1, 7) == 1);
	assert(gcd(2, 7) == 1);
	assert(gcd(7, 7) == 7);
	assert(gcd(2, 14) == 2);
	assert(gcd(12, 16) == 4);
	assert(gcd(12, 24) == 12);
	assert(gcd(15, 20) == 5);
}

/// Returns the least common multiple of one or more positive numbers.
Int lcm(Int)(Int[] factors) {
	assert(factors.length >= 1);
	if (factors.length == 1) {
		return factors[0];
	}
	return lcm(factors[0], lcm(factors[1..$]));
}

unittest {
	assert(lcm([1, 1, 1]) == 1);
	assert(lcm([1, 1, 2]) == 2);
	assert(lcm([2, 1, 1]) == 2);
	assert(lcm([2, 2, 2]) == 2);
	assert(lcm([3, 2, 2]) == 6);
	assert(lcm([2, 3, 2]) == 6);
	assert(lcm([2, 3, 7]) == 42);
	assert(lcm([7, 2, 3]) == 42);
}

/// Returns the least common multiple of exactly two positive numbers.
Int lcm(Int)(Int x, Int y) {
	return x * y / gcd(x, y);
}

unittest {
	assert(lcm(1, 1) == 1);
	assert(lcm(1, 2) == 2);
	assert(lcm(2, 1) == 2);
	assert(lcm(2, 2) == 2);
	assert(lcm(2, 3) == 6);
	assert(lcm(3, 2) == 6);
	assert(lcm(2, 4) == 4);
	assert(lcm(4, 2) == 4);
	assert(lcm(8, 12) == 24);
	assert(lcm(12, 8) == 24);
	assert(lcm(12, 12) == 12);
	assert(lcm(15, 20) == 60);
}

long smallestFactor(long n) {
	long i;
	long prime;
	for (; n % (prime = nthPrime(i)) != 0; i++) {
	}
	return prime;
}

unittest {
	assert(smallestFactor(2) == 2);
	assert(smallestFactor(100) == 2);
	assert(smallestFactor(81) == 3);
	assert(smallestFactor(169) == 13);
}

/// Returns an array of all divisors for a given number.
Int[] enumDivisors(Int)(Int x) {
	bool[Int] divisors;
	while (x > 1) {
		long prime = x;
		if (!isPrime(x)) {
			for (size_t i = 0; x % (prime = nthPrime(i)) != 0; i++) {
			}
		}
		x /= prime;
		Int[] newDivisors;
		foreach (div, _; divisors) {
			newDivisors ~= cast(Int)(div * prime);
		}
		foreach (_, div; newDivisors) {
			divisors[div] = true;
		}
		divisors[cast(Int)(prime)] = true;
	}
	divisors[1] = true;
	auto divs = divisors.keys;
	divs.sort;
	return divs;
}

unittest {
	assert(enumDivisors(1) == [1]);
	assert(enumDivisors(2) == [1, 2]);
	assert(enumDivisors(3) == [1, 3]);
	assert(enumDivisors(4) == [1, 2, 4]);
	assert(enumDivisors(6) == [1, 2, 3, 6]);
	assert(enumDivisors(12) == [1, 2, 3, 4, 6, 12]);
}

long[] enumPrimeFactors(Int)(Int n) {
	bool[long] primeMap;
	long rtN = cast(long)(sqrt(cast(real)(n))) + 1;
	while (n > 1) {
		long prime;
		for (size_t i = 0; (prime = nthPrime(i)) < rtN; i++) {
			if (n % prime == 0) {
				n /= prime;
				primeMap[prime] = true;
				break;
			}
		}
		if (prime >= rtN) {
			primeMap[n] = true;
			break;
		}
	}
	long[] primes = primeMap.keys;
	primes.sort();
	return primes;
}

