// vim: set noet:

#include "../check.hpp"
#include "../factor.hpp"

int main() {
	check(nth_prime<unsigned>(1) == 2);
	check(nth_prime<unsigned>(2) == 3);
	check(nth_prime<unsigned>(3) == 5);
	check(nth_prime<unsigned>(4) == 7);
	check(nth_prime<unsigned>(5) == 11);
	check(nth_prime<unsigned>(6) == 13);
}

