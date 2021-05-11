// sandbox.cpp : Source file for your target.
//


#include <iostream>

#include <LibTest/LibraryTest.h>


int main()
{
	test::libprint();

	std::cout << "Functions return : " << test::get1() << " & " << test::get2() << "\n";

#ifdef _LIB_DEBUG_
	std::cout << "Main debug build!!\n";
#endif

	return 0;
}
