// vim: set noet:

#ifndef DIGIT_HPP
#define DIGIT_HPP

#include "common.hpp"
#include <cassert>

// Returns whether a number is a palindrome in the given base.
template <typename T> bool is_palindrome(T const n, int const base = 10) {
	assert(n >= 0);
	T a = n;
	T rev = 0;
	while (a > 0) {
		T d = a % base;
		rev *= base;
		rev += d;
		a -= d;
		a /= base;
	}
	return rev == n;
}

#endif // #ifndef DIGIT_HPP
