// vim: set noet ts=2 sw=2:

import std.math;

long triangle(long n) {
	return n * (n + 1) / 2;
}

bool isTriangle(int n) {
	static int i;
	static int[] vals;
	static bool[int] map;
	while (vals.length == 0 || vals[$-1] < n) {
		i++;
		int val = i * (i + 1) / 2;
		vals ~= val;
		map[val] = true;
	}
	return (n in map) != null;
}

unittest {
	assert(isTriangle(1));
	assert(isTriangle(3));
	assert(isTriangle(55));
	assert(!isTriangle(54));
	assert(!isTriangle(56));
}

bool isSquare(long n) {
	long rt = cast(long)(sqrt(cast(real)(n)));
	return rt * rt == n;
}

unittest {
	assert(isSquare(1));
	assert(isSquare(225));
	assert(!isSquare(224));
}

long pentagonal(long n) {
	return n * (3 * n - 1) / 2;
}

bool isPentagonal(long n) {

	static long lastBase;
	static long lastPent;
	static bool[long] pents;

	while (n > lastPent) {
		lastBase++;
		lastPent = pentagonal(lastBase);
		pents[lastPent] = true;
	}

	return (n in pents) != null;
}

unittest {
	assert(isPentagonal(1));
	assert(!isPentagonal(2));
	assert(isPentagonal(5));
	assert(!isPentagonal(3));
	assert(isPentagonal(145));
	assert(!isPentagonal(146));
	assert(!isPentagonal(69));
}

long hexagonal(long n) {
	return n * (2 * n - 1);
}

bool isHexagonal(long n) {

	static long lastBase;
	static long lastHex;
	static bool[long] hexes;

	while (n > lastHex) {
		lastBase++;
		lastHex = hexagonal(lastBase);
		hexes[lastHex] = true;
	}

	return (n in hexes) != null;
}

unittest {
	assert(isHexagonal(1));
	assert(!isHexagonal(2));
	assert(isHexagonal(6));
	assert(!isHexagonal(3));
	assert(isHexagonal(45));
	assert(!isHexagonal(46));
	assert(!isHexagonal(44));
	assert(isHexagonal(1));
}

