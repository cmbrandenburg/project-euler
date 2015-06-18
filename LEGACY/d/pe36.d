// vim: set noet ts=2 sw=2:
//
// Double-base palindromes

import std.stdio;
import digit;

void main() {
	long sum;
	for (int i = 1; i < 1_000_000; i++) {
		if (isPalindrome(i) &&
		    isPalindrome(i, 2)) {
			sum += i;
		}
	}
	writeln(sum);
}

