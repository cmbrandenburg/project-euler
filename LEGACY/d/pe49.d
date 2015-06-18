// vim: set noet ts=2 sw=2:
//
// Prime permutations

import std.stdio;
import digit;
import prime;

static bool arePerms(
		long a,
		long b,
		long c) {

	long[10] countDigits(
			long x) {
		long[10] digits;
		while (x > 0) {
			digits[x % 10]++;
			x /= 10;
		}
		return digits;
	}

	long[10][3] digits;
	digits[0] = countDigits(a);
	digits[1] = countDigits(b);
	digits[2] = countDigits(c);

	for (long i = 0; i < 10; i++) {
		if (digits[0][i] != digits[1][i] || digits[1][i] != digits[2][i]) {
			return false;
		}
	}
	return true;
}

void main() {
	size_t i;
	long iPrime;
	while ((iPrime = nthPrime(i)) < 1000) {
		i++;
	}
	while (iPrime < 10000) {
		size_t j = i + 1;
		long jPrime = nthPrime(j);
		long diff = jPrime - iPrime;
		do {
			long kPrime = jPrime + diff;
			if (isPrime(kPrime) && arePerms(iPrime, jPrime, kPrime)) {
				if (iPrime != 1487 || jPrime != 4817 || kPrime != 8147) {
					writeln(catNumbers(iPrime, catNumbers(jPrime, kPrime)));
					return;
				}
			}
			jPrime = nthPrime(++j);
			diff = jPrime - iPrime;
		} while (iPrime + 2 * diff < 10000);
		iPrime = nthPrime(++i);
	}
	assert(false);
}

