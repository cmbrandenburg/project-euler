// vim: set noet:
//
// Hexagonal tile differences
// http://projecteuler.net/problem=128

// Using pencil and paper, PD(1) == 3 (prime differences: 2, 3, 5) and PD(8) ==
// 3 (prime differences: 11, 13, 29). For any other number, n, in the first two
// rings, R==0 and R==1, PD(n) < 3.
//
// For all rings farther out, starting with R==2, only the smallest and largest
// numbers in the ring may yield a PD value equal to 3. All other numbers have
// two prime differences that are even and greater than two and two prime
// differences equal to one.
//
// The smallest number in a ring is smallest(R) == smallest(R-1) + 6*(R-1),
// where smallest(1) == 2.
//
// The biggest number in a ring is biggest(R) == smallest(R) + 6*R - 1.
//
// The possibly prime differences for the smallest number in a ring are:
//   6*R - 1,
//   6*R + 1, and
//   12*R + 5.
//
// The possibly prime differences for the biggest number in a ring are:
//   6*R - 1,
//   6*R + 5, and
//   12*R - 7.
//

#include "../lib/common.hpp"
#include "../lib/factor.hpp"
#include <cassert>
#include <iostream>

typedef unsigned long long solve_t;

solve_t seq(solve_t const N) {
	if (1 == N)
		return 2;
	if (2 == N)
		return 8;
	solve_t n = 2; // numbers found in sequence so far
	solve_t small = 2;
	solve_t R = 1;
	while (true) {
		++R;
		small += 6*(R-1);

		if (!is_prime(6*R - 1))
			continue; // common to both small and big

		if (is_prime(6*R + 1) && is_prime(12*R + 5)) {
			++n;
			if (n == N)
				return small;
		}

		if (is_prime(6*R + 5) && is_prime(12*R - 7)) {
			++n;
			if (n == N)
				return small + 6*R - 1;
		}
	}
}

int main() {
	assert(seq(10) == 271);
	std::cout << seq(2000) << '\n';
}

