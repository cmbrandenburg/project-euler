// vim: set noet:
//
// Repunit nonfactors
// http://projecteuler.net/problem=133

#include "../lib/common.hpp"
#include "../lib/factor.hpp"
#include "../pe-129/repunit.hpp"
#include <cassert>
#include <iostream>

// Naive solution: A prime, p, will divide R(10^n) if and only if A(p) has only
// the prime factors 2 and 5.

unsigned sum(unsigned const N) {
	unsigned acc = 2 + 3 + 5 + 7; // these primes won't factor R(10^k)
	unsigned p;
	for (unsigned i = 5; (p = nth_prime<unsigned>(i)) < N; ++i) {
		unsigned d = A(p);
		//unsigned d_ = d;
		while (d % 2 == 0)
			d /= 2;
		while (d % 5 == 0)
			d /= 5;
		if (d == 1)
			continue; // A(p) divides R(10^n)
		acc += p;
		//std::cout << p << ", " << d_ << '\n';
	}
	return acc;
}

unsigned sum_primes_less_than(unsigned const N) {
	unsigned acc = 0, p;
	for (unsigned i = 1; (p = nth_prime<unsigned>(i)) < N; ++i)
		acc += p;
	return acc;
}

int main() {
	assert(sum(100) == sum_primes_less_than(100) - (11 + 17 + 41 + 73));
	std::cout << sum(100000) << '\n';
}

