// vim: set noet ts=2 sw=2:
//
// Path sum: four ways

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

	// Seed the sums matrix with the one known value: the top left element. Keep
	// an array of all "edge" elements.
	//
	// An edge element is an element (1) whose entry in the sum matrix is valid
	// and (2) adjacent to one or more elements in the sums matrix that aren't yet
	// filled out.

	struct Coord {
		int x;
		int y;
	}

	int xyToScalar(Coord p) {
		return p.y * width + p.x;
	}

	Coord scalarToXY(int n) {
		return Coord(n % width, n / width);
	}

	int[height][width] sums;
	sums[0][0] = matrix[0][0];
	bool[int] edges;
	edges[xyToScalar(Coord(0, 0))] = true;
	int uninitCnt = width * height - 1;

	// While there exists at least one uninitialized element in the sums array,
	// all such uninitialized elements must be reached from one of the current
	// edge elements.
	//
	// Thus, the uninitialized element (or elements) adjacent to the
	// minimum-valued edge element (or elements) must be reached from that edge
	// element (or elements).

	//writeln("\t\t", edges);
	do {

		// Find a minimum edge.
		Coord minEdge;
		int minEdgeValue;
		foreach (scalar, _; edges) {
			Coord edge = scalarToXY(scalar);
			if (minEdgeValue == 0 || sums[edge.x][edge.y] < minEdgeValue) {
				minEdge = edge;
				minEdgeValue = sums[edge.x][edge.y];
			}
		}
		//writeln("\t\tminEdge: ", minEdge);

		// Fill in adjacent, uninitialized elements;
		void initElement(Coord tgt, int srcValue) {
			//writeln("\t(", uninitCnt, ")\t", tgt.x, ", ", tgt.y, "\t-> ", srcValue + matrix[tgt.x][tgt.y]);
			sums[tgt.x][tgt.y] = srcValue + matrix[tgt.x][tgt.y];
			uninitCnt--;
			if ((tgt.x > 0 && sums[tgt.x-1][tgt.y] == 0) ||
					(tgt.y > 0 && sums[tgt.x][tgt.y-1] == 0) ||
			    (tgt.x+1 < width && sums[tgt.x+1][tgt.y] == 0) ||
			    (tgt.y+1 < height && sums[tgt.x][tgt.y+1] == 0))
				edges[xyToScalar(Coord(tgt.x, tgt.y))] = true;
		}
		int x = minEdge.x;
		int y = minEdge.y;
		if (x > 0 && sums[x-1][y] == 0)
			initElement(Coord(x-1, y), minEdgeValue);
		if (y > 0 && sums[x][y-1] == 0)
			initElement(Coord(x, y-1), minEdgeValue);
		if (x+1 < width && sums[x+1][y] == 0)
			initElement(Coord(x+1, y), minEdgeValue);
		if (y+1 < height && sums[x][y+1] == 0)
			initElement(Coord(x, y+1), minEdgeValue);
		edges.remove(xyToScalar(minEdge));
		//writeln("\t\t", edges);
	} while (uninitCnt > 0);

	writeln(sums[width-1][height-1]);
}

