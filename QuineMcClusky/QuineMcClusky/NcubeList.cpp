

#include <vector>
#include <algorithm>
#include <iostream>
#include "NcubeList.h"
#include "NcubeGroup.h"
#include "Ncube.h"


#define N NcubeList

using namespace std;

N::NcubeList(int size) {
	zero_cube_size = size;
}

N::NcubeList() {
}

N::NcubeList(NcubeList* source) {
	// for (NcubeGroup* group : source->list) {

	for (size_t i = 0; i < (source->list.size() - 1); i++) {
		
		NcubeGroup* group = source->list.at(i);
		
		NcubeGroup* consecutive_group = source->list.at(i+1);
		list.push_back(
			new NcubeGroup(group, consecutive_group)
			);
		
		//list.push_back(group);
	}

}

N::~NcubeList() {
	for (NcubeGroup* group: list) {
		delete group;
	}
	list.clear();
}

void N::populate_cube_list(vector<int>& terms, vector<int>& dontcares) {
	NcubeGroup* group;
	for (int i = 0; i < zero_cube_size; i++) {
		group = new NcubeGroup();
		group->populate_cube_group(terms, i);
		group->populate_cube_group(dontcares, i);
		list.push_back(group);
	}
}

void N::sort_cube_list() {
	for (NcubeGroup* group: list) {
		group->sort_cube_group();
	}
}

void N::print_cube_list(int number_of_variables) {
	cout << "~~~~~~" << endl;
	for (size_t i = 0; i < list.size(); i++) {
		cout << "--" << i << "--" << endl;
		list.at(i)->print_cube_group(number_of_variables);
	}
}

bool N::empty() {
	bool empty = true;
	for (NcubeGroup* group : list) {
		empty &= group->empty();
	}
	return empty;
}

void N::list_PIs(vector<Ncube*>& destination) {
	for (NcubeGroup* group : list) {
		group->group_PIs(destination);
	}
}


#undef N
