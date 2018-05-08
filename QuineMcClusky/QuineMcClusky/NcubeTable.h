#ifndef NCUBETABLE_H
#define NCUBETABLE_H

#include <vector>
#include "NcubeList.h"
using std::vector;

class NcubeTable {
public:
	NcubeTable(vector<int>& terms, vector<int>& dontcares, int number_of_variables);
	~NcubeTable();
	void collapse();
	bool is_collapsable;
	void print_table(int number_of_variables);
	void reveal_PIs(vector<Ncube*>& destination);
private:
	vector< NcubeList* > table;
};


#endif
