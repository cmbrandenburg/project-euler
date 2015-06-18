// vim: set noet ts=2 sw=2:
//
// Triangle containment

import std.algorithm;
import std.stdio;
import rational;

void main() {

	auto inFile = new File("data/triangles.txt");
	Triangle[] triangles;
	while (!inFile.eof()) {
		Triangle t;
		inFile.readf("%d,%d,%d,%d,%d,%d ", &t.a.x, &t.a.y, &t.b.x, &t.b.y, &t.c.x, &t.c.y);
		triangles ~= t;
	}

	int finalCnt;
	foreach (_, t; triangles) {
		if (t.containsPoint(Point(0, 0)))
			finalCnt++;
	}

	writeln(finalCnt);
}

static struct Triangle {

	Point a;
	Point b;
	Point c;

	bool containsPoint(Point pt) const {

		//writeln(a, "\t", b, "\t", c);

		static compareLineToPoint(Point end1, Point end2, Point pt) {
			auto slope = Rational!int(end2.y - end1.y, end2.x - end1.x);
			auto yAtX = slope;
			yAtX *= (pt.x - end1.x);
			yAtX += end1.y;
			int ret = yAtX < pt.y ? -1 : (yAtX == pt.y ? 0 : 1);
			//writeln("\t", end1, "\t", end2, "\t", pt, "\t-> ", ret);
			return ret;
		}

		static isLineAtOrAbovePoint(Point end1, Point end2, Point pt) {
			return compareLineToPoint(end1, end2, pt) >= 0;
		}

		static isLineAtOrBelowPoint(Point end1, Point end2, Point pt) {
			return compareLineToPoint(end1, end2, pt) <= 0;
		}

		// Sort the points from left to right, top to bottom.
		Point[] triPts = [a, b, c];
		sort!("a.x < b.x || (a.x == b.x && a.y > b.y)")(triPts);

		// triangle is entirely to the left or right of the point:
		if (triPts[0].x > pt.x || triPts[2].x < pt.x)
			return false;

		// there's a vertical left side of the triangle:
		if (triPts[0].x == triPts[1].x) {
			return isLineAtOrAbovePoint(triPts[0], triPts[2], pt) &&
				isLineAtOrBelowPoint(triPts[1], triPts[2], pt);
		}

		// there's a vertical right side of the triangle:
		if (triPts[1].x == triPts[2].x) {
			return isLineAtOrAbovePoint(triPts[0], triPts[1], pt) &&
				isLineAtOrBelowPoint(triPts[0], triPts[2], pt);
		}

		// else:
		int relPos = compareLineToPoint(triPts[0], triPts[2], pt);
		return compareLineToPoint(triPts[0], triPts[1], pt) == -relPos &&
			compareLineToPoint(triPts[1], triPts[2], pt) == -relPos;
	}
}

static struct Point {
	int x;
	int y;
}

