// vim: set noet:
//
// Sum square difference
// http://projecteuler.net/problem=6

#include "../lib/common.hpp"
#include <cassert>
#include <iostream>

int diff(int const N) {
	int sum_sq = 0;
	for (int i = 1; i <= N; ++i)
		sum_sq += i*i;
	int sq_sum = (N+1)*N / 2;
	sq_sum *= sq_sum;
	return sq_sum - sum_sq;
}

int main() {
	assert(diff(10) == 2640);
	std::cout << diff(100) << '\n';
}

