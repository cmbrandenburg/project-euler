// vim: set noet:
//
// Counting Sundays
// http://projecteuler.net/problem=19

#include "../lib/common.hpp"
#include <cassert>
#include <iostream>

int days(int y, int m) {
	if (1 == m && ((y%100) || !(y%400)))
		return 29; // leap year February
	switch (m) {
		case 1: // Feb
			return 28;
		case 3: // Apr
		case 5: // Jun
		case 8: // Sep
		case 10: // Nov
			return 30;
	}
	return 31;
}

int main() {

	// 1 Jan 1900 was a Monday. 1900 was not a leap year. Therefore, 1 Jan 1901
	// was a Tuesday.

	int c = 0;
	int d = 2; // Tues (0: Sun, 1: Mon, etc.)

	for (int y = 1901; y < 2001; ++y) {
		// 0: Jan, 1: Feb, etc.
		for (int m = 0; m < 12; ++m) {
			if (!d)
				++c;
			d = (d + days(y, m)) % 7;
		}
	}

	std::cout << c << '\n';
}

