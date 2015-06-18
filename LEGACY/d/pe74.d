// vim: set noet ts=2 sw=2:
//
// Digit factorial chains

import std.stdio;
import combo;

void main() {

	immutable MAX = 7 * factorial(9);

	// Enumerate factorial sums.
	int[] sums;
	for (int i = 1; i < MAX; i++) {
		int iCp = i;
		int sum;
		while (iCp > 0) {
			sum += factorial(iCp % 10);
			iCp /= 10;
		}
		sums ~= sum;
	}

	// Brute force find repeating terms.
	int cnt;
	for (int i = 1; i < 1_000_000; i++) {
		int n = i;
		bool[int] history;
		while (!(n in history)) {
			history[n] = true;
			n = sums[n - 1];
		}
		if (history.length >= 60) {
			//writeln(i);
			cnt++;
		}
	}

	writeln(cnt);
}

