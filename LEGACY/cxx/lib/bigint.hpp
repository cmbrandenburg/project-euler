// vim: set noet:

#ifndef PE_BIGINT_HPP
#define PE_BIGINT_HPP

#include "common.hpp"
#include <gmp.h>
#include <memory>
#include <string>
#include <utility>

class bigint {
	mpz_t z;
public:

	~bigint() { clear(); }

	// construction:
	bigint() { mpz_init(z); }
	bigint(bigint const &that) { mpz_init_set(z, that.z); }
	bigint(bigint &&that) { std::swap(z, that.z); }
	bigint(int that) { mpz_init_set_si(z, that); }
	bigint(long that) { mpz_init_set_si(z, that); }
	bigint(unsigned long that) { mpz_init_set_ui(z, that); }
	bigint(char const *s, int base = 10) { mpz_init_set_str(z, s, base); }

	// assignment:
	bigint &operator=(bigint const &that) { mpz_set(z, that.z); return *this; }
	bigint &operator=(bigint &&that) { std::swap(z, that.z); return *this; }
	bigint &operator=(int that) { mpz_set_si(z, that); return *this; }
	bigint &operator=(long that) { mpz_set_si(z, that); return *this; }
	bigint &operator=(unsigned long that) { mpz_set_ui(z, that); return *this; }

	// comparison:
	bool operator==(bigint const &that) const { return compare(that) == 0; }
	bool operator!=(bigint const &that) const { return compare(that) != 0; }
	bool operator<(bigint const &that) const { return compare(that) < 0; }
	bool operator<=(bigint const &that) const { return compare(that) <= 0; }
	bool operator>(bigint const &that) const { return compare(that) > 0; }
	bool operator>=(bigint const &that) const { return compare(that) >= 0; }

	bool operator==(int that) const { return compare(static_cast<long>(that)) == 0; }
	bool operator!=(int that) const { return compare(static_cast<long>(that)) != 0; }
	bool operator<(int that) const { return compare(static_cast<long>(that)) < 0; }
	bool operator<=(int that) const { return compare(static_cast<long>(that)) <= 0; }
	bool operator>(int that) const { return compare(static_cast<long>(that)) > 0; }
	bool operator>=(int that) const { return compare(static_cast<long>(that)) >= 0; }

	bool operator==(long that) const { return compare(that) == 0; }
	bool operator!=(long that) const { return compare(that) != 0; }
	bool operator<(long that) const { return compare(that) < 0; }
	bool operator<=(long that) const { return compare(that) <= 0; }
	bool operator>(long that) const { return compare(that) > 0; }
	bool operator>=(long that) const { return compare(that) >= 0; }

	bool operator==(unsigned long that) const { return compare(that) == 0; }
	bool operator!=(unsigned long that) const { return compare(that) != 0; }
	bool operator<(unsigned long that) const { return compare(that) < 0; }
	bool operator<=(unsigned long that) const { return compare(that) <= 0; }
	bool operator>(unsigned long that) const { return compare(that) > 0; }
	bool operator>=(unsigned long that) const { return compare(that) >= 0; }

	// cast conversion:
	operator bool() const { return *this != 0; }
	operator int() const { return mpz_get_si(z); }
	operator long() const { return mpz_get_si(z); }
	operator unsigned long() const { return mpz_get_ui(z); }

	// string conversion:
	std::string string(int base = 10) const;

	// addition:
	bigint operator+(bigint const &that) const { bigint r; mpz_add(r.z, z, that.z); return r; }
	bigint operator+(int that) const { bigint r; r.add_and_set(*this, that); return r; }
	bigint operator+(long that) const { bigint r; r.add_and_set(*this, that); return r; }
	bigint operator+(unsigned long that) const { bigint r; mpz_add_ui(r.z, z, that); return r; }

	bigint &operator+=(bigint const &that) { mpz_add(z, z, that.z); return *this; }
	bigint &operator+=(int that) { add_and_set(*this, that); return *this; }
	bigint &operator+=(long that) { add_and_set(*this, that); return *this; }
	bigint &operator+=(unsigned long that) { mpz_add_ui(z, z, that); return *this; }

	// multiplication:
	bigint operator*(bigint const &that) const { bigint r; mpz_mul(r.z, z, that.z); return r; }
	bigint operator*(int that) const { bigint r; mpz_mul_si(r.z, z, that); return r; }
	bigint operator*(long that) const { bigint r; mpz_mul_si(r.z, z, that); return r; }
	bigint operator*(unsigned long that) const { bigint r; mpz_mul_ui(r.z, z, that); return r; }

	bigint &operator*=(bigint const &that) { mpz_mul(z, z, that.z); return *this; }
	bigint &operator*=(int that) { mpz_mul_si(z, z, that); return *this; }
	bigint &operator*=(long that) { mpz_mul_si(z, z, that); return *this; }
	bigint &operator*=(unsigned long that) { mpz_mul_ui(z, z, that); return *this; }

