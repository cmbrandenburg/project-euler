// vim: set noet ts=2 sw=2:
//
// Square digit chains

import std.stdio;

void main() {

	static bool is89(int n) {
		while (n != 1 && n != 89) {
			int sum;
			while (n > 0) {
				sum += (n % 10) * (n % 10);
				n /= 10;
			}
			n = sum;
		}
		return n == 89;
	}

	int finalCnt;
	for (int i = 1; i < 10_000_000; i++) {
		if (is89(i))
			finalCnt++;
	}

	writeln(finalCnt);
}

