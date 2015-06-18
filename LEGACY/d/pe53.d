// vim: set noet ts=2 sw=2:
//
// Combinatoric selections

import std.bigint;
import std.stdio;
import combo;

void main() {
	int cnt;
	for (BigInt n = 1; n <= 100; n++) {
		for (BigInt r = 0; r <= n; r++) {
			if (choose(n, r) > 1000000) {
				cnt++;
			}
		}
	}
	writeln(cnt);
}

