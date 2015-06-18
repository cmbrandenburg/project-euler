// vim: set noet:
//
// Names scores
// http://projecteuler.net/problem=22

#include "../lib/common.hpp"
#include "../lib/path.hpp"
#include <algorithm>
#include <cassert>
#include <cctype>
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <vector>

void must(bool c) {
	if (!c)
		throw std::runtime_error("Unexpected file input");
}

unsigned name(std::string const &s) {
	unsigned acc = 0;
	for (auto &&i: s)
		acc += (std::tolower(i) - 'a' + 1);
	return acc;
}

unsigned sum() {
	unsigned acc = 0;

	std::vector<std::string> all;
	std::ifstream in;
	in.exceptions(in.badbit | in.failbit);
	in.open(pe_data_file("p022_names.txt"));
	while (true) {
		must('"' == in.get());
		std::string s;
		std::getline(in, s, '"');
		all.push_back(s);
		in.exceptions(in.goodbit);
		if (',' != in.get() && in.eof())
			break;
		in.exceptions(in.badbit | in.failbit);
	}
	in.close();
	std::sort(std::begin(all), std::end(all));

	for (std::size_t i = 0; i < all.size(); ++i)
		acc += (i+1) * name(all[i]);
	return acc;
}

int main() {
	assert(name("COLIN") == 53);
	std::cout << sum() << '\n';
}

