// vim: set noet ts=2 sw=2:

import std.algorithm;

// Used for problems #18 and #67.
int maxTriangleRoute(int[][] triangle) {
	int[] prevRow = triangle[$-1];
	int curRowIndex = cast(int)(triangle.length - 2);
	while (prevRow.length > 1) {
		int[] curRow = triangle[curRowIndex];
		foreach (i, sum; curRow) {
			curRow[i] = sum + max(prevRow[i], prevRow[i+1]);
		}
		prevRow = curRow;
		curRowIndex--;
	}
	return prevRow[0];
}

/// Returns the next row of Pascal's triangle given the previous row.
long[] nextPascalsTriangleRow(long[] inTriangle) {
	long[] outTriangle;
	outTriangle ~= 1;
	for (size_t i = 0; i < inTriangle.length - 1; i++) {
		outTriangle ~= inTriangle[i] + inTriangle[i + 1];
	}
	outTriangle ~= 1;
	return outTriangle;
}

unittest {
	long[] row = [1];
	assert([1, 1] == (row = nextPascalsTriangleRow(row)));
	assert([1, 2, 1] == (row = nextPascalsTriangleRow(row)));
	assert([1, 3, 3, 1] == (row = nextPascalsTriangleRow(row)));
	assert([1, 4, 6, 4, 1] == (row = nextPascalsTriangleRow(row)));
}