	// division:
	bigint operator/(bigint const &that) const { bigint r; mpz_tdiv_q(r.z, z, that.z); return r; }
	bigint operator/(int that) const { bigint r; r.div_and_set(*this, that); return r; }
	bigint operator/(long that) const { bigint r; r.div_and_set(*this, that); return r; }
	bigint operator/(unsigned that) const { bigint r; mpz_tdiv_q_ui(r.z, z, that); return r; }
	bigint operator/(unsigned long that) const { bigint r; mpz_tdiv_q_ui(r.z, z, that); return r; }

	bigint &operator/=(bigint const &that) { mpz_tdiv_q(z, z, that.z); return *this; }
	bigint &operator/=(int that) { div_and_set(*this, that); return *this; }
	bigint &operator/=(long that) { div_and_set(*this, that); return *this; }
	bigint &operator/=(unsigned that) { mpz_tdiv_q_ui(z, z, that); return *this; }
	bigint &operator/=(unsigned long that) { mpz_tdiv_q_ui(z, z, that); return *this; }

	// modulo:
	bigint operator%(bigint const &that) const { bigint r; mpz_mod(r.z, z, that.z); return r; }
	bigint operator%(int that) const { bigint r; r.mod_and_set(*this, that); return r; }
	bigint operator%(long that) const { bigint r; r.mod_and_set(*this, that); return r; }
	bigint operator%(unsigned long that) const { bigint r; r.mod_and_set(*this, that); return r; }

	bigint &operator%=(bigint const &that) { mpz_mod(z, z, that.z); return *this; }
	bigint &operator%=(int that) { mod_and_set(*this, that); return *this; }
	bigint &operator%=(long that) { mod_and_set(*this, that); return *this; }
	bigint &operator%=(unsigned long that) { mpz_mod_ui(z, z, that); return *this; }

private:
	void clear() { mpz_clear(z); }
	int compare(bigint const &that) const { return mpz_cmp(z, that.z); }
	int compare(long that) const { return mpz_cmp_si(z, that); }
	int compare(unsigned long that) const { return mpz_cmp_ui(z, that); }
	void add_and_set(bigint const &a, long b);
	void div_and_set(bigint const &a, long b);
	void mod_and_set(bigint const &a, long b);
};

inline bool operator==(int a, bigint const &b) { return b == a; }
inline bool operator!=(int a, bigint const &b) { return b != a; }
inline bool operator<(int a, bigint const &b) { return b >= a; }
inline bool operator<=(int a, bigint const &b) { return b > a; }
inline bool operator>(int a, bigint const &b) { return b <= a; }
inline bool operator>=(int a, bigint const &b) { return b < a; }

inline bool operator==(long a, bigint const &b) { return b == a; }
inline bool operator!=(long a, bigint const &b) { return b != a; }
inline bool operator<(long a, bigint const &b) { return b >= a; }
inline bool operator<=(long a, bigint const &b) { return b > a; }
inline bool operator>(long a, bigint const &b) { return b <= a; }
inline bool operator>=(long a, bigint const &b) { return b < a; }

inline bool operator==(unsigned long a, bigint const &b) { return b == a; }
inline bool operator!=(unsigned long a, bigint const &b) { return b != a; }
inline bool operator<(unsigned long a, bigint const &b) { return b >= a; }
inline bool operator<=(unsigned long a, bigint const &b) { return b > a; }
inline bool operator>(unsigned long a, bigint const &b) { return b <= a; }
inline bool operator>=(unsigned long a, bigint const &b) { return b < a; }

#if 0 // need testing
inline bigint operator+(int a, bigint const &b) { return b+a; }
inline bigint operator+(long a, bigint const &b) { return b+a; }
inline bigint operator+(unsigned long a, bigint const &b) { return b+a; }

inline bigint operator*(int a, bigint const &b) { return b*a; }
inline bigint operator*(long a, bigint const &b) { return b*a; }
inline bigint operator*(unsigned long a, bigint const &b) { return b*a; }

#endif // #if 0

inline void bigint::add_and_set(bigint const &a, long b) {
	if (b < 0)
		mpz_sub_ui(z, a.z, -b);
	else
		mpz_add_ui(z, a.z, b);
}

inline void bigint::div_and_set(bigint const &a, long b) {
	if (b < 0) {
		mpz_tdiv_q_ui(z, a.z, -b);
		mpz_neg(z, z);
	} else
		mpz_tdiv_q_ui(z, a.z, b);
}

inline void bigint::mod_and_set(bigint const &a, long b) {
	if (b < 0)
		mpz_mod_ui(z, a.z, -b);
	else
		mpz_mod_ui(z, a.z, b);
}

inline std::string bigint::string(int base) const {
	auto len = mpz_sizeinbase(z, 10);
	std::unique_ptr<char> s(new char[len+2]);
	mpz_get_str(s.get(), base, z);
	return std::string(s.get());
}

#endif // #ifndef PE_BIGINT_HPP
