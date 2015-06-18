// vim: set noet ts=2 sw=2:
//
// Darts

import std.stdio;

// A "dart" comprises a tuple: region, multiplier. The region represents the
// base score of the dart: 1, 2, 3, ..., 20, bullseye. The actual region ranges
// from 0 to 20, inclusively, with 0 being the bullseye. The multiplier is 1, 2,
// or 3.

const int multiMax = 3; // number of multipliers
const int regionMax = 20; // number of numeric regions
const int regionBull = 0; // region representing bullseye
const int bullScore = 25; // point value of bullseye

struct Dart {

	int multi;
	int region;

	this(int multi, int region) {
		this.multi = multi;
		this.region = region;
	}

	this(int id) {
		multi = (id / (regionMax + 1)) + 1;
		region = id % (regionMax + 1);
	}

	// Hashes the dart to a unique scalar.
	int hash() const {
		return (multi - 1) * (regionMax + 1) + region;
	}

	int score() const {
		return multi * (region == 0 ? bullScore : region);
	}
};

unittest {

	// hashing:
	assert(1 == Dart(Dart(1, 1).hash()).multi);
	assert(1 == Dart(Dart(1, 1).hash()).region);
	assert(1 == Dart(Dart(1, 1).hash()).multi);
	assert(3 == Dart(Dart(1, 3).hash()).region);
	assert(2 == Dart(Dart(2, 1).hash()).multi);
	assert(3 == Dart(Dart(2, 3).hash()).region);
	assert(2 == Dart(Dart(2, 1).hash()).multi);
	assert(0 == Dart(Dart(2, 0).hash()).region);

	// scoring:
	assert(1 == Dart(1, 1).score());
	assert(3 == Dart(1, 3).score());
	assert(12 == Dart(2, 6).score());
	assert(18 == Dart(3, 6).score());
	assert(bullScore == Dart(1, 0).score());
	assert(2 * bullScore == Dart(2, 0).score());
}

// Returns an array 
Dart[] enumDarts() {
	Dart[] darts;
	for (int multi = 1; multi <= 3; multi++) {
		for (int region = 0; region <= regionMax; region++) {
			if (region != 0 || multi != 3) {
				darts ~= Dart(multi, region);
			}
		}
	}
	return darts;
}

unittest {
	assert(multiMax * (regionMax + 1) - 1 == enumDarts.length);
}

int checkoutScore(const Dart[] co) {
	int sum;
	foreach (d; co) {
		sum += d.score();
	}
	return sum;
}

// Number of ways to check out with a score less than K.
Dart[][] enumCheckouts() {
	Dart[][] checkouts;
	auto darts = enumDarts();
	foreach (a; darts) {
		int aHash = a.hash();

		// 1 dart:
		if (a.multi == 2) {
			Dart[] co = [a];
			checkouts ~= co;
		}

		foreach (b; darts) {
			int bHash = b.hash();

			// 2 darts:
			if (b.multi == 2) {
				Dart[] co = [a, b];
				checkouts ~= co;
			}

			// 3 darts:
			if (bHash < aHash) {
				continue; // indistinct, so discard
			}
			foreach (c; darts) {
				if (c.multi == 2) {
					Dart[] co = [a, b, c];
					checkouts ~= co;
				}
			}
		}
	}
	return checkouts;
}

unittest {
	assert(42336 == enumCheckouts().length);
}

// Returns the number of checkouts with a score less than K.
int numCheckouts(const int K) {
	const Dart[][] allCheckouts = enumCheckouts();
	int n;
	foreach (co; enumCheckouts) {
		if (checkoutScore(co) < K) {
			n++;
		}
	}
	return n;
}

unittest {
	assert(0 == numCheckouts(2));
	assert(1 == numCheckouts(3));
	assert(2 == numCheckouts(4));

	// D2
	// D1
	// D1 D1
	// S2 D1
	// S1 D1
	// S1 S1 D1
	assert(6 == numCheckouts(5));
}

void main() {
	writeln(numCheckouts(100));
}

