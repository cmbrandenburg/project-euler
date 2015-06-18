// vim: set noet ts=2 sw=2:
//
// Permuted multiples

import std.stdio;
import digit;

void main() {
	long i = 1;
	bool ok;
	do {
		auto canonDigits = enumDigitCounts(i);
		ok = true;
		for (int j = 2; j <= 6 && ok; j++) {
			auto multiDigits = enumDigitCounts(j * i);
			if (canonDigits != multiDigits) {
				ok = false;
				i++;
			}
		}
	} while (!ok);
	writeln(i);
}

