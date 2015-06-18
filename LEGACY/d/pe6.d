// vim: set noet ts=2 sw=2:
//
// Sum square difference

import std.stdio;

void main() {
	long sqOfSum;
	long sumOfSq;
	for (long i = 1; i <= 100; i++) {
		sqOfSum += i;
		sumOfSq += i * i;
	}
	sqOfSum *= sqOfSum;
	writeln(sqOfSum - sumOfSq);
}

