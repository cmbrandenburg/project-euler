// vim: set noet ts=2 sw=2:
//
// Roman numerals

// M: 1000
// D: 500
// C: 100
// L: 50
// X: 10
// V: 5
// I: 1
//
// I before V and X
// X before L and C
// C before D and M

import std.stdio;
import std.string;

void main() {

	size_t finalSum;

	auto inFile = new File("data/roman.txt");
	while (!inFile.eof()) {
		string line = chomp(inFile.readln());
		string shortNum = compressNumeral(line);
		finalSum += line.length - shortNum.length;
		/*writeln(evalNumeral(line), "\t", line.length - shortNum.length, "\t",
				finalSum, "\t", line, "\t", shortNum);*/
	}

	writeln(finalSum);
}

static string compressNumeral(in string inNum) {

	int val = evalNumeral(inNum);
	string outNum;

	while (val >= 1000) {
		val -= 1000;
		outNum ~= "M";
	}
	if (val >= 900) {
		val -= 900;
		outNum ~= "CM";
	}
	if (val >= 500) {
		val -= 500;
		outNum ~= "D";
	}
	if (val >= 400) {
		val -= 400;
		outNum ~= "CD";
	}

	while (val >= 100) {
		val -= 100;
		outNum ~= "C";
	}
	if (val >= 90) {
		val -= 90;
		outNum ~= "XC";
	}
	if (val >= 50) {
		val -= 50;
		outNum ~= "L";
	}
	if (val >= 40) {
		val -= 40;
		outNum ~= "XL";
	}

	while (val >= 10) {
		val -= 10;
		outNum ~= "X";
	}
	if (val >= 9) {
		val -= 9;
		outNum ~= "IX";
	}
	if (val >= 5) {
		val -= 5;
		outNum ~= "V";
	}
	if (val >= 4) {
		val -= 4;
		outNum ~= "IV";
	}

	while (val > 0) {
		val--;
		outNum ~= "I";
	}

	assert(evalNumeral(outNum) == evalNumeral(inNum));

	return outNum;
}

unittest {
	assert(compressNumeral("MMMDCCCC") == "MMMCM");
	assert(compressNumeral("MCCCC") == "MCD");
	assert(compressNumeral("CCCCCCCCC") == "CM");
	assert(compressNumeral("XXXXXXXXX") == "XC");
	assert(compressNumeral("LXXXX") == "XC");
	assert(compressNumeral("XXXX") == "XL");
	assert(compressNumeral("XXXXIIIIIIIII") == "XLIX");
	assert(compressNumeral("IIII") == "IV");
	assert(compressNumeral("DCCCCLXXXXVIIII") == "CMXCIX");
}

static int evalNumeral(in string inNum) {
	int finalSum;
	int prevVal;
	foreach (_, ch; inNum) {
		int curVal = numeralCharToValue(ch);
		if (curVal > prevVal)
			finalSum -= 2 * prevVal;
		finalSum += curVal;
		prevVal = curVal;
	}
	return finalSum;
}

unittest {
	assert(evalNumeral("MMMMDDCCLLXXXVVVIII") == 5348);
	assert(evalNumeral("MMMCMIX") == 3909);
}

static int numeralCharToValue(in char ch) {
	switch (ch) {
		case 'M':
			return 1000;
		case 'D':
			return 500;
		case 'C':
			return 100;
		case 'L':
			return 50;
		case 'X':
			return 10;
		case 'V':
			return 5;
		case 'I':
			return 1;
		default:
			assert(false);
	}
}

