
#include <set>
#include <iostream>
#include "PetrickMethod.h"
#include "Ncube.h"
#include "PIlist.h"
#include <cassert>

#define P PetrickMethod

using namespace std;

P::PetrickMethod(int new_size) {
    size = new_size;
    gap = 1;
    terms.resize(size);
}

P::~PetrickMethod() {

}

set<Ncube*> P::LowestCostTerm() {
    assert(terms.size() > 0);
    set<Ncube*> best_term = terms.at(0);
    int best_term_cost = costFunction(best_term);
    for (set<Ncube*> term : terms) {
        int cost = costFunction(term);
        if (cost < best_term_cost) {
            best_term = term;
            best_term_cost = cost;
        }
    }
    return best_term;
}

int P::costFunction(set<Ncube*>& term) {
    int cost = 0;
    cost += term.size();
    return cost;
}

void P::insert(PIlist* list) {
    int offset = 0;
    int list_size = list->prime_implicants.size();
    gap *= list_size;
    int portion = gap / list_size;
    for (Ncube* cube : list->prime_implicants) {
        for (int i = 0; i < size; i += gap) {
            for (int j = i; j < (i + (portion)); j++) {
                terms[j + offset].insert(cube);
            }
        }
        offset += portion;
    }
}

void P::print_petrick(int number_of_variables) {
    cout << "printing petrick: " << endl;
    int t = 0;
    for (set<Ncube*> term : terms) {
        cout << "term: " << t++ << endl;
        for (Ncube* cube : term) {
            cube->print_cube(number_of_variables);
            cout << endl;
        }
    }
}

#undef P
