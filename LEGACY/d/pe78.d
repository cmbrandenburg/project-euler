// vim: set noet ts=2 sw=2:
//
// Coin partitions

import std.stdio;

void main() {

	immutable MAX = 1_000_000;

	int[int] pCache;

	int P(int n) {

		// This is nearly the same algorithm as used in problem #76, except that
		// only the modulo-MAX part of the result in retained. The reason why this
		// works is that we're only interested in testing divisibility against MAX.

		if (n < 0)
			return 0;
		if (n <= 1)
			return 1;
		if (n in pCache)
			return pCache[n];
		int sum;
		for (int k = 1; k <= n; k++) {
			int subN = n - k * (3 * k - 1) / 2;
			if (subN < 0)
				break;
			int term = P(subN);
			subN = n - k * (3 * k + 1) / 2;
			term += P(subN);
			if (k % 2 == 0)
				term *= -1;
			sum += term;
			sum %= MAX;
		}
		pCache[n] = sum;
		return sum;
	}

	int i = 1;
	int cnt;
	while ((cnt = P(i)) % MAX != 0) {
		i++;
	}

	writeln(i);
}

