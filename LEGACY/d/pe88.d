// vim: set noet ts=2 sw=2:
//
// Product-sum numbers

import std.stdio;
import factor;
import prime;

void main() {

	immutable minK = 2;
	immutable maxK = 12_000;

	long[long] minNs; // k -> N
	bool[long] allNs;
	long finalSum;

	void findKs(long k, in long N, long remaining, long sum) {
		//writeln("\tfindKs(", k, ", ", N, ", ", remaining, ", ", sum, ")");
		if (remaining == 1) {
			k += N - sum;
			//writeln("\t", k, "\t", N);
			if (minK <= k && k <= maxK && !(k in minNs)) {
				minNs[k] = N;
				if (!(N in allNs)) {
					allNs[N] = true;
					finalSum += N;
				}
			}
			return;
		}
		auto divs = enumDivisors(remaining);
		//writeln("\t\t", remaining, "\t", divs);
		foreach (_, div; divs[1 .. $]) {
			findKs(k + 1, N, remaining / div, sum + div);
		}
	}

	long N = 4;
	while (minNs.length < maxK - minK + 1) {
		if (!isPrime(N)) {
			findKs(0, N, N, 0);
		}
		//writeln(N, "\t", minNs.length);
		N++;
	}

	writeln(finalSum);
}

