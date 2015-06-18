// vim: set noet:
//
// Factorial digit sum
// http://projecteuler.net/problem=20

#include "../lib/bigint.hpp"
#include "../lib/common.hpp"
#include <cassert>
#include <iostream>

int sum(int const N, int const base = 10) {
	bigint n = 1;
	for (int i = 2; i <= N; ++i)
		n *= i;
	int sum = 0;
	while (n) {
		sum += static_cast<int>((n % base));
		n /= base;
	}
	return sum;
}

int main() {
	assert(sum(10) == 27);
	std::cout << sum(100) << '\n';
}

