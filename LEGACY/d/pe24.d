// vim: set noet ts=2 sw=2:
//
// Lexicographic permutations

import std.stdio;

void main() {

	long cnt;

	long lexiPerm(
			long numSoFar,
			long[] digits) {
		if (cnt >= 1000000)
			return 0;
		if (digits.length == 1) {
			cnt++;
			if (cnt == 1000000)
				return numSoFar * 10 + digits[0];
		}
		foreach (i, digit; digits) {
			long[] digitsCp;
			digitsCp ~= digits[0..i];
			digitsCp ~= digits[i+1 .. $];
			long result = lexiPerm(numSoFar * 10 + digit, digitsCp);
			if (result != 0)
				return result;
		}
		return 0;
	}

	long[] digits;
	for (long i = 0; i < 10; i++)
		digits ~= i;

	writeln(lexiPerm(0, digits));
}

