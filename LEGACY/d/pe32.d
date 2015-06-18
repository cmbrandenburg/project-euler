// vim: set noet ts=2 sw=2:
//
// Pandigital products

import std.conv;
import std.stdio;

void main() {

	bool[int] prods;

	void findProds(
			string digits) {
		for (int i = 1; i <= 4; i++) {
			for (int j = i + 1; j <= 5; j++) {
				int a = to!int(digits[0..i]);
				int b = to!int(digits[i..j]);
				int c = to!int(digits[j..$]);
				if (a * b == c) {
					prods[c] = true;
				}
			}
		}
	}

	void lexiPerm(
			string numSoFar,
			string[] digits) {
		if (digits.length == 1) {
			string num = numSoFar ~ digits[0];
			findProds(num);
		}
		foreach (i, digit; digits) {
			string[] digitsCp;
			digitsCp ~= digits[0..i];
			digitsCp ~= digits[i+1 .. $];
			lexiPerm(numSoFar ~ digit, digitsCp);
		}
	}

	string[] digits;
	for (int i = 1; i <= 9; i++) {
		digits ~= to!string(i);
	}
	lexiPerm("", digits);

	long sum;
	foreach (prod, _; prods) {
		sum += prod;
	}
	writeln(sum);
}

