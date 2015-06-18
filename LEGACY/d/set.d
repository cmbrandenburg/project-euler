// vim: set noet ts=2 sw=2:

import std.algorithm;
import std.array;
import std.range;

Index[][][] enumNonemptyDisjointPairs(Index)(Index size) {
	Index[] fullSet = array(iota(size));
	Index[][][] pairs;
	foreach (s; enumSubsetIndices(size)) {
		if (s.empty)
			continue;
		auto leftOver = array(setDifference(fullSet[s[0]..$], s));
		foreach (t; enumSubsetIndices(leftOver.length)) {
			if (t.empty)
				continue;
			pairs ~= [s, array(indexed(leftOver, t))];
		}
	}
	return pairs;
}

unittest {
	assert(enumNonemptyDisjointPairs(0) == []);
	assert(enumNonemptyDisjointPairs(1) == []);
	assert(enumNonemptyDisjointPairs(2) == [[[0], [1]]]);
	assert(enumNonemptyDisjointPairs(3) == [[[0], [1]], [[0], [1, 2]], [[0], [2]], [[0, 1], [2]], [[0, 2], [1]], [[1], [2]]]);
}

// Returns an array of arrays, where each inner array containing the indices of
// a unique subset of a set containing size elements. The subsets are returned
// in ascending order, and each subset is itself in ascending order.
Index[][] enumSubsetIndices(Index)(Index size, Index base = 0) {
	// base case:
	if (base == size)
		return [[]];
	// recurrence case:
	Index[][] ret;
	Index[][] subs = enumSubsetIndices(size, cast(Index)(base + 1));
	ret ~= subs[0]; // empty set
	foreach (s; subs)
		ret ~= [base] ~ s;
	foreach (s; subs[1..$])
		ret ~= s;
	return ret;
}

unittest {
	assert(enumSubsetIndices(0) == [[]]);
	assert(enumSubsetIndices(1) == [[], [0]]);
	assert(enumSubsetIndices(2) == [[], [0], [0, 1], [1]]);
	assert(enumSubsetIndices(3) == [[], [0], [0, 1], [0, 1, 2], [0, 2], [1], [1, 2], [2]]);
	assert(enumSubsetIndices(3, 1) == [[], [1], [1, 2], [2]]);
	assert(enumSubsetIndices(3, 2) == [[], [2]]);
}

