# CMakeList.txt : CMake project for LibraryTest, include source and define
# project specific logic here.
#
cmake_minimum_required (VERSION 3.8)

# Add source to this project's executable.
add_library (LibTest "src/LibraryTest.cpp" "inc/LibraryTest.h"  "inc/api.h")
target_include_directories(LibTest PUBLIC "./inc")

target_compile_definitions(LibTest
	PUBLIC $<$<CONFIG:Debug>:_LIB_DEBUG_>
)

# If library is built statically, define API no exports.
if( NOT BUILD_SHARED_LIBS )
	target_compile_definitions(LibTest PUBLIC LibTest_NO_EXPORTS)
endif()

# Create install targets.
install(TARGETS LibTest
		CONFIGURATIONS Debug
		DESTINATION "${PROJECT_BINARY_DIR}/_install")
install(TARGETS LibTest
		CONFIGURATIONS Release
		DESTINATION "${PROJECT_BINARY_DIR}/_install")