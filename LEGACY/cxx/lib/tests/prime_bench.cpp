// vim: set noet:

#include "../factor.hpp"
#include <iostream>

int main(int argc, char **argv) {
	if (argc < 2) {
		std::cerr << "prime_bench: Calculates all prime numbers less than N\n"
			"\n"
			"Usage: prime_bench N\n"
			"\n";
		exit(0);
	}
	unsigned const N = std::stoul(argv[1]);
	unsigned long long acc = 0;
	unsigned p;
	prime_index_t i;
	for (i = 1; (p = nth_prime<unsigned>(i)) < N; ++i)
		acc += p;
	std::cout << "cardinality : " << i-1 << '\n';
	std::cout << "sum         : " << acc << '\n';
}

