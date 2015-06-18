// vim: set noet ts=2 sw=2:
//
// Special Pythagorean triplet

import std.stdio;

void main() {
	for (long a = 1; a <= 1000; a++) {
		for (long b = a + 1; b <= 1000; b++) {
			long c = 1000 - a - b;
			if (a * a + b * b == c * c) {
				writeln(a * b * c);
				return;
			}
		}
	}
	assert(false);
}

