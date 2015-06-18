// vim: set noet ts=2 sw=2:
//
// Su Doku

import std.stdio;
import std.string;

// segment: a row or column within a box

static immutable width = 9;
static immutable height = width;
static immutable boxWidth = width / 3;
static immutable boxHeight = boxWidth;
static immutable base = width + 1;

alias int[width][height] Grid;

void main() {

	// Load puzzle grids.
	Grid[] grids;
	auto inFile = new File("data/sudoku.txt");
	while (true) {
		inFile.readln(); // read and discard "Grid NN"
		if (inFile.eof())
			break;
		Grid grid;
		for (int y = 0; y < height; y++) {
			auto line = inFile.readln();
			line = chomp(line);
			for (int x = 0; x < width; x++)
				grid[x][y] = line[x] - '0';
		}
		grids ~= grid;
	}

	// Solve all puzzles.
	int finalSum;
	foreach (_, grid; grids) {
		//printGrid(grid);
		//writeln();
		sudoku(grid);
		//printGrid(grid);
		//writeln();
		int sum;
		for (int x = 0; x < 3; x++) {
			sum *= 10;
			sum += grid[x][0];
		}
		finalSum += sum;
	}

	writeln(finalSum);
}

static bool sudoku(ref Grid grid) {

	alias int[base][width][height] DigitsGrid;
	alias int[base] Digits;

	static int boxGridX(int x) {
		return x - (x % boxWidth);
	}

	static int boxGridY(int y) {
		return y - (y % boxHeight);
	}

	static int countDigits(Digits digits, out int lastDigit) {
		int finalCnt;
		for (int i = 1; i < base; i++) {
			if (digits[i]) {
				finalCnt++;
				lastDigit = i;
			}
		}
		return finalCnt;
	}

	static void findPossibles(
			in int theX,
			in int theY,
			in Grid grid,
			out Digits possibles) {

		possibles[] = true;
		possibles[0] = false;

		// exclude digits in same row:
		for (int x = 0; x < width; x++) {
			if (x != theX && grid[x][theY] != 0)
				possibles[grid[x][theY]] = false;
		}

		// exclude digits in same column:
		for (int y = 0; y < height; y++) {
			if (y != theY && grid[theX][y] != 0)
				possibles[grid[theX][y]] = false;
		}

		// exclude digits in same box:
		for (int x = boxGridX(theX); x < boxGridX(theX) + boxWidth; x++) {
			for (int y = boxGridY(theY); y < boxGridY(theY) + boxHeight; y++) {
				if (x != theX || y != theY && grid[x][y] != 0)
					possibles[grid[x][y]] = false;
			}
		}

		//writeln("\t\t", theX, ", ", theY, " -> ", possibles);
	}

	static void restrictPossiblesIfOneSegmentForDigit(ref DigitsGrid digits) {

		// If only (the spots of) one segment in a row or column can be filled in
		// with a given digit (that's not already filled in for that row, column, or
		// box), then that digit cannot be anywhere else in the box.

		// by row:
		for (int y = 0; y < height; y++) {
			for (int d = 1; d < base; d++) {
				int[width / boxWidth] boxCnts;
				int totalCnt;
				int lastBoxX;
				for (int x = 0; x < width; x++) {
					if (digits[x][y][d]) {
						int boxX = boxGridX(x);
						boxCnts[boxX / boxWidth]++;
						lastBoxX = boxX;
						totalCnt++;
					}
				}
				if (totalCnt > 0 && boxCnts[lastBoxX / boxWidth] == totalCnt) {
					for (int subY = boxGridY(y); subY < boxGridY(y) + boxHeight; subY++) {
						for (int x = lastBoxX; x < lastBoxX + boxWidth; x++) {
							if (subY != y) {
								digits[x][subY][d] = false;
							}
						}
					}
				}
			}
		}

		// by column:
		for (int x = 0; x < width; x++) {
			for (int d = 1; d < base; d++) {
				int[height / boxHeight] boxCnts;
				int totalCnt;
				int lastBoxY;
				for (int y = 0; y < height; y++) {
					if (digits[x][y][d]) {
						int boxY = boxGridY(y);
						boxCnts[boxY / boxHeight]++;
						lastBoxY = boxY;
						totalCnt++;
					}
				}
				if (totalCnt > 0 && boxCnts[lastBoxY / boxHeight] == totalCnt) {
					for (int subX = boxGridX(x); subX < boxGridX(x) + boxWidth; subX++) {
						for (int y = lastBoxY; y < lastBoxY + boxHeight; y++) {
							if (subX != x) {
								digits[subX][y][d] = false;
							}
						}
					}
				}
			}
		}
	}

	static void restrictPossiblesIfOneSpotForDigit(ref DigitsGrid digits) {

		// If only one spot in a row, column, or box can be filled in with a given
		// digit (that's not already filled in for that row, column, or box), then
		// that spot must be that digit.

		// by row:
		for (int y = 0; y < height; y++) {
			int[base] digitCnts;
			int[base] digitXs;
			for (int x = 0; x < width; x++) {
				foreach (d, possible; digits[x][y]) {
					if (possible) {
						digitCnts[d]++;
						digitXs[d] = x;
					}
				}
			}
			for (int d = 1; d < base; d++) {
				if (digitCnts[d] == 1) {
					int x = digitXs[d];
					//writeln("BY ROW\t", d, "\t", x, "\t", y);
					digits[x][y][] = false;
					digits[x][y][d] = true;
				}
			}
		}

		// by column:
		for (int x = 0; x < width; x++) {
			int[base] digitCnts;
			int[base] digitYs;
			for (int y = 0; y < height; y++) {
				foreach (d, possible; digits[x][y]) {
					if (possible) {
						digitCnts[d]++;
						digitYs[d] = y;
					}
				}
			}
			for (int d = 1; d < base; d++) {
				if (digitCnts[d] == 1) {
					int y = digitYs[d];
					//writeln("BY COL\t", d, "\t", x, "\t", y);
					digits[x][y][] = false;
					digits[x][y][d] = true;
				}
			}
		}

		// by box:
		for (int boxX = 0; boxX < width; boxX += boxWidth) {
			for (int boxY = 0; boxY < height; boxY += boxHeight) {
				int[base] digitCnts;
				int[base] digitXs;
				int[base] digitYs;
				for (int x = boxX; x < boxX + boxWidth; x++) {
					for (int y = boxY; y < boxY + boxHeight; y++) {
						foreach (d, possible; digits[x][y]) {
							if (possible) {
								digitCnts[d]++;
								digitXs[d] = x;
								digitYs[d] = y;
							}
						}
					}
				}
				for (int d = 1; d < base; d++) {
					if (digitCnts[d] == 1) {
						int x = digitXs[d];
						int y = digitYs[d];
						//writeln("BY BOX\t", d, "\t", x, "\t", y);
						digits[x][y][] = false;
						digits[x][y][d] = true;
					}
				}
			}
		}
	}

	static bool calcPossiblesGrid(in Grid grid, ref DigitsGrid digits) {

		// find possible digits in all unfilled spots by excluding digits in the
		// same row, column, or box:
		for (int x = 0; x < width; x++) {
			for (int y = 0; y < height; y++) {
				int d = grid[x][y];
				if (d == 0) {
					findPossibles(x, y, grid, digits[x][y]);
				}
			}
		}

		// further restrictions:
		restrictPossiblesIfOneSegmentForDigit(digits);
		restrictPossiblesIfOneSpotForDigit(digits);	

		// If there a spot that isn't filled in has no possible digits, then this
		// grid is impossible.

		for (int x = 0; x < width; x++) {
			for (int y = 0; y < height; y++) {
				int dummy;
				if (grid[x][y] == 0 && countDigits(digits[x][y], dummy) == 0)
					return false;
			}
		}

		return true;
	}

	// Count zeros.
	int zeroCnt;
	DigitsGrid possibles;
	for (int x = 0; x < width; x++) {
		for (int y = 0; y < height; y++) {
			if (grid[x][y] == 0)
				zeroCnt++;
		}
	}

	// Solve the puzzle.
	//
	// (While there are any remaining zeros, fill in some spots.)
	while (zeroCnt > 0) {

		//writeln("\t\tzeroCnt: ", zeroCnt);
		if (!calcPossiblesGrid(grid, possibles))
			return false;
		//writeln();
		int nextZeroCnt = zeroCnt;

		// Fill in all spots that can be only one possible digit.
		for (int x = 0; x < width; x++) {
			for (int y = 0; y < height; y++) {
				int d;
				if (grid[x][y] == 0 && countDigits(possibles[x][y], d) == 1) {
					//writeln("\t\t", x, ", ", y, " -> ", d);
					grid[x][y] = d;
					nextZeroCnt--;
				}
			}
		}

		//writeln();
		//printGrid(grid, "\t");
		//writeln();

		// No spot can be filled in. Try guessing.
		if (nextZeroCnt == zeroCnt) {

			// find next spot not filled in:
			int x, y;
			while (grid[x][y] != 0) {
				x++;
				if (x == width) {
					x = 0;
					y++;
				}
			}

			// try the next possible digit for this spot:
			for (int d = 1; d < base; d++) {
				if (possibles[x][y][d]) {
					Grid gridCp = grid;
					grid[x][y] = d;
					if (sudoku(grid))
						return true;
					grid = gridCp;
				}
			}
			assert(false);
		}

		assert(nextZeroCnt < zeroCnt);
		zeroCnt = nextZeroCnt;
	}

	assert(checkSudoku(grid));
	return true;
}

