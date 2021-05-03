# CMakeList.txt : Top-level CMake project file, do global configuration
# and include sub-projects here.
#
cmake_minimum_required (VERSION 3.8)

project ("LibraryTest")

# Set "message()" verbosity level to "DEBUG" for testing purposes.
set( CMAKE_MESSAGE_LOG_LEVEL "DEBUG" )

enable_testing()

# Include sub-projects.
add_subdirectory ("LibTest")
add_subdirectory("Sandbox")
add_subdirectory("Tests")
