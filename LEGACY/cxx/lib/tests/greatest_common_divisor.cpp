// vim: set noet:

#include "../check.hpp"
#include "../factor.hpp"

int main() {
	check(greatest_common_divisor(0, 0) == 0);
	check(greatest_common_divisor(17, 0) == 17);
	check(greatest_common_divisor(0, 17) == 17);
	check(greatest_common_divisor(1, 1) == 1);
	check(greatest_common_divisor(17, 1) == 1);
	check(greatest_common_divisor(1, 17) == 1);
	check(greatest_common_divisor(2, 2) == 2);
	check(greatest_common_divisor(3, 2) == 1);
	check(greatest_common_divisor(6, 2) == 2);
	check(greatest_common_divisor(6, 12) == 6);
	check(greatest_common_divisor(8, 12) == 4);
	check(greatest_common_divisor(13, 17) == 1);
}

