// vim: set noet:
//
// Number letter counts
// http://projecteuler.net/problem=17

#include "../lib/common.hpp"
#include <cassert>
#include <cstring>
#include <iostream>

int letters(int const N) {
	if (0 == N)
		return 0;
	if (1 == N)
		return std::strlen("one");
	if (2 == N)
		return std::strlen("two");
	if (3 == N)
		return std::strlen("three");
	if (4 == N)
		return std::strlen("four");
	if (5 == N)
		return std::strlen("five");
	if (6 == N)
		return std::strlen("six");
	if (7 == N)
		return std::strlen("seven");
	if (8 == N)
		return std::strlen("eight");
	if (9 == N)
		return std::strlen("nine");
	if (10 == N)
		return std::strlen("ten");
	if (11 == N)
		return std::strlen("eleven");
	if (12 == N)
		return std::strlen("twelve");
	if (13 == N)
		return std::strlen("thirteen");
	if (14 == N)
		return std::strlen("fourteen");
	if (15 == N)
		return std::strlen("fifteen");
	if (16 == N)
		return std::strlen("sixteen");
	if (17 == N)
		return std::strlen("seventeen");
	if (18 == N)
		return std::strlen("eighteen");
	if (19 == N)
		return std::strlen("nineteen");
	if (20 <= N && N < 30)
		return std::strlen("twenty") + letters(N-20);
	if (30 <= N && N < 40)
		return std::strlen("thirty") + letters(N-30);
	if (40 <= N && N < 50)
		return std::strlen("forty") + letters(N-40);
	if (50 <= N && N < 60)
		return std::strlen("fifty") + letters(N-50);
	if (60 <= N && N < 70)
		return std::strlen("sixty") + letters(N-60);
	if (70 <= N && N < 80)
		return std::strlen("seventy") + letters(N-70);
	if (80 <= N && N < 90)
		return std::strlen("eighty") + letters(N-80);
	if (90 <= N && N < 100)
		return std::strlen("ninety") + letters(N-90);
	if (100 <= N && N < 1000)
		return letters(N/100) + std::strlen("hundred") + (N%100 ? (std::strlen("and") + letters(N%100)) : 0);
	if (1000 == N)
		return std::strlen("one") + std::strlen("thousand");
	assert(false);
	return 0;
}

int sum(int const N) {
	int sum = 0;
	for (int i = 1; i <= N; ++i)
		sum += letters(i);
	return sum;
}

int main() {
	assert(sum(5) == 19);
	assert(letters(342) == 23);
	assert(letters(115) == 20);
	std::cout << sum(1000) << '\n';
}

