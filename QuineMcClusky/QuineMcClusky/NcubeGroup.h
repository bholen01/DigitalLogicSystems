#ifndef NCUBEGROUP_H
#define NCUBEGROUP_H

#include <vector>
#include "Ncube.h"
using std::vector;

class NcubeGroup {
public:
	NcubeGroup();
	NcubeGroup(NcubeGroup* first, NcubeGroup* second);
	~NcubeGroup();
	void populate_cube_group(vector<int>& terms, int group_number);
	void sort_cube_group();
	void print_cube_group(int number_of_variables);
	void push_cube(Ncube* cube);
	bool empty();
	bool contains(Ncube* new_cube);
	void group_PIs(vector<Ncube*>& destination);
private:
	vector<Ncube*> group;
	int number_of_ones(int number) {
		return __builtin_popcount(number);
	};

};


#endif
