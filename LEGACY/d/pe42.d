// vim: set noet ts=2 sw=2:
//
// Coded triangle numbers

import std.regex;
import std.stdio;
import quad;

static int valueFromWord(string word) {
	int ret;
	foreach (_, ch; word) {
		ret += ch - 'A' + 1;
	}
	return ret;
}

void main() {
	// load words:
	auto inFile = File("data/words.txt", "r");
	auto regex = regex("\"([A-Z]+)\",?$");
	string[] words;
	while (!inFile.eof()) {
		string word = inFile.readln(',');
		auto matches = match(word, regex);
		words ~= matches.captures[1];
	}
	// count triangle words:
	int cnt;
	foreach (_, word; words) {
		auto val = valueFromWord(word);
		if (isTriangle(val)) {
			cnt++;
		}
	}
	writeln(cnt);
}

