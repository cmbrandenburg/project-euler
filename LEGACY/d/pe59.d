// vim: set noet ts=2 sw=2:
//
// XOR decryption

import std.ascii;
import std.conv;
import std.regex;
import std.stdio;

void main() {

	auto inFile = File("data/cipher1.txt", "r");
	int[] vals;
	do {
		string line = inFile.readln(',');
		auto regexMatch = match(line, "\\d+");
		assert(!regexMatch.empty());
		vals ~= to!int(regexMatch.captures[0]);
	} while (!inFile.eof());

	/+

		This code was used to manually scan output for English text to find the key.

	int[3] key;
	for (key[0] = 'a'; key[0] <= 'z'; key[0]++) {
		for (key[1] = 'a'; key[1] <= 'z'; key[1]++) {
			for (key[2] = 'a'; key[2] <= 'z'; key[2]++) {
				string msg;
				foreach (i, val; vals) {
					val ^= key[i % 3];
					if (!isPrintable(val))
						break;
					msg ~= cast(char)(val);
				}
				writeln(key, msg);
			}
		}
	}
	+/

	int[] key = ['g', 'o', 'd'];
	int sum;
	foreach (i, val; vals) {
		val ^= key[i % 3];
		sum += val;
	}

	writeln(sum);
}

