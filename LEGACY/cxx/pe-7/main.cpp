// vim: set noet:
//
// 10001st prime
// http://projecteuler.net/problem=7

#include "../lib/common.hpp"
#include "../lib/factor.hpp"
#include <cassert>
#include <iostream>

int main() {
	assert(nth_prime<unsigned>(6) == 13);
	std::cout << nth_prime<unsigned>(10001) << '\n';
}