static bool checkSudoku(Grid grid) {

	// Check each row.
	for (int y = 0; y < height; y++) {
		bool[base] digits;
		for (int x = 0; x < width; x++) {
			int d = grid[x][y];
			if (d < 1 || d >= base || digits[d]) {
				//writeln("CHECK ROW\t", x, "\t", y);
				return false;
			}
			digits[d] = true;
		}
	}

	// Check each column.
	for (int x = 0; x < width; x++) {
		bool[base] digits;
		for (int y = 0; y < height; y++) {
			int d = grid[x][y];
			if (d < 1 || d >= base || digits[d]) {
				//writeln("CHECK COL\t", x, "\t", y);
				return false;
			}
			digits[d] = true;
		}
	}

	// Check each box.
	for (int boxX = 0; boxX < width; boxX += boxWidth) {
		for (int boxY = 0; boxY < height; boxY += boxHeight) {
			bool[base] digits;
			for (int x = boxX; x < boxX + boxWidth; x++) {
				for (int y = boxY; y < boxY + boxHeight; y++) {
					int d = grid[x][y];
					if (d < 1 || d >= base || digits[d]) {
						//writeln("CHECK BOX\t", x, "\t", y);
						return false;
					}
					digits[d] = true;
				}
			}
		}
	}

	return true;
}

static void printGrid(in Grid grid, in string linePrefix = "") {
	for (int y = 0; y < height; y++) {
		if (y > 0 && y % boxHeight == 0)
			writeln(linePrefix, "------+-------+------");
		for (int x = 0; x < width; x++) {
			if (x > 0 && x % boxWidth == 0)
				write(" |");
			writef("%s%d", x == 0 ? linePrefix : " ", grid[x][y]);
		}
		writeln();
	}
}

