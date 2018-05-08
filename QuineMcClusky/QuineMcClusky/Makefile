#
# Makefile for peanuts5k
#
# At some point, I needed -std=c++11 to get nullptr to be available,
# but now that actually seems to break the compilation.
# If you run into trouble, you can try adding it back or switching
# to g++.
#
CXX      = clang++
CXXFLAGS = -g3 -Wall -Wextra -Wpedantic -std=c++11
# CXXFLAGS = -O0 -g3 -Wall -Wextra -std=c++11

#runList.cpp runList.h runner.cpp runner.h
#runner.cpp runList.cpp

build: main.cpp Ncube.h Ncube.cpp NcubeGroup.h NcubeGroup.cpp NcubeList.h NcubeList.cpp NcubeTable.h NcubeTable.cpp HelperFuncs.h HelperFuncs.cpp PIchart.h PIchart.cpp PIlist.h PIlist.cpp PetrickMethod.h PetrickMethod.cpp 
	${CXX} ${CXXFLAGS} -o qmc main.cpp Ncube.cpp NcubeGroup.cpp NcubeList.cpp NcubeTable.cpp HelperFuncs.cpp PIchart.cpp PIlist.cpp PetrickMethod.cpp

clean:
	rm -rf qmc *.dSYM *.o


