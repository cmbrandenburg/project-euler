// vim: set noet:
//
// Summation of primes
// http://projecteuler.net/problem=10

#include "../lib/common.hpp"
#include "../lib/factor.hpp"
#include <cassert>
#include <iostream>

uint64_t sum(unsigned const N) {
	uint64_t sum = 0, p;
	for (int i = 1; (p = nth_prime<unsigned>(i)) < N; ++i)
		sum += p;
	return sum;
}

int main() {
	assert(sum(10) == 17);
	std::cout << sum(2000000) << '\n';
}

