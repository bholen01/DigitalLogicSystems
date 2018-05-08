
#include <vector>
#include <iostream>
#include <map>
#include <list>
#include "PIchart.h"
#include "PIlist.h"
#include "Ncube.h"
#include "NcubeTable.h"
#include "HelperFuncs.h"
#include "PetrickMethod.h"

#define P PIchart

using namespace std;

P::PIchart(NcubeTable* table, vector<int>& new_terms, int number_of_variables) {
	table->reveal_PIs(implicants);
	for (int term : new_terms) {
		terms.push_back(term);
		PIlist* new_list = new PIlist(implicants, term, number_of_variables);
		chart.insert(pair<int, PIlist*>(term, new_list));	
	}
}

P::~PIchart() {
  for (map<int, PIlist*>::iterator it=chart.begin(); it != chart.end(); ++it) {
    delete it->second;
  }
}

void P::print_PIchart(int number_of_variables) {
    for (map<int, PIlist*>::iterator it=chart.begin(); it != chart.end(); ++it) {
    	cout << it->first;
		cout << " => ";
		it->second->print_PIlist(number_of_variables);
		cout << endl;
  	}
}

void P::reduce_PIchart(int number_of_variables, bool is_pos) {
	while(pop_term()) {}

	if(!is_reduced()) {
		petrick_method();
	}

	cout << "ESSENTIAL PI's ";
	if (is_pos) {
		cout << "SOP: ";
		int i = essential_prime_implicants.size();
		for (Ncube* cube : essential_prime_implicants) {
			cout << "(";
			cube->print_cube_pos(number_of_variables);
			cout << ")";
			if (i-- > 1) {
				cout << " + ";
			}
		}
	} else {
		cout << "POS: ";
		for (Ncube* cube : essential_prime_implicants) {
			cout << "(";
			cube->print_cube_sop(number_of_variables);
			cout << ")";
		}
	}
	cout << endl;
}

bool P::pop_term() {
	bool did_pop = false;
	Ncube* cube;
	
	for (map<int, PIlist*>::iterator it=chart.begin(); it != chart.end(); ++it) {
		if (!did_pop) {
			PIlist* list = it->second;
			if (list->size() == 1) {
				cube = list->essential_PI();
				essential_prime_implicants.push_back(cube);
				did_pop = true;
			}
		}
	}

	if (did_pop) {
		map<int, PIlist*>::iterator it=chart.begin();
		while (it != chart.end()) {
			PIlist* list = it->second;
			if (list->contains(cube)) {
				delete list;
				it = chart.erase(it);
			} else {
				++it;
			}
		}
	}
	return did_pop;
}

bool P::is_reduced() {
	return (chart.size() == 0);
}

void P::petrick_method() {
	int size = 1;
	for (map<int, PIlist*>::iterator it=chart.begin(); it != chart.end(); ++it) {
		PIlist* list = it->second;
		size *= list->prime_implicants.size();
	}
	PetrickMethod p(size);
	for (map<int, PIlist*>::iterator it=chart.begin(); it != chart.end(); ++it) {
		PIlist* list = it->second;
		p.insert(list);
	}
	//p.print_petrick(number_of_variables);

	set<Ncube*> petrickResult = p.LowestCostTerm();
	for (Ncube* cube : petrickResult) {
		essential_prime_implicants.push_back(cube);
    }
}

#undef P
