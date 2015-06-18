// vim: set noet ts=2 sw=2:
//
// Number letter counts

import std.algorithm;
import std.ascii;
import std.stdio;

static size_t letters(int x) {
	return count!("std.ascii.isAlpha(a)")(word(x));
}

static string word(int x) {

	assert(1 <= x);
	assert(x <= 1000);

	if (1 <= x && x < 20) {
		switch (x) {
			case 1:
				return "one";
			case 2:
				return "two";
			case 3:
				return "three";
			case 4:
				return "four";
			case 5:
				return "five";
			case 6:
				return "six";
			case 7:
				return "seven";
			case 8:
				return "eight";
			case 9:
				return "nine";
			case 10:
				return "ten";
			case 11:
				return "eleven";
			case 12:
				return "twelve";
			case 13:
				return "thirteen";
			case 14:
				return "fourteen";
			case 15:
				return "fifteen";
			case 16:
				return "sixteen";
			case 17:
				return "seventeen";
			case 18:
				return "eighteen";
			case 19:
				return "nineteen";
			default:
		}
	}

	string str;

	if (x < 100) {
		switch (x / 10) {
			case 2:
				str = "twenty";
				break;
			case 3:
				str = "thirty";
				break;
			case 4:
				str = "forty";
				break;
			case 5:
				str = "fifty";
				break;
			case 6:
				str = "sixty";
				break;
			case 7:
				str = "seventy";
				break;
			case 8:
				str = "eighty";
				break;
			case 9:
				str = "ninety";
				break;
			default:
		}
		if ((x % 10) == 0) {
			return str;
		}
		return str ~ "-" ~ word(x % 10);
	}

	if (x < 1000) {
		str = word(x / 100) ~ " hundred";
		if ((x % 100) == 0) {
			return str;
		}
		return str ~ " and " ~ word(x % 100);
	}

	assert(x == 1000);
	return "one thousand";
}

void main() {
	int numLetters;
	for (int i = 1; i <= 1000; i++) {
		//writefln("%4s: %s", i, word(i));
		numLetters += letters(i);
	}
	writeln(numLetters);
}

