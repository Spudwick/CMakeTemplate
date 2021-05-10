
#define BOOST_TEST_MODULE LibTests
#include <boost/test/unit_test.hpp>

#include "LibTest/LibraryTest.h"

BOOST_AUTO_TEST_CASE(PassTest)
{
    BOOST_CHECK_EQUAL( get2(), 2 );
}
