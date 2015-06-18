// vim: set noet ts=2 sw=2:

import std.conv;
import std.stdio;
import prime;

int main(string[] args) {
	long n = to!long(args[1]);
	if (isPrime(n)) {
		writeln(n);
		return 0;
	}
	return 1;
}

