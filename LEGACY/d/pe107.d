// vim: set noet ts=2 sw=2:
//
// Minimal network

import std.conv;
import std.range;
import std.stdio;
import std.string;

class Graph {

	/** Constructs a graph from a multi-line text string definition--same as the
	 * Project Euler "network.txt" file format. R is a range of text lines. */
	this(R)(R r) {

		// Read range contents into matrix.
		foreach(line; r) {
			matrix.length++;
			line = chomp(line);
			auto fields = split(line, ",");
			foreach (f; fields) {
				f = strip(f);
				if (f == "-") {
					matrix[$-1] ~= unconnected;
				} else {
					auto w = to!int(f);
					matrix[$-1] ~= w;
					totalWeight += w;
				}
			}
		}
		totalWeight /= 2; // each edge was counted twice

		// Sanity check: each row has as many elements as there are rows.
		foreach (row; matrix) {
			if (row.length != matrix.length) {
				throw new Exception("unexpected number of vertices in row");
			}
		}

		// Sanity-check: matrix[x][y] == matrix[y][x].
		for (auto x = 0; x < matrix[0].length; x++) {
			for (auto y = 0; y < matrix.length; y++) {
				if (matrix[y][x] != matrix[x][y]) {
					throw new Exception("matrix is unsymmetrical");
				}
			}
		}
	}

	void addEdge(int v1, int v2, int w) {
		assert(matrix[v1][v2] == unconnected);
		assert(matrix[v2][v1] == unconnected);
		matrix[v1][v2] = w;
		matrix[v2][v1] = w;
		totalWeight += w;
	}

	unittest {
		auto g = new Graph([
				"-, -, 20",
				"-, -, -",
				"20, -, -"
		]);
		assert(20 == g.totalWeight);
		assert(!g.verticesConnected(0, 1));
		assert(g.verticesConnected(0, 2));
		g.addEdge(0, 1, 10);
		assert(30 == g.totalWeight);
		assert(g.verticesConnected(0, 1));
		assert(g.verticesConnected(0, 2));
	}

	void removeEdge(int v1, int v2) {
		int w = matrix[v1][v2];
		assert(w != unconnected);
		assert(w == matrix[v2][v1]);
		matrix[v1][v2] = unconnected;
		matrix[v2][v1] = unconnected;
		totalWeight -= w;
	}

	unittest {
		auto g = new Graph([
				"-, 10, 20",
				"10, -, -",
				"20, -, -"
		]);
		assert(30 == g.totalWeight);
		assert(g.verticesConnected(0, 1));
		assert(g.verticesConnected(0, 2));
		g.removeEdge(0, 1);
		assert(20 == g.totalWeight);
		assert(!g.verticesConnected(0, 1));
		assert(g.verticesConnected(0, 2));
	}

	/** Removes edges from the graph such that (1) no two vertices that were
	 * previously connected become disconnected and (2) the total weight of the
	 * graph is minimized. */
	void optimizeWeight() {

		immutable N = matrix.length;

		// Encapsulates an edge--two vertices and a weight. Can be sorted by weight.
		struct Edge {
			int opCmp(ref const Edge other) const {
				if (weight < other.weight) {
					return -1;
				} else if (weight == other.weight) {
					return 0; // unstable if sorting
				}
				return 1;
			}
			int v1;
			int v2;
			int weight;
		}

		// Created array of edges, sorted from greatest weight to least.
		Edge[] edges;
		for (int v1 = 0; v1 < N; v1++) {
			for (int v2 = v1; v2 < N; v2++) {
				int w = matrix[v1][v2];
				if (w != unconnected) {
					edges ~= Edge(v1, v2, w);
				}
			}
		}
		edges.sort;
		edges.reverse;

		// Optimize the graph by iterating through the edges, from greatest weight
		// to least. If an edge connects two vertices that are connected without
		// that edge then remove that edge.
		//
		// Why does this work? In short, if three subgraphs G1, G2, and G3 are all
		// connected to each other (G1 connects to G2 and G3, and G2 connects to
		// G3), then there's no better optimization for those three subgraphs'
		// connections that doesn't involve removing the greatest-weighted edge
		// connecting any two of the subgraphs. (There may be further optimizations,
		// too.) Use pencil and paper to prove this to yourself.

		foreach (e; edges) {
			removeEdge(e.v1, e.v2);
			if (!verticesConnected(e.v1, e.v2)) {
				addEdge(e.v1, e.v2, e.weight);
			}
		}
	}

	unittest {
		// This is the graph given as the example in the description of problem
		// #107.
		auto g = new Graph([
				" -, 16, 12, 21,  -,  -,  -",
				"16,  -,  -, 17, 20,  -,  -",
				"12,  -,  -, 28,  -, 31,  -",
				"21, 17, 28,  -, 18, 19, 23",
				" -, 20,  -, 18,  -,  -, 11",
				" -,  -, 31, 19,  -,  -, 27",
				" -,  -,  -, 23, 11, 27,  -"
		]);
		assert(243 == g.weight);
		g.optimizeWeight();
		assert(93 == g.weight);
	}

	/** Returns whether there a path through the graph that connects v1 with v2.
	 */
	bool verticesConnected(int v1, int v2) const {
		bool[] visited = new bool[matrix.length];
		visited[v1] = true;
		bool recur(int cur) {
			if (cur == v2) {
				return true;
			}
			foreach (int v, w; matrix[cur]) {
				if (w != unconnected && !visited[v]) {
					visited[v] = true;
					if (recur(v)) {
						return true;
					}
					visited[v] = false;
				}
			}
			return false;
		}
		return recur(v1);
	}

	unittest {

		auto g = new Graph([
				"-, 10, 20",
				"10, -, -",
				"20, -, -"
		]);
		assert(g.verticesConnected(0, 1)); // 0 -> 1
		assert(g.verticesConnected(0, 2)); // 0 -> 2
		assert(g.verticesConnected(1, 2)); // 1 -> 0 -> 2

		g = new Graph([
				"-, -, -",
				"-, -, 10",
				"-, 10, -"
		]);
		assert(!g.verticesConnected(0, 1));
		assert(!g.verticesConnected(0, 2));
		assert(g.verticesConnected(1, 2)); // 1 -> 0 -> 2
	}

	@property int weight() const {
		return totalWeight;
	}

	private static immutable unconnected = -1;
	private int[][] matrix;
	private int totalWeight;
}

void main() {
	auto f = File("data/network.txt");
	auto g = new Graph(f.byLine);
	auto origWeight = g.weight;
	g.optimizeWeight();
	auto savings = origWeight - g.weight;
	writeln(savings);
}

