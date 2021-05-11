# CMakeList.txt : CMake project for LibraryTest, include source and define
# project specific logic here.
#
cmake_minimum_required(VERSION 3.8)

# Add source to this project's executable.
if( LIBTEST_BUILD_SHARED )
	add_library(LibTest SHARED "src/LibraryTest.cpp" "inc/LibTest/LibraryTest.h")
else()
	add_library(LibTest STATIC "src/LibraryTest.cpp" "inc/LibTest/LibraryTest.h")
endif()
target_include_directories(	LibTest PUBLIC
    						$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/inc>
							$<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/generated/inc>
							$<INSTALL_INTERFACE:include>)

target_compile_definitions(	LibTest
							PUBLIC $<$<CONFIG:Debug>:_LIB_DEBUG_>)

# Generate the configuration header file.
configure_file(	${CMAKE_CURRENT_SOURCE_DIR}/config.h.in
				"${CMAKE_CURRENT_BINARY_DIR}/generated/inc/LibTest/config.h")

# Generate the export api header.
include(GenerateExportHeader)
generate_export_header(	LibTest
						EXPORT_FILE_NAME "${CMAKE_CURRENT_BINARY_DIR}/generated/inc/LibTest/exports.h")

# Generate the Config and Version information cmake files to install alongside library.
include(CMakePackageConfigHelpers)
# Generate the configuration cmake file.
configure_package_config_file(	${CMAKE_CURRENT_SOURCE_DIR}/config.cmake.in
								"${CMAKE_CURRENT_BINARY_DIR}/generated/LibTestConfig.cmake"
								INSTALL_DESTINATION "lib/cmake/LibTest"
								NO_SET_AND_CHECK_MACRO
								NO_CHECK_REQUIRED_COMPONENTS_MACRO)
# Generate the version information cmake file.
write_basic_package_version_file(	"${CMAKE_CURRENT_BINARY_DIR}/generated/LibTestConfigVersion.cmake"
									VERSION "${LibTest_VERSION_MAJOR}.${LibTest_VERSION_MINOR}"
									COMPATIBILITY AnyNewerVersion)

# Create install targets.
# Install the generated library target file.
install(	TARGETS LibTest
			EXPORT LibTestTargets
			RUNTIME DESTINATION bin
			LIBRARY DESTINATION lib
			ARCHIVE DESTINATION lib)
# Install the public headers.
install(	DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/inc/
			DESTINATION include
			FILES_MATCHING
				PATTERN "*.h"
				PATTERN "*.hpp")
# Install the generated public headers.
install(	DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/generated/inc/
			DESTINATION include
			FILES_MATCHING
				PATTERN "*.h"
				PATTERN "*.hpp")
# Install the exported targets cmake file.
install(	EXPORT LibTestTargets
			FILE LibTestTargets.cmake
			DESTINATION lib/cmake/LibTest)
# Install the configuration file
install(	FILES
			${CMAKE_CURRENT_BINARY_DIR}/generated/LibTestConfig.cmake
			DESTINATION lib/cmake/LibTest)
