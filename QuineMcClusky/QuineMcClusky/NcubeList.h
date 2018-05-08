#ifndef NCUBELIST_H
#define NCUBELIST_H

#include <vector>
#include "Ncube.h"
#include "NcubeGroup.h"
using std::vector;

class NcubeList {
public:
	NcubeList(int size);
	NcubeList();
	NcubeList(NcubeList* source);
	~NcubeList();
	void populate_cube_list(vector<int>& terms, vector<int>& dontcares);
	void sort_cube_list();
	void print_cube_list(int number_of_variables);
	bool empty();
	void list_PIs(vector<Ncube*>& destination);
private:
	vector<NcubeGroup*> list;
	int zero_cube_size;
};


#endif
