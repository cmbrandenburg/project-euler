// vim: set noet ts=2 sw=2:
//
// Non-bouncy numbers

import std.algorithm;
import std.range;
import std.stdio;

immutable int BASE = 10;

long sumSums(int order, int n) {
	static long[][] pastResults;
	// base case:
	if (order == 0)
		return 1;
	if (n == 0)
		return 0;
	// memoized:
	if (pastResults.length >= order && pastResults[order-1].length >= n)
		return pastResults[order-1][n-1];
	// recur:
	long result = sumSums(order, n-1) + sumSums(order-1,n);
	if (pastResults.length < order)
		pastResults ~= null;
	pastResults[order-1] ~= result;
	return result;
}

unittest {
	assert(sumSums(0, 1) == 1);
	assert(sumSums(0, 10) == 1);
	assert(sumSums(1, 1) == 1);
	assert(sumSums(1, 2) == 2);
	assert(sumSums(1, 3) == 3);
	assert(sumSums(1, 4) == 4);
	assert(sumSums(1, 10) == 10);
	assert(sumSums(2, 1) == 1);
	assert(sumSums(2, 2) == 3);
	assert(sumSums(2, 3) == 6);
	assert(sumSums(2, 4) == 10);
	assert(sumSums(2, 10) == 55);
	assert(sumSums(3, 1) == 1);
	assert(sumSums(3, 2) == 4);
	assert(sumSums(3, 3) == 10);
	assert(sumSums(3, 4) == 20);
	assert(sumSums(4, 1) == 1);
	assert(sumSums(4, 2) == 5);
	assert(sumSums(4, 3) == 15);
	assert(sumSums(4, 4) == 35);
}

long nonBouncy(int digits) {
	if (digits == 0)
		return 0;
	return nonBouncy(digits - 1) + sumSums(digits, BASE-1) + sumSums(digits, BASE) - BASE; 
}

unittest {
	assert(nonBouncy(1) == 9);
	assert(nonBouncy(2) == 99);
	assert(nonBouncy(3) == 474);
	assert(nonBouncy(4) == 1674);
	assert(nonBouncy(5) == 4953);
	assert(nonBouncy(6) == 12951);
}

void main() {
	writeln(nonBouncy(100));
}

