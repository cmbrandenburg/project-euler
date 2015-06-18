// vim: set noet ts=2 sw=2:
//
// Arithmetic expressions

import std.stdio;
import rational;

immutable setSize = 4; // number of digits

void main() {

	auto digitSets = enumDigitSets();
	auto opSeqs = enumOpSequences();

	int[] maxDSet;
	int maxN;

	foreach (_, dSet; digitSets) {
		bool[9 * 8 * 7 * 6 + 1] results;
		auto digitPerms = enumDigitPerms(dSet);
		foreach (__, opSeq; opSeqs) {
			foreach (___, dPerm; digitPerms) {
				// There are five ways to arrange a given sequence of digits (T0, T1,
				// T2, T3) and a given sequence of operations (O0, O1, O2) whereby both
				// sequences are kept in order. Each comment below is written in postfix
				// notation to remove parentheses.
				auto result = Rational!int(0);
				auto result1 = Rational!int(0);
				auto result2 = Rational!int(0);
				auto t0 = Rational!int(dPerm[0]);
				auto t1 = Rational!int(dPerm[1]);
				auto t2 = Rational!int(dPerm[2]);
				auto t3 = Rational!int(dPerm[3]);
				// T0 T1 T2 T3 O0 O1 O2:
				if (opSeq[0](result, t2, t3) &&
						opSeq[1](result, t1, result) &&
						opSeq[2](result, t0, result) &&
				    result >= 0) {
					result.reduce();
					if (result.denominator == 1) {
						results[result.numerator] = true;
						//writeln(result, "\t", dPerm, "\t", opSeq);
					}
				}
				// T0 T1 T2 O0 T3 O1 O2:
				if (opSeq[0](result, t1, t2) &&
						opSeq[1](result, result, t3) &&
						opSeq[2](result, t0, result) &&
				    result >= 0) {
					result.reduce();
					if (result.denominator == 1) {
						results[result.numerator] = true;
						//writeln(result, "\t", dPerm, "\t", opSeq);
					}
				}
				// T0 T1 T2 O0 O1 T3 O2:
				if (opSeq[0](result, t1, t2) &&
						opSeq[1](result, t0, result) &&
						opSeq[2](result, result, t3) &&
				    result >= 0) {
					result.reduce();
					if (result.denominator == 1) {
						results[result.numerator] = true;
						//writeln(result, "\t", dPerm, "\t", opSeq);
					}
				}
				// T0 T1 O0 T2 T3 O1 O2:
				if (opSeq[0](result1, t0, t1) &&
						opSeq[1](result2, t2, t3) &&
						opSeq[2](result, result1, result2) &&
				    result >= 0) {
					result.reduce();
					if (result.denominator == 1) {
						results[result.numerator] = true;
						//writeln(result, "\t", dPerm, "\t", opSeq);
					}
				}
				// T0 T1 O0 T2 O1 T3 O2:
				if (opSeq[0](result, t0, t1) &&
						opSeq[1](result, result, t2) &&
						opSeq[2](result, result, t3) &&
				    result >= 0) {
					result.reduce();
					if (result.denominator == 1) {
						results[result.numerator] = true;
						//writeln(result, "\t", dPerm, "\t", opSeq);
					}
				}
			}
		}
		int i = 0;
		while (results[i + 1]) { i++; }
		if (i > maxN) {
			maxN = i;
			maxDSet = dSet;
		}
		//writeln(dSet, "\t", i);
	}

	int finalNum;
	foreach (_, n; maxDSet) {
		finalNum *= 10;
		finalNum += n;
	}

	writeln(finalNum);
}

static int[][] enumDigitSets() {

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
	for (int i = 1; i <= 9; i++) {
		availDigits ~= i;
	}
	recurseSets(sets, [], availDigits);
	return sets;
}

alias bool function(out Rational!int, Rational!int, Rational!int) opFunc;

static opFunc[][] enumOpSequences() {

	static void recurseSeqs(ref opFunc[][] seqs, opFunc[] curSeq) {
		if (curSeq.length == setSize - 1) {
			seqs ~= curSeq;
			return;
		}
		recurseSeqs(seqs, curSeq ~ function(
					out Rational!int result,
					Rational!int a,
					Rational!int b) {
				//writeln("\t", a, " + ", b, " = ", a + b);
				result = a + b; return true; });
		recurseSeqs(seqs, curSeq ~ function(
					out Rational!int result,
					Rational!int a,
					Rational!int b) {
				//writeln("\t", a, " - ", b, " = ", a - b);
				result =  a - b; return true; });
		recurseSeqs(seqs, curSeq ~ function(
					out Rational!int result,
					Rational!int a,
					Rational!int b) {
				//writeln("\t", a, " * ", b, " = ", a * b);
				result =  a * b; return true; });
		recurseSeqs(seqs, curSeq ~ function(
					out Rational!int result,
					Rational!int a,
					Rational!int b) {
				//writeln("\t", a, " / ", b);
				if (b == 0) { return false; }
				//writeln("\t", a, " / ", b, " = ", a / b);
				result = a / b; return true; });
	}

	opFunc[][] seqs;
	recurseSeqs(seqs, []);
	return seqs;
}

static int[][] enumDigitPerms(int[] digitSet) {

	static void recursePerms(
			ref int[][] perms,
			int[] curPerm,
			int[] availDigits) {
		if (availDigits.length == 0) {
			perms ~= curPerm;
			return;
		}
		foreach (i, d; availDigits) {
			recursePerms(
					perms,
					curPerm ~ d,
					availDigits[0..i] ~ availDigits[i+1 .. $]);
		}
	}

	int[][] perms;
	recursePerms(perms, [], digitSet);
	return perms;
}

