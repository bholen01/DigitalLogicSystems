
#include "Ncube.h"

int hamming_distance(int x, int y) {
	return __builtin_popcount(x ^ y);
	}


bool can_collapse_Ncubes(Ncube* first, Ncube* second) {
	// conditions for collapseability:
	// the hamming distance is 1
	// the dont-cares are identical
	// the first is "lower" than the second
	return (hamming_distance(first->ones, second->ones) == 1) 
		&& (first->phi == second->phi)
		&& (first->ones < second->ones);
}
