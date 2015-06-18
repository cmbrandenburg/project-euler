// vim: set noet ts=2 sw=2:
//
// Number spiral diagonals

import std.stdio;

void main() {


	long n = 1;
	long sum = 1;
	long inc = 2;

	for (int i = 3; i <= 1001; i += 2) {
		for (int j = 0; j < 4; j++) {
			n += inc;
			sum += n;
		}
		inc += 2;
	}

	writeln(sum);
}

