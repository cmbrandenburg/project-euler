// vim: set noet:

#ifndef PE_FACTOR_HPP
#define PE_FACTOR_HPP

#include "common.hpp"
#include <cassert>
#include <cstdlib>
#include <map>
#include <utility>

typedef unsigned prime_index_t;

// Returns the nth prime number, where 2 is the 1st prime number, 3 is the 2nd
// prime number, etc.
template <typename T> T nth_prime(prime_index_t n);

// Returns the smallest prime factor of n that is greater than or equal to min.
template <typename T> T least_prime_factor(T n, T min = 0);

// Returns whether a given number is prime.
bool is_prime(unsigned long long n);

// Returns the greatest common divisor of two numbers.
template <typename T> T greatest_common_divisor(T a, T b) {
	if (a < b)
		std::swap(a, b);
	assert(b >= 0);
	if (b == 1)
		return 1;
	if (b == 0)
		return a;
	T r = a % b;
	return greatest_common_divisor(b, r);
}

// Returns the least common multiple of two numbers.
template <typename T> T least_common_multiple(T a, T b) {
	if (!a || !b)
		return 0;
	assert(a > 0);
	assert(b > 0);
	T d = greatest_common_divisor(a, b);
	return a / d * b;
}

// Returns the least common multiple of all numbers in a container.
template <typename Container> typename Container::value_type least_common_multiple(Container const &x) {
	typename Container::const_iterator i = x.begin();
	auto m = *i;
	for (++i; i != x.end(); ++i)
		m = least_common_multiple(m, *i);
	return m;
}

// Calls a callback once for each divisor of n, in ascending order.
template <typename T, typename F> void for_each_divisor(T n, F &&f) {
	assert(n>0);
	std::map<T, bool> divs;
	std::map<T, bool> new_divs;
	divs[1] = true;

	T min_p = 0;
	while (n>1) {
		auto p = least_prime_factor(n, min_p);
		n /= p;
		min_p = p;
		new_divs = divs;
		for (auto i = std::begin(divs); i != std::end(divs); ++i)
			new_divs[p * i->first] = true;
		std::swap(divs, new_divs);
	}

	for (auto i = std::begin(divs); i != std::end(divs); ++i)
		f(i->first);
}

#endif // #ifndef PE_FACTOR_HPP
