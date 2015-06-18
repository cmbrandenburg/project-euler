// vim: set noet:
//
// abc-hits
// http://projecteuler.net/problem=127

#include "../lib/common.hpp"
#include "../lib/factor.hpp"
#include <algorithm>
#include <cassert>
#include <iostream>
#include <map>
#include <vector>

// Mathematical invariants:
//
// (1) If a, b, and c are coprime then rad(a*b*c) == rad(a) * rad(b) * rad(c).
//
// (2) If a + c == c and (gcd(a, b) == 1 or gcd(a, c) or gcd(b, c) == 1) then
// gcd(a, b, c) == 1.

// A Prime Table maps each number [1, N) to (1) its radical and (2) its distinct
// prime factors sorted in ascending order.
struct prime_table_entry {
	unsigned rad;
	std::vector<unsigned> primes;
};
typedef std::vector<prime_table_entry> prime_table;

prime_table make_prime_table(unsigned const N) {
	prime_table ptab(N);
	for (unsigned i = 1; i < N; ++i) {
		ptab[i].rad = 1;
		unsigned d = 1;
		unsigned n = i;
		while (n > 1) {
			unsigned next_d = least_prime_factor(n, d);
			if (next_d != d) {
				d = next_d;
				ptab[i].primes.push_back(d);
				ptab[i].rad *= d;
			}
			n /= d;
		}
	}
	return ptab;
}

// A Reverse Radical Table maps each number, c, to all numbers n such that
// rad(n) == c.
typedef std::map<unsigned, std::vector<unsigned>> reverse_radical_table;

reverse_radical_table make_reverse_radical_table(prime_table const &ptab) {
	reverse_radical_table rtab;
	for (unsigned i = 1; i < ptab.size(); ++i) {
		rtab[ptab[i].rad].push_back(i);
	}
	return rtab;
}

// Returns whether two containers contain no common elements. The containers
// must be sorted in ascending order.
template <typename Container> bool is_union_empty(Container const &a, Container const &b) {
	for (auto i = a.begin(); i != a.end(); ++i) {
		for (auto j = b.begin(); j != b.end(); ++j) {
			if (*i == *j)
				return false;
			if (*i < *j)
				break; // all subsequent *j are bigger that this *j
		}
	}
	return true;
}

unsigned sum(unsigned const N) {

	// A+B=C and C<N

	unsigned sum = 0;

	// lookup tables:
	auto ptab = make_prime_table(N);
	auto rtab = make_reverse_radical_table(ptab);

	for (unsigned c = 3; c < N; ++c) {
		unsigned long long const crad = ptab[c].rad;
		if (crad == c)
			continue; // discard c when c has no duplicated prime factors
		unsigned brad_max = c / crad;
		for (auto bi = rtab.begin(); bi->first <= brad_max; ++bi) {
			unsigned long long const brad = bi->first;
			if (brad == 1)
				continue; // b, and therefore rad(b), must be >= 2
			if (!is_union_empty(ptab[crad].primes, ptab[brad].primes))
				continue; // a, b, and c are not coprime
			for (auto bj = bi->second.begin(); bj != bi->second.end(); ++bj) {
				unsigned const b = *bj;
				if (b >= c)
					break; // b is too big and will only get bigger
				unsigned const a = c - b;
				if (a >= b)
					continue;
				unsigned long long const arad = ptab[a].rad;
				if (arad * brad * crad >= c)
					continue; // rad(a*b*c) >= c
				sum += c;
			}
		}
	}

	return sum;
}

int main() {
	assert(sum(1000) == 12523);
	std::cout << sum(120000) << '\n';
}

