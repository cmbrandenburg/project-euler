// vim: set noet ts=2 sw=2:
//
// Power digit sum

import std.bigint;
import std.stdio;
import digit;
import exponent;

void main() {
	BigInt x = ipow(BigInt(2), 1000);
	writeln(sumDigits(x));
}

