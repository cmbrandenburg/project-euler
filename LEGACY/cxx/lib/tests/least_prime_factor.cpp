// vim: set noet:

#include "../check.hpp"
#include "../factor.hpp"

int main() {
	check(least_prime_factor<unsigned>(2) == 2);
	check(least_prime_factor<unsigned>(3) == 3);
	check(least_prime_factor<unsigned>(4) == 2);
	check(least_prime_factor<unsigned>(5) == 5);
	check(least_prime_factor<unsigned>(6) == 2);
	check(least_prime_factor<unsigned>(1000) == 2);
	check(least_prime_factor<unsigned>(2) == 2);

	// 13195 = 5 * 7 * 13 * 29
	check(least_prime_factor<unsigned>(13195) == 5);
	check(least_prime_factor<unsigned>(13195/5) == 7);
	check(least_prime_factor<unsigned>(13195/5/7) == 13);
	check(least_prime_factor<unsigned>(13195/5/7/13) == 29);

	// with min:
	check(least_prime_factor<unsigned>(13195, 1) == 5);
	check(least_prime_factor<unsigned>(13195, 2) == 5);
	check(least_prime_factor<unsigned>(13195, 3) == 5);
	check(least_prime_factor<unsigned>(13195, 4) == 5);
	check(least_prime_factor<unsigned>(13195, 5) == 5);
	check(least_prime_factor<unsigned>(13195, 6) == 7);
	check(least_prime_factor<unsigned>(13195, 7) == 7);
	check(least_prime_factor<unsigned>(13195, 8) == 13);
	check(least_prime_factor<unsigned>(13195, 29) == 29);
	check(least_prime_factor<unsigned>(13195, 30) == 13195);
}

