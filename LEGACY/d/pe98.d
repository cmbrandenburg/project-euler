// vim: set noet ts=2 sw=2:
//
// Anagramic squares

import std.algorithm;
import std.regex;
import std.stdio;
import combo;
import quad;

static immutable base = 10;
static alias int['Z' - 'A' + 1] LetterToInt;

static LetterToInt countLettersInWord(string word) {
	LetterToInt letterCnts;
	foreach (_, ch; word)
		letterCnts[ch - 'A']++;
	return letterCnts;
}

static string hashLetterToInts(in LetterToInt letterCnts) {
	string key;
	foreach (index, cnt; letterCnts) {
		for (int i = 0; i < cnt; i++)
			key ~= cast(char)('A' + index);
	}
	return key;
}

void main() {

	// load words:
	auto inFile = File("data/words.txt", "r");
	auto regex = regex("\"([A-Z]+)\",?$");
	string[] words;
	while (!inFile.eof()) {
		string word = inFile.readln(',');
		auto matches = match(word, regex);
		words ~= matches.captures[1];
	}

	// count letters in each word, and hash the letter distribution:
	LetterToInt[] letterCnts;
	size_t[][string] anagrams;
	foreach (wordIndex, word; words) {
		letterCnts ~= countLettersInWord(word);
		auto hashKey = hashLetterToInts(letterCnts[$-1]);
		anagrams[hashKey] ~= wordIndex;
	}

	// for each anagram pair, determine which ones are square anagram word pairs:
	long biggest;
	foreach (key, wordIndices; anagrams) {
		if (wordIndices.length >= 2) {
			auto letterValueCombos = enumLetterValues(letterCnts[wordIndices[0]]);
			auto choices = enumChoices(wordIndices, 2);
			foreach (_, letterValues; letterValueCombos) {
				foreach (__, choice; choices) {
					string word1 = words[choice[0]];
					string word2 = words[choice[1]];
					long value1 = assignWordValue(word1, letterValues);
					long value2 = assignWordValue(word2, letterValues);
					if (letterValues[word1[0] - 'A'] != 0 &&
					    letterValues[word2[0] - 'A'] != 0 &&
							isSquare(value1) &&
							isSquare(value2)) {
						/*writeln("\tgood:\t",
								word1, " (", value1, "), ", word2, " (", value2, ")");*/
						biggest = max(biggest, value1);
						biggest = max(biggest, value2);
					}
				}
			}
		}
	}
	
	writeln(biggest);
}

static long assignWordValue(in string word, in LetterToInt letterValues) {
	long finalValue;
	foreach (_, ch; word) {
		finalValue *= 10;
		finalValue += letterValues[ch - 'A'];
	}
	return finalValue;
}

static LetterToInt[] enumLetterValues(in LetterToInt letterCnts) {

	static void recurse(
			ref LetterToInt[] letterValues,
			LetterToInt cur,
			in int[] availDigits,
			in char[] letters) {
		if (letters.length == 0) {
			letterValues ~= cur;
			return;
		}
		if (availDigits.length == 0)
			return;
		foreach (i, d; availDigits) {
			cur[letters[0] - 'A'] = d;
			recurse(
					letterValues,
					cur,
					availDigits[0..i] ~ availDigits[i+1 .. $],
					letters[1..$]);
			cur[letters[0] - 'A'] = 0;
		}
	}

	LetterToInt[] letterValues;
	LetterToInt cur;
	int[] availDigits;
	for (int i = 0; i < base; i++)
		availDigits ~= i;
	char[] letters;
	foreach (i, cnt; letterCnts) {
		if (cnt > 0)
			letters ~= cast(char)('A' + i);
	}
	recurse(letterValues, cur, availDigits, letters);
	return letterValues;
}

