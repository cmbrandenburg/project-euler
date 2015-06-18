// vim: set noet ts=2 sw=2:
//
// Maximum path sum II

import std.stdio;
import triangle;

void main() {
	int[][] tri;
	auto inFile = new File("data/triangle.txt", "r");
	int lineNo = 1;
	int val;
	inFile.readf("%d ", &val);
	while (!inFile.eof()) {
		tri ~= [[]];
		for (int i = 0; i < lineNo; i++) {
			tri[$-1] ~= val;
			inFile.readf("%d ", &val);
		}
		lineNo++;
	}

	writeln(maxTriangleRoute(tri));
}

