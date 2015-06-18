// vim: set noet:
//
// Smallest multiple
// http://projecteuler.net/problem=5

#include "../lib/common.hpp"
#include "../lib/factor.hpp"
#include <iostream>
#include <vector>

unsigned long long least(int n) {
	std::vector<unsigned long long> v;
	for (int i = 1; i < n; ++i)
		v.push_back(i);
	return least_common_multiple(v);
}

int main() {
	assert(least(10) == 2520);
	std::cout << least(20) << '\n';
}

