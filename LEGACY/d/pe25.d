// vim: set noet ts=2 sw=2:
//
// 1000-digit Fibonacci number

import std.bigint;
import std.stdio;
import exponent;

void main() {

	// The atLeast variable contains the number of iterations that can be done
	// without having to check the number of digits in the term. This optimization
	// greatly reduces the number of BigInt calculations, cutting the runtime time
	// down by a couple orders of magnitude.

	immutable N = 1000;
	BigInt prev = 1;
	BigInt cur = 1;
	long cnt = 2;
	long numDigits;
	long atLeast = N;
	do {
		BigInt newCur = prev + cur;
		prev = cur;
		cur = newCur;
		cnt++;
		atLeast--;
		if (atLeast == 0) {
			numDigits = ilog(cur, 10);
			atLeast = N - numDigits - 1;
		}
	} while (numDigits < N - 1);
	writeln(cnt);
}

