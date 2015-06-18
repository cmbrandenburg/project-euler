// vim: set noet:
//
// Special Pythagorean triplet
// http://projecteuler.net/problem=9

#include "../lib/common.hpp"
#include <cassert>
#include <iostream>

int trip() {
	for (int a = 1; a <= 334; ++a) {
		for (int b = a+1; b <= 500; ++b) {
			int c = 1000 - a - b;
			if (a*a + b*b == c*c)
				return a*b*c;
		}
	}
	assert(false);
	return 0;
}

int main() {
	std::cout << trip() << '\n';
}

