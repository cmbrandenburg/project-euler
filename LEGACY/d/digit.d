// vim: set noet ts=2 sw=2:

import exponent;

/// Returns the sum of the digits.
long sumDigits(Int, alias base = 10)(Int n) {
	long sum;
	while (n > 0) {
		sum += n % base;
		n /= base;
	}
	return sum;
}

unittest {
	assert(sumDigits(1) == 1);
	assert(sumDigits(9) == 9);
	assert(sumDigits(10) == 1);
	assert(sumDigits(1000000) == 1);
	assert(sumDigits(1000001) == 2);
	assert(sumDigits(1009911) == 21);
}

bool isPalindrome(Int)(Int n, Int base = 10) {
	Int rev, origN = n;
	while (n > 0) {
		rev *= base;
		rev += n % base;
		n /= base;
	}
	return origN == rev;
}

unittest {
	assert(isPalindrome(1));
	assert(isPalindrome(9));
	assert(isPalindrome(0));
	assert(isPalindrome(11));
	assert(isPalindrome(121));
	assert(isPalindrome(1221));
	assert(isPalindrome(1239321));
	assert(!isPalindrome(1239320));
	assert(!isPalindrome(1239311));
	assert(!isPalindrome(12911));
	assert(!isPalindrome(10));
	assert(isPalindrome(0x1, 2));
	assert(isPalindrome(0x3, 2));
	assert(isPalindrome(0x5, 2));
	assert(isPalindrome(0x81, 2));
	assert(!isPalindrome(0x4, 2));
}

/// Returns whether a given number is pandigital.
bool isPandigital(long n, bool allowZero = true, int base = 10) {
	bool[] digits;
	bool hasZero;
	digits.length = base;
	int cnt;
	while (n > 0) {
		long digit = n % base;
		if (digit == 0) {
			if (!allowZero)
				return false;
			hasZero = true;
		}
		if (digits[digit])
			return false;
		digits[digit] = true;
		n /= base;
		cnt++;
	}
	return cnt == base - (hasZero ? 0 : 1);
}

unittest {
	assert(isPandigital(123456789, true));
	assert(isPandigital(123456789, false));
	assert(isPandigital(1234567890, true));
	assert(!isPandigital(1234567890, false));
	assert(!isPandigital(12345678, true));
	assert(!isPandigital(12345678, false));
	assert(!isPandigital(12345678901, true));
	assert(!isPandigital(1234567891, true));
	assert(!isPandigital(1234567891, false));
	assert(!isPandigital(0, true, 2));
	assert(isPandigital(1, false, 2));
	assert(isPandigital(1, true, 2));
	assert(isPandigital(2, true, 2));
	assert(!isPandigital(2, false, 2));
	assert(!isPandigital(3, true, 2));
}

bool isPartialPandigital(long n, bool allowZero = false, int base = 10) {
	bool[] digits;
	bool hasZero;
	digits.length = base;
	int cnt;
	while (n > 0) {
		long digit = n % base;
		if (digit == 0) {
			if (!allowZero)
				return false;
			hasZero = true;
		}
		if (digits[digit])
			return false;
		digits[digit] = true;
		n /= base;
		cnt++;
	}
	for (int i = 1; i < cnt + (hasZero ? 0 : 1); i++) {
		if (!digits[i])
			return false;
	}
	return true;
}

unittest {
	assert(isPartialPandigital(1));
	assert(isPartialPandigital(12));
	assert(isPartialPandigital(21));
	assert(isPartialPandigital(123456789));
	assert(isPartialPandigital(987654321));
	assert(isPartialPandigital(9876543210, true));
	assert(isPartialPandigital(987654321, true));
	assert(isPartialPandigital(1, false, 2));
}

long[] enumPandigital(int base) {

	long[] ret;

	void recur(
			long num,
			int[] availDigits) {
		if (availDigits.length == 0) {
			ret ~= num;
			return;
		}
		foreach (i, digit; availDigits) {
			int[] newDigits;
			newDigits ~= availDigits[0..i];
			newDigits ~= availDigits[i+1 .. $];
			recur(num * base + digit, newDigits);
		}
	}

	int[] availDigits;
	for (int i = 0; i < base; i++) {
		availDigits ~= i;
	}

	recur(0, availDigits);	
	return ret;
}

Int catNumbers(Int)(Int a, Int b) {
	return (a * ipow(10, ilog(b) + 1)) + b;
}

unittest {
	assert(catNumbers(1, 12) == 112);
	assert(catNumbers(120, 1) == 1201);
}

Int reverseNumber(Int)(Int n) {
	Int ret;
	while (n > 0) {
		ret *= 10;
		ret += n % 10;
		n /= 10;
	}
	return ret;
}

unittest {
	assert(reverseNumber(0) == 0);
	assert(reverseNumber(1) == 1);
	assert(reverseNumber(5) == 5);
	assert(reverseNumber(55) == 55);
	assert(reverseNumber(50) == 5);
	assert(reverseNumber(51) == 15);
	assert(reverseNumber(1234) == 4321);
	assert(reverseNumber(1004) == 4001);
	assert(reverseNumber(1000) == 1);
}

long[10] enumDigitCounts(Int)(Int n) {
	long[10] counts;
	while (n > 0) {
		counts[n % 10]++;
		n /= 10;
	}
	return counts;
}

