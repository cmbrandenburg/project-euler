// vim: set noet ts=2 sw=2:
//
// Poker hands

import std.algorithm;
import std.ascii;
import std.conv;
import std.stdio;

struct Card {
	int value;
	int suite;
}

static immutable ace = 13;
static immutable king = 12;
static immutable queen = 11;
static immutable jack = 10;

static char readChar(
		File f) {
	char ch;
	do {
		f.readf("%c", &ch);
	} while (isWhite(ch));
	return ch;
}

static Card[] readCards(
		File f,
		long line) {

	class E : Exception {
		this (string msg) {
			super(msg);
		}
	}

	Card[] cards;
	auto lineText = f.readln();
	if (f.eof()) {
		return cards;
	}

	for (int i = 0; i < 10; i++) {
		Card newCard;
		char value = lineText[3 * i];
		if ('2' <= value && value <= '9') {
			newCard.value = value - '1';
		} else if (value == 'T') {
			newCard.value = 9;
		} else if (value == 'J') {
			newCard.value = jack;
		} else if (value == 'Q') {
			newCard.value = queen;
		} else if (value == 'K') {
			newCard.value = king;
		} else if (value == 'A') {
			newCard.value = ace;
		} else {
			throw(new E("invalid card value '" ~ to!string(to!int(value)) ~
						"', line " ~ to!string(line) ~ ", card " ~ to!string(i + 1)));
		}
		char suite = lineText[3 * i + 1];
		switch (suite) {
			case 'D':
				newCard.suite = 1;
				break;
			case 'C':
				newCard.suite = 2;
				break;
			case 'H':
				newCard.suite = 3;
				break;
			case 'S':
				newCard.suite = 4;
				break;
			default:
				throw(new E("invalid card suite '" ~ suite ~ "', line " ~
							to!string(line) ~ ", card " ~ to!string(i + 1)));
		}
		cards ~= newCard;
	}
	return cards;
}

alias Card[5] Hand;

static bool isFlush(
		Hand hand,
		Card[] *highCards = null) {
	int suite = -1;
	foreach (_, card; hand) {
		if (suite != -1 && card.suite != suite)
			return false;
		if (suite == -1)
			suite = card.suite;
	}
	if (highCards != null)
		*highCards = (hand)[];
	return true;
}

unittest {
	alias Card C;
	assert(isFlush([C(13, 1), C(8, 1), C(7, 1), C(6, 1), C(4, 1)]));
	assert(!isFlush([C(13, 1), C(8, 1), C(7, 1), C(7, 2), C(4, 1)]));
}

static bool isFourOfAKind(
		Hand hand,
		Card[] *highCards) {

	bool high(
			int a,
			int b) {
		if (highCards) {
			*highCards ~= hand[a];
			*highCards ~= hand[b];
		}
		return true;
	}

	if (hand[0].value == hand[3].value)
		return high(0, 4);
	if (hand[1].value == hand[4].value)
		return high(1, 0);
	return false;
}

static bool isFullHouse(
		Hand hand,
		Card[] *highCards) {

	bool high(
			int a,
			int b) {
		if (highCards) {
			*highCards ~= hand[a];
			*highCards ~= hand[b];
		}
		return true;
	}

	if (hand[0].value == hand[2].value && hand[3].value == hand[4].value)
		return high(0, 3);
	if (hand[0].value == hand[1].value && hand[2].value == hand[4].value)
		return high(1, 2);
	return false;
}

static bool isOnePair(
		Hand hand,
		Card[] *highCards = null) {

	bool high(
			int a,
			int b, 
			int c,
			int d) {
		if (highCards) {
			*highCards ~= hand[a];
			*highCards ~= hand[b];
			*highCards ~= hand[c];
			*highCards ~= hand[d];
		}
		return true;
	}

	if (hand[0].value == hand[1].value)
		return high(0, 2, 3, 4);
	if (hand[1].value == hand[2].value)
		return high(1, 0, 3, 4);
	if (hand[2].value == hand[3].value)
		return high(2, 0, 1, 4);
	if (hand[3].value == hand[4].value)
		return high(3, 0, 1, 2);
	return false;
}

static bool isRoyalFlush(
		Hand hand) {
	if (!isFlush(hand))
		return false;
	if (!isStraight(hand))
		return false;
	if (hand[0].value != ace) {
		return false;
	}
	return true;
}

static bool isStraight(
		Hand hand,
		Card[] *highCards = null) {
	for (int i = 1; i < hand.length; i++) {
		if (hand[i].value != hand[i - 1].value - 1) {
			return false;
		}
	}
	if (highCards != null)
		*highCards = (hand)[];
	return true;
}

unittest {
	alias Card C;
	assert(isStraight([C(13, 1), C(12, 2), C(11, 3), C(10, 2), C(9, 1)]));
	assert(isStraight([C(10, 1), C(9, 2), C(8, 3), C(7, 2), C(6, 1)]));
	assert(!isStraight([C(10, 1), C(9, 2), C(9, 3), C(7, 2), C(6, 1)]));
	assert(!isStraight([C(10, 1), C(9, 2), C(8, 3), C(7, 2), C(5, 1)]));
	assert(!isStraight([C(11, 1), C(9, 2), C(8, 3), C(7, 2), C(6, 1)]));
}

