// vim: set noet:
//
// Palindromic sums
// http://projecteuler.net/problem=125

#include "../lib/common.hpp"
#include "../lib/digit.hpp"
#include <cassert>
#include <iostream>
#include <map>

typedef unsigned long long solve_t;

solve_t sum(unsigned const N) {
	solve_t sum = 0;
	std::map<unsigned, bool> got;
	unsigned rt = 1; // begin with smallest root
	while (rt*rt + (rt+1)*(rt+1) < N) {
		solve_t acc = rt*rt;
		for (unsigned i = rt+1; (acc += i*i) < N; ++i) {
			if (is_palindrome(acc) && got.find(acc) == got.end()) {
				sum += acc;
				got[acc] = true;
			}
		}
		++rt;
	}
	return sum;
}

int main() {
	//assert(sum(1000) == 4164);
	std::cout << sum(100000000) << '\n';
}

