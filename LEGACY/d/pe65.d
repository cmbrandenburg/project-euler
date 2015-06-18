// vim: set noet ts=2 sw=2:
//
// Convergents of e

import std.bigint;
import std.stdio;
import digit;
import rational;

static int eDigit(int n) {
	assert(n >= 1);
	if (n % 3 == 2)
		return 2 * ((n + 1) / 3);
	return 1;
}

void main() {
	auto r = Rational!BigInt(0);
	import std.stdio;
	for (int i = 99; i >= 1; i--) {
		auto toAdd = Rational!BigInt(1);
		toAdd /= r + eDigit(i);
		r = toAdd;
	}
	r += 2;
	writeln(sumDigits(r.numerator()));
}

