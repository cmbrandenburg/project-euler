// vim: set noet ts=2 sw=2:
//
// Prime power triples

import std.stdio;
import exponent;
import prime;

void main() {

	immutable max = 50_000_000;

	size_t i, j, k;
	long iPrime, jPrime, kPrime;
	bool[long] nums;
	while (true) {
		iPrime = nthPrime(i);
		j = 0;
		while (true) {
			jPrime = nthPrime(j);
			k = 0;
			while (true) {
				kPrime = nthPrime(k);
				long val = ipow(iPrime, 2) + ipow(jPrime, 3) + ipow(kPrime, 4);
				if (val >= max)
					break;
				//writeln(iPrime, "\t", jPrime, "\t", kPrime);
				nums[val] = true;
				k++;
			}
			if (k == 0)
				break;
			j++;
		}
		if (j == 0)
			break;
		i++;
	}

	writeln(nums.length);
}

