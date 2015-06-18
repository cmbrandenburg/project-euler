// vim: set noet ts=2 sw=2:
//
// Bouncy numbers

import std.stdio;

immutable uint BASE = 10;

bool isDecreasing(uint n) {
	uint digit = 0;
	while (n) {
		if (n % BASE < digit)
			return false;
		digit = n % BASE;
		n /= BASE;
	}
	return true;
}

unittest {
	assert(isDecreasing(0));
	assert(isDecreasing(1));
	assert(isDecreasing(10));
	assert(isDecreasing(11));
	assert(!isDecreasing(12));
	assert(isDecreasing(999));
	assert(!isDecreasing(123456789));
	assert(isDecreasing(987654321));
}

bool isIncreasing(uint n) {
	uint digit = BASE;
	while (n) {
		if (n % BASE > digit)
			return false;
		digit = n % BASE;
		n /= BASE;
	}
	return true;
}

unittest {
	assert(isIncreasing(0));
	assert(isIncreasing(1));
	assert(!isIncreasing(10));
	assert(isIncreasing(11));
	assert(isIncreasing(12));
	assert(isIncreasing(999));
	assert(isIncreasing(123456789));
	assert(!isIncreasing(987654321));
}

void main()
{
	uint n;
	uint numBouncy;
	do {
		n++;
		if (!isDecreasing(n) && !isIncreasing(n))
			numBouncy++;
	} while ((n - numBouncy) * 100 != n);
	writeln(n);
}

