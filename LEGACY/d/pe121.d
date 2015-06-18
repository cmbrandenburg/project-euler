// vim: set noet ts=2 sw=2:
//
// Disc game prize fund

import std.algorithm;
import std.bigint;
import std.range;
import std.stdio;
import rational;

alias BigInt T;
alias Rational!T R;

R recur(int need, int discs, int turns) {
	R n;
	if (need == 0)
		n = R(T(1));
	else if (need > turns)
		n = R(T(0));
	else if (need == turns)
		n = reduce!"a * b"(map!(a => R(T(1), T(a)))(iota(discs, discs+turns)));
	else
		n = R(T(1), T(discs)) * recur(need-1, discs+1, turns-1) + R(T(discs-1), T(discs)) * recur(need, discs+1, turns-1);
	n.reduce();
	//writeln(need, ", ", discs, ", ", turns, ": ", n);
	return n;
}

R chance(int turns) {
	return recur(turns / 2 + 1, 2, turns).reduce();
}

unittest {
	assert(chance(1) == R(T(1), T(2)));
	assert(chance(2) == R(T(1), T(6)));

	// manually calculated:
	assert(chance(3) == R(T(7), T(24)));

	// given in problem description:
	assert(chance(4) == R(T(11), T(120)));
}

void main() {
	R odds = chance(15);
	writeln(odds.denominator / odds.numerator);
}

