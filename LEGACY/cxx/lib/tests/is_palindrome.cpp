// vim: set noet:

#include "../check.hpp"
#include "../digit.hpp"

int main() {
	for (int i = 0; i < 10; ++i)
		check(is_palindrome(i));
	check(!is_palindrome(10));
	check(is_palindrome(11));
	check(!is_palindrome(12));
	check(!is_palindrome(20));
	check(is_palindrome(22));
	check(is_palindrome(101));
	check(!is_palindrome(110));
	check(is_palindrome(111));
	check(!is_palindrome(112));
	check(is_palindrome(121));
}

