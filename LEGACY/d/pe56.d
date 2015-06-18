// vim: set noet ts=2 sw=2:
//
// Powerful digit sum

import std.bigint;
import std.stdio;
import digit;
import exponent;

void main() {
	BigInt biggestSum;
	BigInt biggestA;
	long biggestB;
	for (BigInt a = 0; a < 100; a++) {
		for (long b = 0; b < 100; b++) {
			BigInt c = ipow(a, b);
			BigInt sum = sumDigits(c);
			//writeln(a, "^", b, " = ", c, "\t(", sum, ")");
			if (sum > biggestSum) {
				biggestSum = sum;
				biggestA = a;
				biggestB = b;
			}
		}
	}
	writeln(biggestSum);
}

