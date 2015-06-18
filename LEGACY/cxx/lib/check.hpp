// vim: set noet:

#ifndef CHECK_HPP
#define CHECK_HPP

#include "common.hpp"
#include <cstdlib>
#include <iostream>

#define check(cond) do { \
	if (!(cond)) { \
		std::cerr << __FILE__ << ':' << __LINE__ << ": check failed: " << #cond << '\n'; \
		std::abort(); \
	} \
} while (false)

#endif // #ifndef CHECK_HPP
