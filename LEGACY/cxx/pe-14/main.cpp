// vim: set noet:
//
// Longest Collatz sequence
// http://projecteuler.net/problem=14

#include "../lib/common.hpp"
#include <cassert>
#include <iostream>
#include <vector>

typedef unsigned long long solve_t;
unsigned const M = 1000000;
unsigned memo[M] = {1}; // base case

unsigned chain(unsigned n) {
	if (n <= M && memo[n-1])
		return memo[n-1];
	unsigned v = 1+chain((n & 1) ? (3*n + 1) : n/2);
	if (n <= M)
		memo[n-1] = v;
	return v;
}

unsigned longest(unsigned const N) {
	unsigned best = 0;
	unsigned best_v = 0;
	for (unsigned i = 1; i < N; ++i) {
		unsigned v = chain(i);
		if (v > best_v) {
			best = i;
			best_v = v;
		}
	}
	return best;
}

int main() {
	assert(chain(13) == 10);
	std::cout << longest(1000000) << '\n';
}

