#include <vector>
#include <algorithm>
#include <iostream>
#include "NcubeList.h"
#include "NcubeGroup.h"
#include "Ncube.h"
#include "HelperFuncs.h"

#define N NcubeGroup

using namespace std;

N::NcubeGroup() {

}

N::NcubeGroup(NcubeGroup* first, NcubeGroup* second) {
	// duplicates:
	// if the new cube already exists in the group,
	// dont push it and just delete it
	// the proper terms will be marked by the constructor
	for (Ncube* low_cube : first->group) {
		for (Ncube* high_cube : second->group) {
			if (can_collapse_Ncubes(low_cube, high_cube)) {
				Ncube* new_cube = new Ncube(low_cube, high_cube);
				if (!this->contains(new_cube)) {
					group.push_back(new_cube);
				} else {
					delete new_cube;
				}
			}
		}
	}
}

N::~NcubeGroup() {
	for (Ncube* cube: group) {
		delete cube;
	}
	group.clear();
}

void N::populate_cube_group(vector<int>& terms, int group_number) {
	for (int i : terms) {
		if (number_of_ones(i) == group_number) {
			group.push_back(new Ncube(i));
		}
	}
}

void N::sort_cube_group() {
	sort(group.begin(), group.end(), 
		 [](const Ncube* a, const Ncube* b) -> bool {
			 return a->ones < b->ones;
	 });
}

void N::print_cube_group(int number_of_variables) {
	for (Ncube* cube: group) {
		cube->print_cube(number_of_variables);
		cout << endl;
	}
}

void N::push_cube(Ncube* cube) {
	group.push_back(cube);	
}

bool N::empty() {
	return (group.size() == 0);
}

bool N::contains(Ncube* new_cube) {
	bool contains = false;
	for (Ncube* cube : group) {
		contains |= (
			(new_cube->ones == cube->ones) && (new_cube->phi == cube->phi)
			);
	}
	return contains;
}

void N::group_PIs(vector<Ncube*>& destination) {
	for (Ncube* cube : group) {
		if (!cube->marked) {
			destination.push_back(cube);
		}
	}
}

#undef N
