// vim: set noet ts=2 sw=2:
//
// Triangular, pentagonal, and hexagonal

import std.stdio;
import quad;

void main() {
	long n = 286;
	long tri = triangle(n);
	while (!isPentagonal(tri) || !isHexagonal(tri)) {
		n++;
		tri = triangle(n);
	}
	writeln(tri);
}

