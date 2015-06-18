// vim: set noet ts=2 sw=2:
//
// Prime pair sets

import std.stdio;
import digit;
import prime;

static immutable tgtSetSize = 5;

static bool areConcatable(Int)(Int a, Int b) {
	return isPrime(catNumbers(a, b)) && isPrime(catNumbers(b, a));
}

unittest {
	assert(areConcatable(3, 7));
	assert(areConcatable(7, 109));
	assert(!areConcatable(3, 5));
}

static bool isConcatableWithSet(Int)(Int[] set, Int n) {
	foreach (_, member; set) {
		if (!areConcatable(member, n)) {
			return false;
		}
	}
	return true;
}

void main() {

	long[][long] cats;
	long bestSum = 0;
	long[] bestSet;

	void foundSet(long[] primes) {
		long sum;
		foreach (_, n; primes) {
			sum += n;
		}
		//writeln("!!!\t", sum, "\t", primes);
		if (bestSum == 0 || sum < bestSum) {
			bestSum = sum;
			bestSet = primes.dup;
		}
	}

	void findCatSets(long[] primesInSet, long[] primesToTry) {

		if (primesToTry.length == 0) {
			return;
		}

		if (isConcatableWithSet(primesInSet, primesToTry[0])) {
			primesInSet ~= primesToTry[0];
			if (primesInSet.length >= tgtSetSize) {
				foundSet(primesInSet);
			} else {
				findCatSets(primesInSet, primesToTry[1..$]);
			}
			primesInSet = primesInSet[0 .. $-1];
		}

		findCatSets(primesInSet, primesToTry[1..$]);
	}

	long max = 100;
	while (bestSum == 0 || max < bestSum / tgtSetSize) {
		long iPrime;
		for (size_t i = 0; (iPrime = nthPrime(i)) < max; i++) {
			cats.remove(iPrime);
			long jPrime;
			for (size_t j = i + 1; (jPrime = nthPrime(j)) < max; j++) {
				if (areConcatable(iPrime, jPrime)) {
					cats[iPrime] ~= jPrime;
				}
			}
		}
		foreach (iPrime, catPrimes; cats) {
			if (catPrimes.length >= tgtSetSize - 1) {
				long[] primesInSet = [iPrime];
				//writeln("\t", primesInSet, "\t", catPrimes);
				findCatSets(primesInSet, catPrimes);
			}
		}
		max *= 2;
	}

	writeln(bestSum);
}

