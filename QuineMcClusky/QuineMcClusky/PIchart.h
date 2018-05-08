#ifndef PICHART_H
#define PICHART_H

#include <vector>
#include <map>
#include "Ncube.h"
#include "NcubeTable.h"
#include "PIlist.h"
using namespace std;

class PIchart {
public:
	PIchart(NcubeTable* table, vector<int>& new_terms, int number_of_variables);
	~PIchart();
	void print_PIchart(int number_of_variables);
	void reduce_PIchart(int number_of_variables, bool is_pos);
private:
	bool pop_term();
	bool is_reduced();
	void petrick_method();
	vector<Ncube*> implicants;
	vector<int> terms;
	map< int, PIlist* > chart;
	vector<Ncube*> essential_prime_implicants;
};


#endif
