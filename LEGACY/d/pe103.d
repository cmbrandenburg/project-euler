// vim: set noet ts=2 sw=2:
//
// Special subset sums: optimum

import std.algorithm;
import std.conv;
import std.range;
import std.stdio;
import set;

// There are two conditions for a set A to be a Special Sum Set. Let B and C
// be nonempty disjoint subsets of A.
//
//   1. sum(B) != sum(C)
//   2. sum(B) < sum(C) if size(B) < size(C)
//
// To test condition 1 we use a brute condition algorithm by trying all
// combinations of nonempty disjoint subsets.
//
// To test condition 2 we need only check the sum of the smallest N values of
// A against the sum of the biggest N-1 values of A, where N = (size(A) + 1) /
// 2. So for example, if size(A) is 7, then we check the smallest 4 values
// against the 3 biggest values. If the check holds true for these subsets
// then it will hold true for all nonempty disjoint subsets.

/+

// This function brutes forces the solution. It takes over an hour-and-a-half on
// my laptop to find the answer for input size 7.
uint[] optimalSpecialSumSet(uint size) {

	assert(size >= 1);


	const disjointPairs = enumNonemptyDisjointPairs(size);
	const N = (size + 1) / 2;

	bool testCond1(uint[] s) {
		//writeln("\t", s);
		foreach (dp; disjointPairs) {
			auto B = indexed(s, dp[0]);
			ulong sumB = reduce!"a + b"(B);
			auto C = indexed(s, dp[1]);
			ulong sumC = reduce!"a + b"(C); // sum(C)
			//writeln("\t\t", sumB, "  ", B, "  ", sumC, "  ", C);
			if (sumB == sumC) {
				//writeln("\t\tBAD!");
				return false;
			}
		}
		//writeln("\t\tGOOD!");
		return true;
	}

	bool testCond2(uint[] s) {
		uint smallSum = reduce!"a + b"(s[0..N]);
		uint bigSum = reduce!"a + b"(0, s[(size / 2 + 1)..$]);
		return smallSum > bigSum;
	}

	// Queue of sets to try. The first dimension offsets by size, where the 0th
	// element is the currently smallest size, the 1st element is size + 1, the
	// 2nd element is size + 2, etc. The second dimension is an array of all sets
	// to try for that size. The third dimension is an array representing a set.
	uint[][][] q; // sets to try

	void addSet(size_t offset, uint[] s) {
		//writeln("addSet: ", offset, ", ", s, ", ", q);
		if (q.length <= offset)
			q.length += offset - q.length + 1;
		foreach (b; q[offset])
			if (b == s)
				return; // already exists, don't add
		q[offset] ~= s;
	}

	// populate with initial set, {a, a+1, a+2, ...}:
	q ~= [[array(iota(1, 1 + size))]];
	while (!testCond2(q[0][0])) {
		q[0][0][] += 1;
	}

	uint[][] goodSets;
	while (goodSets.empty) {
		//writeln("NEXT SIZE: ", q[0]);
		foreach (s; q[0]) {
			if (testCond1(s))
				goodSets ~= s;
			else {
				// try to create new sets by incrementing a single number:
				for (size_t i = 0; i < size; i++) {
					if (i + 1 == size  || s[i] + 1 < s[i+1]) {
						uint[] s2 = s.dup;
						s2[i]++;
						if (testCond2(s2))
							addSet(1, s2);
					}
				}
				// try to create a new set by incrementing several numbers, starting
				// with the biggest:
				bool ok = true;
				for (size_t i = size; i > size - (N-1); i--) {
					s[i-1]++;
					if (!testCond2(s))
						ok = false;
				}
				if (!ok) {
					size_t i;
					for (i = size - (N-1); !testCond2(s); i--)
						s[i-1]++;
					addSet(size - (i-1), s);
				}
			}
		}
		q = q[1..$]; // pop the current size sets
	}

	// FIXME: I have no reason to believe there's a unique optimal Special Sum Set
	// for this size.
	assert(goodSets.length == 1);
	return goodSets[0];
}

unittest {
	assert(optimalSpecialSumSet(1) == [1]);
	assert(optimalSpecialSumSet(2) == [1, 2]);
	assert(optimalSpecialSumSet(3) == [2, 3, 4]);
	assert(optimalSpecialSumSet(4) == [3, 5, 6, 7]);
	assert(optimalSpecialSumSet(5) == [6, 9, 11, 12, 13]);
	assert(optimalSpecialSumSet(6) == [11, 18, 19, 20, 22, 25]);
}
+/

void main() {

	const uint size = 7;
	const disjointPairs = enumNonemptyDisjointPairs(size);

	// N is the number of smallest values to check against the biggest N-1 values.
	const N = (size + 1) / 2;

	bool testCond1(uint[] s) {
		//writeln("\t", s);
		foreach (dp; disjointPairs) {
			auto B = indexed(s, dp[0]);
			ulong sumB = reduce!"a + b"(B);
			auto C = indexed(s, dp[1]);
			ulong sumC = reduce!"a + b"(C); // sum(C)
			//writeln("\t\t", sumB, "  ", B, "  ", sumC, "  ", C);
			if (sumB == sumC) {
				//writeln("\t\tBAD!");
				return false;
			}
		}
		//writeln("\t\tGOOD!");
		return true;
	}

	bool testCond2(uint[] s) {
		uint smallSum = reduce!"a + b"(s[0..N]);
		uint bigSum = reduce!"a + b"(0, s[(size / 2 + 1)..$]);
		return smallSum > bigSum;
	}

	// By inspection, it's possible to see that the following set, which is
	// generated using the formula given in the problem description, is a Special
	// Sum Set. Therefore, we can solve this problem by looking for possible
	// better Special Sum Sets.
	uint[] initSet = [20, 31, 38, 39, 40, 42, 45];
	uint bestSum = 0;
	uint[][] bestSets = [null];

	// look for better sets:
	uint[] workSet = initSet.dup;
	for (; workSet[size-7] > 0; workSet[size-7]--) {
		workSet[size-6] = initSet[size-6];
		for (; workSet[size-6] > workSet[size-7]; workSet[size-6]--) {
			workSet[size-5] = initSet[size-5];
			for (; workSet[size-5] > workSet[size-6]; workSet[size-5]--) {
				workSet[size-4] = initSet[size-4];
				for (; workSet[size-4] > workSet[size-5]; workSet[size-4]--) {
					workSet[size-3] = initSet[size-3];
					for (; workSet[size-3] > workSet[size-4]; workSet[size-3]--) {
						workSet[size-2] = initSet[size-2];
						for (; workSet[size-2] > workSet[size-3]; workSet[size-2]--) {
							workSet[size-1] = initSet[size-1];
							for (; workSet[size-1] > workSet[size-2]; workSet[size-1]--) {
								if (!testCond2(workSet))
									break;
								//writeln("\t", workSet);
								if (testCond1(workSet)) {
									uint sum = reduce!"a + b"(workSet);
									if (bestSum == 0 || sum < bestSum) {
										bestSum = sum;
										bestSets = [workSet.dup];
										//writeln("REPL:\t", workSet);
									} else if (sum == bestSum) {
										bestSets ~= workSet.dup;
										//writeln("ADD:\t", workSet);
									}
								}
							}
						}
					}
				}
			}
		}
	}

	assert(bestSets.length == 1);

	writeln(reduce!"a ~ b"(map!"to!string(a)"(bestSets[0])));
}

