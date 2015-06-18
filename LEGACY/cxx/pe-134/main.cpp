// vim: set noet:
//
// Prime pair connection
// http://projecteuler.net/problem=134

#include "../lib/common.hpp"
#include "../lib/factor.hpp"
#include <cassert>
#include <iostream>

typedef unsigned long long solve_t;
unsigned const base = 10;

// Return n such that src * n % base == tgt.
unsigned f(unsigned const tgt, unsigned const src) {
	static class table {
		unsigned vals[base][base];
	public:
		table() {
			for (unsigned i = 1; i < base; ++i) {
				unsigned v = i;
				for (unsigned j = 1; j < base; ++j) {
					if (!vals[i][v])
						vals[i][v] = j;
					v += i;
					v %= base;
				}
			}
		}
		unsigned lookup(unsigned const tgt, unsigned const src) const { return vals[src][tgt]; }
	} const tab;
	return tab.lookup(tgt, src);
}

solve_t S(unsigned const p1, unsigned const p2) {

	unsigned const m1 = p2 % base;
	solve_t acc = 0;
	unsigned carry = 0;
	solve_t b = 1; // base^k
	while (b < p1) {
		unsigned digit = (p1 / b + (base - carry)) % base;
		unsigned m2 = f(digit, m1);
		solve_t prod = p2 * m2 * b;
		b *= base;
		acc += prod;
		carry = acc / b % base;
	}

	return acc;
}

solve_t sum(unsigned const N) {
	solve_t acc = 0;
	unsigned p1;
	for (unsigned i = 3; (p1 = nth_prime<unsigned>(i)) <= N; ++i) {
		unsigned p2 = nth_prime<unsigned>(i+1);
		acc += S(p1, p2);
	}
	return acc;
}

int main() {
	assert(S(5, 7) == 35);
	assert(S(7, 11) == 77);
	assert(S(11, 13) == 611);
	assert(S(19, 23) == 1219);
	assert(S(101, 103) == 48101);
	std::cout << sum(1000000) << '\n';
}

