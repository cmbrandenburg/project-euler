# vim: set noet ts=2 sw=2:

import unittest

def solve(N):
		return sum(range(1, N+1))**2 - sum([x**2 for x in range(1, N+1)])

class Test(unittest.TestCase):
	def test(self):
		self.assertEqual(2640, solve(10))

def main():
	print(solve(100))

if __name__ == '__main__':
	main()

