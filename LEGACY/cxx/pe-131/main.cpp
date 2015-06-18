// vim: set noet:
//
// Prime cube partnership
// http://projecteuler.net/problem=131

#include "../lib/common.hpp"
#include "../lib/factor.hpp"
#include <cassert>
#include <iostream>
#include <map>

// This problem is really asking: "How many primes less than one million are the
// difference between two cubes?"
//
// Given: n^3 + n^2*p = k^3,
//
// It is true that: (n + p) * n^2 = k^3.
//
// It is further true that n is a cube. If it isn't, then n divides n + p. But
// if n divides n + p then n also divides p and p wouldn't be prime. But p is
// prime, so n doesn't divide n + p, and n is a cube.
//
// Also, n + p is a cube.
//
// So we're looking for values of p such that (1) n is a cube and (2) n + p is a
// cube.
// 

template <typename T> T cube(T const n) {
	return n*n*n;
}

unsigned count(unsigned const N) {
	typedef unsigned long long T;
	std::map<unsigned, bool> primes;
	for (unsigned i = 1; cube(i+1) - cube(i) < N; ++i) {
		T diff;
		for (unsigned j = i+1; (diff = cube(j)-cube(i)) < N; ++j) {
			if (is_prime(diff))
				primes[diff] = true;
		}
	}
	return primes.size();	
}

int main() {
	assert(count(100) == 4);
	std::cout << count(1000000) << '\n';
}

