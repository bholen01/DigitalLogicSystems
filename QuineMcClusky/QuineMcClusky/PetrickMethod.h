#ifndef PET_H
#define PET_H

#include "Ncube.h"
#include "PIlist.h"
using namespace std;
class PetrickMethod {
public:
	PetrickMethod(int new_size);
	~PetrickMethod();
    set<Ncube*> LowestCostTerm();
    void insert(PIlist* list);
    void print_petrick(int number_of_variables);
private:
    int size, gap;
    int costFunction(set<Ncube*>& term);
    vector< set<Ncube*> > terms;
};

#endif