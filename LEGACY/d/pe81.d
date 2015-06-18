// vim: set noet ts=2 sw=2:
//
// Path sum: two ways

import std.algorithm;
import std.conv;
import std.stdio;
import std.string;

void main() {

	immutable int width = 80;
	immutable int height = 80;

	int[height][width] matrix;
	auto inFile = new File("data/matrix.txt");
	string line;
	for (size_t row; (line = inFile.readln()) !is null; row++) {
		line = chomp(line);
		for (size_t col; line.length > 0; col++) {
			auto numStr = munch(line, "0123456789");
			int val = to!int(numStr);
			matrix[col][row] = val;
			munch(line, ",");
		}
	}

	int[height][width] sums;
	for (int row = 0; row < height; row++) {
		for (int col = 0; col < width; col++) {
			if (row == 0 && col == 0) {
				sums[col][row] = matrix[col][row];
			} else if (row == 0) {
				sums[col][row] = sums[col - 1][row] + matrix[col][row];
			} else if (col == 0) {
				sums[col][row] = sums[col][row - 1] + matrix[col][row];
			} else {
				sums[col][row] = min(sums[col - 1][row], sums[col][row - 1]) +
					matrix[col][row];
			}
		}
	}

	writeln(sums[width - 1][height - 1]);
}

