# vim: set noet ts=2 sw=2:

import itertools
import unittest

def squares_less_than_root_of(m):
	sqs = []
	n = 1
	while n**2 < m:
		sqs.append(n**2)
		n += 1
	return sqs

def solve(N):

	sqs = {x: False for x in squares_less_than_root_of(N)}

	# r^2*a == r*b == r*c, where r is the geometric ratio
	#
	# n = a*c + b, or
	# n = b*c + a.
	#
	# a*c + b < b*c + a

	rden = 1 # ratio denominator
	while True:
		rnum = rden+1 # ratio numerator
		# Invariant: radio is greater than 1.
		abase = a = rden**2
		bbase = b = a*rnum//rden
		cbase = c = b*rnum//rden
		n = a*c + b
		if n >= N:
			break
		while True:
			while True:
				if n in sqs:
					sqs[n] = True
				n = b*c + a
				if n in sqs:
					sqs[n] = True
				a += abase
				b += bbase
				c += cbase
				n = a*c + b
				if n >= N:
					break
			rnum += 1
			abase = a = rden**2
			bbase = b = a*rnum//rden
			cbase = c = b*rnum//rden
			n = a*c + b
			if n >= N:
				break
		rden += 1
	return sum([x for x in sqs if sqs[x]])
			

class Test(unittest.TestCase):
	def test(self):
		self.assertEqual([1, 4, 9], squares_less_than_root_of(10))
		self.assertEqual(124657, solve(10**5))

def main():
	print(solve(10**12))

if __name__ == '__main__':
	main()

