// vim: set noet ts=2 sw=2:
//
// Odd period square roots

// NOTE: This program isn't intended to be readable. It performs a specific
// algebraic algorithm that isn't easily expressed in D. Instead of making the
// program readable, I kept track of the two important numbers, "top" and "bot",
// throughout each iteration. This would make sense only if consulting my
// original notepad, on which I worked out several examples using specific
// values of N from problem 64.

import std.algorithm;
import std.math;
import std.stdio;
import quad;
import factor;

static bool isOddContinuedFraction(int n) {

	int rt = cast(int)(sqrt(cast(real)(n)));
	int firstTop = 1, firstBot = -rt;

	int findPeriod(
			int top,
			int bot,
			bool first = true) {

		//writeln("\t", top, "\t", bot);
		assert(bot < 0);

		if (!first && top == firstTop && bot == firstBot) {
			return 0;
		}

		int oldBot = bot;
		bot = n + (bot * -bot);

		// reduce:
		int factor = gcd(top, bot);
		top /= factor;
		bot /= factor;

		// new digit:
		int newDigit = (-oldBot + rt) / bot;

		// new top:
		top = -oldBot - (newDigit * bot);

		// flip:
		swap(top, bot);

		// repeat:
		return 1 + findPeriod(top, bot, false);
	}

	int len = findPeriod(firstTop, firstBot);
	//writeln("\tlen=", len);
	return (len % 2) == 1;
}

void main() {
	int cnt;
	for (int i = 1; i <= 10000; i++) {
		if (!isSquare(i)) {
			if (isOddContinuedFraction(i)) {
				cnt++;
			}
		}
	}
	writeln(cnt);
}

