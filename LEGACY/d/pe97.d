// vim: set noet ts=2 sw=2:
//
// Large non-Mersenne prime

import std.stdio;
import std.string;

void main() {
	long n = 1;
	for (int i = 0; i < 7830457; i++) {
		n *= 2;
		n %= 10_000_000_000;
	}
	n *= 28433;
	n %= 10_000_000_000;
	n++;
	writeln(format("%010d", n));
}

