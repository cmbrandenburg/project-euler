# vim: set noet ts=2 sw=2:

import factor
import unittest

def solve(N):
	return max(factor.prime_factors(N))

class Test(unittest.TestCase):
	def test(self):
		self.assertEqual(29, solve(13195))

def main():
	print(solve(600851475143))

if __name__ == '__main__':
	main()

