// vim: set noet ts=2 sw=2:
//
// Factorial digit sum

import std.bigint;
import std.stdio;
import digit;

void main() {
	BigInt n = 1;
	for (int i = 1; i <= 100; i++) {
		n *= i;
	}
	writeln(sumDigits(n));
}

