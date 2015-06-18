// vim: set noet ts=2 sw=2:
//
// Right triangles with integer coordinates

import std.stdio;
import factor;

void main() {

	immutable max = 50;

	long finalCnt;

	for (int i = max; i <= max; i++) {

		// First account for all right triangles that have at least one
		// non-hypotenuse side along the X or Y axis.
		finalCnt = 3 * (i * i);

		// Now count the right triangles that have a hypotenuse side along either
		// axis.
		for (int x = 1; x < i; x++) {
			for (int y = 1; y <= i; y++) {
				//writeln("\t(", x, ", ", y, ")");
				int localCnt;
				int x2 = x, y2 = y;
				int factor = gcd(x, y);
				while ((x2 += y / factor) <= i && (y2 -= x / factor) >= 0) {
					//writeln("\t\t(", x2, ", ", y2, ")");
					localCnt++;
				}
				localCnt *= 2;
				finalCnt += localCnt;
			}
		}
		//writeln(i, "\t", finalCnt);
	}

	writeln(finalCnt);
}

