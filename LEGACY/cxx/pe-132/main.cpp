// vim: set noet:
//
// Large repunit factors
// http://projecteuler.net/problem=132

#include "../pe-129/repunit.hpp"
#include "../lib/bigint.hpp"
#include "../lib/common.hpp"
#include "../lib/factor.hpp"
#include <cassert>
#include <iostream>

#if 0

// My original implementation
unsigned long long first(unsigned const N, unsigned const C) {
	unsigned long long acc = 0;
	unsigned cnt = 0;

	// skip p == 2

	// test p == 3
	if (N % A(3) == 0) {
		++cnt;
		acc += 3;
	}

	// skip p == 5

	// test all other primes
	for (unsigned i = 4; cnt < C; ++i) {
		unsigned p = nth_prime<unsigned>(i);
		if (N % A(p) == 0) {
			++cnt;
			acc += p;
		}
	}
	return acc;
}

#else

unsigned pow10mod(unsigned exp, unsigned div) {
	unsigned r = 1;
	for (unsigned p = 0; p < exp; ++p) {
		r *= 10;
		r %= div;
	}
	return r;
}

// Using a comment on the #132 message board:
//
// p divides R (10^9) iff A (p) divides 10^9 iff 10^(gcd (10^9, p - 1)) mod p
// == 1 , allows 3 which must be removed from the sum
//
unsigned long long first(unsigned const N, unsigned const C) {

	unsigned long long acc = 0;
	unsigned cnt = 0;

	// Only primes > 10 meet the criteria.

	for (unsigned i = 4; cnt < C; ++i) {
		unsigned p = nth_prime<unsigned>(i);
		unsigned d = greatest_common_divisor<unsigned>(N, p-1);
		if (pow10mod(d, p) == 1) {
			++cnt;
			acc += p;
		}
	}
	return acc;
}

#endif

int main() {
	assert(first(10, 4) == 9414);
	std::cout << first(1000000000, 40) << '\n';
}

