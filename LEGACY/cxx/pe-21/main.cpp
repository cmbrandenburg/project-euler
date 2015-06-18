// vim: set noet:
//
// Amicable numbers
// http://projecteuler.net/problem=21

#include "../lib/common.hpp"
#include "../lib/factor.hpp"
#include <cassert>
#include <iostream>

unsigned d(unsigned const N) {
	unsigned acc = 0;	
	for_each_divisor(N, [&acc](unsigned n) { acc += n; });
	return acc - N;
}

unsigned sum(unsigned const N) {
	unsigned acc = 0;
	unsigned ds[N];
	for (unsigned i = 1; i < N; ++i)
		ds[i] = d(i);
	for (unsigned i = 1; i < N; ++i)
		if (ds[i] > i && ds[i] < N && ds[ds[i]] == i)
			acc += i + ds[i];
	return acc;
}

int main() {
	assert(d(220) == 284);
	assert(d(284) == 220);
	std::cout << sum(10000) << '\n';
}

