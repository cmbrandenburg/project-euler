// vim: set noet:
//
// Largest prime factor
// http://projecteuler.net/problem=3

#include "../lib/common.hpp"
#include "../lib/factor.hpp"
#include <cassert>
#include <iostream>

typedef unsigned long long int_t;

int_t largest(int_t N) {
	int_t p = 1;
	while (N > 1) {
		p = least_prime_factor(N, p);
		N /= p;
	}
	return p;
}

int main() {
	assert(largest(13195) == 29);
	std::cout << largest(600851475143) << '\n';
}

