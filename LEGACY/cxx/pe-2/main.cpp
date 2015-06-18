// vim: set noet:
//
// Even Fibonacci numbers
// http://projecteuler.net/problem=2

#include "../lib/common.hpp"
#include <iostream>

int sum(int const N) {
	int sum = 0;
	int a = 1, b = 2;
	while (b < N) {
		if (!(b % 2))
			sum += b;
		int c = a + b;
		a = b;
		b = c;
	}
	return sum;
}

int main() {
	std::cout << sum(4000000) << '\n';
}

