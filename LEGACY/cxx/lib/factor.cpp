// vim: set noet:

#include "factor.hpp"
#include <algorithm>
#include <cassert>
#include <vector>

template <typename T> class prime_gen {
	T max;
	std::vector<T> primes;
	std::vector<bool> mask;
	typedef typename std::vector<T>::size_type size_type;
	typedef typename std::vector<T>::const_iterator const_iterator;
public:
	prime_gen(): max(2), mask{false, false} {}
	prime_gen(prime_gen const &) = default;
	prime_gen(prime_gen &&) = default;
	prime_gen &operator=(prime_gen const &) = default;
	prime_gen &operator=(prime_gen &&) = default;
	void populate_n_primes(size_type n);
	void populate_primes_less_than(T n);
	T operator[](size_type n) const { return primes[n]; }
	operator std::vector<T> const &() const { return primes; }
	const_iterator begin() const { return primes.begin(); }
	const_iterator end() const { return primes.end(); }
	size_type index(T n) const; // XXX
	void more();
	T maximum() const { return max; }
	size_type count() const { return primes.size(); }
	T biggest() const { return primes[primes.size()-1]; }
	bool empty() const { return primes.empty(); }
	bool has(T n) const { assert(n < max); return mask[n]; }
};

template <typename T> void prime_gen<T>::populate_n_primes(size_type n) {
	while (primes.size() < n)
		populate_primes_less_than(2*max);
}

template <typename T> void prime_gen<T>::populate_primes_less_than(T n) {
	if (static_cast<size_type>(n) < mask.size())
		return; // don't shrink
	mask.resize(n, true); // assume all new numbers are prime until proved otherwise
	for (auto p: primes) {
		T r = max%p;
		for (T j = max+(r?p-r:0); j < n; j += p)
			mask[j] = false;
	}
	for (T i = max; i < n; ++i) {
		if (mask[i]) {
			for (T j = i+i; j < n; j += i)
				mask[j] = false;
			primes.push_back(i);
		}
	}
	max = n;
}

template <typename T> void prime_gen<T>::more() {
	populate_primes_less_than(2*max);
}

// Prime generator singleton
template <typename T> prime_gen<T> &pgen_instance() {
	static prime_gen<T> pg;
	return pg;
}

//------------------------------------------------------------------------------

template unsigned nth_prime<unsigned>(prime_index_t);
template unsigned long nth_prime<unsigned long>(prime_index_t);
template unsigned long long nth_prime<unsigned long long>(prime_index_t);

template <typename T> T nth_prime(prime_index_t const n) {
	auto &pgen = pgen_instance<T>();
	pgen.populate_n_primes(n);
	return pgen[n-1];
}

template unsigned least_prime_factor<unsigned>(unsigned, unsigned);
template unsigned long least_prime_factor<unsigned long>(unsigned long, unsigned long);
template unsigned long long least_prime_factor<unsigned long long>(unsigned long long, unsigned long long);

template <typename T> T least_prime_factor(T const n, T const min) {
	auto &pgen = pgen_instance<T>();

	assert(n >= 2);

	// lower bound:
	std::size_t i = 0;
	if (min) {
		if (pgen.empty() || pgen.biggest() < min) {
			pgen.populate_primes_less_than(min);
			i = pgen.count();
		} else {
			i = std::lower_bound(pgen.begin(), pgen.end(), min) - pgen.begin();
		}
	}

	while (true) {

		// try to find prime already calculated:
		for (; i < pgen.count() && pgen[i]*pgen[i] <= n; ++i) {
			if (!(n % pgen[i]))
				return pgen[i];
		}

		if (i < pgen.count())
			return n; // n is prime

		// need more primes:
		pgen.more();
	}

	return n; // n is prime
}

bool is_prime(unsigned long long n) {
	auto &pgen = pgen_instance<unsigned>();

	// If the prime generator has tested n then do a lookup.
	if (n < pgen.maximum())
		return pgen.has(n);

	return least_prime_factor(n) == n;
}

