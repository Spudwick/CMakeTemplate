// sandbox.cpp : Source file for your target.
//


#include <iostream>

#include <LibTest/LibraryTest.h>


int main()
{
	libprint();

	std::cout << "Functions return : " << get1() << " & " << get2() << "\n";

#ifdef _LIB_DEBUG_
	std::cout << "Main debug build!!\n";
#endif

	return 0;
}
