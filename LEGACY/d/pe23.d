// vim: set noet ts=2 sw=2:
//
// Non-abundant sums

import std.algorithm;
import std.stdio;
import factor;

void main() {

	// build array and map of abundant numbers:
	long[] abundantNums;
	for (long i = 1; i <= 28123; i++) {
		auto divs = enumDivisors(i);
		divs = divs[0 .. $-1]; // remove self from divisors
		long sum = reduce!"a + b"(cast(long) 0, divs);
		if (sum > i) {
			abundantNums ~= i;
		}
	}
	bool[long] abundantMap;
	foreach (_, num; abundantNums) {
		abundantMap[num] = true;
	}

	// calculate sum:
	long sum;
	for (long i = 1; i <= 28123; i++) {
		bool isAbundantSum;
		for (long j = 0;
		     j < abundantNums.length && abundantNums[j] < i && !isAbundantSum;
		     j++) {
			long diff = i - abundantNums[j];
			auto p = (diff in abundantMap);
			if (p) {
				isAbundantSum = true;
			}
		}
		if (!isAbundantSum) {
			sum += i;
		}
	}

	writeln(sum);
}

