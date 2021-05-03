#pragma once


#undef LIBTEST_API

#ifndef LibTest_NO_EXPORTS

	#ifdef LibTest_EXPORTS
		#define LIBTEST_API		__declspec(dllexport)
	#else	// #ifdef __API_EXPORT__
		#define LIBTEST_API		__declspec(dllimport)
	#endif	// #ifdef __API_EXPORT__

#else	// #ifndef LibTest_NO_EXPORTS

	#define LIBTEST_API

#endif	// #ifndef LibTest_NO_EXPORTS