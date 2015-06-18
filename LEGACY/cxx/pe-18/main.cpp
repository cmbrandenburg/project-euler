// vim: set noet:
//
// Maximum path sum I
// http://projecteuler.net/problem=18

#include "../lib/common.hpp"
#include <algorithm>
#include <cassert>
#include <iostream>
#include <sstream>
#include <utility>
#include <vector>

char const *const S =
	"3\n"
	"7 4\n"
	"2 4 6\n"
	"8 5 9 3\n";

char const *const T =
	"75\n"
	"95 64\n"
	"17 47 82\n"
	"18 35 87 10\n"
	"20  4 82 47 65\n"
	"19  1 23 75  3 34\n"
	"88  2 77 73  7 63 67\n"
	"99 65  4 28  6 16 70 92\n"
	"41 41 26 56 83 40 80 70 33\n"
	"41 48 72 33 47 32 37 16 94 29\n"
	"53 71 44 65 25 43 91 52 97 51 14\n"
	"70 11 33 28 77 73 17 78 39 68 17 57\n"
	"91 71 52 38 17 14 91 43 58 50 27 29 48\n"
	"63 66  4 68 89 53 67 30 73 16 69 87 40 31\n"
	" 4 62 98 27 23  9 70 98 73 93 38 53 60  4 23\n";

std::vector<std::vector<unsigned>> parse_triangle(std::istream &is) {
	std::vector<std::vector<unsigned>> tri;
	unsigned row = 0, len = 0;
	unsigned v;
	while (is >> v) {
		if (len == row) {
			tri.resize(tri.size()+1);
			++row;
			len = 0;
		}
		tri.back().push_back(v);
		++len;
	}
	std::reverse(tri.begin(), tri.end());
	return tri;
}

std::vector<std::vector<unsigned>> parse_triangle(char const *s) {
	std::stringstream ss(s);
	return parse_triangle(ss);
}

unsigned max_path(std::vector<std::vector<unsigned>> const &tri) {
	std::vector<unsigned> bests(tri[0]);
	for (unsigned i = 1; i < tri.size(); ++i) {
		for (unsigned j = 0; j < tri[i].size(); ++j)
			bests[j] = tri[i][j] + std::max(bests[j], bests[j+1]);
	}
	return bests[0];
}

int main() {
	assert(max_path(parse_triangle(S)) == 23);
	std::cout << max_path(parse_triangle(T)) << '\n';
}

