// vim: set noet ts=2 sw=2:
//
// Digit factorials

import std.stdio;

void main() {

	long[] facts;
	facts ~= 1;
	for (int i = 1; i < 10; i++) {
		facts ~= i * facts[$-1];
	}

	long factDigits(
			long n) {
		long sum;
		while (n > 0) {
			sum += facts[n % 10];
			n /= 10;
		}
		return sum;
	}


	long sum;
	// 9! == 362880
	for (long i = 10; i < 3000000; i++) {
		if (i == factDigits(i)) {
			sum += i;
		}
	}
	writeln(sum);
}

