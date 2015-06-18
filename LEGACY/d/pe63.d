// vim: set noet ts=2 sw=2:
//
// Powerful digit counts

import std.bigint;
import std.stdio;
import exponent;

void main() {
	int cnt;
	for (BigInt i = 1; i <= 9; i++) { // 10^x always more than x digits
		int power;
		while (true) {
			BigInt result = ipow(i, ++power);
			if (ilog(result) + 1 != power)
				break;
			cnt++;
		}
	}
	writeln(cnt);
}

