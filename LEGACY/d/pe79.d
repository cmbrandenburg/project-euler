// vim: set noet ts=2 sw=2:
//
// Passcode derivation

import std.bigint;
import std.stdio;

void main() {

	immutable BASE = 10;

	int[] loadKeyLog() {
		auto inFile = new File("data/keylog.txt", "r");
		int key;
		int[] keys;
		inFile.readf("%d ", &key);
		while (!inFile.eof()) {
			keys ~= key;
			inFile.readf("%d ", &key);
		}
		return keys;
	}

	bool[BASE][BASE] buildDepTable(int[] keys) {
		// depTable[A][B] if and only if A precedes B at least one time.
		bool[BASE][BASE] depTable;
		foreach (_, key; keys) {
			int[] prevDigits;
			for (; key > 0; key /= BASE) {
				int digit = key % BASE;
				foreach (__, prevDigit; prevDigits) {
					depTable[digit][prevDigit] = true;
				}
				prevDigits ~= digit;
			}
		}
		return depTable;
	}

	char toDigit(int digit) {
		return cast(char)(digit + '0');
	}

	auto keys = loadKeyLog();
	auto depTable = buildDepTable(keys);

	// By analysis, I verified that the password doesn't repeat any of the digits.
	// So the solution is to concatenate the digits in order, from the digit that
	// precedes the most other digits to the digits that precedes no other digits.

	int[BASE] precedeCnts;
	int passwordLen;
	int[int] digitByCnt;
	for (int digit = 0; digit < BASE; digit++) {
		int cnt;
		for (int j = 0; j < BASE; j++) {
			if (depTable[digit][j])
				cnt++;
		}
		if (cnt > 0)
			passwordLen++;
		precedeCnts[digit] = cnt;
		digitByCnt[cnt] = digit;
	}
	passwordLen++;

	string password;
	for (int i = passwordLen - 1; i >= 1; i--) {
		password ~= toDigit(digitByCnt[i]);
	}

	// special case to append last digit:
	for (int i = 0; i < BASE; i++) {
		if (precedeCnts[i] > 0)
			break;
		bool fail = false;
		for (int j = 0; j < BASE; j++) {
			if (depTable[i][j]) {
				fail = true;
				break;
			}
		}
		if (!fail) {
			password ~= toDigit(i);
			break;
		}
	}

	writeln(password);
}

