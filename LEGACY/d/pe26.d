// vim: set noet ts=2 sw=2:
//
// Reciprocal cycles

import std.stdio;

static int longDivRep(
		int num,
		int denom) {

	int[] prevNums;

	int div(
			int num,
			int denom) {
		if (num == 0)
			return 0;
		foreach (i, prevNum; prevNums) {
			if (prevNum == num) {
				return cast(int)(prevNums.length - i);
			}
		}
		prevNums ~= num;
		int nextNum = 10 * (num % denom);
		return div(nextNum, denom);
	}

	auto rep = div(10 * num, denom);
	return rep;
}

void main() {

	int longestI;
	int longestRep;
	for (int i = 2; i < 1000; i++) {
		auto rep = longDivRep(1, i);
		if (rep > longestRep) {
			longestI = i;
			longestRep = rep;
		}
	}

	writeln(longestI);
}

