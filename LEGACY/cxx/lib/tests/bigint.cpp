// vim: set noet:

#include "../bigint.hpp"
#include "../check.hpp"

int main() {

	// default construction
	bigint a;
	check(a == 0);
	check(0 == a);

	// explicit construction
	bigint b = 13;
	check(b == 13);
	check(13 == b);

	// boolean conversion
	a = 0;
	b = 17;
	check(!a);
	check(b);

	// addition
	a = 0;
	b = 13;
	check(a+b == 13);
	check(13 == a+b);

	b += 17;
	check(b == 30);
	check(b+5 == 35);

	a += b;
	check(a == 30);
	a += b;
	check(a == 60);

	a += -20;
	check(a == 40);
	check(a+-10 == 30);

	// multiplication
	a = 3;
	b = a * a;
	check(b == 9);

	b *= a;
	check(b == 27);
	check(b*2 == 54);
	check((b*=3) == 81);

	// division
	a = 24;
	b = 4;
	check(a/b == 6);
	check((a/=b) == 6);
	check(a == 6);
	check(a/3 == 2);
	check((a/=3) == 2);
	check(a == 2);

	// modulo
	a = 47;
	b = 10;
	check(a%b == 7);
	check((a%=b) == 7);
	check(a == 7);
	check(a%4 == 3);
	check((a%=4) == 3);
	check(a == 3);

}

