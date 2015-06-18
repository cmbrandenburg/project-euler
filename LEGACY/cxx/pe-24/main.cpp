// vim: set noet:
//
// Lexicographic permutations
// http://projecteuler.net/problem=24

#include "../lib/common.hpp"
#include <algorithm>
#include <cassert>
#include <iostream>
#include <vector>

unsigned perm(unsigned const N) {
	std::vector<unsigned> digs{0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
	for (unsigned i = 1; i < N; ++i)
		std::next_permutation(std::begin(digs), std::end(digs));
	unsigned v = 0;
	for (auto &&i: digs)
		v = 10*v + i;
	return v;
}

int main() {
	std::cout << perm(1000000) << '\n';
}

