// vim: set noet ts=2 sw=2:

Int factorial(Int)(Int n) {
	Int prod = 1;
	for (Int i = 1; i <= n; i++) {
		prod *= i;
	}
	return prod;
}

unittest {
	assert(factorial(0) == 1);
	assert(factorial(1) == 1);
	assert(factorial(2) == 2);
	assert(factorial(3) == 6);
	assert(factorial(4) == 24);
	assert(factorial(5) == 120);
}

/// Standard choose function--e.g., 5 choose 3 <-> how many ways to choose 3
// items from 5.
Int choose(Int)(Int n, Int r) {
	return factorial(n) / (factorial(r) * factorial(n - r));
}

/// Enumerates all combinations for a set.
// Precondition: all elements in set are unique.
T[][] enumChoices(T)(in T[] set, size_t n) {

	void recurse(
			ref T[][] choices,
			T[] cur,
			in T[] avail) {
		if (cur.length == n) {
			choices ~= cur;
			return;
		}
		if (cur.length + avail.length < n)
			return;
		recurse(choices, cur ~ avail[0], avail[1..$]);
		if (cur.length + avail.length - 1 >= n)
			recurse(choices, cur, avail[1..$]);
	}

	T[][] choices;
	recurse(choices, [], set);
	return choices;
}

