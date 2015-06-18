# vim: set noet ts=2 sw=2:

import unittest

def solve(N):
	acc = 0
	for i in range(1, N):
		if i%3 == 0 or i%5 == 0:
			acc += i
	return acc

class Test(unittest.TestCase):
	def test(self):
		self.assertEqual(23, solve(10))

def main():
	print(solve(1000))

if __name__ == '__main__':
	main()

