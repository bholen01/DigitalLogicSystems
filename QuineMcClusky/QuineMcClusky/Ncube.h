#ifndef NC_H
#define NC_H

class Ncube {
public:
	Ncube(int val);
	Ncube();
	Ncube(Ncube* first, Ncube* second);
	~Ncube();
	void set_val(int ones_new, int phi_new);
	void mark();
	void print_cube(int number_of_variables);
	void print_cube_pos(int number_of_variables);
	void print_cube_sop(int number_of_variables);
	bool cube_covers_term(int implicant, int number_of_variables);
	int ones;
	int phi;
	bool marked;
};

#endif
