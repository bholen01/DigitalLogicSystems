

#include <vector>
#include <algorithm>
#include <iostream>
#include "NcubeTable.h"
#include "NcubeList.h"

#define N NcubeTable

using namespace std;

N::NcubeTable(vector<int>& terms, vector<int>& dontcares, int number_of_variables) {

	NcubeList* zero_cubes = new NcubeList(number_of_variables + 1);
	zero_cubes->populate_cube_list(terms, dontcares);
	zero_cubes->sort_cube_list();	
	table.push_back(zero_cubes);
	is_collapsable = true;
}

N::~NcubeTable() {
	for (NcubeList* list: table) {
		delete list;
	}
}

void N::collapse() {
	int column = 0;
	while (is_collapsable) {
		NcubeList* next_column = new NcubeList(table.at(column));
		if(!next_column->empty()) {
			table.push_back(next_column);
			column++;
		} else {
			delete next_column;
			is_collapsable = false;
		}
	}

}

void N::print_table(int number_of_variables) {
	for (NcubeList* list : table) {
		list->print_cube_list(number_of_variables);
	}
}

void N::reveal_PIs(vector<Ncube*>& destination) {
	for (NcubeList* list : table) {
		list->list_PIs(destination);
	}
}

#undef N
