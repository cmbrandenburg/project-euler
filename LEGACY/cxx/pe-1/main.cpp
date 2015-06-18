// vim: set noet:
//
// Multiples of 3 and 5
// http://projecteuler.net/problem=1

#include "../lib/common.hpp"
#include <cassert>
#include <iostream>

int sum(int const N) {
	int sum = 0;
	for (int i = 3; i < N; i += 3)
		sum += i;
	for (int i = 5; i < N; i += 15)
		sum += i;
	for (int i = 10; i < N; i += 15)
		sum += i;
	return sum;
}

int main() {
	assert(sum(10) == 23);
	std::cout << sum(1000) << '\n';
}

