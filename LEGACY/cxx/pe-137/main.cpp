// vim: set noet:
//
// Fibonacci golden nuggets
// http://projecteuler.net/problem=137

#include "../lib/common.hpp"
#include <cassert>
#include <iostream>

// The first key to this problem is figuring out the closed form equation for AF(x).
//
//                 AF(x) = x*1 + x^2*1 + x^3*2 + x^4*3 + x^5*5 + x^6*8 + ...
//               x*AF(x) =       x^2*1 + x^3*1 + x^4*2 + x^5*3 + x^6*5 + ...
//           (1-x)*AF(x) = x*1         + x^3*1 + x^4*1 + x^5*2 + x^6*3 + ...
//       (1-x-x^2)*AF(x) = x*1
//                 AF(x) = x / (1-x-x^2)
//
// The second key to this problem is figuring out that x will always be two
// consecutive Fibonacci numbers--e.g., 1/2, 2/3, 3/5, 5/8, ... Note that not
// all consecutive pairs work.

typedef int64_t T;

T nugget(int const N) {
	T a=1, b=1;
	int c = 0; // how many nuggets found?
	T num=1, den=1;
	while (c < N) {
		num = a*b;
		den = a*a - a*b - b*b;
		if (den>0 && num%den == 0)
			++c;
		T new_a = a+b;
		b = a;
		a = new_a;
	}
	return num / den;
}

int main() {
	assert(nugget(1) == 2);
	assert(nugget(10) == 74049690);
	std::cout << nugget(15) << '\n';
}

