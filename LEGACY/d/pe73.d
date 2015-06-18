// vim: set noet ts=2 sw=2:
//
// Counting fractions in a range

import std.stdio;
import factor;

void main() {
	int cnt;
	for (int d = 5; d <= 12_000; d++) {
		for (int n = (d / 3) + 1; n <= (d - 1) / 2; n++) {
			if (gcd(n, d) == 1) {
				cnt++;
			}
		}
	}
	writeln(cnt);
}

