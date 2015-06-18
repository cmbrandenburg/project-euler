// vim: set noet ts=2 sw=2:
//
// Diophantine equation
//
// See: http://en.wikipedia.org/wiki/Chakravala_method

import std.bigint;
import std.math;
import std.stdio;
import quad;

void main() {
	BigInt biggestX;
	int biggestD;
	for (int d = 1; d <= 1000; d++) {
		if (!isSquare(d)) {
			//writeln(d);
			auto x = minX(d);
			if (x > biggestX) {
				biggestX = x;
				biggestD = d;
			}
		}
	}
	writeln(biggestD);
}

static BigInt minX(int N) {

	immutable int rtN = cast(int)(sqrt(cast(real)(N)));

	static BigInt abs(BigInt n) {
		return n < 0 ? -n : n;
	}

	BigInt chooseM(BigInt a, BigInt b, BigInt k) {

		// m is chosen such that:
		// (a + b * m) % k == 0
		//  *and*
		// abs(m * m - N) is minimized

		//writeln("\t\tchoosing m");

		// The method of choosing m isn't efficient. Rather than using
		// (complicated?) modulo math to figure out which m to try first, we instead
		// use a (possibly big) range of values to try. In other words, this is a
		// brute force algorithm, and it's efficiency depends on |k| being a small
		// value.

		BigInt minM;
		BigInt minVal;
		bool first = true;
		for (BigInt tryM = -abs(k) + rtN; tryM <= abs(k) + rtN; tryM += 1) {
			//writeln("\t\t", tryM);
			if ((a + b * tryM) % k == 0) {
				BigInt val = abs(tryM * tryM - N);
				//writeln("\t\t\t", val);
				if (first || val < minVal) {
					minM = tryM;
					minVal = val;
				}
				first = false;
			}
		}
		return minM;
	}

	BigInt a = rtN + 1;
	BigInt b = 1;
	BigInt k = (a * a) - (b * b * N);
	//writeln("\t", a, "\t", b, "\t", k);
	while (k != 1) {
		BigInt m = chooseM(a, b, k);		
		//writeln("\t\tm: ", m);
		BigInt nextA = (a * m + b * N) / abs(k);
		BigInt nextB = (a + b * m) / abs(k);
		BigInt nextK = (m * m - N) / k;
		a = nextA;
		b = nextB;
		k = nextK;
		//writeln("\t", a, "\t", b, "\t", k);
		assert(a * a - N * b * b == k);
	}
	return a;
}

