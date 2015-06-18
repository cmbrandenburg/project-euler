// vim: set noet:
//
// Same differences
// http://projecteuler.net/problem=135

#include "pe-135.hpp"
#include "../lib/common.hpp"
#include <cassert>
#include <iostream>

int main() {
	assert(f(20, 7) == 27);
	assert(f(6, 3) == 27);
	assert(count(1156, 10) == 1);
	std::cout << count(1000000, 10) << '\n';
}

