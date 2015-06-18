// vim: set noet:
//
// Highly divisible triangular number
// http://projecteuler.net/problem=12

#include "../lib/common.hpp"
#include "../lib/factor.hpp"
#include <cassert>
#include <iostream>

typedef unsigned long long triangle_t;
typedef unsigned prime_t;

unsigned num_divisors(triangle_t const N) {

	// We don't need to calculate the values of the divisors. Instead, we
	// calculate only the prime factors.

	triangle_t x = N;
	prime_t min_p = 1;
	unsigned n = 1; // begin with one divisor: 1
	unsigned prev = 1; // number of unique divisor found previous iteration
	while (x > 1) {
		prime_t p = least_prime_factor(x, static_cast<triangle_t>(min_p));
		x /= p;
		if (min_p != p) {
			// first time having found this prime factor:
			min_p = p;
			prev = n;
			n *= 2; // each divisor may be multiplied by this prime to yield twice as many divisors
		} else {
			// found this prime factor previously:
			n += prev; // each divisor found in the previous iteration may be multiplied by this prime to yield more divisors
		}
	}
	return n;
}

triangle_t first(unsigned const N) {
	triangle_t delta, n;
	for (delta = 1, n = 1; num_divisors(n) <= N; ++delta, n += delta);
	return n;
}

int main() {
	std::cout << first(500) << '\n';
}

