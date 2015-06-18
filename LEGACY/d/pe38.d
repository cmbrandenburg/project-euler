// vim: set noet ts=2 sw=2:
//
// Pandigital multiples

import std.stdio;
import digit;
import exponent;

void main() {
	long biggestPan;
	int i = 1;
	while (i < 100000) {
		long cat;
		long prevCat;
		int j = 1;
		while (cat < 1_000_000_000) {
			long prod = i * j;
			prevCat = cat;
			cat *= ipow!long(10, ilog(prod) + 1);
			cat += prod;
			j++;
		}
		if (isPandigital(prevCat)) {
			if (prevCat > biggestPan) {
				biggestPan = prevCat;
			}
		}
		i++;
	}
	writeln(biggestPan);
}

