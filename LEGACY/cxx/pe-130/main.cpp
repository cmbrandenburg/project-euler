// vim: set noet:
//
// Composites with prime repunit property
// http://projecteuler.net/problem=130

#include "../lib/common.hpp"
#include "../lib/factor.hpp"
#include "../pe-129/repunit.hpp"
#include <cassert>
#include <iostream>

unsigned sum(unsigned const N) {
	unsigned acc = 0, cnt = 0;
	std::size_t pi = 0;
	unsigned c = 2; // composite
	while (cnt < N) {
		unsigned p = nth_prime<unsigned>(++pi);
		// test all composites until next prime:
		for (; c < p; ++c) {
			if (c%10 == 1 || c%10 == 3 || c%10 == 7 || c%10 == 9) {
				unsigned k = A(c);
				if ((c-1) % k == 0) {
					acc += c;
					++cnt;
				}
			}
		}
		++c; // skip prime
	}

	return acc;
}

int main() {
	assert(sum(5) == 91+259+451+481+703);
	std::cout << sum(25) << '\n';
}

