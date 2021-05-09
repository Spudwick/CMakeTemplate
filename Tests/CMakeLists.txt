
include("./macros.cmake")

# Find Boost Library for Unit Test Framework.
find_package(Boost COMPONENTS system filesystem unit_test_framework)

# Only create Test targets if the needed Boost components have been found.
if( Boost_FOUND AND Boost_system_FOUND AND Boost_filesystem_FOUND AND Boost_unit_test_framework_FOUND )
    enable_testing()

    SET(Boost_LIBS ${Boost_FILESYSTEM_LIBRARY} ${Boost_SYSTEM_LIBRARY} ${Boost_UNIT_TEST_FRAMEWORK_LIBRARY})

    # Get properties for Test Unit.
    get_target_property(LibTest_INCLUDES LibTest INCLUDE_DIRECTORIES)
    get_target_property(LibTest_SRC_DIR LibTest SOURCE_DIR)

    # Add Unit Tests:
    # Test 1 - Test_the_first
    add_unit_test(  NAME Test_the_first
                    SRCS "Test1.cpp" "${LibTest_SRC_DIR}/src/LibraryTest.cpp"
                    LIBS ${Boost_LIBS}
                    INC_DIRS ${Boost_INCLUDE_DIRS} ${LibTest_INCLUDES})
    target_compile_definitions(Test_the_first PRIVATE BOOST_TEST_DYN_LINK LibTest_NO_EXPORTS)

    # Test 2 - Test_the_second
    add_unit_test(  NAME Test_the_second
                    SRCS "Test2.cpp" "${LibTest_SRC_DIR}/src/LibraryTest.cpp"
                    LIBS ${Boost_LIBS}
                    INC_DIRS ${Boost_INCLUDE_DIRS} ${LibTest_INCLUDES})
    target_compile_definitions(Test_the_second PRIVATE BOOST_TEST_DYN_LINK LibTest_NO_EXPORTS)

    # Finalise the test setup by creating umbrella test target.
    create_test_target()
else()
    message(WARNING "Boost libraries not found, tests disabled!")
endif()