// vim: set noet ts=2 sw=2:
//
// Integer right triangles

import std.stdio;

void main() {
	int maxSolutions;
	int maxP;
	for (int p = 1; p <= 1000; p++) {
		int numSolutions;
		for (int a = 1; a < p / 3; a++) {
			for (int b = a; b < 2 * p / 3; b++) {
				int c = p - a - b;
				if (a * a + b * b == c * c) {
					numSolutions++;
				}
			}
		}
		if (numSolutions > maxSolutions) {
			maxP = p;
			maxSolutions = numSolutions;
		}
	}
	writeln(maxP);
}

