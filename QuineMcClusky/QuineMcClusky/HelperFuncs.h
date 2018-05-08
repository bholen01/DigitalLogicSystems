#ifndef HELPERS
#define HELPERS

#include "Ncube.h"

int hamming_distance(int x, int y);


bool can_collapse_Ncubes(Ncube* first, Ncube* second);

bool can_cover(int term, Ncube* cube);

#endif
