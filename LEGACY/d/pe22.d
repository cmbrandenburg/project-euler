// vim: set noet ts=2 sw=2:
//
// Names scores

import std.regex;
import std.stdio;

void main() {
	// load names:
	auto inFile = File("data/names.txt", "r");
	auto regex = regex("\"([A-Z]+)\",?$");
	string[] names;
	while (!inFile.eof()) {
		string name = inFile.readln(',');
		auto matches = match(name, regex);
		names ~= matches.captures[1];
	}
	names.sort;
	// sum name scores:
	long sum;
	foreach (i, name; names) {
		long alphaValue;
		foreach (_, ch; name) {
			alphaValue += ch - 'A' + 1;
		}
		sum += alphaValue * (i + 1);
	}
	writeln(sum);
}

