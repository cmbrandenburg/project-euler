// vim: set noet ts=2 sw=2:
//
// form eight different primes.

import std.stdio;
import exponent;
import prime;

static long binToDec(long bin) {
	long dec;
	long base = 1;
	while (bin > 0) {
		if ((bin % 2) != 0) {
			dec += base;
		}
		base *= 10;
		bin /= 2;
	}
	return dec;
}

unittest {
	assert(binToDec(0) == 0);
	assert(binToDec(1) == 1);
	assert(binToDec(2) == 10);
	assert(binToDec(3) == 11);
	assert(binToDec(4) == 100);
	assert(binToDec(5) == 101);
	assert(binToDec(6) == 110);
	assert(binToDec(7) == 111);
	assert(binToDec(8) == 1000);
}

void main() {

	long[] enumMasks(long max) {
		long[] masks;
		long bin = 1;
		long dec;
		while ((dec = binToDec(bin)) < max) {
			masks ~= dec;
			bin++;
		}
		return masks;
	}

	import std.stdio;
	long numDigits = 2;
	while (true) {
		// families:
		//  mask -> primeWithoutMask -> [primes]
		//  e.g., 101010 -> 40109 -> [242129, 646169]
		long[][long][long] families;
		long max = ipow(10, numDigits - 1);
		long min = max / 10;
		auto masks = enumMasks(max);
		long prime;
		for (size_t i = primeIndex(min); (prime = nthPrime(i)) < max; i++) {
			foreach (_, mask; masks) {
				long primeCp = prime;
				long maskCp = mask;
				int maskDigit = -1;
				while (primeCp > 0) {
					if ((maskCp % 10) != 0) {
						if (maskDigit == -1) {
							maskDigit = primeCp % 10;
						} else if (maskDigit != (primeCp % 10)) {
							break;
						}
					}
					primeCp /= 10;
					maskCp /= 10;
				}
				// If primeCp is 0 then prime fits the mask.
				if (primeCp == 0) {
					long primeWithoutMask = prime;
					long base = 1;
					maskCp = mask;
					while (maskCp > 0) {
						if ((maskCp % 10) != 0) {
							primeWithoutMask -= base * ((prime / base) % 10);
						}
						maskCp /= 10;
						base *= 10;
					}
					families[mask][primeWithoutMask] ~= prime;
					// Find first family of eight primes.
					if (families[mask][primeWithoutMask].length == 8) {
						writeln(families[mask][primeWithoutMask][0]);
						return;
					}
				}
			}	
		}
		numDigits++;
	}
	assert(false);
}

