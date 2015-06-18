// vim: set noet:
//
// Singleton difference
// http://projecteuler.net/problem=136

#include "../pe-135/pe-135.hpp"
#include "../lib/common.hpp"
#include <cassert>
#include <iostream>

int main() {
	assert(count(100, 1) == 25);
	std::cout << count(50000000, 1) << '\n';
}

