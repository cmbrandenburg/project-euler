// vim: set noet ts=2 sw=2:
//
// Path sum: three ways

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
	for (int x = 0; x < width; x++) {
		for (int y = 0; y < height; y++) {
			int extra; // minimum sum of path leading up to this spot
			if (x == 0) {
				extra = 0;
			} else if (y == 0) {
				extra = sums[x - 1][y];
			} else {
				extra = min(sums[x-1][y], sums[x][y-1]);
			}
			sums[x][y] = extra + matrix[x][y];
			for (int subY = y - 1; subY >= 0; subY--) {
				sums[x][subY] = min(sums[x][subY], sums[x][subY+1] + matrix[x][subY]);
			}
		}
		//writeln(x, "\t", sums[x]);
		//writeln("\t", matrix[x]);
	}

	int smallest = sums[width-1][0];
	for (int y = 1; y < height; y++) {
		smallest = min(smallest, sums[width-1][y]);
	}

	writeln(smallest);
}

