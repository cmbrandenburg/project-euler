// vim: set noet:
//
// Reciprocal cycles
// http://projecteuler.net/problem=26

#include "../lib/common.hpp"
#include <algorithm>
#include <cassert>
#include <iostream>
#include <vector>

int cycle(int const D) {
	std::vector<int> prev;
	std::vector<int>::const_iterator pos;
	int n = 1; // numerator

	while (n) {
		if (std::end(prev) != (pos = std::find(std::begin(prev), std::end(prev), n)))
			return std::end(prev) - pos;
		prev.push_back(n);
		n *= 10;
		n %= D;
	}
	return 0;
}

int longest(int const N) {
	int value{}, best{};
	for (int i = 2; i < N; ++i) {
		int x = cycle(i);
		if (x > value) {
			value = x;
			best = i;
		}
	}
	return best;
}

int main() {
	assert(cycle(2) == 0);
	assert(cycle(3) == 1);
	assert(cycle(4) == 0);
	assert(cycle(5) == 0);
	assert(cycle(6) == 1);
	assert(cycle(7) == 6);
	assert(cycle(8) == 0);
	assert(cycle(9) == 1);
	assert(cycle(10) == 0);
	std::cout << longest(1000) << '\n';
}

