// vim: set noet ts=2 sw=2:

import std.algorithm;
import std.conv;
import factor;

struct Rational(Int) {

	static if (!is(Int == int)) {
		this(int n) {
			m_num = n;
			m_denom = 1;
		}
	}

	this(Int n) {
		m_num = n;
		m_denom = 1;
	}

	this(Int num, Int denom) {
		m_num = num;
		m_denom = denom;
	}

	@property Int numerator() { return m_num; }
	@property Int denominator() { return m_denom; }

	string toString() {
		return to!string(m_num) ~ " / " ~ to!string(m_denom);
	}

	ref typeof(this) reduce() {
		if (m_num == 0) {
			m_denom = 1;
			return this;
		}
		Int div = gcd(m_num, m_denom);
		m_num /= div;
		m_denom /= div;
		return this;
	}

	ref typeof(this) invert() {
		swap(m_num, m_denom);
		return this;
	}

	typeof(this) opAssign(T)(T rhs) {
		static if (is(T == typeof(this))) {
			m_num = rhs.m_num;
			m_denom = rhs.m_denom;
		} else {
			m_num = rhs;
			m_denom = 1;
		}
		return this;
	}

	typeof(this) opOpAssign(string op, T)(T rhs) {
		static if (op == "+") {
			m_num += rhs * m_denom;
			return this;
		} else static if (op == "/" && is(T == typeof(this))) {
			m_num *= rhs.m_denom;
			m_denom *= rhs.m_num;
			return this;
		} else static if (op == "/") {
			m_denom *= rhs;
			return this;
		} else static if (op == "*" && is(T == typeof(this))) {
			m_num *= rhs.m_num;
			m_denom *= rhs.m_denom;
			return this;
		} else static if (op == "*") {
			m_num *= rhs;
			return this;
		} else static assert(0, "Operator "~op~" not implemented");
	}

	typeof(this) opBinary(string op, T)(T rhs) {
		static if (op == "+" && is(T == typeof(this))) {
			auto result = this;
			commonizeDenoms(result, rhs);
			result.m_num += rhs.m_num;
			return result;
		} else static if (op == "+") {
			auto result = this;
			result.m_num += rhs * result.m_denom;
			return result;
		} else static if (op == "-" && is(T == typeof(this))) {
			auto result = this;
			commonizeDenoms(result, rhs);
			result.m_num -= rhs.m_num;
			return result;
		} else static if (op == "*" && is(T == typeof(this))) {
			auto result = this;
			result.m_num *= rhs.m_num;
			result.m_denom *= rhs.m_denom;
			return result;
		} else static if (op == "*") {
			auto result = this;
			result.m_num *= rhs;
			return result;
		} else static if (op == "/" && is(T == typeof(this))) {
			auto result = this;
			result.m_num *= rhs.m_denom;
			result.m_denom *= rhs.m_num;
			return result;
		} else static if (op == "/") {
			auto result = this;
			this.m_denom *= rhs;
			return result;
		} else static if (op == "%") {
			auto result = this / rhs;
			result.reduce();
			result.m_num %= result.m_denom;
			return result;
		} else static assert(0, "Operator "~op~" not implemented");
	}

	int opCmp(T)(T rhs) {
		auto me = this;
		auto it = Rational!Int(rhs);
		commonizeDenoms(me, it);
		return me.m_num < it.m_num ? -1 : (me.m_num == it.m_num ? 0 : 1);
	}

	int opEquals(T)(T rhs) {
		static if (is(T == typeof(this))) {
			auto me = this;
			me.reduce();
			rhs.reduce();
			return me.m_num == rhs.m_num && me.m_denom == rhs.m_denom;
		} else {
			return m_denom * rhs == m_num;
		}
	}

	typeof(this) opUnary(string op)() {
		static if (op == "-") {
			auto result = this;
			result.m_num = -result.m_num;
			return result;
		} else static assert(0, "Operator "~op~" not implemented");
	}

private:

	void commonizeDenoms(ref Rational!Int a, ref Rational!Int b) const {
		if (a.m_denom != b.m_denom) {
			a.m_num *= b.m_denom;
			b.m_num *= a.m_denom;
			a.m_denom *= b.m_denom;
			b.m_denom *= a.m_denom;
		}
	}

	Int m_num;
	Int m_denom;
}

unittest {

	// add/subtract:
	assert(Rational!int(1, 2) + Rational!int(1, 3) == Rational!int(5, 6));
	assert(Rational!int(1, 2) - Rational!int(1, 3) == Rational!int(1, 6));

	// equality:
	assert(Rational!int(1, 2) == Rational!int(2, 4));
}

