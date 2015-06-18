// vim: set noet ts=2 sw=2:
//
// Pandigital prime sets

import std.algorithm;
import std.stdio;
import prime;

immutable int base = 10;

// D: number of digits, [1, D).
long countSets(int D) {

	// Each set is created with its numbers in lexicographically ascending order.

	long cnt;
	bool[] avail;
	avail.length = D;
	long C;    // lexicographically biggest number in current set to test
	int depth;
	long[] set;

	int smallestAvail() {
		for (auto d = 1; d < D; d++) {
			if (avail[d])
				return d;
		}
		return 0;
	}

	void recur() {
		//import std.range;
		//writeln(reduce!"a ~ b"("", take(repeat(" "), depth)), C, ", ", map!"a ? 1 : 0"(avail));
		//depth++;
		int smallD = smallestAvail();
		long save;

		// no more digits available and C is empty:
		if (!smallD && !C) {
			cnt++;
			//writeln(reduce!"a ~ b"("", take(repeat(" "), depth)), "GOOD: ", set ~ C);
			//depth--;
			return;
		}

		// currently extending C, case 1: if C is prime and larger than all primes
		// in the set then add C to the set and recurse
		if (isPrime(C) && filter!(a => C <= a)(set).empty) {
			set ~= C;
			save = C;
			C = 0;
			recur();
			C = save;
			set = set[0 .. $-1];
		}

		// currently extending C, case 2: regardless whether C is prime, continue
		// extending it
		for (auto d = smallD; d < D; d++) {
			if (avail[d]) {
				save = C;
				C = C * base + d;
				avail[d] = false;
				recur();
				avail[d] = true;
				C = save;
			}
		}
		//depth--;
	}

	avail[] = true;
	recur();
	return cnt;
}

unittest {
	assert(countSets(2) == 0);
	assert(countSets(3) == 0);

	// manually inspected:
	// (2) 2, 13; 2, 31
	assert(countSets(4) == 2);

	// manually inspected:
	// (1) 2, 3, 41
	// (4) 2, 431; 3, 241; 3, 421; 23, 41
	// (4) 1423; 2143; 2341; 4231
	assert(countSets(5) == 9);
};

void main() {
	writeln(countSets(10));
}

