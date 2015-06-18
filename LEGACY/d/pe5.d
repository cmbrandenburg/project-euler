// vim: set noet ts=2 sw=2:
//
// Smallest multiple

import std.stdio;
import factor;

void main() {
	long[] factors;
	for (int i = 1; i <= 20; i++) {
		factors ~= i;
	}
	writeln(lcm(factors));
}

