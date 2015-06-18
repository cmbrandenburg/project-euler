// vim: set noet ts=2 sw=2:
//
// Highly divisible triangular number

import std.stdio;
import factor;

void main() {
	long[] divisors;
	long triangleBase;
	long triangleNum;
	do {
		triangleBase++;
		triangleNum = (triangleBase + 1) * triangleBase / 2;
		divisors = enumDivisors(triangleNum);
	} while (divisors.length <= 500);
	writeln(triangleNum);
}

