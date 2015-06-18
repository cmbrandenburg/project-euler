// vim: set noet ts=2 sw=2:
//
// Arranged probability

import std.stdio;

void main() {
	long prevN[2] = [3, 15];
	long prevD[2] = [4, 21];
	long N, D;
	while (true) {
		N = 6 * prevN[1] - prevN[0] - 2;
		D = 6 * prevD[1] - prevD[0] - 2;
		//writeln(N, " / ", D);
		//assert(N * (N - 1) * 2 == D * (D - 1));
		if (D > 1_000_000_000_000) {
			break;
		}
		prevN[0] = prevN[1];
		prevD[0] = prevD[1];
		prevN[1] = N;
		prevD[1] = D;
	}

	writeln(N);
}

