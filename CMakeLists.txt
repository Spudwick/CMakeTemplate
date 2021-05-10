# CMakeList.txt : Top-level CMake project file, do global configuration
# and include sub-projects here.
#
cmake_minimum_required(VERSION 3.8)

# Set "message()" verbosity level to "DEBUG" for testing purposes.
set(CMAKE_MESSAGE_LOG_LEVEL "DEBUG")

# Setup Toolchain File path to allow package location discovery (particularaly Boost for test system).
# Default Toolchain File can be overwritten by passing -DCMAKE_TOOLCHAIN_FILE='<toolchain_file>' on command line.
if( NOT DEFINED CMAKE_TOOLCHAIN_FILE )
	if( WIN32 )
		message(DEBUG "Using default windows Toolchain File (vcpkg.cmake)")
		# If building on windows we use VCPKG by default (root dir of VCPKG install must be provided by environment variable VCPKG_ROOT).
		if( DEFINED ENV{VCPKG_ROOT} )
			set(CMAKE_TOOLCHAIN_FILE "$ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake" CACHE STRING "")
		else()
			message(FATAL_ERROR "ENV{VCPKG_ROOT} must be defined if no CMAKE_TOOLCHAIN_FILE is provided!")
		endif()
	endif()
endif()
message(DEBUG "Toolchain File : '${CMAKE_TOOLCHAIN_FILE}'")

# Create option to select if library should be built as shared or static.
option(BUILD_SHARED_LIBS "Build shared library (ON:.dll/.so  OFF:.lib/.a)" ON)


project(	"LibraryTest"
			VERSION 1.2.3.4
			LANGUAGES C CXX)

# Include sub-projects.
add_subdirectory("LibTest")
add_subdirectory("Sandbox")
add_subdirectory("Tests")
