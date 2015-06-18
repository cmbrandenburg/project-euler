// vim: set noet ts=2 sw=2:
//
// Lattice paths

import std.stdio;
import triangle;

void main() {
	// Use Pascal's triangle. The answers for square NxN grids are the middle
	// numbers of the triangle.
	long[] triangle;
	triangle ~= 1;
	for (int i = 1; i <= 20; i++) {
		triangle = nextPascalsTriangleRow(triangle);
		triangle = nextPascalsTriangleRow(triangle);
	}
	writeln(triangle[triangle.length / 2]);
}

