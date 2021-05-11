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
		message(INFO "Using default windows Toolchain File (vcpkg.cmake)")
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
option(LIBTEST_BUILD_SHARED "Build shared library (ON:.dll/.so  OFF:.lib/.a)" ON)

# Set the default build type. This can be overwritten using cmake command line and is ignored for multi-config generators.
if( NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES )
	set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Choose the type of build to perform." FORCE)
	set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release")
endif()

set(LIBTEST_NAMESPACE "test" CACHE STRING "Root namespace for LibTest.")

# Read verion numbers in from source code.
include(VerFromHdr.cmake)
get_version_from_header(	FILE "${CMAKE_SOURCE_DIR}/LibTest/config.h.in"
							PREFIX LIB)

project(	"LibraryTest"
			VERSION ${LIB_VER_MAJOR}.${LIB_VER_MINOR}.${LIB_VER_PATCH}.${LIB_VER_TWEAK}
			LANGUAGES C CXX)

# Include sub-projects.
add_subdirectory("LibTest")
add_subdirectory("Sandbox")
add_subdirectory("Tests")
