// sandbox.cpp : Source file for your target.
//


#include <conio.h>
#include <iostream>

#include <LibraryTest.h>


int main()
{
	libprint();

	std::cout << "Functions return : " << get1() << " & " << get2() << "\n";

#ifdef _LIB_DEBUG_
	std::cout << "Main debug build!!\n";
#endif

	std::cout << "\nPress any key to continue...\n";
	_getch();
	return 0;
}
