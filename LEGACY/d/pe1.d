// vim: set noet ts=2 sw=2:
//
// Multiples of 3 and 5

import std.stdio;

void main() {
	int sum;
	for (int i = 1; i < 1000; i++) {
		if ((i % 3) == 0 || (i % 5) == 0) {
			sum += i;
		}
	}
	writeln(sum);
}

