// vim: set noet ts=2 sw=2:

/// Returns n ** x.
Int ipow(Int)(Int n, long x) {
	Int prod = 1;
	for (long i = 0; i < x; i++) {
		prod *= n;
	}
	return prod;
}

unittest {
	assert(ipow(0, 0) == 1);
	assert(ipow(0, 3) == 0);
	assert(ipow(1, 0) == 1);
	assert(ipow(1, 10) == 1);
	assert(ipow(2, 0) == 1);
	assert(ipow(2, 1) == 2);
	assert(ipow(2, 10) == 1024);
}

long ilog(Int)(Int n, long base = 10) {
	assert(n > 0);
	long ret;
	while (n >= base) {
		ret++;
		n /= cast(Int)(base);
	}
	return ret;
}

unittest {
	assert(ilog(1) == 0);
	assert(ilog(9) == 0);
	assert(ilog(10) == 1);
	assert(ilog(19) == 1);
	assert(ilog(99) == 1);
	assert(ilog(100) == 2);
	assert(ilog(100, 2) == 6);
}

