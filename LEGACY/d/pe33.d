// vim: set noet ts=2 sw=2:
//
// Digit canceling fractions

import std.stdio;
import factor;

void main() {

	int prodA = 1, prodB = 1;

	for (int a = 10; a <= 99; a++) {
		for (int b = a + 1; b <= 99; b++) {
			if ((a / 10 != (a % 10) || b / 10 != (b % 10)) && 
			    (a % 10) == b / 10 &&
			    (a / 10) * b == (b % 10) * a) {
				prodA *= a;
				prodB *= b;
			}
		}
	}
	int div = gcd(prodA, prodB);
	prodA /= div;
	prodB /= div;
	writeln(prodB);
}

