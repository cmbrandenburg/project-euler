// vim: set noet ts=2 sw=2:
//
// Champernowne's constant

import std.conv;
import std.stdio;

void main() {
	string num;
	int i = 1;
	while (num.length < 1000000) {
		num ~= to!string(i);
		i++;
	}
	writeln(
		(num[0] - '0') *
		(num[9] - '0') *
		(num[99] - '0') *
		(num[999] - '0') *
		(num[9999] - '0') *
		(num[99999] - '0') *
		(num[999999] - '0'));
}

