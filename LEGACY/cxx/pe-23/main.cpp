// vim: set noet:
//
// Names scores
// http://projecteuler.net/problem=23

#include "../lib/common.hpp"
#include "../lib/factor.hpp"
#include <cassert>
#include <iostream>
#include <vector>

unsigned constexpr MAX = 28123;

unsigned sum() {

	std::vector<unsigned> abunds;
	for (unsigned i = 12; i < MAX; ++i) {
		unsigned div_acc = 0;
		for_each_divisor(i, [&div_acc](unsigned d) { div_acc += d; });
		div_acc -= i;
		if(div_acc > i)
			abunds.push_back(i);
	}

	bool poss[MAX] = {}; // numbers that are the sum of two abundant numbers
	for (unsigned i = 0; i < abunds.size(); ++i) {
		for (unsigned j = i; j < abunds.size(); ++j) {
			unsigned n = abunds[i] + abunds[j];
			if (n < MAX)
				poss[n] = true;
		}
	}

	unsigned acc = 0;
	for (unsigned i = 1; i < MAX; ++i)
		if (!poss[i])
			acc += i;
	return acc;
}

int main() {
	std::cout << sum() << '\n';
}

