// vim: set noet ts=2 sw=2:
//
// Digit fifth powers

import std.stdio;

void main() {
	long bigSum;
	for (long i = 2; i < 1000000; i++) {
		long tmp = i;
		long sum;
		while (tmp > 0) {
			long digit = tmp % 10;
			sum += digit * digit * digit * digit * digit;
			tmp /= 10;
		}
		if (sum == i) {
			bigSum += sum;
		}
	}
	writeln(bigSum);
}

