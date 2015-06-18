// vim: set noet ts=2 sw=2:
//
// Primes with runs

// M(p, d): maximum repeating length
// N(p, d): number of primes that have maximum repeating length
// S(p, d): sum of primes that have maximum repeating length

import std.stdio;
import exponent;
import prime;

// Returns an array of masks, where each mask is a scalar representing a set of
// N true values and (maskSize-N) false values. A true value is representing by
// 2^k, where k is the position in the mask. A false value is represented by
// zero.
ulong[] enumBoolComboMasks(const int maskSize, const int N) {
	ulong[] masks;
	void recur(ulong curMask, int trueRemaining, ulong n) {
		if (0 == trueRemaining) {
			masks ~= curMask;
			return;
		}
		if (0 == n) {
			return;
		}
		recur(curMask + n, trueRemaining - 1, n / 2);
		recur(curMask, trueRemaining, n / 2);
	}
	recur(0, N, ipow!ulong(2, maskSize - 1));
	return masks;
}

unittest {
	assert(enumBoolComboMasks(4, 0) == [0]);
	assert(enumBoolComboMasks(4, 1) == [8, 4, 2, 1]);
	assert(enumBoolComboMasks(4, 2) == [12, 10, 9, 6, 5, 3]);
	assert(enumBoolComboMasks(4, 3) == [14, 13, 11, 7]);
	assert(enumBoolComboMasks(4, 4) == [15]);
}

ulong sumAll(const int size, const int base = 10) {
	const ulong minN = ipow!ulong(base, size - 1);
	ulong total;
	int numDiff = size - 1;
	bool[] done = new bool[base]; // done with 0's?, with 1's, etc.
	bool[] nowDone = new bool[base];
	int doneCnt;
	while (doneCnt < base && numDiff >= 0) {
		ulong[] masks = enumBoolComboMasks(size, numDiff);	
		//writeln("doneCnt: ", doneCnt, ", ", masks);
		foreach (m; masks) {
			//writeln("\tmask: ", m);
			const ulong origM = m;
			for (int d = 0; d < base; d++) {
				if (done[d]) {
					continue;
				}
				// build n, where n has all the repeating digits--e.g., 4004404 for d ==
				// 4 and size >= 7:
				ulong n;
				ulong place = 1;
				m = origM;
				for (int i = 0; i < size; i++) {
					if (0 != m % 2) {
						n += place * d;
					}
					place *= base;
					m /= 2;
				}
				//writeln("\t\td: ", d, ", n: ", n);
				// fill in all the non-repeating digits
				ulong[] tries = [n];
				m = origM;
				place = 1;
				for (int i = 0; i < size; i++) {
					if (0 == m % 2) {
						ulong[] newTries;
						for (int j = 0; j < base; j++) {
							if (j == d) {
								continue; // don't use d digit again
							}
							foreach (t; tries) {
								newTries ~= t + j * place;
							}
						}
						tries = newTries;
					}
					place *= base;
					m /= 2;
				}
				//writeln("\t\t\t", tries);
				foreach (t; tries) {
					if (t < minN) {
						continue;
					}
					if (isPrime(t)) {
						//writeln("\t\t\t", t);
						if (!nowDone[d]) {
							nowDone[d] = true;
							doneCnt++;
						}
						total += t;
					}
				}
			}
		}
		for (int d = 0; d < base; d++) {
			if (nowDone[d]) {
				done[d] = true;
			}
		}
		numDiff--;
	}
	return total;
}

unittest {
	assert(273700 == sumAll(4));
}

void main() {
	writeln(sumAll(10));
}

