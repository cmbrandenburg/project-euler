# vim: set noet ts=2 sw=2:

import factor
import itertools
import unittest

# Pythagorean triple
def ptriple(m, n):
	return m**2-n**2, 2*m*n, m**2+n**2


def solve(N):
	cnt = 0
	for m in itertools.count(2):
		a, b, c = ptriple(m, 1)
		if a+b+c >= N:
			return cnt
		for n in range(1+m%2, m, 2):
			if 1 != factor.greatest_common_divisor(m, n):
				continue
			# Invariant: m and n produce a primitive Pythagorean triple.
			a, b, c = ptriple(m, n)
			p = a+b+c
			if p >= N:
				break
			if c % (b-a) == 0:
				# This triangle has an even tiling. So do all of its multiples. Include
				# this triangle and its multiples in the final count.
				cnt += (N-1) // p
	return cnt

def main():
	print(solve(100000000))

if __name__ == '__main__':
	main()

