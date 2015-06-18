// vim: set noet ts=2 sw=2:
//
// Special subset sums: meta-testing

import std.stdio;

version(unittest) {
	import std.conv;
}

// Encapsulates a pair of disjoint subsets.
struct SetPair {
	int[] left;
	int[] right;
}

/** Returns all pairs of sets, where the sets in a pair are (1) empty, (2)
 * disjoint with respect to each other, and (3) contain elements from s. */
SetPair[] subsetPairs(int[] s) {

	SetPair[] curPairs;

	// Special case: s is empty.
	if (0 == s.length) {
		return curPairs;
	}

	// Create all all unique pairs, even the ones including empty sets.
	curPairs = new SetPair[1]; // start with empty pair
	foreach (a; s[0..$]) {
		SetPair[] newPairs;
		foreach (p; curPairs) {
			// For each current pair, there are three possible permutations with
			// respect to the next number, a.
			// (1) add a to the left part of the pair
			auto pair = p;
			pair.left ~= a;
			newPairs ~= pair;
			// (2) add a to the right part of the pair--but only if the left pair is
			// nonempty
			// By only adding to the right if the left is nonempty, we guarantee
			// uniqueness of all the pairs.
			if (0 < p.left.length) {
				pair = p;
				pair.right ~= a;
				newPairs ~= pair;
			}
			// (3) don't add a
			newPairs ~= p;
		}
		curPairs = newPairs;
	}

	// Remove all pairs containing an empty set.
	SetPair[] newPairs;
	foreach (p; curPairs) {
		if (0 != p.left.length && 0 != p.right.length) {
			newPairs ~= p;
		}
	}

	return newPairs;
}

unittest {
	assert(to!string(subsetPairs([1])), "[]");
	assert(to!string(subsetPairs([1, 2])), "[SetPair([1], [2])]");
	assert(to!string(subsetPairs([1, 2, 3])),
			"[SetPair([1, 2], [3]), "
			"SetPair([1, 3], [2]), "
			"SetPair([1], [2, 3]), "
			"SetPair([1], [2]), "
			"SetPair([1], [3]), "
			"SetPair([2], [3])]");
}

void main() {
	writeln(pairsToTest(12)); 
}

int pairsToTest(immutable int n) {

	// Construct set. Don't create a real Special Sum Set. Instead, use
	// incremental placeholders--e.g., [1, 2, 3, 4] for when n is 4.
	int[] set = new int[](n);
	foreach (i; 0 .. n) {
		set[i] = i + 1;
	}

	// Create all pairs of subsets.
	auto pairs = subsetPairs(set);

	// Count pairs whose subsets could be equal. Two subsets could be equal only
	// if (1) the subsets are the same length and (2) the left subset has an nth
	// member that's greater than the right subset's nth member.
	int c;
	foreach (p; pairs) {
		if (p.left.length == p.right.length) {
			foreach (i; 0 .. p.left.length) {
				if (p.left[i] > p.right[i]) {
					c++;
					break;
				}
			}
		}
	}

	return c;
}

unittest {

	// trivial cases:
	assert(0 == pairsToTest(1));
	assert(0 == pairsToTest(2));
	assert(0 == pairsToTest(3));

	// from the Project Euler problem description:
	assert(1 == pairsToTest(4));
	assert(70 == pairsToTest(7));
}

