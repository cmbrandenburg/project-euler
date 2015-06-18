// vim: set noet ts=2 sw=2:
//
// Monopoly odds

// FIXME: This solution isn't deterministic.

import std.random;
import std.stdio;
import std.string;
import digit;
import rational;

static immutable int doubleLimit = 3;
static immutable int numSquares = 40;
static immutable int sidesOnDie = 4;

static immutable int sqJail = 10;
static immutable int sqGoToJail = 30;
static immutable int sqCommChest1 = 2;
static immutable int sqCommChest2 = 17;
static immutable int sqCommChest3 = 33;
static immutable int sqChance1 = 7;
static immutable int sqChance2 = 22;
static immutable int sqChance3 = 36;

static immutable int sqNextR = 41;
static immutable int sqNextU = 42;
static immutable int sqBack3 = 43;

// 0   : no effect
// 1-40: move to this square
// 41+ : special effect
static immutable int commChest[] = [
		1,
		11];
static immutable int chance[] = [
		1,
		11,
		12,
		25,
		40,
		6,
		sqNextR,
		sqNextR,
		sqNextU,
		sqBack3];

static immutable int cardCount = 16;

void main() {
	auto cnts = simulate(10_000_000);
	size_t[long] cntMap;
	//foreach (i, cnt; cnts) { writeln(i, "\t", cnt); }
	foreach (i, cnt; cnts)
		cntMap[cnt] = i;
	cnts.sort;
	cnts.reverse;
	writeln(format("%02d%02d%02d", cntMap[cnts[0]], cntMap[cnts[1]], cntMap[cnts[2]]));
}

static int rollDice(out bool isDouble) {
	int d1 = uniform(1, sidesOnDie + 1);
	int d2 = uniform(1, sidesOnDie + 1);
	isDouble = d1 == d2;
	return d1 + d2;
}

static long[] simulate(long maxIter) {

	// Create decks.

	int[] ccDeck;
	foreach (_, card; commChest)
		ccDeck ~= card;
	ccDeck.length = cardCount;
	randomShuffle(ccDeck);

	int[] chDeck;
	foreach (_, card; chance)
		chDeck ~= card;
	chDeck.length = cardCount;
	randomShuffle(chDeck);

	auto ccDeckTop = uniform(0, ccDeck.length);
	auto chDeckTop = uniform(0, chDeck.length);

	// Create initial state.

	long[] landCnts;
	landCnts.length = numSquares;
	int pos;
	int doubleCnt;

	bool applyCard(int card) {
		//writeln("\t\t\tcard: ", card);
		if (card == 0)
			return true;
		if (card <= numSquares) {
			pos = card - 1;
			return true; // no card explicitly leads to another card
		}
		if (card == sqNextR) {
			int delta = 5 - (pos % 10);
			delta += (delta < 0) ? 10 : 0;
			pos += delta;
			pos %= numSquares;
			return true;
		}
		if (card == sqNextU) {
			pos = (pos >= 12 && pos <= 27) ? 27 : 12;
			return true;
		} 
		if (card == sqBack3) {
			pos -= 3;
			return false;
		}
		assert(false);
	}

	// Simulate.

	//writeln("\t", pos);
	for (long i = 0; i < maxIter; i++) {
		bool isDouble;
		int roll = rollDice(isDouble);
		//writeln("\t\t\troll: ", roll, isDouble ? "*" : "");
		doubleCnt = isDouble ? doubleCnt + 1 : 0;
		pos = doubleCnt == doubleLimit ? sqJail : pos + roll;
		pos %= numSquares;
		bool done = false;
		do {
			switch (pos) {
				case sqGoToJail:
					pos = sqJail;
					done = true;
					break;
				case sqCommChest1:
				case sqCommChest2:
				case sqCommChest3:
					int card = ccDeck[ccDeckTop++];
					ccDeckTop %= ccDeck.length;
					done = applyCard(card);
					break;
				case sqChance1:
				case sqChance2:
				case sqChance3:
					int card = chDeck[chDeckTop++];
					chDeckTop %= chDeck.length;
					done = applyCard(card);
					break;
				default:
					done = true;
					break;
			}
		} while (!done);
		//writeln("\t", pos);
		landCnts[pos]++;
	}

	return landCnts;
}

