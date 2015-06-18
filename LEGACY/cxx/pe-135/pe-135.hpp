#ifndef PE_PE135_HPP
#define PE_PE135_HPP

#include "../lib/common.hpp"
#include <algorithm>
#include <vector>

typedef unsigned long long solve_t;

template <typename T> T square(T const n) { return n*n; }

solve_t f(solve_t x, unsigned delta) {
	return square(x+2*delta) - square(x+delta) - square(x);
}

unsigned count(unsigned const max_n, unsigned const num_sol) {

	std::vector<unsigned> counts(max_n);

	// f(x, d) is maximized for d when x == d and is minimized but still greater
	// than zero when x == 3*d - 1.

	for (unsigned delta = 1; f(3*delta-1, delta) < max_n; ++delta) {
		solve_t v = 0;
		unsigned x;
		for (x = 1; x < 3*delta && (v = f(x, delta)) < max_n; ++x) {
			//std::cout << x << ", " << delta << " -> " << v << '\n';
			++counts[v];
		}
		if (x < 3*delta) {
			for (unsigned x = 3*delta-1; (v = f(x, delta)) < max_n; --x) {
				//std::cout << x << ", " << delta << " -> " << v << '\n';
				++counts[v];
			}
		}
	}

	return std::count(counts.begin(), counts.end(), num_sol);
}

#endif // #ifndef PE_PE135_HPP
