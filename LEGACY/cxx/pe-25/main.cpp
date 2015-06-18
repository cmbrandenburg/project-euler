// vim: set noet:
//
// 1000-digit Fibonacci number
// http://projecteuler.net/problem=25

#include "../lib/bigint.hpp"
#include "../lib/common.hpp"
#include <cassert>
#include <iostream>

unsigned digits(bigint const &n, unsigned const base=10) {
	bigint v = n;
	unsigned c=0;
	while (v) {
		c++;
		v /= base;
	}
	return c;
}

// Returns the nth Fibonacci term to contain N digits.
unsigned first(unsigned const N, unsigned const base=10) {
	if (1==N)
		return 1;
	bigint prev=1, next=2;
	unsigned c = 3;
	while (digits(next) < N) {
		auto t = next+prev;
		prev = next;
		next = t;
		++c;
	}
	return c;
}

int main() {
	assert(digits(1) == 1);
	assert(digits(12) == 2);
	assert(digits(123) == 3);
	assert(digits(1000) == 4);
	assert(first(3) == 12);
	std::cout << first(1000) << '\n';
}

