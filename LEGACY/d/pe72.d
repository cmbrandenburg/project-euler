// vim: set noet ts=2 sw=2:
//
// Counting fractions

import std.stdio;
import factor;

void main() {
	long cnt;
	for (int d = 2; d <= 1_000_000; d++) {
		auto factors = enumPrimeFactors(d);
		long num = d;
		long denom = 1;
		foreach (_, factor; factors) {
			num *= factor - 1;
			denom *= factor;
		}
		long totient = num / denom;
		//writeln(d, "\t", totient, "\t", num, " / ", denom, "\t", factors);
		cnt += totient;
	}
	writeln(cnt);
}
