// vim: set noet:

#include "../check.hpp"
#include "../factor.cpp"

int main() {
	auto &pgen = pgen_instance<unsigned>();
	pgen.populate_primes_less_than(10);
	check(4 == pgen.count());
	check(2 == pgen[0]);
	check(3 == pgen[1]);
	check(5 == pgen[2]);
	check(7 == pgen[3]);
}


