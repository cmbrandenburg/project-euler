// vim: set noet ts=2 sw=2:
//
// Distinct powers

import std.bigint;
import std.stdio;

void main() {
	bool[string] terms;
	for (BigInt a = 2; a <= 100; a++) {
		BigInt val = a;
		for (BigInt b = 2; b <= 100; b++) {
			val *= a;
			val.toString((const(char)[] str) {
					terms[str] = true;
					}, null);
		}
	}

	writeln(terms.length);
}

