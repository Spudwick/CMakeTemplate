// LibraryTest.cpp : Defines the entry point for the application.
//

#include <iostream>

#include "LibTest/LibraryTest.h"

void libprint() {
	std::cout << "Hello from Library!!\n";

#ifdef _LIB_DEBUG_
	std::cout << "Debug build!!\n";
#endif
}

int get1() {
	return 1;
}

int get2() {
	return 2;
}
