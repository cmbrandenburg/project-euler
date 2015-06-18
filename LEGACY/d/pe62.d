// vim: set noet ts=2 sw=2:
//
// Cubic permutations

import std.bigint;
import std.conv;
import std.stdio;

static string permHash(BigInt n) {

	int[] digitCnts;
	digitCnts.length = 10;
	while (n > 0) {
		digitCnts[n % 10]++;
		n /= 10;
	}


	// Hash:
	// 123412341 -> "0030202020";

	string hash;
	foreach (i, cnt; digitCnts) {
		hash ~= to!string(cnt);
		hash ~= "0";
	}
	return hash;
}

static bool findPerms(BigInt[] nums, int cnt, BigInt *answer) {
	BigInt[][string] perms;
	foreach (_, n; nums) {
		string key = permHash(n);
		perms[key] ~= n;
		if (perms[key].length == cnt) {
			//writeln(perms[key]);
			*answer = perms[key][0];
			return true;
		}
	}
	return false;
}

void main() {

	BigInt[] cubeSeq;
	BigInt   cubeBase;
	BigInt   cubeMax = 1;

	BigInt cube(BigInt n) {
		return n * n * n;
	}

	void fillCubeSeq() {
		BigInt nextCube;
		nextCube = cube(cubeBase);
		while (nextCube < cubeMax){
			cubeSeq ~= nextCube;
			cubeBase++;
			nextCube = cube(cubeBase);
		}
	}

	BigInt answer;
	while (true) {
		cubeMax *= 10;
		fillCubeSeq();
		if (findPerms(cubeSeq, 5, &answer)) {
			writeln(answer);
			return;
		}
		cubeSeq.length = 0;
	}
}

