// vim: set noet ts=2 sw=2:
//
// Counting Sundays

import std.stdio;

static int daysInMonth(int year, int month) {
	switch (month) {
		assert(0 <= month && month < 12);
		case 0:  // Jan
		case 2:  // Mar
		case 4:  // May
		case 6:  // Jul
		case 7:  // Aug
		case 9:  // Oct
		case 11: // Dec
			return 31;
		case 3:  // Apr
		case 5:  // Jun
		case 8:  // Sep
		case 10: // Nov
			return 30;
		case 1:  // Feb
			if ((year % 4) != 0) {
				return 28;
			}
			if ((year % 100) != 0) {
				return 29;
			}
			if ((year % 400) != 0) {
				return 28;
			}
			return 29;
		default:
	}
	assert(false);
}

void main() {
	int numSundays;
	int dayOfWeek;
	int year = 1900;
	int month;
	while (year <= 2000) {
		if (year >= 1901 && dayOfWeek == 6) {
			numSundays++;
		}
		dayOfWeek += daysInMonth(year, month);
		dayOfWeek %= 7;
		month++;
		if (month == 12) {
			month = 0;
			year++;
		}
	}
	writeln(numSundays);
}

