# vim: set noet ts=2 sw=2:

# The first key to this problem is figuring out the closed form equation for AG(x).
#
#                 AG(x) = x*1 + x^2*4 + x^3*5 + x^4*9 + x^5*14 + x^6*23 + ...
#               x*AG(x) =       x^2*1 + x^3*4 + x^4*5 + x^5*9  + x^6*14 + ...
#           (1-x)*AG(x) = x*1 + x^2*3 + x^3*1 + x^4*4 + x^5*5 + x^6*9 + ...
#       (1-x-x^2)*AG(x) = x*1 + x^2*3
#                 AG(x) = (x + x^2*3) / (1-x-x^2)
#
# The second key to this problem is figuring out, by trial and error, that x,
# excluding the first x, will always use two consecutive Fibonacci
# numbers--e.g., 1/2, -3/2, 3/5, -5/8, ...
#
# Ergo, golden nuggets may be found by iterating through the Fibonacci sequence,
# taking consecutive values, a and b, and figuring out when AG(a/b) or AG(-b/a) is a
# positive integer.
#
# AG(a/b) = (a*b + 3*a^2) / (b^2 + a*b + a^2)

import itertools
import unittest

def golden_nuggets():
	def numer(a, b):
		return a*b + 3*a**2
	def denom(a, b):
		return b**2 - a*b - a**2
	yield 2
	a = 1
	b = 2
	while True:
		num = numer(a, b)
		den = denom(a, b)
		if den>0 and num%den == 0:
			yield num // den
		else:
			num = numer(-b, a)
			den = denom(-b, a)
			if den>0 and num%den == 0:
				yield num // den
		a, b = b, a+b

def solve(N):
	return sum(itertools.islice(golden_nuggets(), 0, N))

class Test(unittest.TestCase):
	def test(self):
		self.assertEqual(2, sum(list(itertools.islice(golden_nuggets(), 0, 1))))
		self.assertEqual(5, sum(list(itertools.islice(golden_nuggets(), 1, 2))))
		self.assertEqual(211345365, sum(list(itertools.islice(golden_nuggets(), 19, 20))))

def main():
	print(solve(30))

if __name__ == '__main__':
	main()

