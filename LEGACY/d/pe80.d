// vim: set noet ts=2 sw=2:
//
// Square root digital expansion

import std.bigint;
import std.stdio;
import exponent;

void main() {
	int sum;
	for (int i = 1; i <= 100; i++) {
		sum += sumOfDigits(i);
	}
	writeln(sum);
}

static int sumOfDigits(int n) {

	immutable BASE = 10;
	immutable DECIMAL_LEN = 100;

	int findBiggestX(BigInt c, BigInt p) {
		int x;
		for (x  = 0; (x + 1) * (20 * p + (x + 1)) <= c; x++) {
		}
		//writeln("\t\t\tc=", c, ", p=", p, " -> ", x);
		return x;
	}

	long pow = ilog(n, BASE);
	pow -= pow % 2;
	BigInt rem = 0;
	BigInt c, p;
	int decimalCnt;
	int x;
	
	//writeln(n);
	do {
		c = rem * BASE * BASE;
		c += pow >= 0 ? (n / ipow!int(BASE, pow)) : 0;
		//writeln("\tc=", c);
		x = findBiggestX(c, p);
		//writeln("\tx=", x);
		BigInt y = x * (20 * p + x);
		//writeln("\ty=", y);
		rem = c - y;
		//writeln("\trem=", rem);
		p = BASE * p + x;
		if (pow >= 0) {
			pow -= 2;
		} //else {
			decimalCnt++;
		//}
		//writeln("\t\tp=", p, ", decimalCnt=", decimalCnt);
	} while (decimalCnt < DECIMAL_LEN && rem != 0);

	if (rem == 0)
		return 0; // n is a perfect square

	// Sum decimal digits.
	int sum;
	for (int i = 0; i < DECIMAL_LEN; i++) {
		sum += p % BASE;
		p /= BASE;
	}

	//writeln(n, "\t", sum);

	return sum;
}

