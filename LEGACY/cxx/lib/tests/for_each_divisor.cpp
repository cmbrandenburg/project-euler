// vim: set noet:

#include "../check.hpp"
#include "../factor.hpp"
#include <vector>

int main() {
	struct {
		unsigned n;
		std::initializer_list<unsigned> exp;
	} const tab[] = {
		{1, {1}},
		{2, {1, 2}},
		{3, {1, 3}},
		{4, {1, 2, 4}},
		{5, {1, 5}},
		{6, {1, 2, 3, 6}},
		{7, {1, 7}},
		{8, {1, 2, 4, 8}},
		{9, {1, 3, 9}},
		{10, {1, 2, 5, 10}},
		{12, {1, 2, 3, 4, 6, 12}},
		{60, {1, 2, 3, 4, 5, 6, 10, 12, 15, 20, 30, 60}}
	};

	for (auto i = std::begin(tab); i != std::end(tab); ++i) {
		std::vector<unsigned> v;
		for_each_divisor(i->n, [&v](unsigned d) { v.push_back(d); });
		check(i->exp.size() == v.size());
		check(std::equal(std::begin(i->exp), std::end(i->exp), std::begin(v)));
	}

}

