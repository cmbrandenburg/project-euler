// vim: set noet ts=2 sw=2:
//
// Cube digit pairs

import std.stdio;

immutable base = 10;
immutable setSize = 6;
immutable sameAsSix = 9;

void main() {

	int finalCnt;
	auto sets = enumSets();
	foreach (i, a; sets) {
		foreach (_, b; sets[i..$]) {
			if (coversSquares(a, b))
				finalCnt++;
		}
	}

	writeln(finalCnt);
}

static bool coversSquares(int[] setA, int[] setB) {
	for (int root = 1; root < base; root++) {
		int sq = root * root;
		int d1 = sq / base;
		int d2 = sq % base;
		if ((!isInSet(setA, d1) || !isInSet(setB, d2)) &&
		    (!isInSet(setA, d2) || !isInSet(setB, d1))) {
			return false;
		}
	}
	//writeln(setA, "\t", setB);
	return true;
}

static bool isInSet(int[] set, int key) {
	foreach (_, d; set) {
		if (d == key ||
		    (d == sameAsSix && key == 6) ||
		    (d == 6 && key == sameAsSix))
			return true;
	}
	return false;
}

static int[][] enumSets() {

	static void recurseSets(
			ref int[][] sets,
			int[] curSet,
			int[] availDigits) {
		if (curSet.length == setSize) {
			sets ~= curSet;
			return;
		}
		recurseSets(sets, curSet ~ availDigits[0], availDigits[1..$]);
		if (curSet.length + availDigits.length > setSize) {
			recurseSets(sets, curSet, availDigits[1..$]);
		}
	}

	int[][] sets;
	int[] availDigits;
	for (int i = 0; i < base; i++) {
		availDigits ~= i;
	}
	recurseSets(sets, [], availDigits);
	return sets;
}

