// vim: set noet ts=2 sw=2:
//
// Lychrel numbers

import std.bigint;
import std.stdio;
import digit;

void main() {
	int cnt;
	for (BigInt i = 1; i < 10000; i++) {
		int j;
		BigInt sum = i;
		BigInt rev;
		do {
			rev = reverseNumber(sum);
			sum += rev;
			rev = reverseNumber(sum);
			j++;
		} while (j < 50 && rev != sum);
		if (j >= 50) {
			cnt++;
		}
	}
	writeln(cnt);
}

