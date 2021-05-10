# CMakeList.txt : CMake project for LibraryTest, include source and define
# project specific logic here.
#
cmake_minimum_required(VERSION 3.8)

# Add source to this project's executable.
add_library(LibTest "src/LibraryTest.cpp" "inc/LibTest/LibraryTest.h" "inc/LibTest/api.h")
target_include_directories(LibTest PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc>
	
	$<INSTALL_INTERFACE:include>
)

target_compile_definitions(LibTest
	PUBLIC $<$<CONFIG:Debug>:_LIB_DEBUG_>
)

# If library is built statically or we are on Linux, define API no exports.
if( UNIX OR NOT BUILD_SHARED_LIBS )
	target_compile_definitions(LibTest PUBLIC LibTest_NO_EXPORTS)
endif()

# Generate the Config and Version information cmake files to install alongside library.
include(CMakePackageConfigHelpers)
# Generate the configuration cmake file.
configure_package_config_file(	${CMAKE_CURRENT_SOURCE_DIR}/config.cmake.in
								"${CMAKE_CURRENT_BINARY_DIR}/generated/LibTestConfig.cmake"
								INSTALL_DESTINATION "lib/cmake/LibTest"
								NO_SET_AND_CHECK_MACRO
								NO_CHECK_REQUIRED_COMPONENTS_MACRO
)
# Generate the version information cmake file.
write_basic_package_version_file(	"${CMAKE_CURRENT_BINARY_DIR}/generated/LibTestConfigVersion.cmake"
									VERSION "${LibTest_VERSION_MAJOR}.${LibTest_VERSION_MINOR}"
									COMPATIBILITY AnyNewerVersion
)

# Create install targets.
# Install the generated library target file.
install(	TARGETS LibTest
			EXPORT LibTestTargets
			RUNTIME DESTINATION bin
			LIBRARY DESTINATION lib
			ARCHIVE DESTINATION lib
)
# Install the public headers.
install(	DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/inc/
			DESTINATION include
			FILES_MATCHING
				PATTERN "*.h"
				PATTERN "*.hpp"
)
# Install the exported targets cmake file.
install(	EXPORT LibTestTargets
			FILE LibTestTargets.cmake
			DESTINATION lib/cmake/LibTest
)
# Install the configuration file
install(	FILES
			${CMAKE_CURRENT_BINARY_DIR}/generated/LibTestConfig.cmake
			DESTINATION lib/cmake/LibTest
)
