// vim: set noet ts=2 sw=2:
//
// Counting summations

import std.stdio;

void main() {

	long[int] pCache;

	long P(int n) {
		if (n < 0)
			return 0;
		if (n <= 1)
			return 1;
		if (n in pCache)
			return pCache[n];
		long sum;
		for (int k = 1; k <= n; k++) {
			int subN = n - k * (3 * k - 1) / 2;
			if (subN < 0)
				break;
			long term = P(subN);
			subN = n - k * (3 * k + 1) / 2;
			term += P(subN);
			if (k % 2 == 0)
				term *= -1;
			sum += term;
		}
		pCache[n] = sum;
		return sum;
	}

	writeln(P(100) - 1);
}

