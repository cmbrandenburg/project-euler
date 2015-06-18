// vim: set noet ts=2 sw=2:
//
// Coin sums

import std.stdio;

void main() {
	int cnt;
	for (int a = 0; a < 2; a++) {
		for (int b = 0; b < 4; b++) {
			for (int c = 0; c < 10; c++) {
				for (int d = 0; d < 20; d++) {
					for (int e = 0; e < 40; e++) {
						for (int f = 0; f < 100; f++) {
							for (int g = 0; g < 200; g++) {
								if (100 * a + 50 * b + 20 * c + 10 * d + 5 * e + 2 * f + 1 * g == 200) {
									cnt++;
								}
							}
						}
					}
				}
			}
		}
	}
	writeln(cnt + 8);
}

