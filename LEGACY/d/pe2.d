// vim: set noet ts=2 sw=2:
//
// Even Fibonacci numbers

import std.stdio;

void main() {
	long sum;
	long prev = 1;
	long cur = 2;
	while (cur <= 4_000_000) {
		if (cur % 2 == 0)
			sum += cur;
		long next = prev + cur;
		prev = cur;
		cur = next;
	}
	writeln(sum);
}

