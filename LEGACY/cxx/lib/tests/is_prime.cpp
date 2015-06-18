// vim: set noet:

#include "../check.hpp"
#include "../factor.hpp"

int main() {
	check(!is_prime(0));
	check(!is_prime(1));
	check(is_prime(2));
	check(is_prime(3));
	check(!is_prime(4));
	check(is_prime(5));
	check(is_prime(6857));
	check(!is_prime(600851475143));
}

