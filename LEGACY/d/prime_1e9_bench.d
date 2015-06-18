// vim: set noet ts=2 sw=2:

import std.stdio;
import prime;

void main() {
	writeln(enumPrimes(1_000_000_001)[$-1]);
}

