# vim: set noet ts=2 sw=2:

import factor
import unittest

def solve(N):
	return factor.least_common_multiple(range(1, N+1))

class Test(unittest.TestCase):
	def test(self):
		self.assertEqual(2520, solve(10))

def main():
	print(solve(20))

if __name__ == '__main__':
	main()

