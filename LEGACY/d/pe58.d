// vim: set noet ts=2 sw=2:
//
// Spiral primes

import std.bigint;
import std.stdio;
import prime;

void main() {

	long len = 1;
	long inc = 0;
	long last = 1;
	long primeCnt = 0;
	long totalCnt = 1;
	do {
		len += 2;
		inc += 2;
		for (int i = 0; i < 4; i++) {
			last += inc;
			totalCnt++;
			if (isPrime(last))
				primeCnt++;
		}
	} while (primeCnt * 10 >= totalCnt);
	writeln(len);
}

