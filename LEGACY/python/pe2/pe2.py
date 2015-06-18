# vim: set noet ts=2 sw=2:

import unittest

def solve(N):
	acc = 0
	a = 1
	b = 2
	while b < 4000000:
		if b%2 == 0:
			acc += b
		a, b = b, a+b
	return acc

def main():
	print(solve(4000000))

if __name__ == '__main__':
	main()

