// vim: set noet ts=2 sw=2:
//
// Magic 5-gon ring

import std.algorithm;
import std.conv;
import std.stdio;

static immutable N = 5; // solving for 5-gon rings
static immutable solutionLen = 16;

void main() {
	int[] availNums;
	for (int i = 1; i <= 2 * N; i++)
		availNums ~= i;
	auto rings = enumRings(N, availNums);
	string[] solutions;
	foreach (_, ring; rings) {
		//writeln(ring);
		string solution = tryToSolveRing(ring);
		if (solution.length == solutionLen) {
			solutions ~= solution;
		}
	}
	solutions.sort();
	writeln(solutions[$-1]);
}

static string tryToSolveRing(in int[] ring) {

	// Sum the inner pairs.
	int smallestSum = 4 * N;
	int biggestSum;
	int[N] innerSums;
	for (int i = 0; i < N; i++) {
		int sum = ring[i] + ring[(i + 1) % N];
		innerSums[i] = sum;
		smallestSum = min(smallestSum, sum);
		biggestSum = max(biggestSum, sum);
	}

	// Determine which numbers remain to be assigned to the outer slots.
	int smallestOuter = 2 * N;
	int biggestOuter;
	int[] outerNums;
	for (int i = 1; i <= 2 * N; i++) {
		bool outer = true;
		foreach (_, num; ring) {
			if (i == num) {
				outer = false;
				break;
			}
		}
		if (outer) {
			outerNums ~= i;
			smallestOuter = min(smallestOuter, i);
			biggestOuter = max(biggestOuter, i);
		}
	}

	//writeln("\t", innerSums, "\t", outerNums);
	//writeln("\t", smallestOuter, ", ", biggestOuter);

	// Optimization: discard rings whose spread of sums is too big.
	if (biggestSum + smallestOuter > smallestSum + biggestOuter)
		return "";

	//writeln("\tPOSSIBLE");

	// Use brute force to try to solve this ring.
	foreach (_, iOuter; outerNums) {
		int K = innerSums[0] + iOuter;
		bool[int] outerNumMap;
		foreach (__, jOuter; outerNums)
			outerNumMap[jOuter] = false;
		int firstIndex;
		bool fail;
		for (int j = 0; j < N; j++) {
			int need = K - innerSums[j];
			if (!(need in outerNumMap) || outerNumMap[need]) {
				fail = true;
				break;
			}
			outerNumMap[need] = true;
			if (need == smallestOuter) {
				firstIndex = j;
				//writeln("\tfirstIndex=", firstIndex, ", K=", K);
			}
		}
		if (!fail) {
			string solution;
			for (int j = firstIndex; j < firstIndex + N; j++) {
				int modJ = j % N;
				int modJNext = (j + 1) % N;
				int need = K - innerSums[modJ];
				solution ~= to!string(need);
				solution ~= to!string(ring[modJ]);
				solution ~= to!string(ring[modJNext]);
			}
			//writeln("\tSOLUTION: ", solution);
			return solution;
		}
	}

	return "";
}

static int[][] enumRings(int n, int[] availNums) {
	if (n == 0)
		return [[]];
	int[][] rings;
	foreach (i, num; availNums) {
		auto nextAvailNums = availNums[0 .. i] ~ availNums[i+1 .. $];
		auto subRings = enumRings(n - 1, nextAvailNums);
		foreach (j, ring; subRings) {
			subRings[j] ~= num;
		}
		rings ~= subRings;
	}
	return rings;
}

