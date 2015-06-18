# vim: set noet ts=2 sw=2:

import factor
import itertools
import unittest

def solve(N):
    return list(itertools.islice(factor.primes(), N-1, N))[0]

class Test(unittest.TestCase):
	def test(self):
		self.assertEqual(13, solve(6))

def main():
	print(solve(10001))

if __name__ == '__main__':
	main()


