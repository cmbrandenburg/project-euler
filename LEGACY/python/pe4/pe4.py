# vim: set noet ts=2 sw=2:

import unittest

def is_palindrome(n, base = 10):
	rev = 0
	m = n
	while m:
		rev *= base
		rev += m%base
		m //= base
	return rev == n

class TestIsPalindrome(unittest.TestCase):
	def test(self):
		self.assertTrue(is_palindrome(0))
		self.assertTrue(is_palindrome(1))
		self.assertTrue(is_palindrome(9))
		self.assertFalse(is_palindrome(10))
		self.assertTrue(is_palindrome(11))
		self.assertFalse(is_palindrome(12))
		self.assertTrue(is_palindrome(99))
		self.assertFalse(is_palindrome(100))
		self.assertTrue(is_palindrome(111))
		self.assertTrue(is_palindrome(121))
		self.assertTrue(is_palindrome(1221))

def solve(MIN, MAX):
	best = 0
	for i in range(MAX-1, MIN-1, -1):
		for j in range(MAX-1, MIN-1, -1):
			p = i*j
			if p <= best:
				break
			if is_palindrome(p):
				best = p
	return best

class Test(unittest.TestCase):
	def test(self):
		self.assertEqual(9009, solve(10, 100))

def main():
	print(solve(100, 1000))

if __name__ == '__main__':
	main()

