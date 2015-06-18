// vim: set noet ts=2 sw=2:
//
// Pentagon numbers

import std.stdio;
import quad;

void main() {
	long smallestDiff;
	long j, k = 1;
	while (true) {
		k++;
		long pk = pentagonal(k);
		if (smallestDiff != 0 && pk - pentagonal(k - 1) > smallestDiff) {
			break;
		}
		for (j = k - 1; j >= 1; j--) {
			long pj = pentagonal(j);
			long diff = pk - pj;
			if (smallestDiff != 0 && diff > smallestDiff) {
				break;
			}
			if (isPentagonal(diff)) {
				long sum = pk + pj;
				if (isPentagonal(sum)) {
					if (smallestDiff == 0 || diff < smallestDiff) {
						smallestDiff = diff;
					}
					//writeln(pj, "\t", pk, "\t", diff, "\t", sum);
				}
			}
		}
	}
	writeln(smallestDiff);
}

