//
//  main.cpp
//  Benjamin Holen
//  Quine-McCluskey algorithm
//

#include <iostream>
#include <vector>
#include <algorithm>
#include <cassert>

#include "Ncube.h"
#include "NcubeList.h"
#include "NcubeTable.h"
#include "HelperFuncs.h"
#include "PIchart.h"

using namespace std;

typedef vector< vector<Ncube> > termlist;
typedef vector<termlist> termtable;

int interpret_input( vector<int>& minterms,
				     vector<int>& dontcares,
				     vector<int>& maxterms );
void collect_terms(vector<int>& terms);
void generate_maxterms( int number_of_variables, 
					    vector<int>& minterms, 
						vector<int>& dontcares,
						vector<int>& maxterms );
int count_variables(vector<int>& minterms, vector<int>& dontcares);

void vector_print(vector<int>& vec);
int vector_get_max(vector<int>& vec);
bool vector_contains(vector<int>& vec, int i);

int main()
{
	for(;;) {
    vector<int> minterms;
    vector<int> dontcares;
    vector<int> maxterms;
	int number_of_variables = interpret_input(minterms, dontcares, maxterms);
	if (number_of_variables == 0) {
		return 0;
	}
	cout << endl << "~~~~~~~~~~~~~~~~~~~~~~~~~"<< endl;
	NcubeTable* sop_table = new NcubeTable(minterms, dontcares, number_of_variables);
	sop_table->collapse();
	PIchart* pic_sop = new PIchart(sop_table, minterms, number_of_variables);
	pic_sop->reduce_PIchart(number_of_variables, true);
	

	NcubeTable* pos_table = new NcubeTable(maxterms, dontcares, number_of_variables);
	pos_table->collapse();
	PIchart* pic_pos = new PIchart(pos_table, maxterms, number_of_variables);
	pic_pos->reduce_PIchart(number_of_variables, false);
	cout << "~~~~~~~~~~~~~~~~~~~~~~~~~"<< endl << endl;

	delete sop_table;
	delete pic_sop;
	delete pos_table;
	delete pic_pos;
	}
}


int interpret_input( vector<int>& minterms,
    			     vector<int>& dontcares,
					 vector<int>& maxterms ) {

	char c;
	int number_of_variables;
	bool found_terms = false;
	while ((cin.get(c)) && (c != '\n')) {
		if (c == 'm') {
			collect_terms(minterms);
			found_terms = true;
		} else if (c == 'd') {
			collect_terms(dontcares);
		}
	}
	if (!found_terms) {
		return 0;
	}
	number_of_variables = count_variables(minterms, dontcares);
	generate_maxterms(number_of_variables, minterms, dontcares, maxterms);

	cout << "MINTERMS: ";
	vector_print(minterms);
	cout << "DONT CARE: ";
	vector_print(dontcares);
	cout << "MAXTERMS: ";
	vector_print(maxterms);
	return number_of_variables;
}
void collect_terms(vector<int>& terms) {
	int n;
	char c;
	cin.get(c);
	while (c != ')') {
		cin >> n;
		terms.push_back(n);
		cin.get(c);
	}
	assert(!terms.empty());
}


int count_variables(vector<int>& minterms, vector<int>& dontcares) {
	int number_of_variables = 1;
	int highest_term = max(vector_get_max(minterms), vector_get_max(dontcares));
	cout << "Highest term: " << highest_term << endl;
	
	while ((1 << number_of_variables++) <= highest_term);
	number_of_variables--;

	cout << "Variables required: " << number_of_variables << endl;
	return number_of_variables;
}

void generate_maxterms(int number_of_variables, vector<int>& minterms, vector<int>& dontcares, vector<int>& maxterms) {
	int i;
	for (i = 0; i < ((1 << number_of_variables)); i++) {
		if ((!vector_contains(minterms, i)) && (!vector_contains(dontcares, i))) {
			maxterms.push_back(i);
		}
	}
}

bool vector_contains(vector<int>& vec, int i) {
	bool contains = false;
	for (int element : vec) {
		contains |= (element == i);
	}
	return contains;
}

int vector_get_max(vector<int>& vec) {
	int max_value = 0;
	for (int element : vec) {
		if (element > max_value) {
			max_value = element;
		}
	}
	return max_value;
}

void vector_print(vector<int>& vec) {
	for (int element : vec) {
		cout << element << ", ";
	}
	cout << endl;
}


