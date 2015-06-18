// vim: set noet ts=2 sw=2:
//
// Pandigital Fibonacci ends

import std.bigint;
import std.stdio;
import digit;
import exponent;

void main() {

	const long base = 10;

	BigInt prev = 1;
	BigInt cur = 1;
	int k = 2;

	// keep a running calculation of the number digits in the current term:
	uint numDigits = 1;
	BigInt powBase = 1;

	// cur % smallDiv => the smallest (base-1) digits:
	BigInt smallDiv = ipow(cast(long)(base), base - 1);

	// cur / bigDiv => the biggest (base-1) digits, if cur has at least (base-1)
	// digits:
	BigInt bigDiv = 1;

	while (true) {
		if (numDigits < base)
			goto next;
		//writeln(k);
		//writeln(k, ": ", cur);
		auto small = cur % smallDiv;
		//writeln("\t", small);
		if (!isPandigital(small.toLong(), false))
			goto next;
		auto big = cur / bigDiv;
		//writeln("\t", big);
		if (!isPandigital(big.toLong(), false))
			goto next;
		break;
next:
		BigInt t = prev + cur;
		prev = cur;
		cur = t;
		k++;
		if (cur / powBase >= base) {
			numDigits++;
			powBase *= base;
			if (numDigits >= base)
				bigDiv *= base;
		}
	}

	writeln(k);
}

