// vim: set noet ts=2 sw=2:
//
// Goldbach's other conjecture

import std.stdio;
import prime;

void main() {
	long n = 9;
	while (true) {
		bool can;
		for (long i = 1; !can && 2 * i * i < n; i++) {
			long diff = n - (2 * i * i);
			if (isPrime(diff)) {
				can = true;
				break;
			}
		}
		if (!can) {
			writeln(n);
			return;
		}
		do {
			n += 2;
		} while (isPrime(n));
	}
}

