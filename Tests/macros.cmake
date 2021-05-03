
macro(add_unit_test)
	# Create lists of Arguments.
	SET(singleValArgs NAME)
	SET(multiValArgs SRCS LIBS INC_DIRS)
	# Parse macro arguments to UNIT_TEST_**.
	cmake_parse_arguments(UNIT_TEST "${options}" "${singleValArgs}" "${multiValArgs}" ${ARGN})
	
	message(STATUS "Adding unit test : ${UNIT_TEST_NAME}")

	# Create test executable.
	add_executable(${UNIT_TEST_NAME} EXCLUDE_FROM_ALL ${UNIT_TEST_SRCS})
	# Link required libraries for test.
	target_link_libraries(${UNIT_TEST_NAME} ${UNIT_TEST_LIBS})
	# Add additional include directories.
	target_include_directories(${UNIT_TEST_NAME} PRIVATE ${UNIT_TEST_INC_DIRS})

	# Create CTest target.
	add_test(NAME ${UNIT_TEST_NAME} COMMAND ${UNIT_TEST_NAME})
	# Add Test Name to the global list of Unit Tests.
	set(UTEST_LIST ${UTEST_LIST} ${UNIT_TEST_NAME})
	# Create a target to build and run test.
	add_custom_target(run_${UNIT_TEST_NAME}
                  COMMAND ${CMAKE_CTEST_COMMAND} -R ${UNIT_TEST_NAME}
                  DEPENDS ${UNIT_TEST_NAME})

	message(DEBUG "   Generated target '${UNIT_TEST_NAME}'")
	message(DEBUG "   Generated target 'run_${UNIT_TEST_NAME}'")
endmacro(add_unit_test)

macro(create_test_target)
	# Create additional target to build and run all unit tests, "run_tests".
	add_custom_target(run_tests COMMAND ${CMAKE_CTEST_COMMAND} DEPENDS ${UTEST_LIST})
	message(DEBUG "Generated target 'run_tests'")
endmacro(create_test_target)