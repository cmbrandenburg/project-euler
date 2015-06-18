// vim: set noet:
//
// Cuboid layers
// http://projecteuler.net/problem=126

#include "../lib/common.hpp"
#include <cassert>
#include <iostream>
#include <map>
#include <queue>

// Returns the number of cubes needed to create a given layer around the cuboid.
unsigned cubes(unsigned const x, unsigned const y, unsigned const z, unsigned layer) {
	assert(x >= y && y >= z);
	if (0 == layer)
		return x*y*z;
	if (1 == layer)
		return 2*(x*y + y*z + z*x);
	if (2 == layer)
		return 2*(x*y + y*z + z*x) + (layer-1)*4*(x+y+z);
	return 2*(x*y + y*z + z*x) + (layer-1)*4*(x+y+z) + (layer-1)*(layer-2)/2*8;
}

class queue {

	struct entry {
		unsigned x;
		unsigned y;
		unsigned z;
		unsigned layer;
		unsigned value;
		entry(unsigned x, unsigned y, unsigned z): x(x), y(y), z(z), layer(0), value(0) {}
		bool operator<(entry const &that) const { return value < that.value; }
		unsigned next_layer() { value = cubes(x, y, z, ++layer); return value; }
	};

	std::priority_queue<entry> q;
	unsigned min;

public:

	queue() {
		entry e(1, 1, 1);
		min = e.next_layer();
		q.push(e);
	}

	unsigned minimum() const { return min; }
};

// Returns the number of cuboids that contain N cubes in one of its layers. This
// is the function C in the problem description.
unsigned C(unsigned const N) {

	static class state {
		struct cuboid {
			unsigned x;
			unsigned y;
			unsigned z;
			unsigned layer;
			unsigned value;
		};
		struct pq_comparer {
			bool operator()(cuboid const &a, cuboid const &b) const { return a.value > b.value; }
		};
		std::priority_queue<cuboid, std::vector<cuboid>, pq_comparer> q;
		std::map<unsigned, unsigned> memo; // maps n -> C(n)
	public:
		state() { new_cuboid(1, 1, 1); }
		unsigned max() const { return q.top().value; }
		unsigned operator[](unsigned key) { return memo[key]; }
		void more() {

			// Add a layer to the smallest-valued cuboid in the queue. This probably
			// moves the cuboid within the queue.
			cuboid c = q.top();
			unsigned layer = c.layer;
			c.value = cubes(c.x, c.y, c.z, ++c.layer);
			++memo[c.value];
			q.pop();
			q.push(c);
			//dump(c);

			// If this is the first layer for the cuboid then add one or two more
			// cuboids to the queue.
			if (1 == layer) {
				if (1 == c.y)
					new_cuboid(c.x+1, c.y, c.z);
				if (c.x != c.y && 1 == c.z)
					new_cuboid(c.x, c.y+1, c.z);
				if (c.y != c.z)
					new_cuboid(c.x, c.y, c.z+1);
			}
		}
	private:
		void new_cuboid(unsigned x, unsigned y, unsigned z) {
			cuboid c{x, y, z, 1, cubes(x, y, z, 1)};
			++memo[c.value];
			q.push(c);
			//dump(c);
		}
		void dump(cuboid const &c) {
			std::cout << c.value << ": " << c.x << ", " << c.y << ", " << c.z << ", " << c.layer << '\n';
			for (cuboid const *i = &q.top(); i < &q.top()+q.size(); ++i)
				std::cout << "    " << i->value << ": " << i->x << ", " << i->y << ", " << i->z << ", " << i->layer << '\n';
			for (auto i = memo.begin(); i != memo.end(); ++i)
				std::cout << "    [" << i->first << "]: " << i->second << '\n';
			std::cout << '\n';
		}
	} state;

	// Work through more cuboids as needed until we have calculated the values of
	// all  cuboid-and-layer combinations up to N cubes per layer.
	while (state.max() < N)
		state.more();

	return state[N];
}

// Returns the least value of n for which C(n) == N.
unsigned least(unsigned const N) {
	unsigned n = 1;
	while (C(n) != N)
		++n;
	return n;
}

int main() {
	assert(22 == cubes(3, 2, 1, 1));
	assert(46 == cubes(3, 2, 1, 2));
	assert(78 == cubes(3, 2, 1, 3));
	assert(118 == cubes(3, 2, 1, 4));
	assert(22 == cubes(5, 1, 1, 1));
	assert(46 == cubes(5, 3, 1, 1));
	assert(46 == cubes(7, 2, 1, 1));
	assert(46 == cubes(11, 1, 1, 1));
	assert(2 == C(22));
	assert(4 == C(46));
	assert(5 == C(78));
	assert(8 == C(118));
	assert(least(10) == 154);
	std::cout << least(1000) << '\n';
}

