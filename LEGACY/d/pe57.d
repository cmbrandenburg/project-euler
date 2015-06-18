// vim: set noet ts=2 sw=2:
//
// Square root convergents

import std.bigint;
import std.stdio;
import exponent;
import rational;

void main() {

	int cnt;

	auto r = Rational!BigInt(1);
	r /= 2;
	for (int i = 1; i <= 1000; i++) {
		Rational!BigInt cp = r;
		cp += 1;
		if (ilog(cp.numerator) > ilog(cp.denominator))
			cnt++;
		r += 2;
		r.invert();
	}

	writeln(cnt);
}

