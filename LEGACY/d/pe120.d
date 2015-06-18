// vim: set noet ts=2 sw=2:
//
// Square remainders

import std.algorithm;
import std.stdio;

int rmax(int a) {
	int small = 1, big = 1;
	int result = 0;
	do {
		result = max(result, (small + big) % (a*a));
		small = (small * (a-1)) % (a*a);
		big = (big * (a+1)) % (a*a);
	} while (small != 1 || big != 1);
	return result;
}

unittest {
	assert(rmax(7) == 42);
}

void main() {
	int sum;
	for (auto a = 3; a <= 1000; a++)
		sum += rmax(a);
	writeln(sum);
}

