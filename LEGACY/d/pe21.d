// vim: set noet ts=2 sw=2:
//
// Amicable numbers

import std.algorithm;
import std.stdio;
import factor;

void main() {

	// Find all divisors.
	int[][] divs;
	divs ~= [[]]; // 0 has no divisors
	for (int i = 1; i < 10000; i++) {
		auto iDivs = enumDivisors(i);
		assert(iDivs[$-1] == i);
		iDivs = iDivs[0 .. $-1]; // remove self as a divisor
		divs ~= iDivs;
	}

	// Find amicable pairs.
	int sum;
	for (int a = 1; a < 10000; a++) {
		int[] aDivs = divs[a];
		int b = reduce!"a + b"(0, aDivs);
		if (b > a && 1 <= b && b < divs.length) {
			int[] bDivs = divs[b];
			int maybeA = reduce!"a + b"(0, bDivs);
			if (maybeA == a) {
				sum += a + b;
			}
		}
	}

	writeln(sum);
}

