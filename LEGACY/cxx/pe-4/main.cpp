// vim: set noet:
//
// Largest palindrome product
// http://projecteuler.net/problem=4

#include "../lib/common.hpp"
#include "../lib/digit.hpp"
#include <cassert>
#include <iostream>

int largest(int N) {
	int a = N-1, b = N-1;
	int big = 0;
	int p;
	while ((p = a*b) > big || !big) {
		do {
			if (is_palindrome(p)) {
				big = p;
				break;
			}
			--b;
		} while ((p = a*b) > big || !big);
		--a;
		b = a;
	}
	return big;
}

int main() {
	assert(largest(100) == 9009);
	std::cout << largest(1000) << '\n';
}

