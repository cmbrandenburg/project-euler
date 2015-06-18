// vim: set noet ts=2 sw=2:
//
// Largest exponential

import std.math;
import std.stdio;
import exponent;

void main() {

	auto inFile = new File("data/base_exp.txt");
	int lineNo;
	real biggest = 0;
	int biggestLineNo;
	while (!inFile.eof()) {
		// read line:
		lineNo++;
		int base;
		int exp;
		inFile.readf("%d,%d ", &base, &exp);
		// compare logarithms:
		real basePow = log10(base);
		real totalPow = basePow * exp;
		//writeln("\t", base, "^", exp, "\t", totalPow);
		if (totalPow > biggest) {
			biggest = totalPow;
			biggestLineNo = lineNo;
			//writeln(lineNo, "\t", base, "^", exp);
		}
	}

	writeln(biggestLineNo);
}

