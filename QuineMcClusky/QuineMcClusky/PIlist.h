#ifndef PIList_H
#define PIList_H

#include <vector>
#include <map>
#include <list>
#include <set>
#include "Ncube.h"
#include "NcubeTable.h"
using namespace std;

class PIlist {
public:
	PIlist(vector<Ncube*> implicants, int term, int number_of_variables);
	~PIlist();
	void print_PIlist(int number_of_variables);
	int size();
	bool contains(Ncube* cube);
	Ncube* essential_PI();
	list<Ncube*> prime_implicants;
private:

};

#endif