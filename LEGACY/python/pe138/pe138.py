# vim: set noet ts=2 sw=2:

import factor
import itertools
import unittest

# Pythagorean triple
def ptriple(m, n):
	return m**2-n**2, 2*m*n, m**2+n**2


# The first six triangles:
#
# m=4, n=1      → a=15, b=8, c=17
# m=17, n=4     → a=273, b=136, c=305
# m=72, n=17    → a=4895, b=2448, c=5473
# m=305, n=72   → a=87841, b=43920, c=98209
# m=1292, n=305 → a=1576129, b=788120, c=1762289
# m=5473, n=1292 → a=28284465, b=14142232, c=31622993
#
# See the pattern?

def solve(N):
	acc = 0
	cnt = 0
	m = 4
	n = 1
	b = 0
	bqueue = []
	cqueue = []
	while True:
		bprev = b
		a, b, c = ptriple(m, n)
		bqueue.append(b)
		cqueue.append(c)
		acc += c
		cnt += 1
		if cnt == N:
			return acc
		n = m
		if cnt%2 != 0:
			m = cqueue.pop(0)
		else:
			m = (bqueue[0]+bqueue[1]) // 2
			bqueue.pop(0)

class Test(unittest.TestCase):
	def test(self):
		self.assertEqual(17, solve(1))
		self.assertEqual(322, solve(2))

def main():
	print(solve(12))

if __name__ == '__main__':
	main()

