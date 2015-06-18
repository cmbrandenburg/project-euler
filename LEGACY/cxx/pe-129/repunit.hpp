// vim: set noet:

#ifndef PE_REPUNIT_HPP
#define PE_REPUNIT_HPP

#include "../lib/common.hpp"

// Returns least value of k such that n divides R(k).
// See problem #129 for details.
unsigned A(unsigned const n) {
	unsigned k = 1;
	unsigned r = 1;
	while (r) {
		r = (10*r + 1) % n;
		++k;
	}
	return k;
}

#endif // #ifndef PE_REPUNIT_HPP 
