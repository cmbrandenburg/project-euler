// vim: set noet:
//
// Power digit sum
// http://projecteuler.net/problem=16

#include "../lib/bigint.hpp"
#include "../lib/common.hpp"
#include <cassert>
#include <iostream>

int sum(int const N) {
	static int const base = 10;
	bigint C = 1;
	for (int i = 0; i < N; ++i)
		C *= 2;
	unsigned sum = 0;
	while (C) {
		sum += static_cast<int>(C % base);
		C /= base;
	}
	return sum;
}

int main() {
	assert(sum(15) == 26);
	std::cout << sum(1000) << '\n';
}

