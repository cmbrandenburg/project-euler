// vim: set noet ts=2 sw=2:
//
// Circular primes

import std.stdio;
import prime;
import exponent;

void main() {

	bool isCircularPrime(
			long n) {
		long numDigits = ilog(n) + 1;
		long mostSig = ipow(10, numDigits - 1); // e.g., for 197 mostSig==100
		long nRot = n;
		for (int i = 1; i < numDigits; i++) {
			nRot = (nRot % mostSig) * 10 + (nRot / mostSig);
			if (!isPrime(nRot))
				return false;
		}
		return true;	
	}

	int cnt;
	long prime;
	for (int i; (prime = nthPrime(i)) < 1_000_000; i++) {
		if (isCircularPrime(prime))
			cnt++;
	}
	writeln(cnt);
}

