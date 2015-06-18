// vim: set noet:
//
// Repunit divisibility
// http://projecteuler.net/problem=129

#include "repunit.hpp"
#include "../lib/common.hpp"
#include <cassert>
#include <iostream>

// Returns the least value of n for which A(n) first exceeds m.
unsigned least(unsigned const m) {
	for (unsigned i = m - m%10; true; i += 10) {
		if (A(i+1) > m)
			return i+1;
		if (A(i+3) > m)
			return i+3;
		if (A(i+7) > m)
			return i+7;
		if (A(i+9) > m)
			return i+9;
	}
}

int main() {
	assert(least(10) == 17);
	std::cout << least(1000000) << '\n';
}

