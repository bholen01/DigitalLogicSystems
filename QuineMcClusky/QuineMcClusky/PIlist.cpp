
#include <vector>
#include <iostream>
#include <list>
#include "PIlist.h"
#include "HelperFuncs.h"
#include "Ncube.h"

#define P PIlist

using namespace std;

P::PIlist(vector<Ncube*> implicants, int term, int number_of_variables) {
    for (Ncube* cube : implicants) {
        if (cube->cube_covers_term(term, number_of_variables)) {
            prime_implicants.push_back(cube);
        }
    }
}

P::~PIlist() {

}

void P::print_PIlist(int number_of_variables) {
    for (Ncube* cube : prime_implicants) {
        cube->print_cube(number_of_variables);
        cout << ", ";
    }
}
int P::size() {
    return prime_implicants.size();
}

bool P::contains(Ncube* cube) {
    bool contains = false;
    for (Ncube* cube_in_list : prime_implicants) {
        contains |= (cube_in_list == cube);
    }
    return contains;
}

Ncube* P::essential_PI() {
    return prime_implicants.front();
}


#undef P
