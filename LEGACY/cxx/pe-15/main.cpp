// vim: set noet:
//
// Lattice paths
// http://projecteuler.net/problem=15

#include "../lib/common.hpp"
#include <cassert>
#include <iostream>

typedef unsigned long long solve_t;

int const X = 20;
int const Y = 20;

solve_t grid(int const x, int const y) {
	static solve_t memo[Y][X];
	if (!x || !y)
		return 1;
	if (memo[y-1][x-1])
		return memo[y-1][x-1];
	solve_t v = grid(x-1, y) + grid(x, y-1);
	memo[y-1][x-1] = v;
	return v;
}

int main() {
	assert(grid(2, 2) == 6);
	std::cout << grid(20, 20) << '\n';
}

