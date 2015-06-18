// vim: set noet ts=2 sw=2:
//
// Counting rectangles

import std.stdio;

static int abs(int n) {
	return n >= 0 ? n : -n;
}

void main() {

	immutable int tgtValue = 2_000_000;
	int nearestValue;
	int nearestX, nearestY;

	int x = 1, y;
	while (true) {
		y = 1;
		while (true) {
			int value = (x * x + x) / 2 * (y * y + y) / 2;
			if (abs(value - tgtValue) < abs(nearestValue - tgtValue)) {
				nearestValue = value;
				nearestX = x;
				nearestY = y;
			}
			if (value > tgtValue)
				break;
			y++;
		}
		if (y == 1)
			break;
		x++;
	}

	writeln(nearestX * nearestY);
}

