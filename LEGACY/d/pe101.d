// vim: set noet ts=2 sw=2:
//
// Optimum polynomial

import std.algorithm;
import std.stdio;
import combo;
import exponent;

void main() {

	Polynomial u = [1, -1, 1, -1, 1, -1, 1, -1, 1, -1, 1];
	//Polynomial u = [0, 0, 0, 0, 1];

	long finalSum;
	for (long i = 1; i < u.length; i++) {
		finalSum += fit(u, i);
	}

	writeln(finalSum);
}


alias long[] Polynomial;

Polynomial addPolynomials(in Polynomial a, in Polynomial b) {
	Polynomial c;
	if (a.length >= b.length) {
		c = a.dup;
		foreach (i, term; b)
			c[i] += b[i];
	} else {
		c = b.dup;
		foreach (i, term; a)
			c[i] += a[i];
	}
	return c;
}

long polynomial(in Polynomial p, long n) {
	long finalSum;
	foreach (pow, term; p) {
		finalSum += term * ipow(n, pow);
	}
	return finalSum;
}

long[] polynomialN(in Polynomial p, long n) {
	long[] seq;
	for (long i = 1; i <= n; i++)
		seq ~= polynomial(p, i);
	return seq;
}

long fit(in Polynomial p, long size) {
	//writeln("fit(", p, ", ", size, ")");
	Polynomial op = findOp(polynomialN(p, size));
	//writeln("\top: ", op);
	long ret = polynomial(op, size + 1);
	//writeln("fit: ", ret);
	return ret;
}

Polynomial findOp(in long[] seq) {

	//writeln("\tfindOp(", seq, ")");

	// Base case: if the sequence contains only one number, A, then return the
	// polynomial: An^0.
	if (seq.length == 1)
		return [seq[0]];

	// Continue taking the derivative of the sequence until there's only one
	// number remaining.
	long[] derivativeSeq = seq.dup;
	while (derivativeSeq.length > 1) {
		for (long i = 0; i < derivativeSeq.length-1; i++)
			derivativeSeq[i] = derivativeSeq[i+1] - derivativeSeq[i];
		derivativeSeq = derivativeSeq[0 .. $-1];
		//writeln("\t\tderivative: ", derivativeSeq);
	}

	// This is the first term in the polynomial.
	assert(derivativeSeq[0] % factorial!long(seq.length - 1) == 0);
	Polynomial firstTerm;
	firstTerm.length = seq.length;
	firstTerm[$-1] = derivativeSeq[0] / factorial!long(seq.length - 1);
	//writeln("\t\tnext term: ", firstTerm[$-1]);
	//writeln("\t\tnext polynomial: ", firstTerm);
	long[] firstTermSeq = polynomialN(firstTerm, cast(long)(seq.length-1)); 
	long[] nextSeq;
	nextSeq.length = seq.length - 1;
	for (long i = 0; i < nextSeq.length; i++)
		nextSeq[i] = seq[i] - firstTermSeq[i];
	Polynomial remainingTerms = findOp(nextSeq);
	return addPolynomials(firstTerm, remainingTerms);
}

