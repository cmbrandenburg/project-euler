// vim: set noet:

#include "../check.hpp"
#include "../factor.hpp"

int main() {

	// two arguments:
	check(least_common_multiple(0, 0) == 0);
	check(least_common_multiple(1, 0) == 0);
	check(least_common_multiple(0, 1) == 0);
	check(least_common_multiple(1, 1) == 1);
	check(least_common_multiple(17, 1) == 17);
	check(least_common_multiple(1, 17) == 17);
	check(least_common_multiple(2, 2) == 2);
	check(least_common_multiple(3, 2) == 6);
	check(least_common_multiple(6, 2) == 6);
	check(least_common_multiple(6, 12) == 12);
	check(least_common_multiple(8, 12) == 24);
	check(least_common_multiple(13, 17) == 13*17);

	// many arguments:
	check(least_common_multiple(std::initializer_list<int>{0, 0}) == 0);
	check(least_common_multiple(std::initializer_list<int>{2, 3, 4}) == 12);
	check(least_common_multiple(std::initializer_list<int>{2, 9, 4}) == 36);
}

