// vim: set noet ts=2 sw=2:
//
// Largest palindrome product

import std.stdio;
import digit;

void main() {
	int biggestA, biggestB, biggestProd;
	int a, b, prod;
	for (a = 100; a < 1000; a++) {
		for (b = a; b < 1000; b++) {
			prod = a * b;
			if (prod > biggestProd && isPalindrome(prod)) {
				biggestA = a;
				biggestB = b;
				biggestProd = prod;
			}
		}
	}
	writeln(biggestProd);
}

