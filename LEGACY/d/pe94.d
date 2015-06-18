// vim: set noet ts=2 sw=2:
//
// Almost equilateral triangles

import std.stdio;

void main() {

	immutable maxPerim = 1_000_000_000;

	long finalSum;

	long smallRt = 1;
	long smallSq = smallRt * smallRt;
	long bigRt = 1;
	long bigSq = bigRt * bigRt;
	for (long len = 3; len <= maxPerim / 3; len += 2) {

		// The hypotenuse is either one of the two sides that are the same length.
		long hypot = len;
		long hypotSq = hypot * hypot;

		// The base is the side that's a different length than the other two sides.
		long smallBase = (len - 1) / 2;
		long smallBaseSq = smallBase * smallBase;
		long bigBase = (len + 1) / 2;
		long bigBaseSq = bigBase * bigBase;

		// Calculate the height of the triangle. (a^2 + b^2 = c^2)
		long bigHeightSq = hypotSq - smallBaseSq;
		long smallHeightSq = hypotSq - bigBaseSq;

		// Check whether the "big" height is a perfect square.
		while (bigHeightSq > bigSq) {
			bigRt++;
			bigSq = bigRt * bigRt;
		}
		if (bigHeightSq == bigSq) {
			//writeln(hypot, "\t", hypot, "\t", 2 * smallBase);
			long perim = 2 * hypot + 2 * smallBase;
			finalSum += perim;
		}

		// Check whether the "small" height is a perfect square.
		while (smallHeightSq > smallSq) {
			smallRt++;
			smallSq = smallRt * smallRt;
		}
		if (smallHeightSq == smallSq) {
			//writeln(hypot, "\t", hypot, "\t", 2 * bigBase);
			long perim = 2 * hypot + 2 * bigBase;
			finalSum += perim;
		}
	}

	writeln(finalSum);
}