static bool isStraightFlush(
		Hand hand) {
	return isStraight(hand) && isFlush(hand);
}

static bool isThreeOfAKind(
		Hand hand,
		Card[] *highCards = null) {

	bool high(
			int a,
			int b,
			int c) {
		if (highCards) {
			*highCards ~= hand[a];
			*highCards ~= hand[b];
			*highCards ~= hand[c];
		}
		return true;
	}

	if (hand[0].value == hand[2].value)
		return high(0, 3, 4);
	if (hand[1].value == hand[3].value)
		return high(1, 0, 4);
	if (hand[2].value == hand[4].value)
		return high(2, 0, 1);
	return false;
}

static bool isTwoPairs(
		Hand hand,
		Card[] *highCards) {

	bool high(
			int a) {
		if (highCards) {
			*highCards ~= hand[a];
		}
		return true;
	}

	if (hand[0].value == hand[1].value && hand[2].value == hand[3].value)
		return high(4);
	if (hand[0].value == hand[1].value && hand[2].value == hand[4].value)
		return high(3);
	if (hand[0].value == hand[1].value && hand[3].value == hand[4].value)
		return high(2);
	if (hand[0].value == hand[2].value && hand[3].value == hand[4].value)
		return high(1);
	if (hand[1].value == hand[2].value && hand[3].value == hand[4].value)
		return high(0);
	return false;
}

static bool doesP1Win(
		Hand p1Hand,
		Hand p2Hand) {

	bool f1, f2;
	Card[] h1, h2; // high card(s)

	bool checkHighCards(
			Card[] h1,
			Card[] h2) {
		assert(h1.length > 0);
		assert(h2.length > 0);
		if (h1[0].value > h2[0].value)
			return true;
		if (h1[0].value < h2[0].value)
			return false;
		return checkHighCards(h1[1..$], h2[1..$]);
	}

	// royal flush:
	f1 = isRoyalFlush(p1Hand);
	f2 = isRoyalFlush(p2Hand);
	if (f1 && !f2)
		return true;
	if (f2 && !f1)
		return false;

	// straight flush:
	f1 = isStraightFlush(p1Hand);
	f2 = isStraightFlush(p2Hand);
	if (f1 && !f2)
		return true;
	if (f2 && !f1)
		return false;

	// four of a kind:
	f1 = isFourOfAKind(p1Hand, &h1);
	f2 = isFourOfAKind(p2Hand, &h2);
	if (f1 && !f2)
		return true;
	if (f2 && !f1)
		return false;
	if (f1 && f2)
		return checkHighCards(h1, h2);

	// full house:
	f1 = isFullHouse(p1Hand, &h1);
	f2 = isFullHouse(p2Hand, &h2);
	if (f1 && !f2)
		return true;
	if (f2 && !f1)
		return false;
	if (f1 && f2)
		return checkHighCards(h1, h2);

	// flush:
	f1 = isFlush(p1Hand, &h1);
	f2 = isFlush(p2Hand, &h2);
	if (f1 && !f2)
		return true;
	if (f2 && !f1)
		return false;
	if (f1 && f2)
		return checkHighCards(h1, h2);

	// straight:
	f1 = isStraight(p1Hand, &h1);
	f2 = isStraight(p2Hand, &h2);
	if (f1 && !f2)
		return true;
	if (f2 && !f1)
		return false;
	if (f1 && f2)
		return checkHighCards(h1, h2);

	// three of a kind:
	f1 = isThreeOfAKind(p1Hand, &h1);
	f2 = isThreeOfAKind(p2Hand, &h2);
	if (f1 && !f2)
		return true;
	if (f2 && !f1)
		return false;
	if (f1 && f2)
		return checkHighCards(h1, h2);

	// two pairs:
	f1 = isTwoPairs(p1Hand, &h1);
	f2 = isTwoPairs(p2Hand, &h2);
	if (f1 && !f2)
		return true;
	if (f2 && !f1)
		return false;
	if (f1 && f2)
		return checkHighCards(h1, h2);

	// one pair:
	f1 = isOnePair(p1Hand, &h1);
	f2 = isOnePair(p2Hand, &h2);
	if (f1 && !f2)
		return true;
	if (f2 && !f1)
		return false;
	if (f1 && f2)
		return checkHighCards(h1, h2);

	// high card:
	return checkHighCards(p1Hand, p2Hand);
}

void main() {
	auto inFile = File("data/poker.txt", "r");
	long line;
	auto cards = readCards(inFile, ++line);
	int cnt;
	while (cards.length == 10) {
		Hand p1Hand = cards[0..5];
		sort!("a.value > b.value || (a.value == b.value && a.suite < b.suite)")(
				p1Hand[0..$]);
		Hand p2Hand = cards[5..$];
		sort!("a.value > b.value || (a.value == b.value && a.suite < b.suite)")(
				p2Hand[0..$]);
		// Hands are sorted primarily by value, descending, and secondarily by
		// suite, ascending.
		auto win = doesP1Win(p1Hand, p2Hand);
		cnt += win ? 1 : 0;
		//writeln(p1Hand, "\t", p2Hand, "\t", win);
		cards = readCards(inFile, ++line);
	}
	writeln(cnt);
}

