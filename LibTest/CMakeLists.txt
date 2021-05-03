# CMakeList.txt : CMake project for LibraryTest, include source and define
# project specific logic here.
#
cmake_minimum_required (VERSION 3.8)

# Add source to this project's executable.
add_library (LibTest SHARED "src/LibraryTest.cpp" "inc/LibraryTest.h"  "inc/api.h")
target_include_directories(LibTest PUBLIC "./inc")

target_compile_definitions(LibTest
	PUBLIC $<$<CONFIG:Debug>:_LIB_DEBUG_>
)

# TODO: Add tests and install targets if needed.
install(TARGETS LibTest
		CONFIGURATIONS Debug
		DESTINATION "${PROJECT_BINARY_DIR}/_install")