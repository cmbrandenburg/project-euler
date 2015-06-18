// vim: set noet ts=2 sw=2:
//
// Self powers

import std.stdio;

void main() {
	long sum;
	long prod;
	for (long i = 1; i <= 1000; i++) {
		prod = 1;
		for (int j = 0; j < i; j++) {
			prod *= i;
			prod %= 10_000_000_000;
		}
		sum += prod;
		sum %= 10_000_000_000;
	}
	writeln(sum);
}

