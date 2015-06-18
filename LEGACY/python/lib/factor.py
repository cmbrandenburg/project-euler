# vim: set noet ts=2 sw=2:

import unittest

# Stores True if (index/2 + 3) is prime, False otherwise.
g_prime_stat = [
	True,  # 3
	True,  # 5
	True,  # 7
	False, # 9
	True,  # 11
	True,  # 13
	False, # 15
	True,  # 17
	True,  # 19
	False, # 21
	True,  # 23
	False, # 25
	False, # 27
	True,  # 29
	True,  # 31
	False, # 33
]

def primes():

	global g_prime_stat

	def index_to_number(n):
		return 2*n + 3

	yield 2
	ipos = 0

	while True:

		for i in range(ipos, len(g_prime_stat)):
			if g_prime_stat[i]:
				yield index_to_number(i)
		ipos = len(g_prime_stat)

		g_prime_stat = g_prime_stat + len(g_prime_stat)*[True]
		for i in range(len(g_prime_stat)):
			if g_prime_stat[i]:
				p = index_to_number(i)
				for j in range(i+p, len(g_prime_stat), p):
					g_prime_stat[j] = False

class TestPrimes(unittest.TestCase):
	def test(self):
		import itertools
		self.assertEqual([2, 3, 5, 7, 11, 13, 17, 19, 23, 29], list(itertools.islice(primes(), 0, 10)))

def prime_factors(n):
	while n > 1:
		for p in primes():
			if n%p == 0:
				yield p
				n //= p
				break

class TestPrimeFactors(unittest.TestCase):
	def test(self):
		self.assertEqual(set([5, 7, 13, 29]), set(prime_factors(13195)))

def greatest_common_divisor(a, b = None):
	if b == None:
		if len(a) == 1:
			return a[0]
		if len(a) == 2:
			return greatest_common_divisor(a[0], a[1])
		return greatest_common_divisor(a[0], greatest_common_divisor(a[1:]))
	if a < b:
		return greatest_common_divisor(b, a)
	if b == 0:
		return a
	return greatest_common_divisor(b, a%b)

class TestGreatestCommonDivisor(unittest.TestCase):
	def test(self):
		self.assertEqual(1, greatest_common_divisor(1, 1))
		self.assertEqual(1, greatest_common_divisor(1, 17))
		self.assertEqual(1, greatest_common_divisor(13, 17))
		self.assertEqual(6, greatest_common_divisor(12, 18))
		self.assertEqual(12, greatest_common_divisor(12, 24))
		self.assertEqual(12, greatest_common_divisor(24, 12))
		self.assertEqual(24, greatest_common_divisor(24, 24))
		self.assertEqual(6, greatest_common_divisor([24, 24, 6, 48]))

def least_common_multiple(a, b = None):
	if b == None:
		if len(a) == 1:
			return a[0]
		if len(a) == 2:
			return least_common_multiple(a[0], a[1])
		return least_common_multiple(a[0], least_common_multiple(a[1:]))
	return a*b // greatest_common_divisor(a, b)

class TestLeastCommonMultiple(unittest.TestCase):
	def test(self):
		self.assertEqual(24, least_common_multiple(8, 3))
		self.assertEqual(24, least_common_multiple(3, 8))
		self.assertEqual(24, least_common_multiple(12, 8))
		self.assertEqual(24, least_common_multiple([12, 8, 24]))

