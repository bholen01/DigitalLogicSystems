
#include "Ncube.h"
#include <iostream>

#define N Ncube

using namespace std;

N::Ncube(int val) {
	ones = val;
	phi = 0;
	marked = false;
}

N::Ncube() {
	marked = false;
}

N::Ncube(Ncube* first, Ncube* second) {
	// the collapsed cube's value is where the two cubes' values are alike
	// the collapsed cube's phi is where the two cubes' values are different,
	//  OR'ed with the two cubes' existing phi
	// it is invariant that the two cubes have the same phi
	ones = first->ones & second->ones;
	phi = (first->ones ^ second->ones) | (first->phi);
	first->mark();
	second->mark();
	marked = false;
}

N::~Ncube() {
	ones = 0;
	phi = 0;
}

void N::set_val(int ones_new, int phi_new) {
	ones = ones_new;
	phi = phi_new;
}

void N::mark() {
	marked = true;
}

void N::print_cube(int number_of_variables) {
	char c;
	for (int i = 1 << (number_of_variables - 1); i > 0; i >>=1) {
		c = i & phi;
		if (c != 0) {
			cout << 'X';
		} else {
			c = i & ones;
			if (c != 0) {
				cout << '1';
			} else /* c == 0 */ {
				cout << '0';
			}
		}
	}
	if (marked) {
		cout << '*';
	}
}

void N::print_cube_pos(int number_of_variables) {
	char c;
	char variable = 'A' - 1;
	bool should_print_star = false;
	for (int i = 1 << (number_of_variables - 1); i > 0; i >>=1) {
		variable++;
		c = i & phi;
		if (c != 0) {
		} else {
			c = i & ones;
			if (should_print_star) {
				cout << '*';
			}
			should_print_star = true;
			if (c != 0) {
				cout << variable;
			} else /* c == 0 */ {
				cout << variable << '\'';
			}
		}
	}
}

void N::print_cube_sop(int number_of_variables) {
	char c;
	char variable = 'A' - 1;
	bool should_print_plus = false;
	for (int i = 1 << (number_of_variables - 1); i > 0; i >>=1) {
		variable++;
		c = i & phi;
		if (c != 0) {
		} else {
			c = i & ones;
			if (should_print_plus) {
				cout << '+';
			}
			should_print_plus = true;
			if (c != 0) {
				cout << variable << '\'';
			} else /* c == 0 */ {
				cout << variable;
			}
		}
	}
}

bool N::cube_covers_term(int implicant, int number_of_variables) {
	bool contains = false;
	for (int i = 0; i < (1 << number_of_variables); i++) {
		contains |= ((ones | (phi & i)) == implicant);
	}
	return contains;
}

#undef N
